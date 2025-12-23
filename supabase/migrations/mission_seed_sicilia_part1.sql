-- Mission Seed for Sicilia (Part 1)
-- Region: Sicilia (HARD / TRICKY EDITION)
-- Provinces: Palermo (PA), Catania (CT), Messina (ME), Agrigento (AG), Trapani (TP)

-- =================================================================================================
-- PALERMO (PA) - Tor Network ("Il Labirinto a Cipolla")
-- =================================================================================================

-- Mission 1: Onion Routing - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000001', 'PA', 'Strati di Cipolla',
    'Tre salti nel buio per nascondere chi sei.',
    E'# The Onion Router (Tor)\n\nTor protegge l''anonimato rimbalzando le comunicazioni attraverso una rete distribuita di relay gestiti da volontari.\nIl messaggio viene cifrato in strati (come una cipolla).\nOgni nodo sbuccia uno strato e conosce solo il nodo precedente e quello successivo, mai l''intero percorso.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000001', 'Quanti nodi attraversa tipicamente una connessione Tor?', 'multiple_choice', '["Esattamente tre nodi (Guard, Middle, Exit)", "Esattamente due nodi (Entry, Exit relay)", "Esattamente cinque (per massima sicurezza)", "Dipende dalla velocità della connessione"]', 0, 'Il percorso standard è 3 hop: Entry Guard -> Middle Relay -> Exit Node.', NULL),
('51c11a01-0000-0000-0000-000000000001', 'Il nodo "Guard" (Ingresso) conosce il tuo indirizzo IP?', 'multiple_choice', '["Sì, vede il tuo IP ma non sa cosa visiti", "No, vede solo l''IP del nodo intermedio", "Sì, e vede anche il contenuto dei dati", "No, non vede assolutamente il tuo IP"]', 0, 'Il primo nodo deve sapere chi sei per ricevere i dati, ma non sa dove vanno.', NULL),
('51c11a01-0000-0000-0000-000000000001', 'Il provider internet (ISP) sa che stai usando Tor?', 'multiple_choice', '["Sì vede che ti connetti a nodi pubblici", "No perché Tor usa la crittografia SSL", "Sì vede esattamente quali siti visiti", "No perché Tor nasconde tutto all''ISP"]', 0, 'L''ISP vede connessioni verso IP noti di Tor, a meno che non usi un Bridge.', NULL),
('51c11a01-0000-0000-0000-000000000001', 'Tor è lento perché usa troppa crittografia.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. È lento perché fa fare il giro del mondo ai pacchetti tra 3 nodi amatoriali.', NULL),
('51c11a01-0000-0000-0000-000000000001', 'Approfondimento su: LOGIN. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Exit Nodes - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000002', 'PA', 'L''Uscita Pericolosa',
    'L''ultimo miglio è sempre quello fatale.',
    E'# Exit Node\n\nL''Exit Node è l''ultimo server della catena.\nDecifra l''ultimo strato della cipolla e invia i dati al sito di destinazione (es. Google).\n\n**Il rischio:** L''Exit Node vede TUTTO il traffico non cifrato (HTTP). Può leggere le tue password, iniettare virus o modificare le pagine web che vedi.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000002', 'Se visiti un sito HTTPS via Tor, l''Exit Node vede i dati?', 'multiple_choice', '["No vede solo a quale server ti connetti", "Sì perché decifra l''ultimo strato Tor", "Sì ma solo se ha il certificato valido", "No non vede nemmeno il server target"]', 0, 'HTTPS cifra End-to-End. L''Exit Node vede traffico TLS cifrato. Vede "chi" chiami ma non "cosa" dici (grazie a SNI).', NULL),
('51c11a01-0000-0000-0000-000000000002', 'Chiunque può gestire un Exit Node Tor da casa propria?', 'multiple_choice', '["Sì ma rischia visite della polizia locale", "No serve una licenza speciale governativa", "Sì ed è completamente sicuro e anonimo", "No solo gli ISP possono aprirne alcuni"]', 0, 'Se un criminale usa il tuo nodo per attaccare, l''IP che appare è il TUO.', NULL),
('51c11a01-0000-0000-0000-000000000002', 'Cosa succede se l''Exit Node è malevolo (Malicious)?', 'multiple_choice', '["Può fare Man-in-the-Middle e SSL Strip", "Può risalire al tuo indirizzo IP reale", "Può bloccare il funzionamento di Tor", "Può rubare la tua chiave privata PGP"]', 0, 'È la minaccia principale su Tor per il traffico ClearWeb.', NULL),
('51c11a01-0000-0000-0000-000000000002', 'Usare Tor senza HTTPS è sicuro.', 'true_false', '["Vero", "Falso"]', 1, 'Suicida. L''exit node legge tutto.', NULL),
('51c11a01-0000-0000-0000-000000000002', 'L''Exit Node di Tor vede il contenuto del tuo traffico?', 'multiple_choice', '["Mai", "Sì, se non usi HTTPS (il traffico esce in chiaro verso Internet)", "No, è tutto cifrato sempre", "Solo il sabato"]', 1, 'L''ultimo miglio è scoperto se non c''è crittografia end-to-end (HTTPS).', NULL);


-- Mission 3: Hidden Services - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000003', 'PA', 'Servizi Nascosti',
    'Domini strani che finiscono per .onion.',
    E'# Onion Services\n\nI siti `.onion` non usano Exit Node.\nIl traffico non esce mai dalla rete Tor.\nSei connesso End-to-End cifrato dentro la rete.\n\nNessuno sa dov''è il server (IP nascosto).\nNessuno sa chi sei tu (IP nascosto).\nÈ il cuore del Deep Web.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000003', 'Come fa il tuo browser a trovare un indirizzo .onion?', 'multiple_choice', '["Chiede a una Distributed Hash Table (DHT)", "Chiede ai server DNS radice di Internet", "Chiede direttamente a Google Services", "Chiede al server centrale di Tor Project"]', 0, 'Non esistono DNS per .onion. Si usa un sistema di directory distribuita nascosta.', NULL),
('51c11a01-0000-0000-0000-000000000003', 'Cos''è un "Rendezvous Point" nella rete Tor?', 'multiple_choice', '["Un nodo casuale dove client e server si incontrano", "Il server finale dove risiede il sito nascosto", "Il primo nodo guardiano della connessione", "Un server speciale gestito dalla polizia"]', 0, 'Client e Server costruiscono circuiti fino a un punto comune per non rivelarsi a vicenda i propri IP.', NULL),
('51c11a01-0000-0000-0000-000000000003', 'Gli indirizzi .onion v3 sono lunghi 56 caratteri. Perché?', 'multiple_choice', '["Perché contengono la chiave pubblica Ed25519 completa", "Perché sono generati casualmente per sicurezza", "Perché usano un hash SHA-1 vecchio e insicuro", "Perché includono la localizzazione GPS del server"]', 0, 'La chiave pubblica È l''indirizzo. Non serve nessuna CA (Certificate Authority). Autenticazione automatica.', NULL),
('51c11a01-0000-0000-0000-000000000003', 'Tor Browser supporta UDP.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Tor supporta solo flussi TCP. Per questo il VoIP e i giochi non funzionano.', NULL),
('51c11a01-0000-0000-0000-000000000003', 'In ambito Servizi Nascosti (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- CATANIA (CT) - Dark Markets ("Il Mercato Nero")
-- =================================================================================================

-- Mission 1: Escrow & Multisig - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000004', 'CT', 'Fiducia Zero',
    'Come comprare illegalmente senza farsi rubare i soldi.',
    E'# Escrow\n\nNessuno si fida di nessuno.\nTu paghi, ma i soldi non vanno al venditore.\nVanno all''**Escrow** (il Mercato).\nQuando ricevi la merce, dici "OK" e il Mercato sblocca i fondi al venditore.\n\nSe il Mercato scappa coi soldi? (Exit Scam). Serve il **Multisig**.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000004', 'Cos''è il Multisig 2-of-3 in un acquisto darknet?', 'multiple_choice', '["Servono 2 firme su 3 per muovere i fondi (Buyer, Seller, Market)", "Il venditore deve firmare 3 volte per sicurezza", "Il compratore deve avere 3 chiavi private diverse", "Il mercato controlla tutto con 2 password"]', 0, 'Nessuno ha il controllo totale. Se il mercato fallisce, Buyer e Seller possono recuperare i fondi.', NULL),
('51c11a01-0000-0000-0000-000000000004', 'Perché l''Escrow centralizzato è pericoloso?', 'multiple_choice', '["Il mercato può fare Exit Scam e rubare tutto", "È troppo lento a processare i pagamenti", "Richiede documenti di identità reali", "Non supporta Bitcoin ma solo Monero"]', 0, 'L''admin del sito ha le chiavi di tutti i wallet interni.', NULL),
('51c11a01-0000-0000-0000-000000000004', 'Cosa significa FE (Finalize Early)?', 'multiple_choice', '["Rilasciare i fondi prima di ricevere la merce", "Cancellare l''ordine velocemente per errore", "Ricevere uno sconto per il pagamento rapido", "Usare una spedizione express tracciata"]', 0, 'Richiesto dai vendor famosi, ma rischiosissimo per l''utente. Nessuna protezione.', NULL),
('51c11a01-0000-0000-0000-000000000004', 'I market illegali usano PayPal.', 'true_false', '["Vero", "Falso"]', 1, 'Ovviamente no. Solo Crypto.', NULL),
('51c11a01-0000-0000-0000-000000000004', 'In ambito Fiducia Zero (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: FE Scam - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000005', 'CT', 'Prendi i Soldi e Scappa',
    'Il venditore perfetto diventa ladro all''improvviso.',
    E'# The Long Con\n\nUn venditore costruisce una reputazione perfetta per mesi. 1000 recensioni positive.\nPoi annuncia "Saldi al 50% solo per oggi! Pagamento FE obbligatorio".\nRiceve migliaia di ordini FE.\nSparisce con i soldi.\n\nNella Darknet, la reputazione è moneta, e si spende una volta sola.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000005', 'Come riconoscere un potenziale Exit Scam di un vendor?', 'multiple_choice', '["Offre sconti enormi se paghi subito fuori escrow", "Risponde lentamente ai messaggi dei clienti", "Non ha recensioni recenti da due settimane", "Cambia la chiave PGP senza nessun avviso"]', 0, '"Sconto 30% per Direct Deal" è il segnale classico.', NULL),
('51c11a01-0000-0000-0000-000000000005', 'Se un mercato va offline per "Manutenzione" per 3 giorni...', 'multiple_choice', '["È probabilmente un Exit Scam dell''admin del sito", "Stanno solo aggiornando i server per sicurezza", "Hanno subito un attacco DDoS dai concorrenti", "È colpa della tua connessione Tor instabile"]', 0, 'La "Manutenzione" prolungata senza update PGP firmati è la morte del market.', NULL),
('51c11a01-0000-0000-0000-000000000005', 'In caso di Exit Scam, la polizia può recuperare i soldi?', 'multiple_choice', '["Quasi mai, i fondi sono già in mixer o Monero", "Sì, se fai denuncia alla Polizia Postale", "Sì, perché i Bitcoin sono sempre tracciabili", "Solo se hai pagato con carta di credito"]', 0, 'I soldi sono irrecuperabili.', NULL),
('51c11a01-0000-0000-0000-000000000005', 'Il Doxxing è usato come arma contro gli scammer?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, gli utenti arrabbiati pubblicano i dati reali del venditore se li scoprono.', NULL),
('51c11a01-0000-0000-0000-000000000005', 'In ambito Prendi i Soldi e Scappa (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Accesso & Captcha - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000006', 'CT', 'Prova di Umanità',
    'Dimostra di non essere un bot della polizia.',
    E'# Anti-DDoS & Captcha\n\nI market sono sotto attacco costante (DDoS) da rivali o LEA (Law Enforcement).\nPer entrare, devi risolvere Captcha impossibili (orologi, rotazioni, puzzle logici).\nSe sbagli, il tuo circuito Tor viene bruciato.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000006', 'Perché i Captcha darknet sono così difficili rispetto a Google?', 'multiple_choice', '["Devono resistere a bot AI avanzati senza usare JS", "Perché gli admin sono sadici e vogliono pochi utenti", "Perché usano vecchie tecnologie non aggiornate", "Per evitare che la polizia acceda al sito web"]', 0, 'Senza Javascript, i controlli comportamentali (Recaptcha v3) non funzionano. Serve la sfida visiva pura.', NULL),
('51c11a01-0000-0000-0000-000000000006', 'Cos''è un "Phishing Mirror" di un market?', 'multiple_choice', '["Un sito falso identico all''originale per rubare login", "Un sito di backup ufficiale gestito dagli admin", "Il sito della polizia che monitora il traffico", "Un errore del browser quando carichi la pagina"]', 0, 'Il 90% dei link su "Hidden Wiki" sono phishing. Si rubano credenziali e depositi.', NULL),
('51c11a01-0000-0000-0000-000000000006', 'Come si verifica un link onion.v3 correttamente?', 'multiple_choice', '["Verificando la firma PGP crittografica del messaggio", "Controllando se inizia e finisce con gli stessi caratteri", "Cercandolo su Google per vedere se è recensito", "Chiedendo sul forum Reddit se è quello giusto"]', 0, 'L''unica fonte di verità è la firma PGP dell''admin.', NULL),
('51c11a01-0000-0000-0000-000000000006', 'I market richiedono Javascript attivo?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Richiedono categoricamente JS disattivato per sicurezza.', NULL),
('51c11a01-0000-0000-0000-000000000006', 'In ambito Prova di Umanità (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- MESSINA (ME) - Money Laundering ("I Soldi Sporchi")
-- =================================================================================================

-- Mission 1: Bitcoin Mixing - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000007', 'ME', 'Lavatrice Digitale',
    'Mischiare le monete per confondere le acque.',
    E'# CoinJoin & Mixers\n\nBitcoin è pseudo-anonimo. Tutto è pubblico.\nSe mandi BTC da Coinbase al Market, Coinbase SA che hai comprato droga.\n\n**Mixing:** Metto i miei BTC in un calderone con altri 100 utenti. I BTC vengono mescolati e ridistribuiti. Ora non si sa quale output appartiene a chi.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000007', 'Gli Exchange centralizzati accettano Bitcoin mixati?', 'multiple_choice', '["Spesso no, bloccano l''account per rischio riciclaggio", "Sì, non possono distinguere i Bitcoin mixati", "Sì, anzi consigliano di usare sempre i mixer", "Solo se paghi una commissione extra di deposito"]', 0, 'Il "Tainted Bitcoin" viene rifiutato dalle piattaforme compliant KYC.', NULL),
('51c11a01-0000-0000-0000-000000000007', 'Qual è la differenza tra Mixer centralizzato e CoinJoin?', 'multiple_choice', '["Il Mixer ha un custode che può rubare, CoinJoin è P2P", "CoinJoin costa molto di più del Mixer classico", "CoinJoin funziona solo su rete Ethereum non BTC", "Nessuna, sono due nomi per la stessa identica cosa"]', 0, 'CoinJoin (es. Wasabi, Samurai) è trustless. Il Mixer vecchio stile è una banca opaca.', NULL),
('51c11a01-0000-0000-0000-000000000007', 'Mixare i fondi garantisce anonimato perfetto?', 'multiple_choice', '["No, attacchi statistici avanzati possono de-mixare", "Sì, matematicamente impossibile risalire alla fonte", "Sì, se lo fai due volte di fila non c''è rischio", "Solo se usi Tor durante il processo di mixing"]', 0, 'Nulla è perfetto. Se sbagli i tempi o gli importi, sei tracciabile.', NULL),
('51c11a01-0000-0000-0000-000000000007', 'Tornado Cash è un mixer per Bitcoin.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. È per Ethereum (e altre chain EVM).', NULL),
('51c11a01-0000-0000-0000-000000000007', 'Approfondimento su: PATTERN. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Monero vs Bitcoin - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000008', 'ME', 'Il Re della Privacy',
    'L''unica moneta veramente fungibile.',
    E'# Monero (XMR)\n\nBitcoin ha un registro pubblico trasparente.\nMonero ha un registro pubblico **opaco**.\n\n*   Mittente nascosto (Ring Signatures).\n*   Importo nascosto (Confidential Transactions).\n*   Destinatario nascosto (Stealth Addresses).\n\nÈ lo standard de facto per il crimine (e la privacy estrema).',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000008', 'Perché molti market accettano SOLO Monero?', 'multiple_choice', '["Per evitare Chain Analysis da parte delle forze dell''ordine", "Perché Monero è più stabile di Bitcoin come prezzo", "Perché le commissioni di Monero sono più alte e ricche", "Perché Bitcoin è illegale in tutti i paesi del mondo"]', 0, 'La tracciabilità di Bitcoin ha portato all''arresto di troppi vendor.', NULL),
('51c11a01-0000-0000-0000-000000000008', 'Cos''è una "View Key" in Monero?', 'multiple_choice', '["Una chiave che permette di vedere le transazioni (audit)", "La chiave per spendere i fondi del wallet (privata)", "Una password per accedere al forum della comunità", "Un virus che registra lo schermo del computer"]', 0, 'Permette un audit selettivo (es. per le tasse) senza dare potere di spesa.', NULL),
('51c11a01-0000-0000-0000-000000000008', 'Gli Exchange sono felici di listare Monero?', 'multiple_choice', '["No, subiscono pressioni enormi dai regolatori per delistarlo", "Sì, porta molti volumi di scambio e guadagni facili", "Non gli importa, basta che sia una crypto famosa", "Sì perché è la moneta preferita da Elon Musk"]', 0, 'Molti exchange (es. Kraken in EU, Binance) hanno dovuto rimuovere XMR.', NULL),
('51c11a01-0000-0000-0000-000000000008', 'Le transazioni Monero sono molto più grandi (byte) di Bitcoin.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Le prove crittografiche (Bulletproofs) occupano spazio.', NULL),
('51c11a01-0000-0000-0000-000000000008', 'Approfondimento su: VEDERE. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Chain Analysis - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000009', 'ME', 'Sulle Tracce',
    'La polizia ha strumenti migliori dei tuoi.',
    E'# Blockchain Forensics\n\nAziende come Chainalysis mappano il mondo crypto.\nSanno che quell''indirizzo appartiene a "DarkMarket X" e quell''altro a "Binance KYC User Y".\n\nSe sposti fondi tra i due, il software disegna una linea rossa: "Utente Y ha pagato Market X".\nGame Over.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000009', 'Cos''è l''euristica del "Common Input Ownership"?', 'multiple_choice', '["Se 2 indirizzi sono input nella stessa tx, sono della stessa persona", "Se due persone usano lo stesso PC, sono complici", "Se un indirizzo riceve soldi, deve spenderli subito", "Se usi Bitcoin, sei sicuramente un criminale russo"]', 0, 'Ipotesi fondamentale della clustering analysis.', NULL),
('51c11a01-0000-0000-0000-000000000009', 'Cosa significa "Peel Chain"?', 'multiple_choice', '["Una tecnica per riciclare piccoli importi in sequenza rapida", "Una catena di blocchi corrotta che viene scartata", "Un attacco hacker che sbuccia la cifratura del wallet", "Un tipo di banana digitale venduta come NFT"]', 0, 'Pattern tipico degli exchange o dei mixer che inviano "il resto" a un nuovo indirizzo.', NULL),
('51c11a01-0000-0000-0000-000000000009', 'Gli Swap instantanei (BTC -> XMR) sono tracciabili?', 'multiple_choice', '["Sì se usi un servizio centralizzato che tiene i log (KYC o no)", "No perché cambi blockchain e perdi le tracce sempre", "Sì perché Bitcoin e Monero condividono lo stesso ledger", "No se usi una VPN durante il cambio valuta"]', 0, 'Il punto di swap è il collo di bottiglia dell''anonimato.', NULL),
('51c11a01-0000-0000-0000-000000000009', 'Lightning Network è perfettamente anonimo?', 'true_false', '["Vero", "Falso"]', 1, 'Migliora la privacy, ma attacchi di timing e routing possono de-anonimizzare.', NULL),
('51c11a01-0000-0000-0000-000000000009', 'In ambito Sulle Tracce (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- AGRIGENTO (AG) - Crittografia PGP ("I Pizzini Cifrati")
-- =================================================================================================

-- Mission 1: Chiavi Pubbliche/Private - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000010', 'AG', 'La Busta e il Sigillo',
    'Senza PGP, sei nudo nella piazza.',
    E'# PGP (Pretty Good Privacy)\n\nNella Darknet, il sito non protegge i tuoi messaggi (l''admin può leggerli).\nDevi cifrarli TU prima di incollarli nel box messaggi.\n\n*   **Chiave Pubblica del destinatario:** Usata per CIFRARE (Chiudere la busta).\n*   **Tua Chiave Privata:** Usata per DECIFRARE (Aprire la busta).',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000010', 'Per inviare l''indirizzo di spedizione al vendor, cosa usi?', 'multiple_choice', '["La chiave Pubblica del Vendor per cifrare il messaggio", "La tua chiave Privata per cifrare il messaggio", "La chiave Pubblica del Vendor per firmare il testo", "La chiave Privata del Vendor che ti ha inviato"]', 0, 'Cifri con la pubblica del destinatario. Solo lui (con la privata) potrà leggere.', NULL),
('51c11a01-0000-0000-0000-000000000010', 'Se perdi la tua Chiave Privata PGP, puoi recuperarla?', 'multiple_choice', '["No, mai. I messaggi per te resteranno illeggibili per sempre", "Sì, se hai la Chiave Pubblica puoi ricalcolarla", "Sì, chiedendo all''admin del market di resettarla", "Sì, brute-forcing della password in 24 ore"]', 0, 'La crittografia asimmetrica non ha "Password Reset".', NULL),
('51c11a01-0000-0000-0000-000000000010', 'È sicuro generare le chiavi PGP online su un sito web?', 'multiple_choice', '["No, il sito potrebbe salvare la tua chiave privata segretamente", "Sì, è comodo e veloce senza installare software", "Sì, se il sito usa HTTPS ed è famoso come GnuPG", "Dipende se usi la modalità incognito del browser"]', 0, 'Mai generare chiavi private su computer altrui (il server web).', NULL),
('51c11a01-0000-0000-0000-000000000010', 'Incollare la Chiave Privata nel profilo del market è corretto?', 'true_false', '["Vero", "Falso"]', 1, 'Follia pura. Devi incollare solo la PUBBLICA. La privata resta sul tuo PC.', NULL),
('51c11a01-0000-0000-0000-000000000010', 'In ambito La Busta e il Sigillo (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: 2FA con PGP - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000011', 'AG', 'Autenticazione Blindata',
    'La password non basta mai.',
    E'# PGP 2FA\n\nGoogle Authenticator non funziona bene nell''anonimato.\nI market usano il **PGP 2FA**.\n\n1.  Fai login con password.\n2.  Il sito ti mostra un messaggio cifrato con la TUA chiave pubblica.\n3.  Devi decifrarlo sul tuo PC, copiare il codice segreto dentro, e incollarlo nel sito.\nSolo chi ha la chiave privata reale può entrare.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000011', 'Perché PGP 2FA è superiore agli SMS o alle App OTP?', 'multiple_choice', '["Non richiede telefono/SIM e prova il possesso della chiave di cifratura", "È più veloce da usare rispetto a copiare codici a 6 cifre", "Permette di recuperare la password se la dimentichi", "Funziona anche se il sito è offline o sotto attacco"]', 0, 'Lega l''identità all''unica cosa che conta: la crittografia.', NULL),
('51c11a01-0000-0000-0000-000000000011', 'Se un hacker ruba la tua password del market, può entrare?', 'multiple_choice', '["No, se hai PGP 2FA attivo, si bloccherà alla sfida crittografica", "Sì, la 2FA sui market è opzionale e si aggira facilmente", "Sì, se usa un attacco brute force sulla pagina di login", "No, ma può resettare la tua chiave PGP via email"]', 0, 'La 2FA è la barriera reale contro i database leak e il phishing (in parte).', NULL),
('51c11a01-0000-0000-0000-000000000011', 'Decifrare il messaggio 2FA richiede la connessione internet?', 'multiple_choice', '["No, avviene in locale sul tuo PC con il software GPG/Kleopatra", "Sì, devi inviare la chiave privata al server per la verifica", "Sì, serve per sincronizzare l''orario con la blockchain", "Dipende dal software che usi per gestire le chiavi"]', 0, 'Tutto offline. Air Gap friendly.', NULL),
('51c11a01-0000-0000-0000-000000000011', 'Posso usare la stessa chiave PGP su tutti i market?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, è la tua identità digitale persistente (Identity Key).', NULL),
('51c11a01-0000-0000-0000-000000000011', 'In ambito Autenticazione Blindata (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- TRAPANI (TP) - De-anonimizzazione ("Il Traditore")
-- =================================================================================================

-- Mission 1: Correlation Attack - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000012', 'TP', 'Il Tempo ti Tradisce',
    'Entri ed esci nello stesso istante. Ti ho visto.',
    E'# Global Adversary\n\nTor protegge dall''analisi del traffico locale.\nMa se un ente (NSA/ISP Globali) vede:\n1.  Tu invii 5MB di dati criptati a Tor alle 14:00:01.\n2.  Il sito Target riceve 5MB di dati da Tor alle 14:00:02.\n\nPer correlazione statistica temporale, sa che sei TU. Non serve decifrare.',
    'semplice', '5 min', 50, 'level_1', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000012', 'Come Tor cerca di mitigare i Correlation Attack?', 'multiple_choice', '["Padding dei pacchetti e ritardi casuali (anche se imperfetti)", "Cambiando il percorso ogni singolo secondo per confondere", "Usando più banda di quella necessaria per generare rumore", "Non può farci nulla, è un limite teorico irrisolvibile"]', 0, 'I pacchetti sono resi uniformi (celle da 512 byte), ma la temporizzazione (Timing) resta un problema difficile.', NULL),
('51c11a01-0000-0000-0000-000000000012', 'Usare Tor solo per pochi secondi è sicuro?', 'multiple_choice', '["No, sessioni brevi sono più facili da correlare statisticamente", "Sì, meno tempo stai online meno sei tracciabile dall''hacker", "Sì, basta che cancelli i cookie alla fine della sessione", "Dipende se usi Windows o Linux per la connessione"]', 0, 'Il traffico "burst" è unico. Il traffico costante si mimetizza meglio.', NULL),
('51c11a01-0000-0000-0000-000000000012', 'Se posti su Facebook "Ciao" via Tor, sei anonimo?', 'multiple_choice', '["No, ti sei identificato col login e l''orario del post coincide", "Sì, Facebook vede l''IP di Tor quindi non sa dove ti trovi", "Sì, se usi un account falso creato lo stesso giorno", "Forse, dipende se Facebook collabora con la polizia"]', 0, 'Il contenuto e il comportamento ti de-anonimizzano, non l''IP.', NULL),
('51c11a01-0000-0000-0000-000000000012', 'VPN over Tor (VPN prima di Tor) risolve la correlazione?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Sposta solo il punto di ingresso. L''analisi dei pattern di traffico (dimensione/tempo) resta valida.', NULL),
('51c11a01-0000-0000-0000-000000000012', 'Approfondimento su: USCITA. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Browser Fingerprinting - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000013', 'TP', 'Impronta Unica',
    'La tua risoluzione schermo ti condanna.',
    E'# Fingerprinting\n\nAnche senza Cookie e IP, il tuo browser dice al sito:\n"Sono Tor Browser, risoluzione 1920x1080, Font installati: Arial, Times..."\n\nQuesta combinazione è UNICA. Se ridimensioni la finestra di Tor, crei una risoluzione unica (es. 1234x987) che ti rende tracciabile tra milioni di utenti.',
    'medio', '10 min', 75, 'level_2', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000013', 'Perché Tor Browser ti avvisa se massimizzi la finestra?', 'multiple_choice', '["Perché devi confonderti nella massa di utenti con finestra default", "Perché a schermo intero Tor consuma troppa CPU e rallenta", "Perché i siti darknet sono progettati per schermi piccoli", "Perché massimizzare rompe la crittografia della scheda"]', 0, '"Letterboxing" (bande nere) è usato ora per mitigare, ma la dimensione standard resta la più sicura.', NULL),
('51c11a01-0000-0000-0000-000000000013', 'I Font installati nel sistema ti identificano?', 'multiple_choice', '["Sì, la lista dei font è un''impronta digitale molto specifica", "No, i font sono uguali su tutti i computer del mondo", "Sì, ma solo se accetti i cookie di terze parti", "No, Tor Browser blocca la lettura dei font di sistema"]', 0, 'Tor Browser standardizza i font visibili per evitare questo leak.', NULL),
('51c11a01-0000-0000-0000-000000000013', 'Canvas Fingerprinting cos''è?', 'multiple_choice', '["Disegnare un''immagine invisibile per vedere come la GPU la renderizza", "Scaricare un''immagine di sfondo per tracciare l''IP", "Usare la webcam per prendere l''impronta digitale", "Un errore grafico"]', 0, 'Ogni scheda video/driver disegna la stessa immagine con differenze di pixel microscopiche uniche.', NULL),
('51c11a01-0000-0000-0000-000000000013', 'Usare un User-Agent falso (es. iPhone) su PC aiuta?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Ti rende PIÙ unico, perché il comportamento del browser non corrisponderà all''User-Agent dichiarato (incoerenza).', NULL),
('51c11a01-0000-0000-0000-000000000013', 'In ambito Impronta Unica (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Javascript Enable - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    '51c11a01-0000-0000-0000-000000000014', 'TP', 'Il Cavallo di Troia',
    'Un click su "Abilita" e sei fuori.',
    E'# Javascript De-anonimizzazione\n\nNel 2013, l''FBI ha preso il controllo di Freedom Hosting iniettando un Javascript malevolo nelle pagine.\nIl JS sfruttava un bug di Firefox (su cui Tor è basato) per inviare l''IP REALE e il MAC Address a un server dell''FBI, bypassando il proxy Tor.\n\nRegola: **NoScript** sempre attivo sui siti sconosciuti.',
    'difficile', '15 min', 150, 'level_3', 'Sicilia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('51c11a01-0000-0000-0000-000000000014', 'Perché Tor Browser ha uno slider di sicurezza (Standard/Safer/Safest)?', 'multiple_choice', '["Per disabilitare progressivamente JS e funzionalità rischiose", "Per cifrare di più la connessione se sei paranoico", "Per cambiare il percorso dei nodi più velocemente", "Per bloccare le pubblicità fastidiose sui siti"]', 0, 'Safest = Javascript disabilitato globalmente (Massima sicurezza).', NULL),
('51c11a01-0000-0000-0000-000000000014', 'Un exploit Javascript può uscire dalla sandbox del browser?', 'multiple_choice', '["Sì, se è uno Zero-Day critico contro il motore di rendering", "No, Javascript è sempre confinato nella scheda corrente", "Sì, ma solo se scarichi un file .exe volontariamente", "No, i moderni browser sono impenetrabili al JS"]', 0, 'Gli exploit RCE (Remote Code Execution) via JS sono rari ma devastanti.', NULL),
('51c11a01-0000-0000-0000-000000000014', 'WebRTC attivo su Tor Browser è pericoloso?', 'multiple_choice', '["Sì, può rivelare l''IP reale anche dietro VPN/Proxy via STUN", "No, serve solo per le videochiamate ed è innocuo", "Sì, ma solo se usi la webcam durante la sessione", "No, Tor Browser lo gestisce in modo sicuro di default"]', 0, 'WebRTC leak è la causa n.1 di de-anonimizzazione accidentale.', NULL),
('51c11a01-0000-0000-0000-000000000014', 'Disabilitare JS rompe la maggior parte dei siti Onion.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. I siti onion seri sono costruiti per funzionare senza JS (NoJS) proprio per sicurezza.', NULL),
('51c11a01-0000-0000-0000-000000000014', 'In ambito Il Cavallo di Troia (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
