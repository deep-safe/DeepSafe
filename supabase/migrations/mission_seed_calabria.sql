-- Mission Seed for Calabria (Theme: "Il Ponte verso il Futuro: La Minaccia Quantistica")
-- Region: Calabria (HARD / TRICKY EDITION)
-- Provinces: Reggio Calabria (RC), Cosenza (CS), Catanzaro (CZ), Crotone (KR), Vibo Valentia (VV)

-- =================================================================================================
-- REGGIO CALABRIA (RC) - Harvest Now, Decrypt Later ("I Bronzi Immortali")
-- =================================================================================================

-- Mission 1: L'Archivio Silente - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000001', 'RC', 'Ladro Paziente',
    'Rubare oggi spazzatura illeggibile per trovare oro domani.',
    E'# Harvest Now, Decrypt Later (HNDL)\n\nGli hacker (e le nazioni) stanno rubando petabyte di traffico cifrato (VPN, HTTPS) che OGGI non possono leggere.\nPerché?\n\nPerché tra 10 o 15 anni, quando avranno un Computer Quantistico funzionante, potranno decifrare tutto in pochi secondi.\nSe i tuoi dati (DNA, segreti militari, brevetti) devono rimanere segreti per >10 anni, sei già "bucato".',
    'semplice', '5 min', 50, 'level_1', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000001', 'Qual è la difesa per i dati già rubati oggi dagli hacker in ottica HNDL?', 'multiple_choice', '["Cambiare password", "Nessuna. Quel dato cifrato è ormai in possesso dell''attaccante. Quando avrà la chiave quantistica, lo aprirà. La prevenzione era l''unica via", "Usare AES-256", "Cancellare i file"]', 1, 'Data exfiltration is forever.', NULL),
('ca1ab81a-0000-0000-0000-000000000001', 'Quanto deve durare la segretezza di una password bancaria?', 'multiple_choice', '["Per sempre", "Pochi mesi/anni. HNDL è meno rilevante per le password che cambiano spesso, ma critico per dati biometrici o sanitari che non cambiano mai", "1 giorno", "100 anni"]', 1, 'Il rischio HNDL dipende dalla "Shelf Life" del dato.', NULL),
('ca1ab81a-0000-0000-0000-000000000001', 'Usare una VPN protegge da HNDL?', 'multiple_choice', '["Sì", "No, anzi. Il traffico VPN è un bersaglio primario per la registrazione di massa da parte di attori statali per decifrazione futura", "Forse", "Sì se costosa"]', 1, 'I tunnel cifrati attirano l''attenzione.', NULL),
('ca1ab81a-0000-0000-0000-000000000001', 'HNDL funziona anche sui dati cartacei?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Se non è digitalizzato e intercettato, non può essere processato dal Quantum Computer.', NULL),
('ca1ab81a-0000-0000-0000-000000000001', 'In ambito Ladro Paziente (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Forward Secrecy - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000002', 'RC', 'Chiavi Usa e Getta',
    'Se cade il re, il castello non deve crollare tutto.',
    E'# Perfect Forward Secrecy (PFS)\n\nSenza PFS: Se l''hacker ruba la chiave privata del server OGGI, può decifrare tutto il traffico registrato 5 ANNI FA.\n\nCon PFS (es. ECDHE): Ogni sessione (ogni clic) usa una chiave effimera diversa. Se l''hacker ruba la chiave maestra oggi, non può leggere il passato, ma solo il futuro.',
    'medio', '10 min', 75, 'level_2', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000002', 'PFS protegge completamente dal Quantum Computer?', 'multiple_choice', '["Sì", "No, ma limita il danno. Invece di una chiave sola per decifrare tutto l''archivio storico, il computer quantistico dovrà rompere ogni singola chiave di sessione una per una (costoso)", "No, è inutile", "Solo su Linux"]', 1, 'Rende l''attacco computazionalmente molto più oneroso.', NULL),
('ca1ab81a-0000-0000-0000-000000000002', 'Quale algoritmo di scambio chiavi supporta PFS?', 'multiple_choice', '["RSA statico", "Diffie-Hellman Ephemeral (DHE) o Elliptic Curve DHE (ECDHE). La ''E'' sta per Ephemeral (temporaneo)", "AES", "MD5"]', 1, 'RSA puro (senza DH) NON ha forward secrecy.', NULL),
('ca1ab81a-0000-0000-0000-000000000002', 'TLS 1.3 obbliga l''uso di PFS?', 'multiple_choice', '["No", "Sì, ha rimosso il supporto agli algoritmi di scambio chiavi statici (come RSA Key Exchange) proprio per garantire la Forward Secrecy", "Solo in Europa", "Forse"]', 1, 'Un grande passo avanti per la privacy globale.', NULL),
('ca1ab81a-0000-0000-0000-000000000002', 'WhatsApp usa la Forward Secrecy?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, il protocollo Signal (usato da WA) rigenera le chiavi (Ratchet) continuamente.', NULL),
('ca1ab81a-0000-0000-0000-000000000002', 'Approfondimento su: CHIAVI. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Q-Day - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000003', 'RC', 'Il Giorno del Giudizio',
    'Quando crolleranno i muri matematici?',
    E'# Q-Day (Y2Q)\n\nÈ il giorno ipotetico in cui un Computer Quantistico "Cryptographically Relevant" (CRQC) sarà acceso.\nIn quel momento:\n1.  Tutte le firme digitali attuali diventano falsificabili.\n2.  Tutto il traffico internet cifrato diventa leggibile.\n3.  Le criptovalute (Bitcoin) non migrate diventano rubabili.',
    'difficile', '15 min', 150, 'level_3', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000003', 'Quando è previsto il Q-Day?', 'multiple_choice', '["Il 2025", "Nessuno lo sa. Le stime variano dal 2030 al 2050. Ma prepararsi richiede anni (migrazione infrastrutture)", "Mai", "Domani"]', 1, 'L''incertezza temporale è il rischio maggiore (Mosca 2015 theorem).', NULL),
('ca1ab81a-0000-0000-0000-000000000003', 'Cosa si intende per "Crypto-Agility"?', 'multiple_choice', '["Correre veloci", "La capacità di un software di cambiare algoritmo crittografico (es. da RSA a Kyber) senza dover riscrivere tutto il codice o l''hardware", "Usare Bitcoin", "Nulla"]', 1, 'Se hai hardcodato "RSA" nel codice, sarai spacciato al Q-Day.', NULL),
('ca1ab81a-0000-0000-0000-000000000003', 'Bitcoin è vulnerabile al Q-Day?', 'multiple_choice', '["No", "Sì, perché usa Elliptic Curves (ECDSA) per le firme. Se non migra a firme post-quantum (es. Lamport), i fondi negli indirizzi pubblici (old P2PK) sono a rischio", "Solo Ethereum", "Tutte le monete sono sicure"]', 1, 'La blockchain dovrà fare un Hard Fork per salvarsi.', NULL),
('ca1ab81a-0000-0000-0000-000000000003', 'Rompere AES richiede un computer quantistico?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. L''algoritmo di Grover indebolisce AES (dimezza i bit di sicurezza), ma NON lo rompe fatalmente come RSA. Basta usare AES-256 invece di AES-128 per essere sicuri.', NULL),
('ca1ab81a-0000-0000-0000-000000000003', 'Approfondimento su: TEMPO. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- =================================================================================================
-- COSENZA (CS) - Shor's Algorithm & RSA ("Il Labirinto Matematico")
-- =================================================================================================

-- Mission 1: La Fine dei Fattori - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000004', 'CS', 'Fattori Primi',
    'Un castello di carte matematico.',
    E'# RSA e Fattorizzazione\n\nTutta la sicurezza web odierna (il lucchetto HTTPS) si basa su un problema matematico: "È facile moltiplicare due numeri primi giganti, ma è difficilissimo risalire ai numeri originali partendo dal risultato".\n\nUn computer classico ci mette milioni di anni.\n**L''algoritmo di Shor** (su computer quantistico) ci mette pochi minuti. RSA è morto.',
    'semplice', '5 min', 50, 'level_1', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000004', 'L''Algoritmo di Shor rompe anche la crittografia simmetrica (AES)?', 'multiple_choice', '["Sì", "No. Shor rompe specificamente la crittografia asimmetrica basata su fattorizzazione (RSA) e logaritmi discreti (ECC, Diffie-Hellman)", "Solo AES-128", "Rompe tutto"]', 1, 'È un bisturi matematico preciso contro la Public Key Cryptography.', NULL),
('ca1ab81a-0000-0000-0000-000000000004', 'Quanto deve essere grande una chiave RSA per resistere?', 'multiple_choice', '["2048 bit", "4096 bit", "Non importa la grandezza. Shor trasforma la complessità esponenziale in polinomiale. Aumentare la chiave serve a poco, verrà rotta comunque velocemente", "1 milione di bit"]', 2, 'Aumentare la chiave RSA non è una difesa sostenibile contro il Quantum.', NULL),
('ca1ab81a-0000-0000-0000-000000000004', 'Shor funziona sui computer di oggi?', 'multiple_choice', '["Sì", "No, richiede hardware quantistico (Qubit e sovrapposizione) per eseguire la trasformata di Fourier quantistica", "Sì se hai GPU potenti", "Solo su Mac"]', 1, 'È un algoritmo quantistico nativo.', NULL),
('ca1ab81a-0000-0000-0000-000000000004', 'Gli Hash (SHA-256) sono rotti da Shor?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Gli Hash sono resistenti. Solo Grover li attacca (trovare collisioni), ma basta usare SHA-384 o SHA-512 per essere tranquilli.', NULL),
('ca1ab81a-0000-0000-0000-000000000004', 'Approfondimento su: FATTORI. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Elliptic Curves (ECC) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000005', 'CS', 'Curve Pericolose',
    'Più efficienti, ma più fragili.',
    E'# ECC vs Quantum\n\nCredevamo che le Curve Ellittiche (ECC) fossero il futuro: chiavi cortissime, sicurezza altissima.\n\n**La beffa:** L''algoritmo di Shor rompe le Curve Ellittiche (Logaritmo Discreto) **PIÙ FACILMENTE** di quanto rompa RSA.\nPer un computer quantistico, attaccare una chiave ECC a 256 bit richiede MENO Qubit che attaccare una chiave RSA 2048.',
    'medio', '10 min', 75, 'level_2', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000005', 'Perché usiamo ECC oggi se è vulnerabile?', 'multiple_choice', '["Siamo stupidi", "Perché oggi i computer quantistici non ci sono, e ECC è velocissima e leggera per gli smartphone. È la scelta migliore per il presente classico", "Costa meno", "Google obbliga"]', 1, 'ECC è ottima... finché non arriva il Q-Day.', NULL),
('ca1ab81a-0000-0000-0000-000000000005', 'Quanti Qubit servono per rompere ECC-256?', 'multiple_choice', '["Milioni", "Circa 2300 Qubit logici (stime variano). Per RSA-2048 ne servono il doppio o triplo. ECC cade prima", "1", "Infiniti"]', 1, 'Le chiavi piccole sono un vantaggio per noi, ma anche per l''attacker quantistico.', NULL),
('ca1ab81a-0000-0000-0000-000000000005', 'Cos''è la "Supersingular Isogeny Key Exchange" (SIKE)?', 'multiple_choice', '["Una curva ECC sicura", "Un algoritmo candidato Post-Quantum basato su curve ellittiche supersingolari... che è stato clamorosamente rotto da un PC classico nel 2022 prima di diventare standard", "Una bici", "Un virus"]', 1, 'Dimostra che la crittografia Post-Quantum è ancora un campo minato di ricerca.', NULL),
('ca1ab81a-0000-0000-0000-000000000005', 'Oggi il tuo smartphone usa ECC per collegarsi a Google.', 'true_false', '["Vero", "Falso"]', 0, 'Sì, probabilmente usa Curve25519 (X25519) per lo scambio chiavi.', NULL),
('ca1ab81a-0000-0000-0000-000000000005', 'In ambito Curve Pericolose (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- CATANZARO (CZ) - Post-Quantum Cryptography (PQC) ("La Nuova Cittadella")
-- =================================================================================================

-- Mission 1: Software, non Hardware - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000006', 'CZ', 'Difesa Classica',
    'Per combattere i quanti, basta cambiare la matematica.',
    E'# PQC (Post-Quantum Crypto)\n\nNon serve comprare un "Firewall Quantistico" per difendersi.\nLa PQC sono algoritmi (software) che girano sui nostri PC normali, ma basati su problemi matematici (es. Reticoli/Lattices) che NEMMENO un computer quantistico sa risolvere velocemente.\n\nEsempio: CRYSTALS-Kyber.',
    'semplice', '5 min', 50, 'level_1', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000006', 'Qual è lo svantaggio principale della PQC?', 'multiple_choice', '["Nessuno", "Chiavi e firme molto più grandi (in termini di Kilobyte) rispetto a RSA/ECC, causando rallentamenti nelle connessioni internet deboli", "Richiede Windows 11", "Non funziona su Android"]', 1, 'Il peso dei dati in transito aumenta significativamente.', NULL),
('ca1ab81a-0000-0000-0000-000000000006', 'Il NIST ha già standardizzato gli algoritmi?', 'multiple_choice', '["No", "Sì, nel 2024 sono stati rilasciati i primi standard FIPS ufficiali (ML-KEM, ML-DSA, SLH-DSA). Le aziende devono iniziare la migrazione", "Tra 100 anni", "Solo in USA"]', 1, 'La gara è iniziata ufficialmente.', NULL),
('ca1ab81a-0000-0000-0000-000000000006', 'Un algoritmo basato su "Hash-based signatures" (es. SPHINCS+) è sicuro?', 'multiple_choice', '["No", "Sì, è molto sicuro e ben compreso, ma produce firme enormi e lente. È usato come backup se i Lattices falliscono", "Sì se cifrato", "No è vecchio"]', 1, 'È la cintura di sicurezza di riserva.', NULL),
('ca1ab81a-0000-0000-0000-000000000006', 'Aggiornare Chrome all''ultima versione ti dà già protezione PQC?', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Google Chrome e i server Google usano già uno scambio chiavi ibrido (X25519 + Kyber) per proteggere gli utenti.', NULL),
('ca1ab81a-0000-0000-0000-000000000006', 'In ambito Difesa Classica (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Ibrido è meglio - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000007', 'CZ', 'Doppia Serratura',
    'Non fidarsi del nuovo arrivato.',
    E'# Approccio Ibrido\n\nGli algoritmi PQC sono nuovi. Potrebbero avere bug nascosti.\nGli algoritmi Classici (RSA/ECC) sono vecchi e solidi (contro PC classici), ma deboli contro i quanti.\n\n**Soluzione:** Usiamo entrambi! Deriviamo la chiave di sessione combinando una chiave ECC + una chiave Kyber.\n*   Se Kyber ha un bug -> ECC ci protegge oggi.\n*   Se arriva il computer quantistico (ECC rotto) -> Kyber ci protegge.',
    'medio', '10 min', 75, 'level_2', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000007', 'Perché non switchare solo a PQC subito?', 'multiple_choice', '["Costa troppo", "Rischio matematico. Nel 2022 l''algoritmo SIKE (finalista NIST) è stato rotto in un weekend. Se avessimo usato solo SIKE, saremmo stati nudi", "Non piace", "Difficile"]', 1, 'La prudenza crittografica impone la ridondanza.', NULL),
('ca1ab81a-0000-0000-0000-000000000007', 'Come si chiama questa modalità ibrida in SSH/TLS?', 'multiple_choice', '["Double Trouble", "Hybrid Key Exchange (es. X25519Kyber768Draft00). I client e server devono supportarlo entrambi", "Quantico", "Mixed Mode"]', 1, 'È lo standard di fatto per il prossimo decennio.', NULL),
('ca1ab81a-0000-0000-0000-000000000007', 'Usare due chiavi raddoppia il tempo di connessione?', 'multiple_choice', '["Sì", "Aggiunge un piccolo overhead (qualche millisecondo), ma trascurabile per la sicurezza ottenuta", "No, è più veloce", "Blocca tutto"]', 1, 'L''overhead è accettabile.', NULL),
('ca1ab81a-0000-0000-0000-000000000007', 'L''approccio ibrido protegge anche dall''attacco "Harvest Now"?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, perché la parte Kyber della chiave ibrida non potrà essere rotta in futuro dal computer quantistico, mantenendo il segreto.', NULL),
('ca1ab81a-0000-0000-0000-000000000007', 'Approfondimento su: CHIAVI. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- =================================================================================================
-- CROTONE (KR) - Quantum Key Distribution (QKD) ("Il Tempio di Hera")
-- =================================================================================================

-- Mission 1: Fisica vs Matematica - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000008', 'KR', 'Fotonica',
    'Usare la luce per creare segreti.',
    E'# QKD (Quantum Key Distribution)\n\nInvece di usare algoritmi matematici, usiamo la fisica (fotoni di luce).\nInvii fotoni polarizzati attraverso una fibra ottica dedicata.\n\nSe un hacker (Eve) cerca di "guardare" i fotoni mentre viaggiano, per le leggi della meccanica quantistica, **li altera irrimediabilmente**.\nAlice e Bob se ne accorgono (tasso di errore alto) e buttano via la chiave. Intercettazione impossibile senza essere scoperti.',
    'semplice', '5 min', 50, 'level_1', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000008', 'Perché QKD è considerato "Information-Theoretically Secure"?', 'multiple_choice', '["Parole a caso", "Perché la sua sicurezza non dipende dalla potenza di calcolo dell''hacker, ma dalle leggi della fisica universo. Nemmeno Dio può copiare un Qubit (No-Cloning Theorem)", "È magico", "È economico"]', 1, 'La sicurezza assoluta, teoricamente.', NULL),
('ca1ab81a-0000-0000-0000-000000000008', 'Posso fare QKD sul mio PC di casa?', 'multiple_choice', '["Sì", "No. Richiede hardware laser costoso, rilevatori di singoli fotoni e una fibra ottica DEDICATA (Dark Fiber) punto-punto. Non passa attraverso i normali router internet", "Solo se gaming", "Sì col Wi-Fi"]', 1, 'È una tecnologia per banche e governi, non per l''utente finale.', NULL),
('ca1ab81a-0000-0000-0000-000000000008', 'La QKD cifra i dati?', 'multiple_choice', '["Sì", "No. La QKD serve solo a *generare e scambiare la chiave* (Key Distribution). Poi usi quella chiave per cifrare i dati con AES tradizionale (OTP)", "Solo le mail", "Forse"]', 1, 'È un protocollo di scambio chiavi, non di cifratura payload.', NULL),
('ca1ab81a-0000-0000-0000-000000000008', 'La QKD funziona via satellite?', 'true_false', '["Vero", "Falso"]', 0, 'Vero (es. satellite Micius cinese). Lo spazio vuoto non disturba la polarizzazione dei fotoni come l''atmosfera o la fibra lunga.', NULL),
('ca1ab81a-0000-0000-0000-000000000008', 'In ambito Fotonica (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Limiti della QKD - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000009', 'KR', 'Distanza Limitata',
    'La luce si stanca.',
    E'# Repeater Problem\n\nI fotoni si attenuano nella fibra.\nDopo circa 80-100km, il segnale sparisce.\n\nIn una rete normale mettiamo un "Amplificatore".\nMa in QKD, amplificare significa "misurare e rigenerare", il che distrugge lo stato quantistico (copia).\nQuindi servono "Trusted Nodes": bunker sicuri ogni 80km dove la chiave viene decifrata e ricifrata. Un punto debole enorme.',
    'medio', '10 min', 75, 'level_2', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000009', 'Perché i "Trusted Nodes" sono un problema?', 'multiple_choice', '["Costano poco", "Perché devi fidarti che nessuno sia entrato fisicamente nel bunker intermedio. La sicurezza end-to-end è persa. È una catena di fiducia fisica", "Sono brutti", "Non servono"]', 1, 'Se il bunker è compromesso, tutta la rete QKD è compromessa.', NULL),
('ca1ab81a-0000-0000-0000-000000000009', 'Cos''è un "Quantum Repeater"?', 'multiple_choice', '["Un''antenna", "Il Santo Graal della rete quantistica: un dispositivo che estende il raggio usando l''Entanglement Swapping, senza misurare (e disturbare) il fotone. NON esiste ancora commercialmente", "Un cavo", "Un router"]', 1, 'Quando avremo i Quantum Repeaters, avremo la vera Quantum Internet.', NULL),
('ca1ab81a-0000-0000-0000-000000000009', 'La QKD protegge dall''autenticazione (Man-in-the-Middle)?', 'multiple_choice', '["Sì", "No. La QKD garantisce che nessuno ascolti, ma non garantisce CHI c''è dall''altra parte. Serve comunque un''''autenticazione classica iniziale (chiavi pre-condivise) per evitare di fare QKD con l''hacker", "Sì sempre", "Forse"]', 1, 'QKD richiede un canale autenticato preesistente. Paradosso.', NULL),
('ca1ab81a-0000-0000-0000-000000000009', 'PQC (Software) è più scalabile di QKD (Hardware)?', 'true_false', '["Vero", "Falso"]', 0, 'Assolutamente. PQC si installa ovunque. QKD richiede infrastruttura fisica nuova.', NULL),
('ca1ab81a-0000-0000-0000-000000000009', 'In ambito Distanza Limitata (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- VIBO VALENTIA (VV) - Entanglement & Superposition ("L'Onda")
-- =================================================================================================

-- Mission 1: Il Gatto Vivo e Morto - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca1ab81a-0000-0000-0000-000000000010', 'VV', 'Sovrapposizione',
    'Informatica non binaria.',
    E'# Qubit vs Bit\n\n*   **Bit Classico:** Vale 0 OPPURE 1. Come una moneta ferma.\n*   **Qubit:** Vale 0, 1, o una sovrapposizione infinita di entrambi. Come una moneta che gira vorticosamente.\n\nQuesto permette al computer quantistico di esplorare milioni di soluzioni contemporaneamente, invece che una alla volta. Ecco perché rompe le password.',
    'semplice', '5 min', 50, 'level_1', 'Calabria', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca1ab81a-0000-0000-0000-000000000010', 'Aggiungere 1 Qubit raddoppia la potenza?', 'multiple_choice', '["Sì", "Esponenzialmente. 30 Qubit contengono più stati di quanti PC ci siano sulla terra. 300 Qubit superano gli atomi dell''universo", "No, somma", "Dipende"]', 1, 'La potenza scala come 2^N.', NULL),
('ca1ab81a-0000-0000-0000-000000000010', 'Il computer quantistico è più veloce a fare tutto (es. Excel)?', 'multiple_choice', '["Sì", "No. È lentissimo per i calcoli sequenziali classici. È veloce SOLO per problemi specifici parallelizzabili (ricerca database, fattorizzazione, simulazione chimica)", "Solo i giochi", "Sì"]', 1, 'Non avremo PC quantistici sulla scrivania per guardare Netflix.', NULL),
('ca1ab81a-0000-0000-0000-000000000010', 'Cos''è l''Entanglement?', 'multiple_choice', '["Un nodo", "La connessione spettrale a distanza. Due Qubit correlati reagiscono istantaneamente, anche se a anni luce di distanza. Modificando uno, l''altro collassa", "Un cavo", "Amore"]', 1, 'Einstein lo chiamava "Spooky action at a distance".', NULL),
('ca1ab81a-0000-0000-0000-000000000010', 'Un computer quantistico può violare la blockchain Bitcoin?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, può calcolare la chiave privata (ECDSA) partendo dalla chiave pubblica, permettendo di spendere i fondi altrui.', NULL),
('ca1ab81a-0000-0000-0000-000000000010', 'In ambito Sovrapposizione (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
