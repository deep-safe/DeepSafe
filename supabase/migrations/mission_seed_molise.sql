-- Migration to add Phishing Missions for Molise (Campobasso - CB)

-- 1. Insert Missions (using UUIDs generated)
-- Note: 'nc_reward' column stores the NC (Credits) reward.
-- Levels: semplice, medio, difficile.

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

-- 2. Insert Questions
-- Mission 1 Questions
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type)
VALUES
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Ricevi una email da "supporto@goggle.com". Cosa noti?',
    '["Sembra legittima", "C''è un errore di battitura nel dominio (goggle.com)", "È sicuramente sicura", "È un indirizzo premium"]'::jsonb,
    1,
    'I truffatori spesso usano domini che somigliano a quelli reali (Typosquatting). Controlla sempre lettera per lettera.',
    'multiple_choice'
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Una mail dice "Il tuo account verrà chiuso tra 1 ora se non clicchi qui". Cosa fai?',
    '["Clicco subito per non perdere l''account", "Rispondo chiedendo più tempo", "Ignoro il link e controllo sul sito ufficiale", "Inoltro la mail a tutti i colleghi"]'::jsonb,
    2,
    'L''urgenza e la paura sono le armi preferite del phishing. Le aziende serie non ti minacciano di chiusura immediata via mail.',
    'multiple_choice'
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'La mail inizia con "Gentile Cliente" invece del tuo nome. Cosa suggerisce?',
    '["È indice di una mail massiva (potenziale phishing)", "È un segno di rispetto", "La banca ha dimenticato il mio nome", "È la prassi standard"]'::jsonb,
    0,
    'Le organizzazioni con cui hai un rapporto usano solitamente il tuo nome. "Gentile Cliente" è spesso usato nelle campagne di phishing di massa.',
    'multiple_choice'
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'La tua "banca" ti chiede via mail di rispondere con la tua password per un "controllo di sicurezza".',
    '["Glie la mando, è per la sicurezza", "La mando ma criptata", "Nessuna banca chiede mai la password via mail", "Chiedo prima il nome dell''impiegato"]'::jsonb,
    2,
    'Le credenziali non vengono **mai** richieste via email o telefono dagli amministratori di sistema o dalle banche.',
    'multiple_choice'
),
(
    '98644952-3836-4218-A626-C54885815C1C',
    'Ricevi una fattura imprevista come allegato ".exe".',
    '["Apro per controllare", "È sicuramente un virus, non aprire", "È un formato standard per le fatture", "L''antivirus lo bloccherebbe se fosse pericoloso"]'::jsonb,
    1,
    'Le fatture sono solitamente PDF. Un file .exe è un programma eseguibile e quasi certamente installerà malware.',
    'multiple_choice'
);

-- Mission 2 Questions
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type)
VALUES
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Analizza questo link: "https://paypal.supporto-sicurezza.com". Dove porta realmente?',
    '["Sul sito di PayPal", "Su una pagina di supporto ufficiale", "Su ''supporto-sicurezza.com'' (sito truffa)", "È un sottodominio sicuro di PayPal"]'::jsonb,
    2,
    'In un URL, la parte "reale" è quella subito prima del .com/.it. Qui il dominio è "supporto-sicurezza.com", non PayPal.',
    'multiple_choice'
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Un attaccante usa una ''a'' cirillica al posto della ''a'' latina in "amazon.com". Come si chiama questo attacco?',
    '["SQL Injection", "Homograph Attack (IDN Homograph)", "Brute Force", "Man in the Middle"]'::jsonb,
    1,
    'L''attaccante sfrutta caratteri visivamente identici ma con codici diversi per registrare domini falsi che sembrano veri.',
    'multiple_choice'
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Il testo della mail dice "www.google.com" ma passando il mouse sopra vedi che punta a "bit.ly/xyz".',
    '["È normale redirection", "È sospetto, l''URL di destinazione è mascherato", "Google usa bit.ly per i suoi link", "È sicuro se inizia con https"]'::jsonb,
    1,
    'Se il testo visualizzato non corrisponde all''URL di destinazione (visibile in basso a sinistra nel browser), è un forte segnale di pericolo.',
    'multiple_choice'
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Ricevi un SMS dalla "Posta" con un link "bit.ly/pacco23". È affidabile?',
    '["Sì, le poste usano sempre bit.ly", "No, le grandi aziende usano domini propri e shortener brandizzati", "Dipende dall''orario di invio", "Sì, se il numero del mittente sembra italiano"]'::jsonb,
    1,
    'Le grandi aziende usano domini proprietari (es. poste.it) o shortener brandizzati. I link bit.ly generici sono sospetti in questo contesto.',
    'multiple_choice'
),
(
    'C4B4FEF1-415B-4EC5-BCCA-61B0212047A2',
    'Clicchi un link e atterri su una pagina IDENTICA a quella di Microsoft 365, ma l''URL è "login-microsoft-auth.net".',
    '["Inserisco le credenziali, la pagina è giusta", "È un sito di phishing clonato", "Microsoft ha cambiato dominio", "È un server di backup"]'::jsonb,
    1,
    'È facile copiare la grafica di un sito. L''unica cosa che un attaccante non può falsificare perfettamente è il dominio nella barra degli indirizzi.',
    'multiple_choice'
);

-- Mission 3 Questions
INSERT INTO public.mission_questions (mission_id, text, options, correct_answer, explanation, type)
VALUES
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Arriva una mail dal "CEO" che chiede un bonifico urgente su un conto estero per un''operazione segreta.',
    '["Eseguo subito, è il capo", "Verifico la procedura internamente (chiamata o protocollo)", "Rispondo alla mail chiedendo conferma", "Lo anticipo con la mia carta di credito"]'::jsonb,
    1,
    'Questa è la "Truffa del CEO". I truffatori fanno leva sulla gerarchia e la segretezza. Verifica sempre tramite un altro canale.',
    'multiple_choice'
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Trovi una chiavetta USB nel parcheggio aziendale con etichetta "Stipendi Dirigenti 2024".',
    '["La inserisco nel PC per cercare il proprietario", "La porto all''ufficio oggetti smarriti/IT senza inserirla", "La guardo a casa sul mio PC personale", "La formatto e la uso"]'::jsonb,
    1,
    'È una trappola (Baiting). La chiavetta potrebbe contenere malware che si installa automaticamente appena inserita, o distruggere il PC (USB Killer).',
    'multiple_choice'
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Ti chiama il "Supporto Tecnico Microsoft" dicendo che il tuo PC ha un virus e devono collegarsi da remoto.',
    '["Seguo le loro istruzioni", "Microsoft non fa chiamate non sollecitate di supporto", "Chiedo il loro numero di matricola e procedo", "Do loro accesso solo per 5 minuti"]'::jsonb,
    1,
    'I grandi provider tech non ti chiamano mai a casa per dirti che hai un virus. È una truffa per installare RAT (Remote Access Trojan) o rubare soldi.',
    'multiple_choice'
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Una persona con le mani impegnate da scatoloni ti chiede di tenergli aperta la porta riservata col badge.',
    '["Per gentilezza apro", "Chiedo di vedere il badge o non apro", "Apro solo se è vestito bene", "Chiamo la polizia"]'::jsonb,
    1,
    'Il Tailgating sfrutta la cortesia per accedere ad aree riservate. La sicurezza fisica è il primo baluardo della cybersecurity.',
    'multiple_choice'
),
(
    '9381035D-ED26-46A3-B789-12F5EFF3BA77',
    'Qualcuno chiama fingendosi un fornitore e chiede "conferma" di alcuni dati interni per "aggiornare l''anagrafica".',
    '["Fornisco i dati, sembrano innocui", "Rifiuto e verifico l''identità del fornitore chiamando il numero ufficiale", "Chiedo di mandarmi una mail generica", "Do dati falsi per vedere cosa succede"]'::jsonb,
    1,
    'Il Pretexting consiste nell''inventare uno scenario (pretesto) per estorcere informazioni. Non dare mai dati aziendali a chiamante non verificati.',
    'multiple_choice'
);
