-- Migration to add Phishing Missions for Molise (Campobasso - CB)
-- Topic: Phishing & Social Engineering

-- 1. Insert Missions
-- We use static UUIDs to allow idempotent updates (ON CONFLICT DO UPDATE).

INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, region, tier)
VALUES 
(
    '98644952-3836-4218-A626-C54885815C1C', 
    'CB', 
    'Fondamenti del Phishing', 
    'Impara a distinguere chi ti scrive davvero da chi finge di essere un amico o un servizio noto.', 
    E'# Identificazione del Phishing\n\nIl phishing è l''arte dell''inganno digitale. In questa missione imparerai a riconoscere i segnali di allarme immediati nelle comunicazioni sospette.\n\n## Punti Chiave\n- **Mittente**: Controlla sempre l''indirizzo email reale, non solo il nome visualizzato.\n- **Urgenza**: Diffida di chi ti mette fretta.\n- **Genericità**: "Gentile Cliente" è spesso un brutto segno.', 
    'semplice', 
    '5 min',
    100,
    'Molise',
    'level_1'
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2', 
    'CB', 
    'Analisi Avanzata dei Link', 
    'Non tutto ciò che luccica è un link legittimo. Allena l''occhio a scovare le trappole negli URL.', 
    E'# Analisi degli URL\n\nUn link può mentire. Il testo che vedi non è sempre la destinazione reale.\n\n## Tecniche Comuni\n- **Sottodomini**: paypal.fake.com non è paypal.com.\n- **Omografia**: Caratteri simili (es. ''a'' cirillica) per ingannare l''occhio.\n- **Shorteners**: bit.ly nasconde la destinazione reale.', 
    'medio', 
    '8 min',
    150,
    'Molise',
    'level_1'
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77', 
    'CB', 
    'Manipolazione Sociale', 
    'I truffatori hackerano le persone, non solo i computer. Riconosci le tecniche di manipolazione psicologica.', 
    E'# Social Engineering\n\nIl "fattore umano" è spesso l''anello debole.\n\n## Tecniche Psicologiche\n- **Autorità**: Fingersi un capo o un poliziotto.\n- **Paura**: Minacciare conseguenze negative.\n- **Curiosità**: Sfruttare la voglia di sapere (es. chiavetta USB trovata).', 
    'difficile', 
    '10 min',
    200,
    'Molise',
    'level_1'
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, 
    description = EXCLUDED.description, 
    content = EXCLUDED.content, 
    estimated_time = EXCLUDED.estimated_time,
    nc_reward = EXCLUDED.nc_reward,
    level = EXCLUDED.level;

-- 2. Cleanup old questions to ensure clean state for new 5-question sets
DELETE FROM public.mission_questions WHERE mission_id IN (
    '98644952-3836-4218-A626-C54885815C1C',
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    '9381035D-ED26-46A3-B789-12F5EFF3BA77'
);

-- 3. Insert Questions (Mix of MC, T/F)
-- REMOVED Image questions as per user request

-- Mission 1: Fondamenti del Phishing (Easy)
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type, image_url)
VALUES
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Ricevi un''email da "assistenza@paypaI.com" (con una ''i'' maiuscola al posto della ''l''). Cosa noti?',
    '["È un indirizzo legittimo di PayPal", "È un tentativo di Typosquatting", "È un sottodominio ufficiale", "È un errore del server"]'::jsonb,
    1,
    'I truffatori usano caratteri visivamente simili (come I al posto di l) per ingannare l''occhio. Questo si chiama Typosquatting.',
    'multiple_choice',
    NULL
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'La tua banca ti scrive chiedendo di confermare il PIN via email per sbloccare il conto.',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Le banche e le istituzioni serie non chiedono MAI credenziali, password o PIN tramite email, SMS o telefono.',
    'true_false',
    NULL
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Ricevi un''email da un collega con allegato "Fattura.exe". È sicuro aprirlo?',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Un file .exe è un programma eseguibile. Le fatture sono solitamente PDF o XML. Aprire un .exe da un''email è quasi sempre garanzia di infezione, anche se il mittente sembra noto (potrebbe essere stato hackerato).',
    'true_false',
    NULL
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    '"Ultimo avviso: il tuo account verrà eliminato in 10 minuti". Questa tecnica è basata su:',
    '["Paura e Urgenza", "Cortesia e Rispetto", "Protocolli Standard", "Verifica a Due Fattori"]'::jsonb,
    0,
    'Il phishing fa leva sulle emozioni forti come la paura e l''urgenza per spingerti ad agire senza riflettere.',
    'multiple_choice',
    NULL
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Un sito con il lucchetto HTTPS è sempre legittimo e sicuro, indipendentemente dal nome del dominio.',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. HTTPS significa solo che la comunicazione è cifrata, non che il sito sia legittimo. Anche i siti di phishing possono (e spesso hanno) il lucchetto HTTPS gratuito.',
    'true_false',
    NULL
);

-- Mission 2: Analisi Avanzata dei Link (Medium)
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type, image_url)
VALUES
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Un SMS dalla "Dogana" contiene un link "bit.ly/34fk". Cosa dovresti fare?',
    '["Cliccare subito per pagare", "Usare un URL expander per verificare", "Rispondere ''STOP'' all''SMS", "Inoltro l''SMS alla Polizia"]'::jsonb,
    1,
    'Invece di cliccare alla cieca, usa un servizio online di "URL Expander" per vedere dove porta realmente quel link abbreviato prima di aprirlo.',
    'multiple_choice',
    NULL
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Nell''URL "https://google.com.login-page.xyz", il vero dominio è "google.com".',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Il vero dominio è l''ultima parte a destra prima del TLD (.xyz, .com, .it). In questo caso il dominio è "login-page.xyz", il resto è solo un sottodominio ingannevole.',
    'true_false',
    NULL
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Se passando il mouse su un link vedi un indirizzo IP numerico (es. 192.168.x.x) invece di un dominio, è probabile che sia sicuro?',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Vedere un IP nudo invece di un dominio, specialmente per servizi pubblici o bancari, è altamente sospetto.',
    'true_false',
    NULL
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Un attaccante registra "appIe.com" usando caratteri cirillici identici a quelli latini. Come si chiama questo attacco?',
    '["SQL Injection", "IDN Homograph Attack", "Cross-Site Scripting", "Denial of Service"]'::jsonb,
    1,
    'L''IDN Homograph Attack sfrutta la somiglianza visiva tra caratteri di alfabeti diversi (es. ''a'' latina vs ''a'' cirillica) per falsificare domini.',
    'multiple_choice',
    NULL
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Se una pagina di login è graficamente identica a quella ufficiale Microsoft, ma l''URL è diverso (es. micro-soft.net), è sicuro inserire i dati?',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. La grafica si può clonare facilmente. L''unica garanzia è l''URL corretto (es. microsoft.com). Se l''URL è diverso, è un sito di phishing.',
    'true_false',
    NULL
);

-- Mission 3: Manipolazione Sociale (Hard)
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type, image_url)
VALUES
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Il "Direttore" ti scrive su WhatsApp chiedendo di comprare buoni regalo Amazon per i clienti.',
    '["Corro a comprarli subito", "Verifico chiamando il Direttore", "Pago con la carta aziendale", "Chiedo il rimborso spese"]'::jsonb,
    1,
    'Questa è una classica "CEO Fraud". Non agire mai su richieste finanziarie insolite ricevute via chat o email senza una verifica vocale o di persona.',
    'multiple_choice',
    NULL
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    '"Microsoft" ti chiama dicendo che il tuo PC invia virus e deve connettersi da remoto. È una procedura standard?',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Microsoft, Apple o Google non chiamano MAI i clienti a freddo per segnalare virus. È una truffa "Tech Support Scam".',
    'true_false',
    NULL
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Trovi una chiavetta USB incustodita in ufficio. La cosa più sicura da fare è inserirla nel PC per cercare il proprietario.',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso! Mai inserire supporti sconosciuti. È un attacco "Baiting". La chiavetta potrebbe installare malware automaticamente.',
    'true_false',
    NULL
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Uno sconosciuto con le mani occupate ti chiede di tenergli aperta la porta riservata. Cosa fai?',
    '["Lo faccio per gentilezza", "Chiedo di passare il badge", "Gli apro se è ben vestito", "Chiamo subito il 112"]'::jsonb,
    1,
    'Questa tecnica si chiama "Tailgating". La cortesia è il nemico della sicurezza fisica. Ognuno deve passare il proprio badge.',
    'multiple_choice',
    NULL
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Lavorare su documenti sensibili in treno senza filtro privacy sullo schermo è una pratica sicura.',
    '["Vero", "Falso"]'::jsonb,
    1,
    'Falso. Si chiama "Shoulder Surfing". Chiunque passi o sia seduto vicino può leggere i tuoi dati. Usa sempre un Privacy Screen in pubblico.',
    'true_false',
    NULL
);
