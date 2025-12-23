-- Mission Seed for Sicilia (Part 2)
-- Region: Sicilia (HARD / TRICKY EDITION)
-- Provinces: Siracusa (SR), Ragusa (RG), Caltanissetta (CL), Enna (EN)

-- =================================================================================================
-- SIRACUSA (SR) - Alternative Darknets ("I Rifugi Segreti")
-- =================================================================================================

-- Mission 1: I2P vs Tor - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000015', 'SR', 'Il Progetto Invisibile',
    'Non solo cipolle, ma aglio.',
    E'# I2P (Invisible Internet Project)\n\nTor è ottimizzato per navigare il web normale (Clearweb) in anonimato.\nI2P è ottimizzato per servizi nascosti (Hidden Services) che comunicano TRA LORO.\n\nDifferenze:\n*   Tor usa circuiti bidirezionali.\n*   I2P usa tunnel unidirezionali (uno per entrare, uno per uscire). Più veloce e sicuro per il P2P.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000015', 'I2P è accessibile con un browser normale?', 'multiple_choice', '["No, serve configurare un proxy locale (127.0.0.1:4444)", "Sì, basta digitare l''indirizzo .i2p nella barra URL", "No, serve un cavo in fibra ottica speciale installato", "Sì, Chrome lo supporta nativamente nelle impostazioni"]', 0, 'Richiede il software Router I2P (Java o C++) in background.', NULL),
('51c11a01-0000-0000-0000-000000000015', 'Perché I2P è migliore per il Torrenting rispetto a Tor?', 'multiple_choice', '["Il protocollo a pacchetti (Garlic Routing) regge il carico", "Tor blocca il traffico torrent per policy degli exit node", "I2P è illegale quindi più veloce senza limiti di banda", "Non c''è differenza, entrambi vanno bene per scaricare"]', 0, 'Tor collassa con il traffico P2P. I2P è progettato per esso.', NULL),
('51c11a01-0000-0000-0000-000000000015', 'I2P ha degli "Exit Node" verso internet come Tor?', 'multiple_choice', '["Pochissimi (Outproxies) e lenti, non è il suo scopo primario", "Migliaia, molto più veloci ed efficienti di quelli Tor", "Nessuno, è una rete chiusa ermeticamente (LAN globale)", "Sì, gestiti direttamente da Google e Facebook gratis"]', 0, 'Navigare su Google con I2P è un''esperienza dolorosa.', NULL),
('51c11a01-0000-0000-0000-000000000015', 'La rete I2P è centralizzata.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Completamente distribuita senza Directory Authority centrali (usa DHT).', NULL),
('51c11a01-0000-0000-0000-000000000015', 'Approfondimento su: TUNNEL. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Freenet - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000016', 'SR', 'L''Archivio Immortale',
    'Un hard disk globale e incensurabile.',
    E'# Freenet\n\nNon è una rete per navigare.\nÈ un **Datastore Distribuito**.\n\nQuando carichi un file su Freenet, questo viene spezzettato, cifrato e distribuito sui computer degli altri utenti.\nNessuno sa cosa ospita.\nIl file rimane online anche spegni il PC.\nImpossibile da cancellare (Censorship Resistant).',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000016', 'Cos''è la modalità "Darknet" in Freenet?', 'multiple_choice', '["Connettersi SOLO agli amici fidati (Friend-to-Friend F2F)", "Attivare il tema scuro dell''interfaccia grafica utente", "Accedere ai siti illegali nascosti nella rete pubblica", "Spegnere lo schermo mentre il computer scarica file"]', 0, 'F2F rende la rete impossibile da enumerare per un attaccante esterno.', NULL),
('51c11a01-0000-0000-0000-000000000016', 'Se ospiti un nodo Freenet, sei responsabile dei file?', 'multiple_choice', '["No, grazie alla ''Plausible Deniability''. Tutto è cifrato", "Sì, la polizia può leggerti l''hard disk e arrestarti", "Sì, ma solo se i file superano 1GB di dimensione", "No, perché i server sono in Russia e non in Italia"]', 0, 'Tu offri spazio su disco cifrato. Non hai la chiave per sapere COSA c''è dentro.', NULL),
('51c11a01-0000-0000-0000-000000000016', 'Quanto è veloce scaricare un file da Freenet?', 'multiple_choice', '["Molto lento (alta latenza), non adatto allo streaming", "Istantaneo come BitTorrent su fibra ottica pura", "Veloce solo se paghi un abbonamento mensile", "Dipende dalla marca del tuo router wifi di casa"]', 0, 'È progettato per sopravvivenza dei dati, non performance.', NULL),
('51c11a01-0000-0000-0000-000000000016', 'Freenet supporta siti web dinamici (PHP/MySQL)?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Solo siti statici (HTML/CSS) chiamati "Freesites". Niente server-side scripting.', NULL),
('51c11a01-0000-0000-0000-000000000016', 'In ambito L''''Archivio Immortale (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Zeronet - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000017', 'SR', 'Il Web Senza Server',
    'Se visiti il sito, TU diventi il sito.',
    E'# ZeroNet\n\nUsa la crittografia Bitcoin e la rete BitTorrent.\n1.  Ogni sito è un indirizzo Bitcoin.\n2.  Quando visiti un sito, scarichi tutto il contenuto via Torrent.\n3.  Ora anche TU ospiti quel sito e lo servi agli altri.\n\nImpossibile tirarlo giù finché c''è almeno 1 peer online.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000017', 'ZeroNet garantisce l''anonimato dell''IP di default?', 'multiple_choice', '["No, usa BitTorrent quindi l''IP è visibile. Serve Tor", "Sì, cifra tutto e nasconde l''IP automaticamente", "Sì, ma solo se usi la modalità privata del browser", "No, ma non serve perché è legale in tutto il mondo"]', 0, 'ZeroNet + Tor è necessario per l''anonimato. ZeroNet da solo è solo decentralizzazione.', NULL),
('51c11a01-0000-0000-0000-000000000017', 'Come si aggiorna un sito su ZeroNet?', 'multiple_choice', '["Il proprietario firma i nuovi file con la chiave privata Bitcoin", "Bisogna contattare l''hosting provider centrale e pagare", "Si caricano i file via FTP come su Altervista anni 90", "I visitatori possono modificare il sito liberamente"]', 0, 'La firma crittografica verifica l''autenticità dell''aggiornamento che si propaga P2P.', NULL),
('51c11a01-0000-0000-0000-000000000017', 'Cosa succede se cancelli i file di ZeroNet dal tuo PC?', 'multiple_choice', '["Smetti di fare seeding, ma il sito vive sugli altri peer", "Il sito viene cancellato da internet per tutti quanti", "Vieni bannato dalla rete per comportamento egoista", "Nulla, i file si rigenerano da soli magicamente"]', 0, 'La resilienza dipende dalla ridondanza dei nodi.', NULL),
('51c11a01-0000-0000-0000-000000000017', 'ZeroNet usa i nomi di dominio .bit (Namecoin).', 'true_false', '["Vero", "Falso"]', 0, 'Sì, per avere nomi leggibili invece di indirizzi Bitcoin lunghi.', NULL),
('51c11a01-0000-0000-0000-000000000017', 'In ambito Il Web Senza Server (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- RAGUSA (RG) - OpSec & Tails ("L'Uomo Invisibile")
-- =================================================================================================

-- Mission 1: Tails OS - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000018', 'RG', 'Amnesia Digitale',
    'Lasciare tracce è un errore capitale.',
    E'# Tails (The Amnesic Incognito Live System)\n\nUn sistema operativo Linux su chiavetta USB.\nAvvii il PC dalla USB.\nUsi Tor, PGP, fai quello che devi fare.\nSpegni il PC (o strappi la chiavetta).\n\n**Risultato:** La RAM viene cancellata. Nessuna traccia sull''Hard Disk del PC. Come se non fossi mai esistito.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000018', 'Se usi Tails su un PC Windows infetto, sei sicuro?', 'multiple_choice', '["Quasi sempre sì, perché Windows non viene proprio avviato", "No, il virus di Windows infetta la chiavetta USB subito", "Sì, ma solo se l''antivirus di Windows è aggiornato", "No, i virus moderni risiedono tutti nel chip BIOS"]', 0, 'Tails bypassa l''OS installato. Il rischio residuo è solo firmware/BIOS/Hardware logger.', NULL),
('51c11a01-0000-0000-0000-000000000018', 'Cosa succede se strappi la USB mentre Tails è acceso?', 'multiple_choice', '["Emergency Shutdown: sovrascrive la RAM e spegne tutto", "Corrompe la chiavetta e perdi i dati persistenti", "Nulla, continua a funzionare finché c''è batteria", "Windows si riavvia automaticamente per sicurezza"]', 0, 'Funzione vitale in caso di irruzione fisica (Raid).', NULL),
('51c11a01-0000-0000-0000-000000000018', 'Posso salvare file su Tails?', 'multiple_choice', '["Sì, creando un volume ''Persistent Storage'' cifrato sulla USB", "No, Tails è amnesico e dimentica tutto per design", "Sì, ma solo caricandoli sul cloud Google Drive", "No, devi usare un secondo hard disk esterno cifrato"]', 0, 'La persistenza cifrata (LUKS) è opzionale e sicura.', NULL),
('51c11a01-0000-0000-0000-000000000018', 'Tails instrada tutto il traffico su Tor obbligatoriamente.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Se un''app prova a uscire senza Tor, viene bloccata dal firewall.', NULL),
('51c11a01-0000-0000-0000-000000000018', 'In ambito Amnesia Digitale (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Metadata Scrubbing - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000019', 'RG', 'La Firma Invisibile',
    'La foto dice dove sei, non cosa vedi.',
    E'# EXIF Data\n\nFai una foto alla merce da vendere col telefono.\nLa carichi sul market.\n\n**Errore:** I metadati EXIF contengono **Coordinate GPS**, Modello Telefono, Data e Ora esatta.\nLa polizia scarica la foto, legge il GPS, e viene a bussare.\n\nSoluzione: MAT (Metadata Anonymisation Toolkit).',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000019', 'I PDF contengono metadati pericolosi?', 'multiple_choice', '["Sì, autore, software usato, data creazione, revisioni", "No, i PDF sono documenti di sola lettura sicuri", "Solo se contengono immagini al loro interno", "Sì ma solo se creati con Adobe Acrobat originale"]', 0, 'I documenti Office/PDF sono miniere d''oro per l''OSINT.', NULL),
('51c11a01-0000-0000-0000-000000000019', 'Fare screenshot invece di inviare il file originale è sicuro?', 'multiple_choice', '["Spesso sì, rimuove i metadati interni ma riduce qualità", "No, lo screenshot contiene comunque il GPS del monitor", "No, Windows aggiunge una filigrana segreta agli screenshot", "Sì è la tecnica standard usata da tutti gli hacker"]', 0, 'Il "Re-encoding" (screenshot/convert) distrugge gli EXIF originali.', NULL),
('51c11a01-0000-0000-0000-000000000019', 'Tails pulisce i metadati automaticamente?', 'multiple_choice', '["No, devi usare il tool MAT cliccando col tasto destro", "Sì, ogni file che tocchi viene pulito in background", "Sì, ma solo per le immagini JPG e PNG non per i video", "No, Tails non ha strumenti per i metadati installati"]', 0, 'L''utente deve agire consapevolmente con MAT2.', NULL),
('51c11a01-0000-0000-0000-000000000019', 'Caricare foto su Imgur/Social rimuove i metadati.', 'true_false', '["Vero", "Falso"]', 0, 'Vero, la compressione dei social di solito li rimuove. Ma il social li ha letti e loggati prima di cancellarli!', NULL),
('51c11a01-0000-0000-0000-000000000019', 'In ambito La Firma Invisibile (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Separazione Identità - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000020', 'RG', 'Doppia Vita',
    'Mai incrociare i flussi.',
    E'# OpSec Isolation\n\nRegola suprema: L''identità "Dark" non deve MAI toccare l''identità "Real".\n\n*   Mai usare lo stesso nickname.\n*   Mai usare la stessa password.\n*   Mai parlare dei propri hobby o meteo ("Piove forte oggi" restringe l''area geografica).\n*   Mai loggarsi su Gmail dentro Tor.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000020', 'Cosa è la "Stylometry"?', 'multiple_choice', '["Analisi dello stile di scrittura per identificare l''autore", "Misurazione dello stile dei vestiti nelle foto", "Tecnica per creare font anonimi per i documenti", "Studio della crittografia stilistica antica"]', 0, 'Il modo in cui usi le virgole o le parole "comuni" è un''impronta digitale semantica.', NULL),
('51c11a01-0000-0000-0000-000000000020', 'Ross Ulbricht (Silk Road) come è stato beccato?', 'multiple_choice', '["Ha usato il suo nick ''altoid'' sia per spammare Silk Road che per chiedere aiuto su codice PHP con la sua mail reale", "Ha venduto droga a un poliziotto sotto copertura per strada", "Ha perso la chiavetta USB con le chiavi in un bar", "Hanno hackerato il server Tor centrale e letto tutto"]', 0, 'Un errore di sovrapposizione identità anni prima del suo arresto.', NULL),
('51c11a01-0000-0000-0000-000000000020', 'Cosa fare se ti rendi conto di aver leakato un dato personale?', 'multiple_choice', '["Bruciare l''identità. Smettere di usare quell''account/chiave immediatamente e crearne una nuova pulita da zero", "Cancellare il messaggio e sperare che nessuno l''abbia visto", "Chiedere scusa pubblicamente sul forum per l''errore", "Cambiare la password e continuare a usare l''account"]', 0, 'Kill Switch dell''identità. Non c''è altra via.', NULL),
('51c11a01-0000-0000-0000-000000000020', 'Usare gergo tecnico specifico può tradirti?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, restringe il cerchio ai professionisti di quel settore.', NULL),
('51c11a01-0000-0000-0000-000000000020', 'In ambito Doppia Vita (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- CALTANISSETTA (CL) - Crime-as-a-Service ("L'Appalto")
-- =================================================================================================

-- Mission 1: Ransomware Affiliate - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000021', 'CL', 'Franchising del Male',
    'Non serve saper programmare per hackerare.',
    E'# RaaS (Ransomware-as-a-Service)\n\nI gruppi elite (es. LockBit) scrivono il virus.\nGli affiliati (tu?) lo noleggiano e infettano le aziende.\n\nIl riscatto viene diviso automaticamente: 70% all''affiliato, 30% agli sviluppatori.\nQuesto modello ha democratizzato il cybercrimine.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000021', 'Perché i creatori di Ransomware usano gli affiliati?', 'multiple_choice', '["Per scalare le operazioni riducendo il rischio diretto di arresto", "Perché non sanno come infettare i computer delle vittime", "Per beneficenza verso i criminali meno esperti", "Per testare il virus su reti diverse e trovare bug"]', 0, 'Delega del rischio. Chi va in galera spesso è l''affiliato.', NULL),
('51c11a01-0000-0000-0000-000000000021', 'Come vengono reclutati gli affiliati?', 'multiple_choice', '["Sui forum darknet russi con annunci di lavoro e colloqui", "Tramite annunci su LinkedIn e Facebook Ads pubblici", "Vengono scelti a caso tra gli utenti di Tor Browser", "Non vengono reclutati, è un club chiuso di amici"]', 0, 'Processo di hiring professionale: richiedono portfolio di accessi.', NULL),
('51c11a01-0000-0000-0000-000000000021', 'L''affiliato deve gestire il pagamento del riscatto?', 'multiple_choice', '["Spesso no, il portale RaaS gestisce negoziazione e decifratura", "Sì, deve fornire il proprio IBAN bancario alla vittima", "Sì, deve andare fisicamente a ritirare i contanti", "No, il pagamento è gestito dalla compagnia assicurativa"]', 0, 'La piattaforma RaaS offre supporto clienti e payment processing.', NULL),
('51c11a01-0000-0000-0000-000000000021', 'Il RaaS colpisce solo grandi aziende.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Colpiscono chiunque abbia dati e soldi (ospedali, PMI, comuni).', NULL),
('51c11a01-0000-0000-0000-000000000021', 'In ambito Franchising del Male (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Doxxing & Swatting - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000022', 'CL', 'Terrore a Domicilio',
    'Dalla tastiera alla squadra SWAT.',
    E'# Swatting\n\nRubare i dati personali (Doxxing) è il primo passo.\nPoi qualcuno chiama la polizia dicendo: "Ho ostaggi e una bomba all''indirizzo X".\nLa SWAT fa irruzione a casa della vittima ignara.\nRisultato: terrore, feriti, a volte morti.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000022', 'Come si protegge il proprio indirizzo di casa dal Doxxing?', 'multiple_choice', '["Rimuovendo i dati dai Data Broker e social media (OpSec)", "Mettendo un cartello falso sulla porta di casa", "Usando una VPN per ordinare la pizza a domicilio", "Non è possibile, l''indirizzo è pubblico per legge"]', 0, 'Hygiene digitale proattiva (Data removal services).', NULL),
('51c11a01-0000-0000-0000-000000000022', 'Lo Swatting è considerato un reato grave?', 'multiple_choice', '["Sì, crimine federale/penale con pene detentive severe", "No, è considerato uno scherzo telefonico (prank)", "Solo se qualcuno si fa male fisicamente durante il raid", "Dipende se la vittima è uno streamer famoso o no"]', 0, 'Le conseguenze legali sono devastanti ora.', NULL),
('51c11a01-0000-0000-0000-000000000022', 'Chi sono i principali bersagli dello Swatting?', 'multiple_choice', '["Streamer Twitch, politici, e rivali online gaming", "Aziende farmaceutiche e banche d''investimento", "Persone anziane che non usano il computer", "Nessuno, è una leggenda metropolitana rara"]', 0, 'La visibilità online attira l''odio.', NULL),
('51c11a01-0000-0000-0000-000000000022', 'Doxbin è un sito famoso per ospitare info di doxxing.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Un archivio pubblico di dati personali rubati.', NULL),
('51c11a01-0000-0000-0000-000000000022', 'Approfondimento su: LUCE. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Initial Access Brokers - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000023', 'CL', 'Chiavi in Mano',
    'Non sfondare la porta, compra la chiave.',
    E'# IAB (Initial Access Brokers)\n\nHacker specializzati nel trovare accessi VPN/RDP di aziende.\nNon rubano dati, non criptano.\nVendono solo l''accesso ("Shell in azienda X, fatturato 100M, privilegi Admin") per 5.000$ sul darknet.\nIl cliente (Ransomware gang) compra ed esegue l''attacco.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000023', 'Qual è il vettore di accesso più venduto dagli IAB?', 'multiple_choice', '["Credenziali VPN rubate o RDP esposti senza MFA", "Exploit Zero-Day su kernel Linux super complessi", "Accesso fisico corrompendo le guardie giurate", "Chiavette USB lasciate nel parcheggio dell''azienda"]', 0, 'Le credenziali valide (InfoStealer logs) sono le più economiche ed efficaci.', NULL),
('51c11a01-0000-0000-0000-000000000023', 'Quanto costa un accesso a una PMI italiana?', 'multiple_choice', '["Poche centinaia o migliaia di dollari (abbordabile)", "Milioni di euro perché è un''azienda europea", "È gratis, lo fanno per gloria e reputazione", "Si paga solo dopo aver incassato il riscatto"]', 0, 'Il mercato è saturo, i prezzi sono bassi.', NULL),
('51c11a01-0000-0000-0000-000000000023', 'Come difendersi dagli Initial Access Brokers?', 'multiple_choice', '["Monitorando il Dark Web per le proprie credenziali e usando MFA ovunque", "Non usando VPN aziendali ma solo connessioni dirette", "Installando tre antivirus diversi sui server", "Licenziando i dipendenti che lavorano da remoto"]', 0, 'Threat Intelligence + MFA robusta è la cura.', NULL),
('51c11a01-0000-0000-0000-000000000023', 'Un IAB esegue il ransomware personalmente?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Vende l''accesso e passa alla prossima vittima. Specializzazione del lavoro.', NULL),
('51c11a01-0000-0000-0000-000000000023', 'In ambito Chiavi in Mano (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- ENNA (EN) - Law Enforcement ("La Cattura")
-- =================================================================================================

-- Mission 1: Honeypots - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000024', 'EN', 'Trappola per Topi',
    'Sembra un market, profuma di market... è la polizia.',
    E'# Operation Onymous\n\nLe forze dell''ordine creano o prendono il controllo di siti illegali (Honeypot).\nLi lasciano aperti per mesi.\nRegistrano IP, messaggi, spedizioni.\nPoi, una mattina, scatta l''arresto di massa per migliaia di utenti.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000024', 'Come Hansa Market è diventato un Honeypot?', 'multiple_choice', '["La polizia olandese ha sequestrato i server e l''ha gestito segretamente per un mese", "Hanno creato il sito da zero fingendosi hacker russi", "Hanno pagato l''admin originale per tradire gli utenti", "Hanno usato un bug di Tor per reindirizzare il traffico"]', 0, 'Il takeover segreto è la tecnica più devastante per la fiducia.', NULL),
('51c11a01-0000-0000-0000-000000000024', 'Cosa succede se fai login su un sito controllato dalla polizia?', 'multiple_choice', '["Hanno le tue credenziali e possono correlarle ad altri siti sequestrati", "Ti arrestano istantaneamente a casa tramite GPS", "Il computer esplode per autodistruzione remota", "Nulla, la polizia non può leggere le password hashate"]', 0, 'Costruiscono il profilo criminale incrociato.', NULL),
('51c11a01-0000-0000-0000-000000000024', 'Perché lasciano il sito aperto invece di chiuderlo subito?', 'multiple_choice', '["Per raccogliere più prove e identificare i pesci grossi (vendor/admin)", "Perché non sanno come spegnere i server Linux", "Per guadagnare le commissioni sulle vendite illegali", "Per attendere l''autorizzazione del giudice internazionale"]', 0, 'Intelligence gathering > Disruption immediata.', NULL),
('51c11a01-0000-0000-0000-000000000024', 'Un Honeypot può distribuire malware agli utenti?', 'true_false', '["Vero", "Falso"]', 0, 'Legalmente grigio, ma tecnicamente possibile (Nitrocarbol usage, deanonymization tools).', NULL),
('51c11a01-0000-0000-0000-000000000024', 'In ambito Trappola per Topi (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Takedown & Seizure - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000025', 'EN', 'Spento per Sempre',
    'Quando i server fisici vengono staccati dalla spina.',
    E'# Physical Seizure\n\nNon puoi cancellare un sito Tor via software.\nDevi trovare fisicamente il server.\n\nCome? Analizzando errori di configurazione, tempi di risposta, pagamenti Bitcoin dell''hosting...\nUna volta trovato il data center (spesso in Islanda o Svizzera), la polizia locale sequestra l''hardware.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000025', 'La Full Disk Encryption (LUKS) ferma la polizia al sequestro?', 'multiple_choice', '["Sì, se il server è spento. Ma se lo prendono acceso (Live), le chiavi sono in RAM", "Sì, la crittografia è inviolabile anche a computer acceso", "No, la polizia ha la master key di Linux fornita da Linus Torvalds", "Sì, ma solo se usano password lunghe più di 20 caratteri"]', 0, 'Per questo fanno i raid "Cold Boot" o cercano di non far spegnere le macchine.', NULL),
('51c11a01-0000-0000-0000-000000000025', 'Cos''è un "Bulletproof Hosting"?', 'multiple_choice', '["Un provider che ignora i mandati di perquisizione e abuse report", "Un server blindato fisicamente contro i proiettili", "Un hosting gestito dalla polizia per sicurezza", "Un servizio di hosting gratuito per studenti"]', 0, 'Spesso nei paesi con legislazione lassista (Seychelles, Russia, Panama).', NULL),
('51c11a01-0000-0000-0000-000000000025', 'Se sequestrano il server, hanno anche i Bitcoin del market?', 'multiple_choice', '["Solo quelli nell''Hot Wallet sul server. I Cold Wallet (maggioranza fondi) sono offline", "Sì, tutti i soldi sono sempre nel server per funzionare", "No, i Bitcoin sono nel cloud non nel server fisico", "Dipende se il server aveva la porta USB inserita"]', 0, 'Admin intelligenti tengono pochi spiccioli sul server (Hot Wallet risk).', NULL),
('51c11a01-0000-0000-0000-000000000025', 'I server Tor possono essere virtualizzati (VPS)?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, ma è meno sicuro perché l''hoster VPS ha accesso alla memoria della VM.', NULL),
('51c11a01-0000-0000-0000-000000000025', 'Approfondimento su: COLD. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Exploit Governativi - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000026', 'EN', 'Armi di Stato',
    'Quando la polizia usa gli hacker.',
    E'# NIT (Network Investigative Technique)\n\nTermine legale USA per "Malware di Stato".\nL''FBI usa exploit Zero-Day contro Tor Browser (Firefox) per "taggare" gli utenti pedofili o terroristi.\n\nIl malware invia l''IP reale ai server dell''FBI.\nEtica vs Giustizia.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000026', 'Playpen Case: come l''FBI ha identificato 4000 utenti?', 'multiple_choice', '["Ha hackerato il server, poi ha servito un exploit Flash/JS agli utenti per settimane", "Ha chiesto a Google la lista degli utenti che cercavano il sito", "Ha decifrato il traffico Tor con un computer quantistico segreto", "Ha indovinato le password degli utenti una per una"]', 0, 'Operazione massiva di hacking governativo (Operation Pacifier).', NULL),
('51c11a01-0000-0000-0000-000000000026', 'Gli exploit usati dall''FBI vengono poi resi pubblici?', 'multiple_choice', '["Spesso no. Mozilla deve combattere in tribunale per sapere il bug e fixarlo", "Sì, immediatamente per proteggere tutti gli utenti onesti", "Sì, li pubblicano su GitHub come open source", "No, li vendono al mercato nero per finanziarsi"]', 0, 'Tensione tra "Law Enforcement" e "Public Security". Tenere il bug aperto lascia tutti vulnerabili.', NULL),
('51c11a01-0000-0000-0000-000000000026', 'Se usi Tails, sei immune ai NIT?', 'multiple_choice', '["Molto più resistente, ma non immune a exploit che rompono la virtualizzazione o il kernel", "Sì, Tails è matematicamente inviolabile da qualsiasi software", "No, Tails ha una backdoor della CIA preinstallata", "Sì perché Tails non usa Firefox ma Chrome"]', 0, 'La difesa in profondità (Depth) di Tails rende l''exploit molto più costoso e raro.', NULL),
('51c11a01-0000-0000-0000-000000000026', 'Tor Project collabora con l''FBI per inserire backdoor?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Il codice è Open Source e verificato. La fiducia è la base del progetto.', NULL),
('51c11a01-0000-0000-0000-000000000026', 'In ambito Armi di Stato (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
