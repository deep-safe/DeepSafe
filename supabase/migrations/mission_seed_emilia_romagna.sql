-- Mission Seed for Emilia Romagna (Theme: Motor Valley - Automotive Security)
-- Provinces: Bologna (BO), Modena (MO), Reggio Emilia (RE), Parma (PR), Rimini (RN)

-- =================================================================================================
-- MODENA (MO) - Car Hacking & CAN Bus ("Il Cuore del Motore")
-- =================================================================================================

-- Mission 1: CAN Bus Injection
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0001-4001-8901-234567890123', 'MO', 'Hackerare i Freni',
    'Come parlare la lingua segreta dell''auto.',
    E'# CAN Bus Injection\n\nLe auto moderne non sono meccaniche, sono computer su ruote. Tutte le centraline (ECU) comunicano su una "rete aziendale" interna chiamata **CAN Bus**.\n\nSe un hacker si collega a questa rete (es. tramite la porta OBD sotto il volante), può inviare messaggi falsi: "Frena ora!", "Spegni il motore!". Poiché il CAN Bus non ha sicurezza (di solito), l''auto obbedisce.',
    'semplice', '5 min', 50, 'level_1', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0001-4001-8901-234567890123', 'Cos''è il CAN Bus?', 'multiple_choice', '["Un autobus pubblico", "La rete di comunicazione interna che collega le centraline dell''auto", "Una bevanda", "Un pezzo del motore"]', 1, 'È il sistema nervoso dell''auto.'),
('2B310000-0001-4001-8901-234567890123', 'Cosa succede se un hacker inietta messaggi nel CAN Bus?', 'multiple_choice', '["L''auto va più veloce", "L''auto obbedisce ai comandi falsi (es. frenare, aprire portiere) perché non verifica la fonte", "Nulla", "Si accende la radio"]', 1, 'Il protocollo CAN standard non ha autenticazione del mittente.');

-- Mission 2: Keyless Entry Attack (Relay)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0002-4001-8901-234567890123', 'MO', 'Furto in 60 Secondi',
    'Aprire la tua auto senza toccarla.',
    E'# Relay Attack\n\nHai la chiave intelligente (Keyless) in cucina. L''auto è in strada.\nDue ladri usano un "amplificatore" radio: uno sta vicino alla tua porta di casa, l''altro vicino all''auto. Il segnale della chiave viene "allungato" fino all''auto, che crede che tu sia lì e si apre.\n\n**Soluzione:** Metti le chiavi in una scatola schermata (Faraday Cage).',
    'medio', '10 min', 75, 'level_2', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0002-4001-8901-234567890123', 'Come funziona un Relay Attack?', 'multiple_choice', '["Rompendo il vetro", "Amplificando il segnale della chiave wireless legittima per ingannare l''auto", "Usando un piede di porco", "Copiando la chiave"]', 1, 'Sfrutta la comodità del Keyless Entry.'),
('2B310000-0002-4001-8901-234567890123', 'Come ci si difende a basso costo?', 'multiple_choice', '["Vendendo l''auto", "Avvolgendo la chiave nella carta stagnola o usando una custodia Faraday", "Togliendo le ruote", "Mettendo l''allarme"]', 1, 'La schermatura blocca le onde radio.');

-- Mission 3: ECU Remapping & Malware
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0003-4001-8901-234567890123', 'MO', 'Tuning Pericoloso',
    'Più cavalli, ma a quale prezzo?',
    E'# ECU Tuning\n\nMolti appassionati modificano il software della centralina (ECU) per avere più potenza. Ma scaricare file di mappatura da forum sconosciuti è rischioso.\n\nUn file modificato malevolmente potrebbe disattivare i sistemi di sicurezza (ABS, Airbag) o installare un ransomware che blocca l''auto finché non paghi.',
    'difficile', '15 min', 100, 'level_3', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0003-4001-8901-234567890123', 'Cosa si rischia installando firmware custom sull''auto?', 'multiple_choice', '["Che vada troppo forte", "Malware, instabilità e disattivazione dei sistemi di sicurezza", "Che consumi meno", "Nulla"]', 1, 'Stai essenzialmente facendo il "Root" di un dispositivo da 2 tonnellate.'),
('2B310000-0003-4001-8901-234567890123', 'Un ransomware può colpire un''auto?', 'multiple_choice', '["No, solo i PC", "Sì, bloccando l''accensione elettronica finché non si paga", "Solo se ha il Wi-Fi", "Impossibile"]', 1, 'Se l''auto è software, l''auto è hackerabile.');


-- =================================================================================================
-- BOLOGNA (BO) - V2X & Smart Roads ("La Strada Intelligente")
-- =================================================================================================

-- Mission 1: V2X (Vehicle-to-Everything)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0004-4001-8901-234567890123', 'BO', 'Parlare con i Semafori',
    'Quando l''auto sa che il rosso sta arrivando.',
    E'# V2X\n\nNel futuro prossimo, le auto parleranno tra loro (V2V) e con l''infrastruttura (V2I).\n\n**Vantaggio:** "Frena, c''è ghiaccio tra 1km!"\n**Rischio:** Se un hacker inietta falsi messaggi V2X, può creare ingorghi fantasma o causare incidenti convincendo le auto che la strada è libera quando non lo è.',
    'semplice', '5 min', 50, 'level_1', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0004-4001-8901-234567890123', 'Cosa significa V2X?', 'multiple_choice', '["Velocità 2 Per", "Vehicle-to-Everything (comunicazione tra veicolo e ambiente)", "Versione 2", "Video"]', 1, 'È la base della guida autonoma cooperativa.'),
('2B310000-0004-4001-8901-234567890123', 'Qual è il rischio di sicurezza nel V2X?', 'multiple_choice', '["Che le batterie si scarichino", "Iniezione di dati falsi che causano incidenti o caos nel traffico", "Troppe notifiche", "Costo alto"]', 1, 'Fidarsi ciecamente dei dati esterni è pericoloso.');

-- Mission 2: OTA Updates (Over-the-Air)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0005-4001-8901-234567890123', 'BO', 'Aggiornamento in Corso',
    'La tua auto si aggiorna mentre dormi.',
    E'# OTA (Over-the-Air)\n\nCome gli smartphone, le auto moderne ricevono aggiornamenti via internet.\n\nSe il server del produttore viene compromesso (Supply Chain Attack), l''hacker può inviare un aggiornamento malevolo a milioni di auto contemporaneamente, bloccandole o disabilitando i freni. È lo scenario "Apocalisse Zombie" delle auto.',
    'medio', '10 min', 75, 'level_2', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0005-4001-8901-234567890123', 'Cosa permette la tecnologia OTA?', 'multiple_choice', '["Di volare", "Di aggiornare il software dell''auto a distanza senza andare in officina", "Di cambiare le gomme", "Di lavare l''auto"]', 1, 'Comodità estrema, ma rischio centralizzato estremo.'),
('2B310000-0005-4001-8901-234567890123', 'Chi controlla l''aggiornamento?', 'multiple_choice', '["Il meccanico", "Il produttore tramite server remoti", "Tu con una chiavetta", "Nessuno"]', 1, 'La sicurezza del server centrale diventa critica.');

-- Mission 3: La Smart City Hakerata
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0006-4001-8901-234567890123', 'BO', 'Green Wave Attack',
    'Manipolare i semafori per una rapina perfetta.',
    E'# Hacking Infrastrutturale\n\nColpire l''auto è difficile. Colpire il semaforo è spesso più facile.\n\nIn un "Green Wave Attack", gli hacker manipolano i sensori della Smart City per dare "Verde Sempre" a un veicolo in fuga, o "Rosso Sempre" per bloccare la polizia o creare ingorghi artificiali.',
    'difficile', '15 min', 100, 'level_3', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0006-4001-8901-234567890123', 'Cos''è un Green Wave Attack?', 'multiple_choice', '["Un''onda ecologica", "Manipolazione dei semafori per favorire o bloccare il traffico", "Un tipo di carburante", "Un''auto verde"]', 1, 'Hackerare la gestione del traffico per vantaggi fisici.'),
('2B310000-0006-4001-8901-234567890123', 'Perché le Smart City sono vulnerabili?', 'multiple_choice', '["Perché sono stupide", "Perché connettono infrastrutture critiche (Spesso vecchie) a internet", "Perché usano troppo cemento", "Non lo sono"]', 1, 'L''aumento della superficie d''attacco è il prezzo della connessione.');


-- =================================================================================================
-- REGGIO EMILIA (RE) - Industrial Espionage ("Il Progetto Segreto")
-- =================================================================================================

-- Mission 1: Il Blueprint Rubato
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0007-4001-8901-234567890123', 'RE', 'Il Blueprint Rubato',
    'Come rubare un''auto che non esiste ancora.',
    E'# Intellectual Property (IP) Theft\n\nNelle fabbriche della Motor Valley, il valore non è solo nell''auto finita, ma nei disegni (CAD) del motore del prossimo anno.\n\nGli hacker statali o concorrenti cercano di rubare questi file dai server di progettazione. Se rubi un progetto, risparmi miliardi in ricerca e sviluppo.',
    'semplice', '5 min', 50, 'level_1', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0007-4001-8901-234567890123', 'Qual è il bersaglio principale dello spionaggio industriale automotive?', 'multiple_choice', '["Le gomme", "La Proprietà Intellettuale (Progetti, Brevetti, Codice Sorgente)", "La mensa", "I computer vecchi"]', 1, 'Il vantaggio competitivo si basa sui segreti industriali.'),
('2B310000-0007-4001-8901-234567890123', 'Chi compie questi attacchi?', 'multiple_choice', '["Ragazzini", "Spesso gruppi organizzati pagati da concorrenti o stati esteri", "Nessuno", "I meccanici"]', 1, 'È un business da miliardi.');

-- Mission 2: Insider Threat
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0008-4001-8901-234567890123', 'RE', 'Il Traditore',
    'Il pericolo indossa il badge aziendale.',
    E'# Insider Threat\n\nIl firewall più costoso non ferma un ingegnere scontento che copia i file su una chiavetta USB prima di licenziarsi.\n\nNella Motor Valley, dove i tecnici passano spesso da un team all''altro, la protezione dei dati "In-Use" e il controllo degli accessi (DLP) sono vitali.',
    'medio', '10 min', 75, 'level_2', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0008-4001-8901-234567890123', 'Cos''è una "Insider Threat"?', 'multiple_choice', '["Un virus", "Una minaccia proveniente da dentro l''organizzazione (dipendenti, collaboratori)", "Un hacker esterno", "Un bug"]', 1, 'Spesso è la minaccia più difficile da rilevare.'),
('2B310000-0008-4001-8901-234567890123', 'Come si previene il furto di dati via USB?', 'multiple_choice', '["Chiedendo per favore", "Con sistemi DLP (Data Loss Prevention) che bloccano o tracciano la copia di file sensibili", "Togliendo le sedie", "Spegnendo la luce"]', 1, 'La tecnologia deve impedire l''azione fisica di esfiltrazione.');

-- Mission 3: Prototype Camouflage
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0009-4001-8901-234567890123', 'RE', 'Prototipo #9',
    'Proteggere i dati di telemetria in pista.',
    E'# Telemetria Racing\n\nQuando un prototipo gira a Fiorano o Imola, invia Terrabyte di dati (Telemetria) ai box via radio.\n\nSe questa comunicazione non è criptata al livello militare, i rivali possono intercettarla e conoscere in tempo reale le prestazioni del nuovo motore. La sicurezza cybersecurity in pista è importante quanto quella in fabbrica.',
    'difficile', '15 min', 100, 'level_3', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0009-4001-8901-234567890123', 'Perché la telemetria va criptata?', 'multiple_choice', '["Perché è pesante", "Per evitare che i rivali conoscano le prestazioni segrete del veicolo", "Perché piove", "Per legge"]', 1, 'I dati sulle performance sono segreti strategici.'),
('2B310000-0009-4001-8901-234567890123', 'Qual è il rischio di un attacco alla telemetria?', 'multiple_choice', '["Nessuno", "Perdita di vantaggio competitivo o addirittura sabotaggio remoto", "Che l''auto si fermi", "Che il pilota si distragga"]', 1, 'Sapere quanto consuma il nemico ti dice quando si fermerà.');


-- =================================================================================================
-- PARMA (PR) - Privacy & Infotainment ("L'Auto ti Ascolta")
-- =================================================================================================

-- Mission 1: L'Auto Spiona
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0010-4001-8901-234567890123', 'PR', 'L''Auto Spiona',
    'La tua auto sa dove dormi e con chi parli.',
    E'# Data Privacy Automotive\n\nLe auto moderne raccolgono più dati di uno smartphone:\n*   Posizione GPS (dove vai).\n*   Microfono (comandi vocali).\n*   Telecamere interne (se sei stanco).\n*   Peso sui sedili (chi c''è con te).\n\nA chi vanno questi dati? Spesso vengono venduti alle assicurazioni o ai data broker.',
    'semplice', '5 min', 50, 'level_1', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0010-4001-8901-234567890123', 'Che tipo di dati raccoglie un''auto smart?', 'multiple_choice', '["Solo la velocità", "Praticamente tutto: Biometria, Posizione, Voce, Abitudini di guida", "Nulla", "Solo la musica"]', 1, 'È un dispositivo di sorveglianza su ruote.'),
('2B310000-0010-4001-8901-234567890123', 'A chi appartengono i dati generati dalla tua guida?', 'multiple_choice', '["A te, sempre", "È una zona grigia legale, spesso il produttore ne rivendica la proprietà nei termini d''uso", "Alla polizia", "Al benzinaio"]', 1, 'Leggi sempre la Privacy Policy (anche se è lunga).');

-- Mission 2: Syncing Sbagliato
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0011-4001-8901-234567890123', 'PR', 'Syncing Sbagliato',
    'Mai collegare il telefono all''auto a noleggio.',
    E'# Infotainment Risk\n\nQuando noleggi un''auto e colleghi il telefono via Bluetooth o USB, l''auto scarica la tua Rubrica, i Messaggi e il Registro Chiamate.\n\nSe restituisci l''auto senza fare il "Factory Reset" dell''infotainment, il prossimo cliente saprà tutto di te.',
    'medio', '10 min', 75, 'level_2', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0011-4001-8901-234567890123', 'Cosa succede se colleghi lo smartphone a un''auto a noleggio?', 'multiple_choice', '["Si ricarica e basta", "Spesso trasferisce rubrica, chiamate e messaggi nella memoria dell''auto", "Il telefono esplode", "Nulla"]', 1, 'I dati restano nell''auto finché non vengono cancellati.'),
('2B310000-0011-4001-8901-234567890123', 'Cosa devi fare prima di restituire un''auto a noleggio?', 'multiple_choice', '["Lavarla", "Cancellare il tuo profilo/dispositivo dal sistema di infotainment", "Fare il pieno", "Salutare"]', 1, 'Digital Cleaning: cancella le tue tracce digitali.');

-- Mission 3: App Companion
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0012-4001-8901-234567890123', 'PR', 'Le Chiavi nel Cloud',
    'L''App sul telefono comanda l''auto. Se hackerano il telefono?',
    E'# Companion App Risk\n\nOggi apri e accendi l''auto con l''App sullo smartphone. Questo significa che la sicurezza fisica della tua auto dipende dalla sicurezza del tuo telefono.\n\nSe hai una password debole sull''account dell''App, un hacker può localizzare la tua auto, aprirla e portarsela via senza toccarti.',
    'difficile', '15 min', 100, 'level_3', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0012-4001-8901-234567890123', 'Se un hacker entra nel tuo account dell''App dell''auto, cosa può fare?', 'multiple_choice', '["Cambiare stazione radio", "Spesso può localizzare, aprire e avviare il veicolo (se supportato)", "Nulla", "Cambiare colore"]', 1, 'L''account diventa una chiave digitale duplicabile all''infinito.'),
('2B310000-0012-4001-8901-234567890123', 'Come proteggere l''App dell''auto?', 'multiple_choice', '["Non usarla", "Password forte e autenticazione a due fattori (2FA)", "Usare il Wi-Fi", "Chiudere l''app"]', 1, 'La 2FA è essenziale per proteggere l''accesso remoto al veicolo.');


-- =================================================================================================
-- RIMINI (RN) - GPS Spoofing & Navi ("La Rotta Sbagliata")
-- =================================================================================================

-- Mission 1: GPS Spoofing
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0013-4001-8901-234567890123', 'RN', 'La Rotta Sbagliata',
    'Quando il navigatore mente sulle coordinate.',
    E'# GPS Spoofing\n\nIl GPS si basa su segnali deboli dai satelliti. Un hacker con un dispositivo radio da 200€ può sovrastare questo segnale e inviare coordinate false.\n\nPuò far credere all''autopilota di essere in mezzo all''oceano o su una strada diversa, causando cambi di rotta improvvisi o dirottamenti di camion merci.',
    'semplice', '5 min', 50, 'level_1', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0013-4001-8901-234567890123', 'Cos''è il GPS Spoofing?', 'multiple_choice', '["Il GPS rotto", "Trasmettere un segnale GPS falso per ingannare il ricevitore sulla posizione", "Un aggiornamento mappe", "Un satellite"]', 1, 'A differenza del Jamming (che blocca), lo Spoofing inganna.'),
('2B310000-0013-4001-8901-234567890123', 'Qual è il pericolo per la guida autonoma?', 'multiple_choice', '["Che arrivi tardi", "Che l''auto esegua manovre pericolose basandosi su una posizione errata", "Che la radio non vada", "Nessuno"]', 1, 'L''auto si fida ciecamente dei suoi sensori.');

-- Mission 2: Jamming
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0014-4001-8901-234567890123', 'RN', 'Buco Nero',
    'Spegnere la visibilità del veicolo.',
    E'# GPS/Signal Jamming\n\nI ladri di auto di lusso e camion usano i "Jammer" (disturbatori di frequenza) per bloccare GPS e 4G.\n\nSe l''auto viene rubata con un Jammer attivo, l''antifurto satellitare non può chiamare "casa" e l''App non può localizzarla. L''auto sparisce dai radar finché non viene smontata.',
    'medio', '10 min', 75, 'level_2', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0014-4001-8901-234567890123', 'Cosa fa un Jammer?', 'multiple_choice', '["Suona musica", "Genera rumore radio per bloccare le comunicazioni (GPS, GSM)", "Fa il caffè", "Apre le porte"]', 1, 'Crea una "nebbia" elettromagnetica che isola il dispositivo.'),
('2B310000-0014-4001-8901-234567890123', 'Perché i ladri usano i Jammer?', 'multiple_choice', '["Per ascoltare la radio", "Per impedire all''antifurto satellitare di inviare la posizione", "Per divertimento", "Per guidare meglio"]', 1, 'Neutralizza i sistemi di tracciamento.');

-- Mission 3: Phantom Maps
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '2B310000-0015-4001-8901-234567890123', 'RN', 'Strade Fantasma',
    'Quando la mappa dice "Gira a destra" nel burrone.',
    E'# Map Poisoning\n\nGli attacchi non devono essere sempre tecnologici. Modificando i dati su OpenStreetMap o segnalando falsi incidenti su Waze/Google Maps, si possono deviare flussi di traffico reali.\n\nUtile per creare imboscate o liberare una strada per una fuga veloce.',
    'difficile', '15 min', 100, 'level_3', 'Emilia Romagna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('2B310000-0015-4001-8901-234567890123', 'Come si possono influenzare i navigatori altrui?', 'multiple_choice', '["Gridando dal finestrino", "Segnalando falsi incidenti o modificando mappe collaborative", "Non si può", "Usando i segnali di fumo"]', 1, 'Le app di navigazione si basano sul crowdsourcing, che è manipolabile.'),
('2B310000-0015-4001-8901-234567890123', 'È un attacco informatico?', 'multiple_choice', '["No", "Sì, è un attacco all''integrità dei dati (Data Integrity)", "Forse", "Dipende"]', 1, 'Corrompere i dati su cui si prendono decisioni è hacking.');
