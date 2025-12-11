-- Mission Seed for Liguria (Theme: Il Porto Digitale - Supply Chain & Future Threats)
-- Provinces: Genova (GE), La Spezia (SP), Savona (SV), Imperia (IM)

-- =================================================================================================
-- GENOVA (GE) - Supply Chain Attacks ("Il Container Infetto")
-- =================================================================================================

-- Mission 1: Il Cavallo di Troia 2.0 (Supply Chain Attack)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A1B2C3D4-E5F6-4001-8901-234567890000', 'GE', 'Il Container Infetto',
    'Quando l''attacco arriva da chi ti fidi.',
    E'# Supply Chain Attack\n\nNon serve attaccare la fortezza se puoi avvelenare le provviste che entrano.\n\nIn un attacco Supply Chain (come SolarWinds), gli hacker infettano un software legittimo distribuito da un fornitore fidato. Quando scarichi l''aggiornamento ufficiale, installi anche la backdoor.\n\n**Lezione:** Fidati, ma verifica (Zero Trust).',
    'semplice', '5 min', 50, 'level_1', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A1B2C3D4-E5F6-4001-8901-234567890000', 'Cos''è un attacco alla Supply Chain?', 'multiple_choice', '["Un attacco ai pirati", "Compromettere un fornitore per colpire i suoi clienti", "Rubare un camion", "Bloccare il porto"]', 1, 'L''obiettivo è usare il fornitore come veicolo di infezione di massa.'),
('A1B2C3D4-E5F6-4001-8901-234567890000', 'Perché sono difficili da rilevare?', 'multiple_choice', '["Sono invisibili", "Perché il malware proviene da una fonte fidata e firmata", "Perché avvengono di notte", "Non lo sono"]', 1, 'Sfruttano la fiducia implicita nel fornitore software.');

-- Mission 2: Dependency Confusion
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A1B2C3D4-E5F6-4002-8901-234567890000', 'GE', 'Merce Contraffatta',
    'Quando scarichi la libreria sbagliata.',
    E'# Dependency Confusion\n\nI moderni software sono costruiti come LEGO, usando pezzi (librerie) pronti.\n\nSe un hacker carica su un registro pubblico (es. npm, PyPI) una libreria malevola con lo stesso nome di quella privata usata dalla tua azienda, il tuo sistema potrebbe scaricare quella sbagliata (quella pubblica, infetta) invece di quella interna.\n\nÈ come ordinare pezzi di ricambio originali e ricevere copie esplosive.',
    'medio', '10 min', 75, 'level_2', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A1B2C3D4-E5F6-4002-8901-234567890000', 'Dove si nasconde il pericolo nella "Dependency Confusion"?', 'multiple_choice', '["Nel codice sorgente", "Nei registri dei pacchetti software (es. npm)", "Nella tastiera", "Nello schermo"]', 1, 'L''attacco sfrutta l''ambiguità tra pacchetti pubblici e privati.'),
('A1B2C3D4-E5F6-4002-8901-234567890000', 'Come si previene?', 'multiple_choice', '["Smettendo di programmare", "Configurando correttamente le priorità dei registri software", "Usando solo CD-ROM", "Pregando"]', 1, 'Bisogna specificare esplicitamente da dove scaricare ogni pacchetto.');

-- Mission 3: SBOM (Software Bill of Materials)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A1B2C3D4-E5F6-4003-8901-234567890000', 'GE', 'La Lista di Carico',
    'Sai esattamente cosa c''è nel tuo software?',
    E'# SBOM (Software Bill of Materials)\n\nLa SBOM è la "lista degli ingredienti" del software. Elenca ogni singola libreria e componente usato.\n\nSenza SBOM, se viene scoperta una falla in una libreria (es. Log4j), non sai nemmeno se la stai usando.\n\n**Nel 2026**, la SBOM è obbligatoria per molti settori critici.',
    'difficile', '15 min', 100, 'level_3', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A1B2C3D4-E5F6-4003-8901-234567890000', 'Cos''è una SBOM?', 'multiple_choice', '["Una bomba", "Un inventario completo dei componenti software", "Un tipo di server", "Un database"]', 1, 'È essenziale per la gestione delle vulnerabilità nella supply chain.'),
('A1B2C3D4-E5F6-4003-8901-234567890000', 'A cosa serve in caso di vulnerabilità critica?', 'multiple_choice', '["A niente", "A identificare rapidamente se siamo colpiti", "A riparare il PC", "A chiamare la polizia"]', 1, 'Permette una risposta rapida sapendo esattamente cosa è installato.');


-- =================================================================================================
-- LA SPEZIA (SP) - OT & Industrial IoT ("La Difesa Navale")
-- =================================================================================================

-- Mission 1: IT vs OT
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'B2C3D4E5-F6A7-4001-9012-345678901000', 'SP', 'IT vs OT',
    'Quando l''hacker non ruba dati, ma fa esplodere cose.',
    E'# IT vs OT\n\n*   **IT (Information Technology):** Gestisce i dati (email, file). Priorità: Riservatezza.\n*   **OT (Operational Technology):** Gestisce il mondo fisico (motori navali, dighe, reti elettriche). Priorità: **Sicurezza Fisica (Safety)** e Disponibilità.\n\nSe hackeri l''IT perdi dati. Se hackeri l''OT, qualcuno può farsi male.',
    'semplice', '5 min', 50, 'level_1', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('B2C3D4E5-F6A7-4001-9012-345678901000', 'Qual è la priorità principale nell''OT (Operational Technology)?', 'multiple_choice', '["Privacy", "Safety (Incolumità fisica) e Continuità operativa", "Grafica", "Velocità di download"]', 1, 'Negli impianti industriali, un guasto può causare disastri ambientali o umani.'),
('B2C3D4E5-F6A7-4001-9012-345678901000', 'Esempio di dispositivo OT?', 'multiple_choice', '["Un laptop", "Un PLC che controlla una turbina", "Un mouse", "Un server web"]', 1, 'I PLC (Programmable Logic Controller) sono il cuore dell''automazione industriale.');

-- Mission 2: Il Mito dell'Air Gap
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'B2C3D4E5-F6A7-4002-9012-345678901000', 'SP', 'Il Mito dell''Air Gap',
    'Pensare di essere staccati da internet non ti salva.',
    E'# Air Gap\n\nSi crede che i sistemi critici (es. controllo di una nave) siano sicuri perché "non connessi a internet" (Air Gapped).\n\n**Falso:** Basta una chiavetta USB infetta inserita da un manutentore per saltare il fosso (come successo con Stuxnet). Inoltre, l''Industrial IoT sta connettendo tutto al cloud.',
    'medio', '10 min', 75, 'level_2', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('B2C3D4E5-F6A7-4002-9012-345678901000', 'Cos''è un "Air Gap"?', 'multiple_choice', '["Un vuoto d''aria", "Isolamento fisico di una rete da internet", "Un tipo di aereo", "Un software"]', 1, 'È una misura di sicurezza fisica, ma non infallibile.'),
('B2C3D4E5-F6A7-4002-9012-345678901000', 'Come si supera un Air Gap?', 'multiple_choice', '["Con la magia", "Tramite supporti fisici (USB) o connessioni temporanee di manutenzione", "Urlando", "Non si può"]', 1, 'Il fattore umano (chiavette USB) è spesso il ponte per l''infezione.');

-- Mission 3: Digital Twin
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'B2C3D4E5-F6A7-4003-9012-345678901000', 'SP', 'Il Gemello Digitale',
    'Simulare l''attacco per salvare la nave vera.',
    E'# Digital Twin\n\nUn Digital Twin è una copia virtuale esatta di un sistema fisico (es. il motore di una nave). \n\nNella cybersecurity, usiamo i Digital Twin per testare attacchi devastanti senza rischiare di rompere il macchinario vero. È il campo di addestramento definitivo per la difesa OT.',
    'difficile', '15 min', 100, 'level_3', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('B2C3D4E5-F6A7-4003-9012-345678901000', 'A cosa serve un Digital Twin nella sicurezza?', 'multiple_choice', '["A giocare ai videogiochi", "A simulare attacchi e patch senza rischi per l''impianto reale", "A raddoppiare i costi", "A fare backup"]', 1, 'Permette di fare "Crash Test" informatici in sicurezza.'),
('B2C3D4E5-F6A7-4003-9012-345678901000', 'È un concetto legato a?', 'multiple_choice', '["Social Network", "Industria 4.0 e OT", "Cucina", "Sport"]', 1, 'È un pilastro della digitalizzazione industriale.');


-- =================================================================================================
-- SAVONA (SV) - APT (Advanced Persistent Threats) ("La Spia Dormiente")
-- =================================================================================================

-- Mission 1: Il Nemico Silenzioso
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'C3D4E5F6-A7B8-4001-0123-456789012000', 'SV', 'Il Nemico Silenzioso',
    'Non vogliono i tuoi soldi, vogliono i tuoi segreti.',
    E'# Cos''è un APT?\n\nUn Advanced Persistent Threat (APT) non è un ragazzino in cameretta. È spesso un gruppo sostenuto da uno stato (Nation-State Actor).\n\nObiettivo: Spionaggio a lungo termine.\nModo: Entrare, restare nascosti per mesi o anni, ed esfiltrare dati goccia a goccia ("Low and Slow").',
    'semplice', '5 min', 50, 'level_1', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('C3D4E5F6-A7B8-4001-0123-456789012000', 'Cosa differenzia un APT da un criminale comune?', 'multiple_choice', '["L''uso del computer", "La persistenza, la pazienza e le risorse (spesso statali)", "L''uso di Linux", "Niente"]', 1, 'Gli APT hanno tempo e budget illimitati per raggiungere l''obiettivo.'),
('C3D4E5F6-A7B8-4001-0123-456789012000', 'Qual è l''obiettivo tipico di un APT?', 'multiple_choice', '["Vandalismo", "Spionaggio industriale o geopolitico", "Ransomware veloce", "Vendere Viagra"]', 1, 'Mirano a segreti, proprietà intellettuale o posizionamento strategico.');

-- Mission 2: Living off the Land
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'C3D4E5F6-A7B8-4002-0123-456789012000', 'SV', 'Mimetizzarsi',
    'Perché portare armi se puoi usare quelle della vittima?',
    E'# Living off the Land (LotL)\n\nPer non farsi scoprire dagli antivirus, gli APT usano strumenti già presenti nel sistema (es. PowerShell, CMD, WMI).\n\nInvece di installare un virus (che verrebbe rilevato), usano comandi legittimi di Windows per fare cose malevole. È come se un ladro usasse le chiavi che trova in casa invece di un piede di porco.',
    'medio', '10 min', 75, 'level_2', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('C3D4E5F6-A7B8-4002-0123-456789012000', 'Cosa significa "Living off the Land" in cybersecurity?', 'multiple_choice', '["Vivere in campagna", "Usare strumenti di amministrazione legittimi per condurre attacchi", "Rubare terra", "Coltivare virus"]', 1, 'Rende l''attribuzione e il rilevamento molto difficili.'),
('C3D4E5F6-A7B8-4002-0123-456789012000', 'Perché è efficace?', 'multiple_choice', '["È ecologico", "Elude i controlli tradizionali basati su file malevoli noti", "È più veloce", "Richiede meno RAM"]', 1, 'Se l''attività sembra amministrazione di sistema legittima, l''antivirus non scatta.');

-- Mission 3: Lateral Movement
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'C3D4E5F6-A7B8-4003-0123-456789012000', 'SV', 'Movimento Laterale',
    'Dal PC della segretaria al Server del Direttore.',
    E'# Lateral Movement\n\nUna volta entrato (Initial Access), l''APT non si ferma. Si muove "lateralmente" nella rete cercando credenziali migliori (Privilege Escalation) per raggiungere il "Gioiello della Corona" (Database, Controller di Dominio).\n\nLa segmentazione della rete (dividere la rete in stanze chiuse) è l''unico modo per rallentarli.',
    'difficile', '15 min', 100, 'level_3', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('C3D4E5F6-A7B8-4003-0123-456789012000', 'Cos''è il movimento laterale?', 'multiple_choice', '["Ballare", "Spostarsi all''interno della rete compromessa per cercare bersagli di valore", "Uscire dalla rete", "Inviare mail"]', 1, 'È la fase di esplorazione e espansione del controllo.'),
('C3D4E5F6-A7B8-4003-0123-456789012000', 'Come si ostacola?', 'multiple_choice', '["Spegnendo tutto", "Segmentazione della rete e Zero Trust", "Gridando", "Cambiando mouse"]', 1, 'Se ogni "stanza" (segmento) è chiusa a chiave, il ladro fa fatica a muoversi.');


-- =================================================================================================
-- IMPERIA (IM) - Quantum Security ("L'Orizzonte Quantistico")
-- =================================================================================================

-- Mission 1: Q-Day
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D4E5F6A7-B8C9-4001-1234-567890123000', 'IM', 'Il Giorno Q',
    'Quando tutte le password del mondo scadranno in un istante.',
    E'# Il Computer Quantistico\n\nI computer classici lavorano a bit (0 o 1). Quelli quantistici a Qubit.\n\nQuando arriverà il "Q-Day", un computer quantistico abbastanza potente potrà rompere in secondi la crittografia che oggi protegge banche, internet e segreti di stato (RSA, Elliptic Curve).\n\nNon è fantascienza: è matematica.',
    'semplice', '5 min', 50, 'level_1', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D4E5F6A7-B8C9-4001-1234-567890123000', 'Cos''è il Q-Day?', 'multiple_choice', '["Una festa", "Il giorno in cui i computer quantistici renderanno obsoleta la crittografia attuale", "Un film", "La fine di internet"]', 1, 'Segnerà la fine della crittografia asimmetrica classica.'),
('D4E5F6A7-B8C9-4001-1234-567890123000', 'La crittografia attuale (es. RSA) sarà sicura per sempre?', 'multiple_choice', '["Sì", "No, è vulnerabile alla potenza di calcolo quantistica", "Forse", "Dipende dal meteo"]', 1, 'L''algoritmo di Shor può fattorizzare grandi numeri (base di RSA) esponenzialmente più veloce dei PC classici.');

-- Mission 2: Harvest Now, Decrypt Later
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D4E5F6A7-B8C9-4002-1234-567890123000', 'IM', 'Raccogli ora, Decripta dopo',
    'Perché i tuoi dati criptati di oggi sono già a rischio.',
    E'# SNDL (Store Now, Decrypt Later)\n\nGli hacker (e gli stati) stanno rubando OGGI enormi quantità di dati criptati che non possono ancora leggere.\n\nPerché? Li conservano in attesa del computer quantistico.\n\nTra 5 o 10 anni, quando il Q-Day arriverà, potranno aprire quei vecchi forzieri. Se i tuoi segreti devono durare nel tempo, sei GIA'' in pericolo.',
    'medio', '10 min', 75, 'level_2', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D4E5F6A7-B8C9-4002-1234-567890123000', 'Cosa si intende per "Harvest Now, Decrypt Later"?', 'multiple_choice', '["Agricoltura digitale", "Rubare dati criptati oggi per decifrarli in futuro con computer quantistici", "Rubare password", "Fare backup"]', 1, 'È la minaccia principale per dati con lungo ciclo di vita (es. dati sanitari, segreti di stato).'),
('D4E5F6A7-B8C9-4002-1234-567890123000', 'Per quali dati è una minaccia?', 'multiple_choice', '["Lista della spesa", "Dati sensibili che devono rimanere segreti per decenni", "Meme", "News"]', 1, 'Se il dato scade domani, non importa. Se deve restare segreto per 10 anni, è un problema.');

-- Mission 3: PQC (Post-Quantum Cryptography)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D4E5F6A7-B8C9-4003-1234-567890123000', 'IM', 'Lo Scudo del Futuro',
    'La matematica che salverà il mondo digitale.',
    E'# PQC (Post-Quantum Cryptography)\n\nIl mondo (NIST) sta standardizzando nuovi algoritmi crittografici (es. CRYSTALS-Kyber) che sono resistenti anche ai computer quantistici.\n\nLa sfida dei prossimi anni (2025-2030) sarà la "Migrazione Crittografica": aggiornare miliardi di dispositivi ai nuovi standard PQC prima che sia troppo tardi.',
    'difficile', '15 min', 100, 'level_3', 'Liguria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D4E5F6A7-B8C9-4003-1234-567890123000', 'Cos''è la PQC?', 'multiple_choice', '["Un partito politico", "Post-Quantum Cryptography: algoritmi resistenti ai computer quantistici", "Un nuovo iPhone", "Un virus"]', 1, 'È la soluzione tecnologica al problema quantistico.'),
('D4E5F6A7-B8C9-4003-1234-567890123000', 'Qual è la grande sfida del prossimo decennio?', 'multiple_choice', '["Inventare internet 2", "Migrare tutti i sistemi alla PQC", "Smettere di usare computer", "Usare la carta"]', 1, 'Aggiornare l''infrastruttura mondiale richiederà anni di lavoro (Y2K non è stato nulla in confronto).');
