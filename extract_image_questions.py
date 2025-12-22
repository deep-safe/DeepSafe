import os
import re
import glob

def parse_sql_files(directory):
    mission_map = {} # id -> {region, province, title}
    image_questions = [] # list of {mission_id, text, type, current_url}

    files = glob.glob(os.path.join(directory, "*.sql"))
    
    for filepath in files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Parse Missions
        # Strategy: Find "INSERT INTO public.missions"
        # Then find "VALUES"
        # Then parse the tuple strictly.
        
        insert_starts = [m.start() for m in re.finditer(r"INSERT INTO public\.missions", content, re.IGNORECASE)]
        
        for start_idx in insert_starts:
            # Find VALUES after this insert
            values_match = re.search(r"VALUES\s*\(", content[start_idx:], re.IGNORECASE)
            if not values_match:
                continue
            
            # Start parsing from the opening parent of VALUES
            scan_idx = start_idx + values_match.end() - 1 # This is the '('
            
            # Parse the tuple
            # We want to extract comma-separated values, treating '...' strings as atomic
            parts = []
            current_part = []
            in_quote = False
            paren_depth = 0
            
            i = scan_idx
            while i < len(content):
                char = content[i]
                
                if char == "'":
                    # Check for escapement: '' is escape in SQL standard (usually)
                    # If we are in quote and next is ', it's an escape
                    if in_quote and i + 1 < len(content) and content[i+1] == "'":
                         current_part.append("'")
                         current_part.append("'")
                         i += 2
                         continue
                    else:
                         in_quote = not in_quote
                
                if in_quote:
                    current_part.append(char)
                else:
                    if char == '(':
                        paren_depth += 1
                        if paren_depth > 1: # Capture inner parens
                             current_part.append(char)
                    elif char == ')':
                        paren_depth -= 1
                        if paren_depth == 0:
                            # End of tuple
                            parts.append("".join(current_part).strip())
                            break # Finish this tuple
                        else:
                            current_part.append(char)
                    elif char == ',' and paren_depth == 1:
                        parts.append("".join(current_part).strip())
                        current_part = []
                    else:
                        current_part.append(char)
                
                i += 1
            
            # Extract fields
            if len(parts) >= 10:
                 # id, province_id, title...
                 m_id = parts[0].strip("'")
                 prov = parts[1].strip("'")
                 title = parts[2].strip("'")
                 
                 # Region extraction
                 # Try to find a known region in the parts
                 known_regions = ["Valle d'Aosta", "Piemonte", "Lombardia", "Veneto", "Sicilia", "Emilia Romagna", "Toscana", "Lazio", "Campania", "Puglia", "Calabria", "Sardegna", "Liguria", "Friuli Venezia Giulia", "Trentino Alto Adige", "Umbria", "Marche", "Abruzzo", "Molise", "Basilicata"]
                 
                 region = "Unknown"
                 for p in parts:
                     clean_p = p.strip("'").replace("''", "'")
                     if clean_p in known_regions:
                         region = clean_p
                         break
                 
                 mission_map[m_id] = {
                    'p': prov,
                    't': title,
                    'r': region
                 }

    # Pass 2: Questions
    # Same parsing logic but looking for mission_questions
    for filepath in files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # We need to know column order to find image_url
        # "INSERT INTO public.mission_questions (col1, col2...) VALUES"
        
        qs_inserts = list(re.finditer(r"INSERT INTO public\.mission_questions\s*\((.*?)\)\s*VALUES", content, re.IGNORECASE | re.DOTALL))
        
        for match in qs_inserts:
            cols_str = match.group(1).lower()
            cols = [c.strip() for c in cols_str.split(',')]
            
            has_image_col = 'image_url' in cols
            image_col_idx = cols.index('image_url') if has_image_col else -1
            
            # Start parsing values after VALUES keyword
            # This might be multi-row VALUES (...), (...);
            # We locate the start of VALUES
            values_start = match.end()
            
            # Robust parser for sequence of tuples
            i = values_start
            while i < len(content):
                # Skip whitespace to find '('
                while i < len(content) and content[i].isspace():
                    i += 1
                
                if i >= len(content) or content[i] != '(':
                    break # No more tuples or end of statement
                
                # Parse one tuple
                paren_depth = 0
                in_quote = False
                current_part = []
                parts = []
                
                start_tuple = i
                
                while i < len(content):
                    char = content[i]
                     
                    if char == "'":
                        if in_quote and i + 1 < len(content) and content[i+1] == "'":
                             current_part.append("'")
                             current_part.append("'")
                             i += 2
                             continue
                        else:
                             in_quote = not in_quote
                    
                    if in_quote:
                        current_part.append(char)
                    else:
                        if char == '(':
                            paren_depth += 1
                            if paren_depth > 1: current_part.append(char)
                        elif char == ')':
                            paren_depth -= 1
                            if paren_depth == 0:
                                parts.append("".join(current_part).strip())
                                i += 1 # Consume closing paren
                                break
                            else:
                                current_part.append(char)
                        elif char == ',' and paren_depth == 1:
                            parts.append("".join(current_part).strip())
                            current_part = []
                        else:
                            current_part.append(char)
                    i += 1
                
                # Check parts
                if len(parts) >= 3:
                     m_id = parts[0].strip("'")
                     text = parts[1].strip("'")
                     q_type = parts[2].strip("'")
                     
                     is_image = 'image' in q_type
                     curr_url = "NULL"
                     
                     if has_image_col and len(parts) > image_col_idx:
                         curr_url = parts[image_col_idx].strip("'")
                         if curr_url != "NULL":
                              is_image = True # Has non-null url, assume image needed/present
                     
                     if is_image:
                         image_questions.append({
                            'mid': m_id,
                            'text': text,
                            'type': q_type,
                            'url': curr_url
                        })
                
                # Check for comma after tuple (multi-row)
                while i < len(content) and content[i].isspace():
                    i += 1
                if i < len(content) and content[i] == ',':
                    i += 1
                    continue
                elif i < len(content) and content[i] == ';':
                    break # End of statement
                else:
                    break # Should be end or new statement

    return mission_map, image_questions

def generate_report(mission_map, image_questions):
    lines = []
    lines.append("# Missing Images Report")
    lines.append("")
    lines.append("The following questions require an image. Please create images with the specified filenames.")
    lines.append("")
    lines.append("| Region | Province | Mission | Question Text | Current Placeholder | Recommended Filename |")
    lines.append("|---|---|---|---|---|---|")
    
    for q in image_questions:
        m_id = q['mid']
        if m_id in mission_map:
            region = mission_map[m_id]['r']
            prov = mission_map[m_id]['p']
            mission_title = mission_map[m_id]['t']
        else:
            region = "UNKNOWN"
            prov = "UNK"
            mission_title = "Unknown Mission"
            
        # Clean strings for filename
        def clean(s):
            return re.sub(r'[^A-Z0-9]', '_', s.upper()).strip('_')
            
        r_clean = clean(region)
        p_clean = clean(prov)
        m_clean = clean(mission_title)
        
        # Construct filename: REGION-PROVINCE-MISSION
        # Since there can be multiple images per mission, we might need a suffix?
        # The user asked for "REGION-PROVINCE-MISSION".
        # If multiple questions in same mission need images, they would clash.
        # I'll append a short slug of the question text or an index.
        # But to stick to user request, I'll start with REGION-PROVINCE-MISSION and add -Qx if needed.
        
        # Check uniqueness later? For now, let's suggest REGION-PROVINCE-MISSION-KEYWORD
        # Identify keyword from question?
        # Or just use the format user asked for and let them deal with multiple?
        # User said: "named like this (REGION-PROVINCE-MISSION)"
        # I'll stick to that format base, but logically distinguish them.
        
        # Let's clean the Mission Title to be filename friendly
        # e.g. "Strati di Cipolla" -> "STRATI_DI_CIPOLLA"
        
        filename = f"{r_clean}-{p_clean}-{m_clean}"
        
        lines.append(f"| {region} | {prov} | {mission_title} | {q['text'][:50]}... | `{q['url']}` | `{filename}.png` |")

    return "\n".join(lines)

if __name__ == "__main__":
    directory = "/Users/simo/Downloads/DEV/DeepSafe 2/supabase/migrations"
    m_map, i_qs = parse_sql_files(directory)
    report = generate_report(m_map, i_qs)
    
    with open("MISSING_IMAGES.md", "w", encoding='utf-8') as f:
        f.write(report)
        
    print(f"Found {len(i_qs)} questions requiring images.")
