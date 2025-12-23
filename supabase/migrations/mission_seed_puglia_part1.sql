-- Mission Seed for Puglia (Part 1)
-- Region: Puglia (HARD / TRICKY EDITION)
-- Provinces: Bari (BA), Lecce (LE), Taranto (TA)

-- =================================================================================================
-- BARI (BA) - Firewalling Avanzato ("Il Castello Svevo")
-- =================================================================================================

-- Mission 1: Egress Filtering - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000001', 'BA', 'L''Uscita Vietata',
    'Bloccare i ladri che escono è importante quanto bloccare quelli che entrano.',
    E'# Egress Filtering\n\nMolte aziende bloccano tutto in entrata (Ingress), ma lasciano tutto aperto in uscita (Egress).\n\nSe un dipendente inserisce una chiavetta USB infetta, il malware installato cercherà di "chiamare casa" (C2 Server) per ricevere comandi.\nSe la porta 443 in uscita è aperta verso TUTTI, il malware riesce a comunicare e l''attacco continua.',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000001', 'Perché configurare regole di Egress Filtering?', 'multiple_choice', '["Per risparmiare banda", "Per impedire al malware di contattare il server di controllo (C2) o esfiltrare dati rubati", "Per bloccare Facebook", "È inutile"]', 1, 'L''Egress Filtering è l''ultima linea di difesa per contenere un''infezione già avvenuta.', NULL),
('ba000100-0000-0000-0000-000000000001', 'Se blocchi tutte le porte in uscita tranne la 80 e 443, sei sicuro?', 'multiple_choice', '["Sì", "No. Gli hacker usano il ''Tunneling'' su HTTP/HTTPS per nascondere traffico SSH o RDP dentro pacchetti web apparentemente legittimi", "Sì, sono porte web", "Dipende"]', 1, 'Le porte "standard" sono le autostrade preferite dai malware.', NULL),
('ba000100-0000-0000-0000-000000000001', 'Il firewall di Windows blocca le connessioni in uscita di default?', 'true_false', '["Vero", "Falso"]', 1, 'Falso! Di default, Windows Firewall permette TUTTO in uscita. Deve essere configurato manualmente (o via GPO).', NULL),
('ba000100-0000-0000-0000-000000000001', 'Cos''è una "Reverse Shell"?', 'multiple_choice', '["Una conchiglia", "Quando è la vittima a connettersi all''hacker (uscita), bypassando il firewall che blocca solo l''entrata", "Un virus", "Un backup"]', 1, 'L''hacker non entra, è la vittima che lo invita.', NULL),
('ba000100-0000-0000-0000-000000000001', 'Approfondimento su: USCITA. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Stateful vs Stateless - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000002', 'BA', 'La Memoria del Muro',
    'Il firewall deve ricordarsi chi ha iniziato la conversazione.',
    E'# Stateful Inspection\n\n*   **Stateless (Router ACL):** Guarda ogni pacchetto singolarmente. Se permetti l''entrata sulla porta 80, chiunque può entrare.\n*   **Stateful:** Tiene traccia delle connessioni ("Stato"). Se arriva un pacchetto sulla porta 80, lo fa passare SOLO SE è la risposta a una richiesta che TU hai fatto prima.\n\nSenza "Stato", la sicurezza è un colabrodo.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000002', 'Un pacchetto con flag "ACK" (risposta) arriva al firewall. Uno stateless lo blocca?', 'multiple_choice', '["Sì", "Spesso no, se la regola è ''Permetti traffico stabilito''. Gli hacker usano ''ACK Scan'' per mappare la rete bypassando i filtri semplici", "Sì sempre", "Dipende"]', 1, 'Lo stateless vede "ACK" e pensa "Ah ok, è una risposta, passa pure". Lo Stateful dice "Ehi, nessuno ti ha chiamato!" e blocca.', NULL),
('ba000100-0000-0000-0000-000000000002', 'FTP è un protocollo difficile per i firewall. Perché?', 'multiple_choice', '["È vecchio", "Perché apre porte dinamiche casuali per il trasferimento dati. Il firewall deve capire il protocollo (Inspection) per aprire temporaneamente quelle porte", "Usa la porta 21", "È lento"]', 1, 'Richiede "Application Layer Gateway" (ALG).', NULL),
('ba000100-0000-0000-0000-000000000002', 'UDP ha uno "stato"?', 'multiple_choice', '["Sì", "No, UDP è connectionless. Ma il firewall Stateful ''inventa'' uno stato virtuale basato sui timeout per gestirlo come TCP", "Sì sempre", "Mai"]', 1, 'Il firewall crea una tabella di stato anche per UDP/ICMP.', NULL),
('ba000100-0000-0000-0000-000000000002', 'In una tabella di stato, cosa significa "ESTABLISHED"?', 'true_false', '["Connessione finita", "Connessione attiva e validata (Handshake completato)"]', 1, 'Il traffico passa veloce senza ricontrollare le regole.', NULL),
('ba000100-0000-0000-0000-000000000002', 'In ambito La Memoria del Muro (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Next-Gen Firewall (NGFW) - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000003', 'BA', 'Vedere l''Invisibile',
    'Aprire la busta senza rompere il sigillo?',
    E'# SSL Inspection (DPI)\n\nOggi il 90% del traffico è cifrato (HTTPS).\nUn firewall classico è cieco: vede passare dati cifrati e non sa se contengono gattini o ransomware.\n\nIl **NGFW** fa "Man-in-the-Middle" legale: decifra il traffico, lo controlla con l''antivirus, lo ricifra e lo manda all''utente.\nMa attenzione alla privacy!',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000003', 'Per fare SSL Inspection aziendale senza errori di certificato sui PC, cosa devi fare?', 'multiple_choice', '["Nulla", "Installare il certificato Root CA del Firewall su tutti i PC dei dipendenti come ''Autorità Fidata''", "Disabilitare SSL", "Usare HTTP"]', 1, 'Senza la Root CA, i browser daranno l''errore "Sito non sicuro" perché vedono il certificato del firewall, non quello vero.', NULL),
('ba000100-0000-0000-0000-000000000003', 'È legale decifrare il traffico Home Banking dei dipendenti?', 'multiple_choice', '["Sì", "Generalmente NO. I NGFW hanno liste di esclusione per categorie ''Finance/Health'' per rispettare la privacy normativa e non vedere i saldi bancari", "Sì, sono pagati per lavorare", "Solo in pausa"]', 1, 'Il bypass per il banking è mandatorio in molte giurisdizioni.', NULL),
('ba000100-0000-0000-0000-000000000003', 'Cos''è il "Certificate Pinning" nelle App mobili?', 'multiple_choice', '["Una spilla", "Una tecnica che impedisce al NGFW di decifrare il traffico. L''App si rifiuta di connettersi se non vede ESATTAMENTE il certificato originale del server", "Un virus", "Un backup"]', 1, 'Dropbox e le App bancarie usano il Pinning per evitare l''ispezione, anche se legittima.', NULL),
('ba000100-0000-0000-0000-000000000003', 'L''ispezione SSL rallenta il Firewall?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, la decifratura è computazionalmente pesantissima (CPU intensive). Spesso abbatte le prestazioni del 50%.', NULL),
('ba000100-0000-0000-0000-000000000003', 'In ambito Vedere l''''Invisibile (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- LECCE (LE) - Intrusion Detection ("Il Barocco Complesso")
-- =================================================================================================

-- Mission 1: Signature vs Anomaly - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000004', 'LE', 'Riconoscere il Male',
    'Sai chi è il ladro? O cerchi chi "si comporta" da ladro?',
    E'# IDS: Metodi di Rilevamento\n\n*   **Signature-based:** Cerca impronte esatte di attacchi noti (es. "Se vedi il pacchetto `0x909090`, è un exploit"). Veloce, ma cieco sugli attacchi nuovi.\n*   **Anomaly-based (Heuristic):** Crea un "profilo normale" del traffico. Se il traffico triplica di colpo alle 3 di notte, allerta. Rileva tutto, ma fa molti errori (Falsi Positivi).',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000004', 'Un amministratore scarica la ISO di Windows (5GB) e l''IDS Anomaly-based lo blocca. Cos''è?', 'multiple_choice', '["Un attacco", "Un Falso Positivo. L''azione è legittima ma ''anomala'' rispetto al traffico abituale", "Un virus", "Un errore di rete"]', 1, 'I Falsi Positivi sono il nemico numero 1 degli analisti SOC.', NULL),
('ba000100-0000-0000-0000-000000000004', 'L''IDS Signature-based rileva uno Zero-Day mai visto prima?', 'multiple_choice', '["Sì", "No, perché non esiste ancora la firma nel database", "Sì, se è potente", "Forse"]', 1, 'È reattivo, non proattivo.', NULL),
('ba000100-0000-0000-0000-000000000004', 'Qual è la differenza fondamentale tra IDS e IPS?', 'multiple_choice', '["Una lettera", "IDS Rileva (Detection) e invia email. IPS Previene (Prevention) e blocca il pacchetto attivamente", "IPS costa meno", "Nessuna"]', 1, 'L''IPS è "in-line" (sul cavo), l''IDS è spesso "out-of-band" (ascolta una copia del traffico).', NULL),
('ba000100-0000-0000-0000-000000000004', 'Gli aggiornamenti delle firme IDS sono inutili.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Vanno aggiornate ogni giorno, come l''antivirus.', NULL),
('ba000100-0000-0000-0000-000000000004', 'Approfondimento su: PATTERN. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Evasion - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000005', 'LE', 'Divisi per Vincere',
    'Se spezzetti il veleno, l''antidoto non funziona.',
    E'# Fragmentation Attack\n\nL''attaccante invia un exploit diviso in tanti piccoli pacchetti IP frammentati.\n\n*   Pacchetto 1: "GET /cgi-b"\n*   Pacchetto 2: "in/exploit"\n\nSe l''IDS analizza i pacchetti uno per uno, non vede nulla di male in "GET /cgi-b".\nIl server bersaglio però riassembla i pezzi ed esegue l''attacco.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000005', 'Come si difende un IPS moderno dalla frammentazione?', 'multiple_choice', '["Blocca tutto", "Esegue il ''Packet Reassembly'' in memoria prima dell''ispezione, ricostruendo lo stream come lo vedrebbe la vittima", "Ignora i frammenti", "Usa l''AI"]', 1, 'Richiede molta RAM, ma è necessario per vedere l''attacco intero.', NULL),
('ba000100-0000-0000-0000-000000000005', 'Cos''è l''obfuscation (url encoding) negli URL web?', 'multiple_choice', '["Scrivere male", "Usare `%20` invece di spazio, o codifiche esotiche per mascherare parole chiave dannose (es. `SELECT` -> `%53%45%4C%45%43%54`) agli occhi dell''IDS", "Crittografia", "Errore"]', 1, 'L''IDS deve saper decodificare (Normalize) prima di ispezionare.', NULL),
('ba000100-0000-0000-0000-000000000005', 'Se l''IPS è troppo lento a processare, cosa succede alla rete?', 'multiple_choice', '["Nulla", "Rallenta tutto (Latenza) o, in caso di ''Fail Open'', lascia passare tutto il traffico per non bloccare l''azienda (rischio sicurezza)", "Si spegne", "Esplode"]', 1, 'In caso di sovraccarico, la scelta è "Bloccare tutto" (Fail Closed) o "Passare tutto" (Fail Open).', NULL),
('ba000100-0000-0000-0000-000000000005', 'Spedire i pacchetti fuori ordine (Out-of-order) confonde gli IDS semplici.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Devono riordinarli per capire.', NULL),
('ba000100-0000-0000-0000-000000000005', 'In ambito Divisi per Vincere (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Encrypted Traffic Analysis - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000006', 'LE', 'Impronte Digitali Cifrate',
    'Riconoscere l''assassino dal modo in cui cammina nel buio.',
    E'# JA3 Fingerprinting\n\nNon possiamo decifrare il traffico (privacy).\nMa possiamo guardare *come* il client avvia la connessione cifrata (Client Hello).\nOgni malware (e ogni browser) usa una combinazione unica di versioni TLS, algoritmi supportati e curve ellittiche.\n\nQuesta "impronta digitale" si chiama **JA3**. Ci permette di dire: "Quello è il malware Emotet" senza leggere i dati.',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000006', 'Se un malware usa le librerie standard di Windows per HTTPS, la sua impronta JA3 sarà...', 'multiple_choice', '["Unica", "Uguale a quella di Internet Explorer/Edge o PowerShell, confondendosi col traffico legittimo (False Negative)", "Vuota", "Rossa"]', 1, 'È il limite del fingerprinting: il "Living off the Land" maschera anche l''impronta di rete.', NULL),
('ba000100-0000-0000-0000-000000000006', 'L''analisi dei metadati del traffico cifrato (ETA) guarda anche la "Lunghezza dei pacchetti" e il "Tempo tra i pacchetti"?', 'multiple_choice', '["No", "Sì. Ad esempio, una sessione SSH interattiva ha pacchetti piccoli e irregolari (tasti premuti). Un download ha pacchetti grandi e continui", "Solo il colore", "Inutile"]', 1, 'Riconoscere il TIPO di traffico (video vs chat vs upload) è possibile anche se cifrato.', NULL),
('ba000100-0000-0000-0000-000000000006', 'JA3S serve a impartire impronta digitale al server.', 'true_false', '["Vero", "Falso"]', 0, 'JA3 = Client. JA3S = Server. Insieme creano un rilevamento molto preciso.', NULL),
('ba000100-0000-0000-0000-000000000006', 'Cambiare browser cambia la tua JA3 signature?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, Chrome e Firefox negoziano TLS in modo diverso.', NULL),
('ba000100-0000-0000-0000-000000000006', 'In ambito Impronte Digitali Cifrate (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- TARANTO (TA) - Industrial Security (OT/SCADA) ("L'Acciaieria")
-- =================================================================================================

-- Mission 1: Il Mito dell'Air Gap - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000007', 'TA', 'Il Mito dell''Air Gap',
    'Stuxnet non aveva internet.',
    E'# Air Gap\n\nSi crede che le reti industriali (OT) siano sicure perché "staccate da Internet".\n\n**La realtà:**\n1.  I tecnici collegano laptop di manutenzione (infetti).\n2.  Si usano chiavette USB per aggiornare i PLC.\n3.  C''è quasi sempre un "Collega" nascosto verso la rete uffici (IT) per mandare i dati di produzione al gestionale.\n\nL''Air Gap puro è un mito.',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000007', 'Come è entrato Stuxnet nella centrale nucleare iraniana (Air Gapped)?', 'multiple_choice', '["Via Wi-Fi", "Via chiavetta USB infetta usata da un ingegnere inconsapevole", "Via mail", "Via satellite"]', 1, 'Il fattore umano scavalca qualsiasi muro fisico.', NULL),
('ba000100-0000-0000-0000-000000000007', 'Cos''è un "Data Diode"?', 'multiple_choice', '["Un LED", "Un dispositivo hardware che permette il flusso di dati SOLO in una direzione (es. dalla Fabbrica all''Ufficio) ma impedisce fisicamente qualsiasi ritorno (Nessun comando può entrare)", "Un cavo rotto", "Un router"]', 1, 'L''unica vera garanzia fisica per connettere reti critiche.', NULL),
('ba000100-0000-0000-0000-000000000007', 'Collegare la rete SCADA a Internet per la "Teleassistenza" è sicuro?', 'multiple_choice', '["Sì, se il tecnico è bravo", "No, è un rischio enorme. Espone macchinari fisici pericolosi ad attacchi remoti (es. shodan)", "Sì, col 5G", "Solo il weekend"]', 1, 'Vedi attacco all''acquedotto in Florida (TeamViewer abusato).', NULL),
('ba000100-0000-0000-0000-000000000007', 'I PLC hanno antivirus?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Sono computer embedded minimali. Non puoi installarci nulla. La sicurezza deve essere nella rete.', NULL),
('ba000100-0000-0000-0000-000000000007', 'In ambito Il Mito dell''''Air Gap (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Modbus & Protocolli Antichi - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000008', 'TA', 'Parole in Chiaro',
    'Le macchine parlano una lingua degli anni ''70.',
    E'# Modbus TCP\n\nCreato nel 1979.\n*   **Nessuna Autenticazione:** Chiunque invii il comando "Spegni", viene obbedito.\n*   **Nessuna Cifratura:** I comandi viaggiano in chiaro.\n\nProteggere una rete Modbus richiede firewall industriali (Deep Packet Inspection OT) che controllano CHI manda QUALE comando.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000008', 'Se un hacker è nella rete OT, cosa gli impedisce di dare comandi al PLC?', 'multiple_choice', '["La password", "Nulla, nella maggior parte dei protocolli industriali legacy (Modbus, Profinet). La sicurezza è solo perimetrale", "L''antivirus", "La coscienza"]', 1, 'Security by Protocol Design non esisteva 40 anni fa.', NULL),
('ba000100-0000-0000-0000-000000000008', 'Cos''è un attacco "Man-in-the-Middle" su Modbus?', 'multiple_choice', '["Rubare cavi", "Intercettare i comandi di lettura temperatura e falsificarli per dire all''operatore ''Tutto Ok'' mentre il macchinario brucia", "Spegnere la luce", "Un errore"]', 1, 'Esattamente quello che ha fatto Stuxnet (Replay Attack / Falsificazione dati sensoristica).', NULL),
('ba000100-0000-0000-0000-000000000008', 'Esistono versioni sicure dei protocolli (es. Modbus Secure)?', 'multiple_choice', '["No", "Sì, ma richiedono hardware nuovo e costoso. Aggiornare una fabbrica richiede 20 anni, non 2 mesi", "Sì, basta scaricarli", "No"]', 1, 'Il ciclo di vita OT è decennale. Il patching è lentissimo.', NULL),
('ba000100-0000-0000-0000-000000000008', 'Un firewall IT standard capisce il protocollo Modbus?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Vede solo "Traffico TCP porta 502". Serve un firewall OT specifico per dire "Blocca comando WRITE, permetti READ".', NULL),
('ba000100-0000-0000-0000-000000000008', 'In ambito Parole in Chiaro (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: IT vs OT - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000009', 'TA', 'Non Toccare!',
    'Scansionare una fabbrica può distruggerla.',
    E'# Fragilità OT\n\nNel mondo IT (Computer), se fai una scansione Nmap intensa, al massimo rallenti la rete.\nNel mondo OT (PLC, Robot), una scansione attiva può **bloccare il dispositivo**.\n\nI PLC hanno processori minuscoli. Ricevere troppe richieste impreviste li manda in crash, fermando la produzione (Danno economico enorme).\nIn OT si usa il monitoraggio **PASSIVO** (ascolto copia del traffico).',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000009', 'Qual è la priorità numero 1 nell''OT (Operational Technology)?', 'multiple_choice', '["Confidenzialità (Privacy)", "Disponibilità (Availability) e Sicurezza Fisica (Safety). Nessuno deve farsi male e la fabbrica non deve fermarsi", "Integrità", "Velocità"]', 1, 'In IT è CIA (Confidentiality, Integrity, Availability). In OT è AIC (Availability, Integrity, Confidentiality) + Safety.', NULL),
('ba000100-0000-0000-0000-000000000009', 'Cosa succede se aggiorni (Patch) un server SCADA senza testare?', 'multiple_choice', '["Diventa più sicuro", "Rischi che il software di controllo non sia compatibile con la patch Windows e smetta di funzionare. Il patching in OT è un incubo pianificato", "Si riavvia", "Nulla"]', 1, 'Spesso i vendor certificano le patch mesi dopo Microsoft.', NULL),
('ba000100-0000-0000-0000-000000000009', 'Il "Virtual Patching" può aiutare in OT?', 'multiple_choice', '["No", "Sì, mettere un firewall davanti al PC vulnerabile (XP) che blocca gli exploit di rete, senza dover toccare il PC stesso", "Forse", "Cos''è?"]', 1, 'È l''unica soluzione per proteggere sistemi Legacy non aggiornabili (Legacy Shielding).', NULL),
('ba000100-0000-0000-0000-000000000009', 'Possiamo usare il Cloud per gestire direttamente i robot industriali?', 'true_false', '["Vero", "Falso"]', 1, 'Falso (o molto rischioso). La latenza e la perdita di connessione Internet creerebbero pericoli di sicurezza fisica.', NULL),
('ba000100-0000-0000-0000-000000000009', 'In ambito Non Toccare! (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
