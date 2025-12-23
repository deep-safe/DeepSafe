-- Mission Seed for Umbria (Theme: "Codici Segreti & Privacy del Cuore Verde")
-- Region: Umbria
-- Provinces: Perugia (PG), Terni (TR)

-- =================================================================================================
-- PERUGIA (PG) - Crittografia & Steganografia ("L'Arte di Nascondere")
-- =================================================================================================

-- Mission 1: Il Codice del Monaco (Facile)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123001', 'PG', 'Il Codice del Monaco',
    'Capire perché nascondiamo i messaggi.',
    E'# Crittografia Classica\n\nFin dall''antichità (dai tempi di Giulio Cesare), l''uomo ha sentito il bisogno di proteggere i propri messaggi da occhi indiscreti.\n\nLa **Crittografia** è l''arte di scrivere in codice.\nUn tempo si usavano dischi rotanti e bastoni (Scitala), oggi usiamo la matematica, ma il concetto è lo stesso: nascondere il significato a chi non possiede la **chiave**.',
    'semplice', '5 min', 50, 'level_1', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123001', 'Qual è lo scopo principale della crittografia?', 'multiple_choice', '["Rendere il messaggio più bello", "Nascondere il contenuto a chi non è autorizzato (Confidenzialità)", "Correggere gli errori di grammatica", "Spedire il messaggio più velocemente"]', 1, 'La confidenzialità è il pilastro della crittografia.', NULL),
('a738848f-3760-44d4-9844-245367123001', 'Cos''è il Cifrario di Cesare?', 'multiple_choice', '["Una insalata famosa", "Un metodo che sposta le lettere dell''alfabeto di un numero fisso di posizioni", "Un codice per aprire le porte", "Un antico computer romano"]', 1, 'Cesare spostava le lettere di 3 posizioni (A diventa D).', NULL),
('a738848f-3760-44d4-9844-245367123001', 'Perché "encoding" (codifica) e "encryption" (cifratura) sono diversi?', 'multiple_choice', '["Sono la stessa cosa", "La codifica serve solo a cambiare formato (es. Morse, ASCII) senza segreti, la cifratura protegge con una chiave", "La cifratura è gratis", "La codifica usa i numeri"]', 1, 'Se non c''è una chiave segreta, è solo codifica, non crittografia.', NULL),
('a738848f-3760-44d4-9844-245367123001', 'In crittografia, il messaggio in chiaro si chiama "Plaintext".', 'true_false', '["Vero", "Falso"]', 0, 'Plaintext è il testo leggibile, Ciphertext è quello cifrato.', NULL),
('a738848f-3760-44d4-9844-245367123001', 'In ambito Il Codice del Monaco (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Chiavi e Lucchetti Digitali (Medio)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123002', 'PG', 'Chiavi e Lucchetti Digitali',
    'Come viaggiano sicuri i dati sul web.',
    E'# Simmetrica vs Asimmetrica\n\nImmagina una scatola:\n*   **Crittografia Simmetrica:** C''è una sola chiave. Chi chiude la scatola deve dare la chiave a chi la apre (rischio: se ti rubano la chiave, leggono tutto).\n*   **Crittografia Asimmetrica:** Ci sono due chiavi. Una "Pubblica" (chiunque può chiudere la scatola) e una "Privata" (solo tu puoi aprirla). È così che funziona HTTPS sul web.',
    'medio', '10 min', 75, 'level_2', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123002', 'Cosa significa la "S" in HTTPS?', 'multiple_choice', '["Speed", "Secure", "Simple", "System"]', 1, 'Indica che la connessione è cifrata (usando TLS/SSL).', NULL),
('a738848f-3760-44d4-9844-245367123002', 'Nella crittografia Asimmetrica, quale chiave dai a tutti?', 'multiple_choice', '["La Chiave Privata", "La Chiave di Casa", "La Chiave Pubblica", "Nessuna"]', 2, 'La Pubblica serve per cifrare (chiudere il lucchetto), la Privata per decifrare (aprire).', NULL),
('a738848f-3760-44d4-9844-245367123002', 'Qual è il vantaggio della crittografia Simmetrica?', 'multiple_choice', '["È più sicura", "È molto più veloce di quella asimmetrica", "Non usa chiavi", "Funziona senza computer"]', 1, 'È computazionalmente più leggera, per questo si usa per cifrare il traffico dati vero e proprio.', NULL),
('a738848f-3760-44d4-9844-245367123002', 'È sicuro condividere la tua Chiave Privata con il supporto tecnico.', 'true_false', '["Vero", "Falso"]', 1, 'MAI condividere la chiave privata. Mai.', NULL),
('a738848f-3760-44d4-9844-245367123002', 'In ambito Chiavi e Lucchetti Digitali (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Note Nascoste (Difficile)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123003', 'PG', 'Note Nascoste',
    'Nascondere segreti dentro una foto di gattini.',
    E'# Steganografia & Hashing\n\nNon serve solo cifrare, a volte serve nascondere l''esistenza del messaggio.\n\n*   **Steganografia:** Nascondere un file dentro un altro (es. cambiare i pixel di una foto per scrivere testo).\n*   **Hashing:** Trasformare un testo in una stringa unica (es. password) impossibile da invertire.\n\nSe un hacker intercetta il file, vede solo un''immagine innocua.',
    'difficile', '15 min', 150, 'level_3', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123003', 'Cos''è l''Hashing?', 'multiple_choice', '["Un modo per comprimere i file", "Una funzione unidirezionale che crea un''impronta digitale fissa di un dato", "Un social network", "Un tipo di hashtag"]', 1, 'Da un Hash non si può tornare al testo originale.', NULL),
('a738848f-3760-44d4-9844-245367123003', 'A cosa serve la Steganografia?', 'multiple_choice', '["A nascondere l''esistenza stessa della comunicazione", "A cifrare i dati", "A velocizzare internet", "A fare musica"]', 0, 'Security through Obscurity (ma fatta bene).', NULL),
('a738848f-3760-44d4-9844-245367123003', 'Le password dovrebbero essere salvate nel database come...', 'multiple_choice', '["Testo in chiaro", "File Word", "Hash (con Salt)", "Crittografia reversibile"]', 2, 'Così se il DB viene rubato, le password non sono leggibili.', NULL),
('a738848f-3760-44d4-9844-245367123003', 'Modificare anche un solo bit di un file cambia completamente il suo Hash.', 'true_false', '["Vero", "Falso"]', 0, 'Si chiama "effetto valanga" ed è fondamentale per l''integrità.', NULL),
('a738848f-3760-44d4-9844-245367123003', 'Approfondimento su: OCCHI. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- =================================================================================================
-- TERNI (TR) - GDPR & Privacy ("L'Industria dei Dati")
-- =================================================================================================

-- Mission 1: Dati d'Acciaio (Facile)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123004', 'TR', 'Dati d''Acciaio',
    'Cosa sono i tuoi dati personali?',
    E'# Personal Identifiable Information (PII)\n\nI tuoi dati sono il nuovo petrolio (o acciaio).\n\n*   **Dati Personali:** Nome, email, telefono (ti identificano).\n*   **Dati Sensibili:** Salute, orientamento politico, religione (richiedono protezione extra).\n\nIl **GDPR** è la legge europea che difende questi dati.',
    'semplice', '5 min', 50, 'level_1', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123004', 'Cosa si intende per PII?', 'multiple_choice', '["Personal Internet IP", "Personal Identifiable Information (Informazioni Identificabili Personalmente)", "Private International Institute", "Post in Instagram"]', 1, 'Sono tutti i dati che possono portare alla tua identità.', NULL),
('a738848f-3760-44d4-9844-245367123004', 'Quale di questi è un "Dato Sensibile"?', 'multiple_choice', '["Il tuo nome", "Il tuo indirizzo email", "La tua cartella clinica", "Il tuo colore preferito"]', 2, 'I dati sanitari richiedono tutele maggiori nel GDPR.', NULL),
('a738848f-3760-44d4-9844-245367123004', 'Il GDPR protegge...', 'multiple_choice', '["Le aziende", "I cittadini dell''Unione Europea e i loro dati", "I computer", "I server americani"]', 1, 'È una normativa incentrata sulla persona fisica.', NULL),
('a738848f-3760-44d4-9844-245367123004', 'Una foto del tuo volto è considerata un dato biometrico.', 'true_false', '["Vero", "Falso"]', 0, 'Sì, perché permette l''identificazione univoca.', NULL),
('a738848f-3760-44d4-9844-245367123004', 'In ambito Dati d''''Acciaio (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Il Diritto di Sparire (Medio)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123005', 'TR', 'Il Diritto di Sparire',
    'Puoi chiedere a Internet di dimenticarti?',
    E'# Diritto all''Oblio\n\nInternet non dimentica, ma tu hai dei diritti.\n\n*   **Diritto all''Oblio:** Puoi chiedere a Google o a un sito di rimuovere link a vecchie notizie su di te non più rilevanti.\n*   **Consenso:** I banner dei cookie servono a chiederti il permesso. "Legittimo Interesse" non copre tutto!',
    'medio', '10 min', 75, 'level_2', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123005', 'Cos''è il "Diritto all''Oblio"?', 'multiple_choice', '["Il diritto a non studiare storia", "Il diritto a ottenere la cancellazione dei propri dati personali se non più necessari", "Il diritto a navigare in incognito", "Il diritto a perdere la password"]', 1, 'Right to be Forgotten (Art. 17 GDPR).', NULL),
('a738848f-3760-44d4-9844-245367123005', 'Cosa sono i cookie di profilazione?', 'multiple_choice', '["Biscotti digitali", "File che tracciano il tuo comportamento per mostrarti pubblicità mirata", "Virus", "Antivirus"]', 1, 'Servono il consenso esplicito (Opt-in).', NULL),
('a738848f-3760-44d4-9844-245367123005', 'Se un sito non ha il banner dei cookie...', 'multiple_choice', '["È legale", "Probabilmente sta violando la normativa se usa cookie non tecnici", "È più veloce", "È americano"]', 1, 'In UE è obbligatorio informare l''utente.', NULL),
('a738848f-3760-44d4-9844-245367123005', 'È obbligatorio cliccare "Accetta Tutto" per visitare un sito.', 'true_false', '["Vero", "Falso"]', 1, 'È un "Dark Pattern". Dev''esserci l''opzione "Solo Necessari" o "Rifiuta".', NULL),
('a738848f-3760-44d4-9844-245367123005', 'Approfondimento su: NASCOSTO. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Falla nel Sistema (Difficile)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'a738848f-3760-44d4-9844-245367123006', 'TR', 'Falla nel Sistema',
    'Cosa fare quando i tuoi dati sono già fuori.',
    E'# Data Breach\n\nSuccede: un''azienda viene hackerata e i tuoi dati finiscono nel Dark Web.\n\n1.  **Non riutilizzare password:** Se usi la stessa ovunque, bucato uno, bucati tutti (Credential Stuffing).\n2.  **HaveIBeenPwned:** Controlla se la tua email è compromessa.\n3.  **2FA:** Attiva l''autenticazione a due fattori ovunque.',
    'difficile', '15 min', 150, 'level_3', 'Umbria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('a738848f-3760-44d4-9844-245367123006', 'Entro par quanto tempo un''azienda deve notificare un Data Breach grave?', 'multiple_choice', '["1 settimana", "72 ore", "1 mese", "Mai"]', 1, 'Il GDPR impone tempi strettissimi per avvisare l''autorità.', NULL),
('a738848f-3760-44d4-9844-245367123006', 'Cos''è il "Credential Stuffing"?', 'multiple_choice', '["Riempire il tacchino", "Provare username/password rubati da un sito su tanti altri siti sperando siano uguali", "Creare password lunghe", "Rubare lo staff"]', 1, 'Per questo il riutilizzo delle password è il peccato capitale.', NULL),
('a738848f-3760-44d4-9844-245367123006', 'Data la password "Pippo123", quanto tempo serve a un hacker per crackarla?', 'multiple_choice', '["Mille anni", "Istantaneamente", "Un giorno", "Un minuto"]', 1, 'È nelle liste comuni, viene indovinata al primo tentativo.', NULL),
('a738848f-3760-44d4-9844-245367123006', 'Se modifico la password dopo un breach, l''hacker perde l''accesso.', 'true_false', '["Vero", "Falso"]', 0, 'Salvo che non abbia installato una backdoor o rubato i token di sessione, cambiare password ti protegge per il futuro.', NULL),
('a738848f-3760-44d4-9844-245367123006', 'In ambito Falla nel Sistema (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
