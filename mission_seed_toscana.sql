-- Mission Seed for Toscana (Theme: Digital Renaissance & Art of Fake)
-- Provinces: Firenze (FI), Siena (SI), Lucca (LU), Pisa (PI), Livorno (LI)

-- =================================================================================================
-- FIRENZE (FI) - NFT & Crypto Art ("Il Falso d'Autore 2.0")
-- =================================================================================================

-- Mission 1: NFT Rug Pull
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0001-4001-8901-234567890123', 'FI', 'Il Collezionista Fantasma',
    'Quando l''arte digitale vale zero.',
    E'# Rug Pull NFT\n\nCompri un''opera d''arte digitale (NFT) per 1.000€. Il progetto promette un videogioco, eventi e valore futuro.\nIl giorno dopo, il sito sparisce, gli account social vengono cancellati e i creatori scappano con i soldi.\n\nNel mondo crypto non c''è nessuna polizia a cui denunciare il furto.',
    'semplice', '5 min', 50, 'level_1', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0001-4001-8901-234567890123', 'Cos''è un "Rug Pull"?', 'multiple_choice', '["Un tappeto nuovo", "Una truffa in cui gli sviluppatori abbandonano il progetto scappando con i soldi degli investitori", "Un tipo di danza", "Un virus"]', 1, 'Letteralmente "tirare via il tappeto" da sotto i piedi.'),
('3C410000-0001-4001-8901-234567890123', 'Gli NFT sono sempre sicuri?', 'multiple_choice', '["Sì, sono sulla blockchain", "No, la tecnologia è sicura ma il valore e l''onestà del progetto non sono garantiti", "Sì, se costano tanto", "Dipende dal colore"]', 1, 'La Blockchain certifica la proprietà, non la qualità o l''onestà.');

-- Mission 2: Smart Contract Hacks
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0002-4001-8901-234567890123', 'FI', 'Il Codice è Legge?',
    'Se il contratto sbaglia, tu perdi tutto.',
    E'# Smart Contract Vulnerability\n\nUno Smart Contract è un programma che sposta soldi automaticamente.\nSe c''è un bug nel codice (es. Reentrancy Attack), un hacker può svuotare l''intero fondo in secondi.\n\n"Code is Law" significa che se il codice permette il furto, il furto è tecnicamente "legale" per la macchina.',
    'difficile', '15 min', 100, 'level_3', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0002-4001-8901-234567890123', 'Cosa succede se uno Smart Contract ha un bug?', 'multiple_choice', '["Viene corretto da Microsoft", "I fondi possono essere rubati irreversibilmente e non c''è un ''Servizio Clienti''", "Nulla", "Si spegne"]', 1, 'L''immutabilità della Blockchain rende i bug leterni e costosi.'),
('3C410000-0002-4001-8901-234567890123', 'Come si controlla uno Smart Contract?', 'multiple_choice', '["Leggendolo velocemente", "Tramite un Audit di sicurezza professionale prima del rilascio", "Fidandosi", "Chiedendo a ChatGPT"]', 1, 'L''Audit è essenziale per trovare falle logiche.');

-- Mission 3: Wallet Drainers
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0003-4001-8901-234567890123', 'FI', 'Firma Qui, Prego',
    'Un click sbagliato e il portafoglio è vuoto.',
    E'# Malicious Signatures\n\nTi arriva un airdrop gratuito di un token sconosciuto. Per riscattarlo, devi collegare il wallet e "Firmare" una transazione.\n\nQuella firma non serve a ricevere il regalo, ma dà al ladro il permesso ("Approval") di spendere tutti i tuoi USDT. Hai appena firmato un assegno in bianco.',
    'medio', '10 min', 75, 'level_2', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0003-4001-8901-234567890123', 'Cosa significa dare "Approval" a un token?', 'multiple_choice', '["Dire che è bello", "Autorizzare uno Smart Contract a spendere i tuoi fondi per tuo conto", "Venderlo", "Comprarlo"]', 1, 'È il permesso più pericoloso nel Web3.'),
('3C410000-0003-4001-8901-234567890123', 'Come evitare i Wallet Drainers?', 'multiple_choice', '["Usare un Burner Wallet per siti sospetti e non firmare mai transazioni che non capisci", "Usare un antivirus", "Spegnere il PC", "Pregare"]', 1, 'Isolare il rischio usando wallet secondari vuoti.');


-- =================================================================================================
-- SIENA (SI) - Banking Security ("La Cassaforte Antica")
-- =================================================================================================

-- Mission 1: ATM Skimmer
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0004-4001-8901-234567890123', 'SI', 'Il Bancomat Truccato',
    'La fessura della carta sembra strana...',
    E'# Skimming\n\nI criminali installano dispositivi (Skimmer) sopra la fessura del bancomat per leggere la banda magnetica della tua carta.\nSpesso aggiungono una micro-telecamera nascosta per filmare il PIN.\n\n**Consiglio:** Tira sempre la fessura di plastica prima di inserire la carta. Se si muove, è falsa.',
    'semplice', '5 min', 50, 'level_1', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0004-4001-8901-234567890123', 'Cos''è uno Skimmer?', 'multiple_choice', '["Uno sciatore", "Un dispositivo che clona i dati della carta di credito inserita nel bancomat", "Un software bancario", "Una carta prepagata"]', 1, 'È hardware malevolo applicato fisicamente.'),
('3C410000-0004-4001-8901-234567890123', 'Perché coprire la mano mentre digiti il PIN?', 'multiple_choice', '["Per educazione", "Per impedire alle micro-telecamere nascoste di vedere il codice", "Perché fa freddo", "Per non sbagliare"]', 1, 'Senza PIN, i dati clonati della carta sono (quasi) inutili.');

-- Mission 2: SWIFT Fraud
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0005-4001-8901-234567890123', 'SI', 'La Rapina del Secolo',
    'Rubare 81 milioni di dollari senza pistole.',
    E'# SWIFT Hacking\n\nSWIFT è il sistema di messaggistica che le banche usano per spostare denaro internazionalmente.\n\nSe un hacker compromette le credenziali SWIFT di una banca (come successo in Bangladesh), può ordinare bonifici miliardari legittimi verso conti offshore. È la rapina in banca definitiva.',
    'difficile', '15 min', 100, 'level_3', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0005-4001-8901-234567890123', 'Cos''è la rete SWIFT?', 'multiple_choice', '["Un social network", "Il sistema globale per i trasferimenti finanziari interbancari", "Una criptovaluta", "Un''auto"]', 1, 'È la spina dorsale della finanza mondiale.'),
('3C410000-0005-4001-8901-234567890123', 'Come difendersi?', 'multiple_choice', '["Usando password facili", "Autenticazione a più fattori e controlli incrociati sui grandi trasferimenti", "Chiudendo la banca", "Non usando computer"]', 1, 'La sicurezza procedurale è importante quanto quella tecnica.');

-- Mission 3: Banking Trojan
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0006-4001-8901-234567890123', 'SI', 'Il Cavallo di Troia',
    'Un virus che aspetta che tu faccia un bonifico.',
    E'# Banking Trojans (es. Zeus)\n\nQuesti malware restano dormienti nel PC.\nSi svegliano solo quando visiti il sito della tua banca. A quel punto, mostrano una pagina di login identica ma falsa (Overlay Attack) o modificano l''IBAN del destinatario mentre fai il bonifico (Man-in-the-Browser).',
    'medio', '10 min', 75, 'level_2', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0006-4001-8901-234567890123', 'Cosa fa un attacco "Man-in-the-Browser"?', 'multiple_choice', '["Rallenta internet", "Modifica i dati della transazione (es. IBAN) al volo prima che vengano inviati alla banca", "Cancella la cronologia", "Apre finestre pop-up"]', 1, 'Tu vedi l''IBAN giusto, la banca riceve l''IBAN del ladro.'),
('3C410000-0006-4001-8901-234567890123', 'Perché l''SMS di conferma è utile?', 'multiple_choice', '["Perché è gratis", "Per verificare che l''IBAN e l''importo nell''SMS corrispondano a quelli che credi di inviare", "Per salutare", "Non serve"]', 1, 'È un canale di verifica "Out-of-Band" (fuori dal PC compromesso).');


-- =================================================================================================
-- LUCCA (LU) - Gaming & Account Theft ("Game Over")
-- =================================================================================================

-- Mission 1: Stealer Logs
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0007-4001-8901-234567890123', 'LU', 'Game Over',
    'Hai scaricato i trucchi, hai perso l''account.',
    E'# Stealer Malware\n\nHai cercato "Crack FIFA 25" o "Aimbot Fortnite". Hai scaricato un `.exe`.\nIl gioco non parte, ma il malware ha copiato tutti i file `Login Data` di Chrome e Firefox e li ha inviati a un hacker russo.\n\nRisultato: Hanno le password di Amazon, Instagram, Steam e Gmail.',
    'semplice', '5 min', 50, 'level_1', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0007-4001-8901-234567890123', 'Perché i crack dei giochi sono pericolosi?', 'multiple_choice', '["Perché non funzionano", "Sono il veicolo #1 per diffondere malware che rubano password (InfoStealer)", "Perché sono illegali", "Occupano spazio"]', 1, 'Nessuno regala software costoso per gentilezza.'),
('3C410000-0007-4001-8901-234567890123', 'Cosa ruba un InfoStealer?', 'multiple_choice', '["I tuoi selfie", "Tutte le password salvate nel browser, i cookie di sessione e i wallet crypto", "La musica", "I giochi"]', 1, 'Salvare le password nel browser è comodo ma rischioso.');

-- Mission 2: Steam Scam
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0008-4001-8901-234567890123', 'LU', 'Vota la mia squadra',
    'Un amico ti chiede un favore su Discord.',
    E'# Phishing via Chat\n\nUn tuo amico su Steam o Discord ti scrive: "Hey, vota la mia squadra in questo torneo e vinco 50$!". Ti manda un link.\nIl sito sembra vero, ti chiede di loggarti con Steam.\n\nIn realtà, il tuo amico è già stato hackerato. Appena inserisci i dati, perdi l''account anche tu. È una catena.',
    'medio', '10 min', 75, 'level_2', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0008-4001-8901-234567890123', 'Se un amico ti manda un link sospetto, cosa fai?', 'multiple_choice', '["Clicco subito", "Lo chiamo o gli chiedo una prova che sia davvero lui (es. come ci siamo conosciuti?)", "Lo insulto", "Lo blocco"]', 1, 'Mai fidarsi, verifica sempre fuori dal canale compromesso.'),
('3C410000-0008-4001-8901-234567890123', 'Cos''è l''API Scam su Steam?', 'multiple_choice', '["Un gioco nuovo", "Un metodo per intercettare gli scambi (Trade) usando una chiave API rubata", "Uno sconto", "Una skin"]', 1, 'Controlla sempre se hai una "Web API Key" attiva che non hai generato tu.');

-- Mission 3: Doxxing & Swatting
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0009-4001-8901-234567890123', 'LU', 'Scherzo Mortale',
    'Quando il bullismo online diventa un crimine reale.',
    E'# Doxxing & Swatting\n\n**Doxxing:** Pubblicare i dati privati (indirizzo, scuola) di un giocatore rivale per intimidirlo.\n**Swatting:** Fare una falsa chiamata alla polizia dicendo che a quell''indirizzo c''è una bomba o un ostaggio, per far irrompere le forze speciali (SWAT) a casa della vittima in diretta streaming.',
    'difficile', '15 min', 100, 'level_3', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0009-4001-8901-234567890123', 'Cos''è il Doxxing?', 'multiple_choice', '["Un documento", "La ricerca e diffusione pubblica di informazioni private su una persona", "Un cane", "Un social"]', 1, 'L''anonimato online non è garantito se lasci troppe tracce.'),
('3C410000-0009-4001-8901-234567890123', 'Lo Swatting è un reato?', 'multiple_choice', '["No, è uno scherzo", "Sì, gravissimo, può portare a feriti o morti accidentali", "Solo in America", "Dipende"]', 1, 'Sprecando risorse di emergenza si mette a rischio la vita di tutti.');


-- =================================================================================================
-- PISA (PI) - Research & Legacy Code ("La Torre Pendente")
-- =================================================================================================

-- Mission 1: Open Source Vulnerability
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0010-4001-8901-234567890123', 'PI', 'La Torre Pendente',
    'Costruire software su fondamenta instabili.',
    E'# Log4Shell & Co.\n\nIl software moderno è come una torre costruita con mattoncini presi gratis da altri (Librerie Open Source).\n\nSe un mattoncino alla base ha un difetto (es. la vulnerabilità Log4j), l''intera torre crolla. Milioni di server nel mondo possono essere hackerati perché usavano tutti quella piccola libreria gratuita.',
    'semplice', '5 min', 50, 'level_1', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0010-4001-8901-234567890123', 'Cosa si intende per "Software Supply Chain Attack"?', 'multiple_choice', '["Attaccare la catena della bici", "Compromettere una libreria usata da molti software per colpire tutti gli utilizzatori a valle", "Rubare i CD", "Spengere il Wi-Fi"]', 1, 'Colpisci uno per educarne (infettarne) cento.'),
('3C410000-0010-4001-8901-234567890123', 'L''Open Source è meno sicuro?', 'multiple_choice', '["Sì, chiunque vede il codice", "No, anzi \"molti occhi rendono i bug superficiali\", ma richiede manutenzione costante", "Dipende dalla lingua", "Sì, sempre"]', 1, 'La trasparenza è un''arma a doppio taglio che richiede vigilanza.');

-- Mission 2: Legacy Code
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0011-4001-8901-234567890123', 'PI', 'Il Codice Antico',
    'Software scritto quando i tuoi genitori andavano a scuola.',
    E'# Legacy Systems\n\nBanche e ospedali usano ancora software scritti 30 anni fa (COBOL, Windows XP).\nQuesti sistemi sono "stabili" ma non possono essere aggiornati contro i virus moderni. Sono come castelli medievali contro i droni.\n\n**Sfida:** Come proteggere ciò che non puoi aggiornare?',
    'medio', '10 min', 75, 'level_2', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0011-4001-8901-234567890123', 'Cos''è un sistema Legacy?', 'multiple_choice', '["Un computer nuovo", "Un sistema obsoleto ancora in uso, difficile da sostituire o aggiornare", "Un videogioco", "Una legge"]', 1, 'Il debito tecnico accumulato negli anni.'),
('3C410000-0011-4001-8901-234567890123', 'Perché è rischioso usare Windows XP oggi?', 'multiple_choice', '["È brutto", "Non riceve più aggiornamenti di sicurezza (Patch) da anni", "È lento", "Costa troppo"]', 1, 'Senza patch, ogni nuova vulnerabilità scoperta rimane aperta per sempre.');

-- Mission 3: University Hacking
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0012-4001-8901-234567890123', 'PI', 'Voto: 30 e Lode',
    'Cambiare i voti nel database dell''università.',
    E'# Integrity Attacks\n\nNegli attacchi all''istruzione (modifica dei voti) o alla ricerca (modifica dei dati sperimentali), l''obiettivo non è distruggere o rubare, ma alterare la verità.\n\nSe un hacker cambia una virgola nei risultati di una ricerca medica, potrebbe rendere un farmaco pericoloso approvabile.',
    'difficile', '15 min', 100, 'level_3', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0012-4001-8901-234567890123', 'Quale pilastro della sicurezza viola la modifica di un voto?', 'multiple_choice', '["Confidenzialità", "Integrità", "Disponibilità", "Privacy"]', 1, 'I dati devono essere accurati e non manipolati.'),
('3C410000-0012-4001-8901-234567890123', 'Come proteggere i database universitari?', 'multiple_choice', '["Con i lucchetti", "Log immutabili (Audit Trail) e controllo severo degli accessi privilegiati", "Non usando database", "Cancellando tutto"]', 1, 'Sapere "chi ha cambiato cosa e quando" è fondamentale.');


-- =================================================================================================
-- LIVORNO (LI) - Maritime Logistics ("Il Porto Digitale")
-- =================================================================================================

-- Mission 1: Container Tracking
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0013-4001-8901-234567890123', 'LI', 'Il Container Fantasma',
    'Far sparire 10 tonnellate di merce con un click.',
    E'# Hacking Logistico\n\nI porti sono gestiti da software complessi che dicono alle gru quale container spostare.\n\nI narcos o i contrabbandieri hackerano questi sistemi per:\n1.  Nascondere un container "caldo" dai controlli doganali.\n2.  Far segnare un container pieno come "vuoto" o viceversa.\n3.  Far ritirare il carico dai loro complici prima che arrivi la polizia.',
    'semplice', '5 min', 50, 'level_1', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0013-4001-8901-234567890123', 'Perché hackerare il porto?', 'multiple_choice', '["Per fare un giro in barca", "Per facilitare il contrabbando o il furto di merci senza confronto fisico", "Per vedere il mare", "Per pescare"]', 1, 'Hackerare il database è più facile che corrompere 50 guardie.'),
('3C410000-0013-4001-8901-234567890123', 'Cos''è il "Bill of Lading"?', 'multiple_choice', '["Un conto", "Il documento di trasporto fondamentale. Se digitale e non protetto, è falsificabile", "Una nave", "Un porto"]', 1, 'La digitalizzazione dei documenti cartacei introduce nuovi rischi.');

-- Mission 2: Nave alla Deriva
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0014-4001-8901-234567890123', 'LI', 'Nave alla Deriva',
    'Spegnere il motore di una petroliera da remoto.',
    E'# OT Security Marittima\n\nLe navi moderne hanno sistemi OT (Operational Technology) connessi al satellite per la diagnostica.\n\nSe un hacker infetta la rete di bordo (spesso tramite una chiavetta USB del capitano o via satellite), può spegnere i motori, alterare le carte nautiche (ECDIS) o sbilanciare il carico facendo inclinare la nave.',
    'medio', '10 min', 75, 'level_2', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0014-4001-8901-234567890123', 'Cosa sono i sistemi ECDIS?', 'multiple_choice', '["Motori", "Electronic Chart Display and Information System (Carte nautiche digitali)", "Radio", "Radar"]', 1, 'Se la carta è hackerata, la nave può finire sugli scogli credendosi in mare aperto.'),
('3C410000-0014-4001-8901-234567890123', 'Le navi sono connesse a internet?', 'multiple_choice', '["No, mai", "Sì, via satellite (VSAT), ma spesso con scarsa sicurezza cyber", "Solo al porto", "Solo le barche a vela"]', 1, 'La connessione satellitare è un vettore di attacco sempre più usato.');

-- Mission 3: AIS Spoofing
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '3C410000-0015-4001-8901-234567890123', 'LI', 'Cerchi nel Mare',
    'Disegnare rotte false sui radar del mondo.',
    E'# AIS Spoofing\n\nL''AIS è il sistema che trasmette la posizione della nave agli altri.\nNavi da guerra o pescherecci illegali spesso fanno "Spoofing" dell''AIS:\n1.  Fingono di essere altrove.\n2.  Fingono di essere un''altra nave.\n3.  Disegnano rotte assurde (es. cerchi perfetti o simboli "Z") per trollare o confondere l''intelligence.',
    'difficile', '15 min', 100, 'level_3', 'Toscana', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('3C410000-0015-4001-8901-234567890123', 'A cosa serve l''AIS?', 'multiple_choice', '["A pescare", "A trasmettere identità e posizione per evitare collisioni", "A cucinare", "A dormire"]', 1, 'Automatic Identification System.'),
('3C410000-0015-4001-8901-234567890123', 'Perché una nave dovrebbe falsificare l''AIS?', 'multiple_choice', '["Per gioco", "Per nascondere attività illegali (pesca vietata, trasporto armi/petrolio sanzionato)", "Per risparmiare carburante", "Per andare più veloce"]', 1, 'Le "Dark Fleet" (flotte fantasma) operano così ogni giorno.');
