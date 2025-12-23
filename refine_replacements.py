import os
import re
import glob

# =============================================================================
# REPLACEMENT CONTENT LIBRARY (Enriched)
# =============================================================================

def get_smart_question(mission_title, existing_text=""):
    """
    Returns a dict with: text, options (json string), correct_answer (int), explanation
    """
    key = mission_title.upper()
    
    # -------------------------------------------------------------------------
    # CAMPANIA
    # -------------------------------------------------------------------------
    if "METADATA" in key or "FANTASMI" in key:
        return {
            "text": "Quali informazioni sensibili possono nascondersi nei metadati di un PDF?",
            "options": '["Solo il peso del file", "Autore, software usato, data di creazione e cronologia delle revisioni", "Il font usato", "Nessuna"]',
            "correct_answer": 1,
            "explanation": "I metadati sono spesso invisibili a schermo ma leggibili con semplici tool."
        }
    if "TIME" in key or "MACCHINA DEL TEMPO" in key:
        return {
            "text": "È possibile fidarsi della 'Data di Creazione' di un file digitale?",
            "options": '["Sì, è certificata dal sistema operativo", "No, può essere alterata banalmente (Timestomping) per nascondere l''origine di un malware", "Sì, se il file è di sola lettura", "Solo su Mac"]',
            "correct_answer": 1,
            "explanation": "In informatica forense, i timestamp del filesystem sono considerati dati volatili e non affidabili."
        }
    if "STEGANOGRAFIA" in key or "NASCOSTO" in key:
        return {
            "text": "La tecnica che nasconde un messaggio segreto dentro un'immagine apparentemente normale si chiama:",
            "options": '["Crittografia", "Steganografia", "Compressione", "Fotoritocco"]',
            "correct_answer": 1,
            "explanation": "Mentre la crittografia protegge il contenuto, la steganografia protegge l'esistenza stessa della comunicazione."
        }
    if "LAMPADINA" in key or "IOT" in key:
        return {
            "text": "Perché i dispositivi IoT (lampadine, frigo smart) sono spesso vulnerabili?",
            "options": '["Costano poco", "Spesso hanno firmware non aggiornabili e password di default hardcoded impossibili da cambiare", "Consumano troppa corrente", "Sono piccoli"]',
            "correct_answer": 1,
            "explanation": "La sicurezza è spesso sacrificata per il basso costo e la facilità d'uso (plug & play)."
        }
    if "BOTNET" in key or "ZOMBIE" in key:
        return {
            "text": "Se il tuo PC fa parte di una Botnet, te ne accorgi?",
            "options": '["Sì, compare un teschio", "Spesso no. Il malware lavora silenziosamente in background usando la tua banda per attaccare altri", "Sì, il PC si spegne", "No, perché non esiste"]',
            "correct_answer": 1,
            "explanation": "L'obiettivo della Botnet è restare operativa il più a lungo possibile senza essere scoperta."
        }
    if "ZIGBEE" in key or "JAMMING" in key or "SILENZIO" in key:
        return {
            "text": "Un allarme wireless può essere neutralizzato con:",
            "options": '["Un martello", "Un Jammer radio che satura la frequenza impedendo la comunicazione tra sensori e centralina", "Un telecomando TV", "Una torcia"]',
            "correct_answer": 1,
            "explanation": "Il Jamming crea un 'muro di rumore' che blocca i segnali radio."
        }
    if "SUPPLY CHAIN" in key or "ANELLO DEBOLE" in key:
        return {
            "text": "Perché gli hacker colpiscono i fornitori di un'azienda (Supply Chain Attack)?",
            "options": '["Sono più simpatici", "Spesso hanno accesso ai sistemi del cliente finale ma difese molto povere, agendo da cavallo di Troia", "Hanno uffici più belli", "Per sbaglio"]',
            "correct_answer": 1,
            "explanation": "Si attacca l'anello debole della catena per raggiungere il bersaglio forte."
        }
    if "TYPOSQUATTING" in key or "GEMELLO" in key:
        return {
            "text": "In un attacco IDN Homograph, un dominio malevolo appare:",
            "options": '["Scritto in rosso", "Identico all''originale (es. apple.com) usando caratteri di altri alfabeti visivamente uguali", "Sgranato", "Più lungo"]',
            "correct_answer": 1,
            "explanation": "Sfrutta i limiti dell'occhio umano nel distinguere glifi simili."
        }
    if "DEPENDENCY" in key or "LIBRERIE" in key:
        return {
            "text": "Scaricare codice da repository pubblici (npm, pip) senza controllo espone a:",
            "options": '["Nulla", "Typosquatting e Dependency Confusion (scaricare malware con nome simile a librerie lecite)", "Virus nel mouse", "Rallentamenti"]',
            "correct_answer": 1,
            "explanation": "Mai fidarsi ciecamente dei pacchetti pubblici."
        }
    if "PORT SCANNING" in key or "BUSSARE" in key:
        return {
            "text": "Se nmap dice che una porta è 'FILTERED', significa che:",
            "options": '["È aperta", "È chiusa", "Un firewall sta bloccando o ignorando la richiesta, non dando informazioni all''attaccante", "È rotta"]',
            "correct_answer": 2,
            "explanation": "'Filtered' è lo stato ideale per la difesa: il nemico non sa se esisti."
        }
    if "DNS" in key or "TUNNEL" in key:
        return {
            "text": "Il DNS over HTTPS (DoH) impedisce al tuo provider internet di:",
            "options": '["Farti pagare la bolletta", "Vedere quali domini (siti web) stai risolvendo/visitando", "Rallentarti", "Disconnetterti"]',
            "correct_answer": 1,
            "explanation": "Cifra la 'rubrica telefonica' di internet."
        }
    if "HONEYPOT" in key or "VASO" in key:
        return {
            "text": "Perché un'azienda installa un Honeypot?",
            "options": '["Per attirare, rallentare e studiare gli attaccanti in un ambiente controllato", "Per produrre miele", "Per aumentare la velocità di rete", "Per gestire le password"]',
            "correct_answer": 0,
            "explanation": "L'honeypot è un sistema sacrificale."
        }
    if "LOLBINS" in key:
        return {
            "text": "I LOLBins (Living Off The Land Binaries) sono difficili da rilevare perché:",
            "options": '["Sono invisibili", "Sono programmi legittimi di sistema (es. PowerShell) usati per scopi malevoli, quindi ''firmati'' e trusted", "Hanno nomi strani", "Sono piccoli"]',
            "correct_answer": 1,
            "explanation": "L'attaccante 'vive della terra' usando ciò che trova già installato."
        }
    if "ZERO-CLICK" in key:
        return {
            "text": "Per infettare un telefono con uno Zero-Click exploit, l'utente deve:",
            "options": '["Cliccare un link", "Scaricare un''app", "Non fare assolutamente nulla (basta ricevere un messaggio o una chiamata)", "Riavviare"]',
            "correct_answer": 2,
            "explanation": "La pericolosità sta proprio nell'assenza di interazione utente richiesta."
        }
    if "BEC" in key or "IMPOSTORE" in key:
        return {
            "text": "La truffa BEC (Business Email Compromise) si basa principalmente su:",
            "options": '["Malware avanzato", "Social Engineering e inganno (fingersi il CEO o un fornitore noto)", "Brute force", "Virus USB"]',
            "correct_answer": 1,
            "explanation": "È hacking psicologico, non tecnologico."
        }

    # -------------------------------------------------------------------------
    # SICILIA (PART 1 & 2)
    # -------------------------------------------------------------------------
    if "FINGERPRINTING" in key:
        return {
             "text": "Il 'Canvas Fingerprinting' identifica il tuo browser basandosi su:",
             "options": '["I cookie", "Come la tua scheda grafica renderizza (disegna) impercettibilmente font e grafiche 3D uniche", "Il tuo indirizzo IP", "La tua webcam"]',
             "correct_answer": 1,
             "explanation": "Ogni combinazione hardware/driver disegna in modo unico al pixel."
        }
    if "EXIF" in key or "METADATA" in key:
         return {
             "text": "Perché inviare una foto originale a uno sconosciuto è rischioso?",
             "options": '["È pesante", "Pochi sanno che i dati EXIF possono contenere le coordinate GPS esatte di dove è stata scattata", "Si vede male", "Non si apre"]',
             "correct_answer": 1,
             "explanation": "Privacy geografica a rischio."
        }
    if "STYLOMETRY" in key:
        return {
             "text": "La Stilometria può de-anonimizzare un testo anonimo analizzando:",
             "options": '["La calligrafia", "La frequenza di parole, punteggiatura e schemi grammaticali unici dell''autore", "Il font", "Il colore"]',
             "correct_answer": 1,
             "explanation": "Il modo in cui scrivi è un'impronta digitale."
        }
    if "CIPOLLA" in key or "TOR" in key:
         return {
             "text": "Tor Browser protegge la tua identità instradando il traffico:",
             "options": '["Direttamente al server", "Attraverso tre nodi casuali (Guard, Middle, Exit) cifrati a cipolla", "In incognito", "Via satellite"]',
             "correct_answer": 1,
             "explanation": "Peeling the onion."
        }    
    if "USCITA" in key or "EXIT NODE" in key:
         return {
             "text": "L'Exit Node di Tor vede il contenuto del tuo traffico?",
             "options": '["Mai", "Sì, se non usi HTTPS (il traffico esce in chiaro verso Internet)", "No, è tutto cifrato sempre", "Solo il sabato"]',
             "correct_answer": 1,
             "explanation": "L'ultimo miglio è scoperto se non c'è crittografia end-to-end (HTTPS)."
        }
    if "COINJOIN" in key or "MIXER" in key:
         return {
             "text": "A cosa serve un servizio di CoinJoin/Mixer?",
             "options": '["A fare cocktail", "A mescolare le criptovalute di molti utenti per rompere il legame tra mittente e destinatario sulla blockchain", "A raddoppiare i soldi", "A minare"]',
             "correct_answer": 1,
             "explanation": "Rende difficile la Chain Analysis."
        }
    if "MONERO" in key:
         return {
             "text": "Perché Monero è considerata una Privacy Coin?",
             "options": '["Ha un logo segreto", "Offusca mittente, destinatario e importo di default (Ring Signatures, Stealth Addresses)", "Usa Bitcoin", "È illegale"]',
             "correct_answer": 1,
             "explanation": "Sicurezza tramite oscurità matematica (crittografia avanzata)."
        }
    
    # -------------------------------------------------------------------------
    # LOMBARDIA / PIEMONTE (GENERIC)
    # -------------------------------------------------------------------------
    if "TRUFFA" in key or "SCAM" in key:
         return {
             "text": "Cosa indica spesso una truffa online?",
             "options": '["Prezzi normali", "Urgenza eccessiva (''Scade tra 5 minuti!'') e richieste di pagamento insolite (Gift Card, Crypto)", "Foto belle", "Descrizioni lunghe"]',
             "correct_answer": 1,
             "explanation": "La fretta è nemica della sicurezza."
        }
    if "PHISHING" in key:
         return {
             "text": "In una mail di phishing, l'URL visualizzato è sempre quello reale?",
             "options": '["Sì", "No, il testo del link può dire ''google.com'' ma puntare a ''evil.com''. Bisogna controllare passando il mouse sopra (hover)", "Forse", "Dipende dal client"]',
             "correct_answer": 1,
             "explanation": "Non fidarti di ciò che leggi, verifica dove clicchi."
        }

    # DEFAULT FALLBACK (Better than UNK)
    return {
        "text": f"In ambito {mission_title} (Cybersecurity), qual è la regola d'oro?",
        "options": '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password ''123456''", "Non usare il computer"]',
        "correct_answer": 1,
        "explanation": "La fiducia implicita è la vulnerabilità principale."
    }

# =============================================================================
# MAIN SCRIPT
# =============================================================================

def fix_files(directory):
    files = glob.glob(os.path.join(directory, "*.sql"))
    
    # exclude the update script itself if present
    files = [f for f in files if "update_mission_images" not in f]

    for filepath in files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 1. Build Mission Map from INSERT INTO missions
        # Regex to find: ('UUID', 'PROV', 'TITLE', ...)
        # Values patterns vary, need to be careful.
        # Assuming format: ('UUID', 'PROV', 'TITLE', ...
        
        mission_map = {} # UUID -> Title
        
        mission_inserts = re.finditer(r"INSERT INTO public\.missions.*?\nVALUES", content, re.IGNORECASE | re.DOTALL)
        # Actually usually it's INSERT ... VALUES (...), (...);
        # Let's simplified parse:
        
        # Extract potential UUIDs and Titles
        # Look for pattern: 'uuid', 'prov', 'title' matches
        # UUID is 8-4-4-4-12 hex chars.
        
        # This regex looks for: ('UUID', 'PROV', 'TITLE'
        # Handles escaped quotes: ((?:[^']|'')*)
        regex_missions = r"\(\s*'([0-9a-fA-F-]{36})',\s*'([A-Z]{2})',\s*'((?:[^']|'')*)'"
        
        for m in re.finditer(regex_missions, content):
            mid = m.group(1)
            # prov = m.group(2)
            title = m.group(3)
            mission_map[mid] = title
            # print(f"Mapped {mid} -> {title}")
            
        # 2. Find Question Inserts
        # We need to replace rows in MISSION_QUESTIONS
        # We look for rows that contain "Approfondimento su: UNK" OR "In questa foto" (bad ones)
        
        # We will iterate line by line to locate target strings? 
        # No, questions are often multiline.
        # Let's use the same block parser as before but focused.
        
        matches = list(re.finditer(r"(INSERT INTO public\.mission_questions\s*\((.*?)\)\s*VALUES\s*)(.*?;)", content, re.IGNORECASE | re.DOTALL))
        
        if not matches:
            continue
            
        modified_file = False
        new_content = content
        
        for match in matches:
            full_block = match.group(0)
            prefix = match.group(1)
            cols_str = match.group(2).lower()
            values_block = match.group(3)
            
            cols = [c.strip() for c in cols_str.split(',')]
            
            # Simple splitter again (assuming no commas in JSON for now, or handling basic)
            # Re-using the parser from before would be better.
            
            # Quick hack: If the block contains "Approfondimento su: UNK" or "In questa foto", RE-PARSE it properly.
            if "Approfondimento su: UNK" not in full_block and "In questa foto" not in full_block and "In questo screenshot" not in full_block and "In ambito" not in full_block:
               continue
               
            # Parsing logic
            tuples = []
            v_str = values_block.strip().rstrip(';')
            
            parsed_tuples_raw = []
            idx = 0
            paren_depth = 0
            in_quote = False
            tuple_start = -1
            
            while idx < len(v_str):
                char = v_str[idx]
                if char == "'":
                    if in_quote and idx + 1 < len(v_str) and v_str[idx+1] == "'":
                        idx += 1
                    else:
                        in_quote = not in_quote
                if not in_quote:
                    if char == '(':
                        if paren_depth == 0: tuple_start = idx
                        paren_depth += 1
                    elif char == ')':
                        paren_depth -= 1
                        if paren_depth == 0: parsed_tuples_raw.append(v_str[tuple_start:idx+1])
                idx += 1
                
            new_tuples_str = []
            block_modified = False
            
            for t_raw in parsed_tuples_raw:
                t_content = t_raw[1:-1]
                # split logic
                vals = []
                curr_val = []
                p_depth = 0
                q_in = False
                k = 0
                while k < len(t_content):
                    c = t_content[k]
                    if c == "'":
                        if q_in and k + 1 < len(t_content) and t_content[k+1] == "'":
                            curr_val.append("''"); k += 2; continue
                        else: q_in = not q_in
                    if q_in: curr_val.append(c)
                    else:
                        if c == ',' and p_depth == 0: vals.append("".join(curr_val).strip()); curr_val = []
                        elif c == '(': p_depth += 1; curr_val.append(c)
                        elif c == ')': p_depth -= 1; curr_val.append(c)
                        else: curr_val.append(c)
                    k += 1
                vals.append("".join(curr_val).strip())
                
                row = {}
                for cx, cname in enumerate(cols):
                    if cx < len(vals): row[cname] = vals[cx]
                
                text_val = row.get('text', '').strip("'")
                
                # CHECK TARGETS
                # 1. The generic UNK
                # 2. The explicit image reference "In questa foto"
                
                is_unk = "Approfondimento su: UNK" in text_val
                is_img_ref = "In questa foto" in text_val or "In questo screenshot" in text_val or "Guarda l'immagine" in text_val
                is_broken_l = "In ambito" in text_val
                
                if is_unk or is_img_ref or is_broken_l:
                    mid = row.get('mission_id', '').strip("'")
                    m_title = mission_map.get(mid, "General Security")
                    
                    smart_q = get_smart_question(m_title, text_val)
                    
                    # Update
                    row['text'] = f"'{smart_q['text'].replace("'", "''")}'"
                    row['options'] = f"'{smart_q['options'].replace("'", "''")}'"
                    row['correct_answer'] = str(smart_q['correct_answer'])
                    row['explanation'] = f"'{smart_q['explanation'].replace("'", "''")}'"
                    if 'type' in row: row['type'] = "'multiple_choice'" # force text type
                    if 'image_url' in row: row['image_url'] = "NULL"
                    
                    # Rebuild
                    new_vals = []
                    for c in cols: new_vals.append(row.get(c, "NULL"))
                    new_tuples_str.append("(" + ", ".join(new_vals) + ")")
                    block_modified = True
                    print(f"Fixed in {os.path.basename(filepath)}: [{m_title}] {text_val[:20]}... -> {smart_q['text'][:20]}...")
                else:
                    new_tuples_str.append(t_raw)
            
            if block_modified:
                values_rebuilt = ",\n".join(new_tuples_str)
                new_block = f"{prefix}{values_rebuilt};"
                new_content = new_content.replace(full_block, new_block)
                modified_file = True
        
        if modified_file:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"SAVED updates to {filepath}")

if __name__ == "__main__":
    fix_files("supabase/migrations")
