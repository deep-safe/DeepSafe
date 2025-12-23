import os
import re
import glob

# Re-using the robust parser from extract_image_questions.py
def parse_sql_files(directory):
    mission_map = {} 
    image_questions = [] 

    files = glob.glob(os.path.join(directory, "*.sql"))
    
    for filepath in files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        insert_starts = [m.start() for m in re.finditer(r"INSERT INTO public\.missions", content, re.IGNORECASE)]
        
        for start_idx in insert_starts:
            values_match = re.search(r"VALUES\s*\(", content[start_idx:], re.IGNORECASE)
            if not values_match: continue
            
            scan_idx = start_idx + values_match.end() - 1 
            parts = []
            current_part = []
            in_quote = False
            paren_depth = 0
            
            i = scan_idx
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
                            break 
                        else:
                            current_part.append(char)
                    elif char == ',' and paren_depth == 1:
                        parts.append("".join(current_part).strip())
                        current_part = []
                    else:
                        current_part.append(char)
                i += 1
            
            if len(parts) >= 10:
                 m_id = parts[0].strip("'")
                 prov = parts[1].strip("'")
                 title = parts[2].strip("'")
                 known_regions = ["Valle d'Aosta", "Piemonte", "Lombardia", "Veneto", "Sicilia", "Emilia Romagna", "Toscana", "Lazio", "Campania", "Puglia", "Calabria", "Sardegna", "Liguria", "Friuli Venezia Giulia", "Trentino Alto Adige", "Umbria", "Marche", "Abruzzo", "Molise", "Basilicata"]
                 region = "Unknown"
                 for p in parts:
                     clean_p = p.strip("'").replace("''", "'")
                     if clean_p in known_regions:
                         region = clean_p
                         break
                 
                 mission_map[m_id] = {'p': prov, 't': title, 'r': region}

    for filepath in files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        qs_inserts = list(re.finditer(r"INSERT INTO public\.mission_questions\s*\((.*?)\)\s*VALUES", content, re.IGNORECASE | re.DOTALL))
        
        for match in qs_inserts:
            cols_str = match.group(1).lower()
            cols = [c.strip() for c in cols_str.split(',')]
            has_image_col = 'image_url' in cols
            image_col_idx = cols.index('image_url') if has_image_col else -1
            values_start = match.end()
            
            i = values_start
            while i < len(content):
                while i < len(content) and content[i].isspace(): i += 1
                if i >= len(content) or content[i] != '(': break
                
                paren_depth = 0
                in_quote = False
                current_part = []
                parts = []
                
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
                                i += 1 
                                break
                            else:
                                current_part.append(char)
                        elif char == ',' and paren_depth == 1:
                            parts.append("".join(current_part).strip())
                            current_part = []
                        else:
                            current_part.append(char)
                    i += 1
                
                if len(parts) >= 3:
                     m_id = parts[0].strip("'")
                     text = parts[1].strip("'")
                     q_type = parts[2].strip("'")
                     
                     is_image = 'image' in q_type
                     curr_url = "NULL"
                     if has_image_col and len(parts) > image_col_idx:
                         curr_url = parts[image_col_idx].strip("'")
                         if curr_url != "NULL" and "placehold" in curr_url:
                             is_image = True 
                     
                     if is_image:
                         image_questions.append({
                            'mid': m_id,
                            'text': text,
                            'type': q_type,
                            'url': curr_url
                        })
                
                while i < len(content) and content[i].isspace(): i += 1
                if i < len(content) and content[i] == ',':
                    i += 1
                    continue
                elif i < len(content) and content[i] == ';':
                    break 
                else: break

    return mission_map, image_questions

def generate_update_sql(directory, mission_map, image_questions):
    lines = []
    lines.append("-- Auto-generated image updates")
    lines.append("-- Run this to link the new WebP images to mission questions.")
    lines.append("")
    
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
            
        def clean(s):
            return re.sub(r'[^A-Z0-9]', '_', s.upper()).strip('_')
            
        r_clean = clean(region)
        p_clean = clean(prov)
        m_clean = clean(mission_title)
        
        filename = f"{r_clean}-{p_clean}-{m_clean}.webp"
        
        # Escape single quotes in text for SQL safety
        safe_text = q['text'].replace("'", "''")
        
        sql = f"""UPDATE public.mission_questions 
SET image_url = '/missions/{filename}' 
WHERE mission_id = '{m_id}' AND text = '{safe_text}';"""
        
        lines.append(sql)
        
    return "\n".join(lines)

if __name__ == "__main__":
    directory = "/Users/simo/Downloads/DEV/DeepSafe 2/supabase/migrations"
    m_map, i_qs = parse_sql_files(directory)
    sql_content = generate_update_sql(directory, m_map, i_qs)
    
    out_file = "supabase/migrations/99999999_update_mission_images.sql"
    with open(out_file, "w", encoding='utf-8') as f:
        f.write(sql_content)
        
    print(f"Generated SQL updates for {len(i_qs)} questions at {out_file}")
