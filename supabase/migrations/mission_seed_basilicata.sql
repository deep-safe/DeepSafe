-- Mission Seed for Basilicata (Theme: "Le Caverne Cifrate: Blockchain & Decentralizzazione")
-- Region: Basilicata (HARD / TRICKY EDITION)
-- Provinces: Matera (MT), Potenza (PZ)

-- =================================================================================================
-- MATERA (MT) - Crypto Storage & Wallets ("La Città di Pietra - Cold Storage")
-- =================================================================================================

-- Mission 1: Seed Phrase & Paper - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000001', 'MT', 'Parole di Pietra',
    'La tua banca sei tu. Se perdi le chiavi, la banca brucia.',
    E'# Seed Phrase (12/24 Parole)\n\nLa Seed Phrase è la chiave maestra (Master Private Key) di TUTTI i tuoi asset.\n\nRegole d''oro:\n1.  **MAI Online:** Non scriverla mai su note, cloud, email o fare foto.\n2.  **MAI Clipboard:** Non copiarla mai negli appunti (i malware leggono la clipboard).\n3.  **Cold Storage:** Scrivila su carta o incidila su metallo.',
    'semplice', '5 min', 50, 'level_1', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000001', 'È sicuro salvare la Seed Phrase in un Password Manager cifrato (es. LastPass, Bitwarden)?', 'multiple_choice', '["Sì, se ha MFA", "No. Se il tuo PC è infetto da un Keylogger quando la digiti, o se il Cloud del provider viene bucato, perdi tutto. Le chiavi crypto non si cambiano come le password email", "Sì, la cifratura è AES", "Solo se paghi"]', 1, 'Per le crypto, il livello di sicurezza richiesto è "Air Gap". Il cloud non basta.', NULL),
('ba510000-0000-0000-0000-000000000001', 'Se perdi il Ledger (Hardware Wallet), perdi i fondi?', 'multiple_choice', '["Sì, i soldi sono dentro la chiavetta", "No. I fondi sono sulla Blockchain. Il Ledger contiene solo le chiavi. Se hai la Seed Phrase, puoi ripristinare il wallet su un nuovo dispositivo", "Sì, perdi metà", "Devi chiamare l''assistenza"]', 1, 'Il dispositivo è sacrificabile. La Seed Phrase è l''unica cosa che conta.', NULL),
('ba510000-0000-0000-0000-000000000001', 'Qualcuno ti contatta: "Salve, Supporto MetaMask. Per sbloccare il conto serve verificare le 12 parole".', 'multiple_choice', '["Gliele do", "È una truffa al 100%. NESSUN supporto tecnico legittimo chiederà MAI la seed phrase. Mai.", "Chiedo il nome", "Controllo il logo"]', 1, 'La regola universale: chi chiede la Seed è un ladro.', NULL),
('ba510000-0000-0000-0000-000000000001', 'Dividere la Seed Phrase a metà (6 parole a casa, 6 parole in ufficio) è intelligente?', 'true_false', '["Vero", "Falso"]', 1, 'Falso (o rischioso). Se ti rubano metà seed (6 parole), un hacker può indovinare le altre 6 con un attacco Brute Force in tempi ragionevoli. Mai depotenziare l''entropia.', NULL),
('ba510000-0000-0000-0000-000000000001', 'Approfondimento su: PAROLE. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Infinite Approval (Rug Pull) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000002', 'MT', 'Firma alla Cieca',
    'Hai appena regalato il portafoglio al ladro.',
    E'# Token Approval\n\nQuando usi un Exchange Decentralizzato (DEX), devi prima "Approvare" (Approve) l''uso dei tuoi token.\nMolti siti, per comodità, chiedono l''approvazione per **"Unlimited USDT"**.\n\nSe firmi, quel contratto intelligente può prelevare TUTTI i tuoi USDT in qualsiasi momento futuro, senza chiedertelo più. Se il contratto è malevolo, sei rovinato.',
    'medio', '10 min', 75, 'level_2', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000002', 'Come ti difendi dall''Infinite Approval?', 'multiple_choice', '["Non usare DeFi", "Quando il wallet (MetaMask) chiede l''approvazione, modifica manualmente l''importo da ''Illimitato'' all''importo esatto che vuoi spendere (es. 100 USDT). È scomodo ma sicuro", "Usare VPN", "Pregare"]', 1, 'Principio del minimo privilegio applicato ai soldi.', NULL),
('ba510000-0000-0000-0000-000000000002', 'Cos''è `revoke.cash`?', 'multiple_choice', '["Un sito di phishing", "Un tool essenziale per vedere tutte le approvazioni attive sul tuo wallet e revocarle (togliere il permesso di spesa ai vecchi contratti)", "Un bancomat", "Un gioco"]', 1, 'Igiene periodica del wallet: revocare i permessi vecchi.', NULL),
('ba510000-0000-0000-0000-000000000002', 'Se revochi un permesso, paghi Gas Fee?', 'multiple_choice', '["No", "Sì, revocare è una transazione sulla blockchain che modifica lo stato del contratto. Costa soldi", "Solo il martedì", "Dipende"]', 1, 'La sicurezza costa (letteralmente).', NULL),
('ba510000-0000-0000-0000-000000000002', 'Un Hardware Wallet protegge dagli scam "Malicious Approval"?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. L''Hardware Wallet firma quello che tu gli dici di firmare. Se approvi una transazione malevola, il Ledger la firma diligentemente e i soldi spariscono.', NULL),
('ba510000-0000-0000-0000-000000000002', 'Approfondimento su: FIRMA. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Dusting Attack - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000003', 'MT', 'Polvere Tracciante',
    'Niente è gratis, nemmeno i token.',
    E'# Dusting Attack\n\nTrovi nel wallet 0.00001 di un token sconosciuto o un NFT "Voucher 1000$".\nL''hacker te l''ha mandato (Airdrop).\n\n**Obiettivo:** Se tu muovi quei token (li vendi o li sposti), l''hacker analizza la Blockchain e vede con quali altri wallet interagisci, collegando il tuo wallet anonimo alla tua identità reale (es. wallet dell''Exchange KYC). De-anonimizzazione.',
    'difficile', '15 min', 150, 'level_3', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000003', 'Cosa fare se ricevi token "Dust" sconosciuti?', 'multiple_choice', '["Venderli subito", "Ignorarli e NON toccarli mai. Usare la funzione ''Hide'' del wallet. Se non li muovi, non generi tracce", "Rimandarli al mittente", "Chiamare la polizia"]', 1, 'Non interagire è la difesa.', NULL),
('ba510000-0000-0000-0000-000000000003', 'Alcuni NFT truffa possono svuotare il wallet solo guardandoli?', 'multiple_choice', '["No", "No, ma possono contenere codice malevolo nel link esterno o indurti a visitare un sito di phishing per ''riscattare il premio''", "Sì, se sono GIF", "Dipende"]', 1, 'L''NFT in sé è inerte, ma l''interazione umana (andare sul sito per vendere) è il pericolo.', NULL),
('ba510000-0000-0000-0000-000000000003', 'Cos''è un "Vampire Attack" in crypto?', 'multiple_choice', '["Un pipistrello", "Un protocollo clone che offre incentivi (token) migliori per risucchiare liquidità e utenti dal protocollo originale (es. SushiSwap vs Uniswap)", "Un virus", "Sangue"]', 1, 'Strategia di mercato aggressiva.', NULL),
('ba510000-0000-0000-0000-000000000003', 'Le transazioni sulla Blockchain sono anonime.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Sono PSEUDO-anonime. Tutto è pubblico per sempre. Basta collegare un indirizzo a una persona una volta, e tutto lo storico è rivelato.', NULL),
('ba510000-0000-0000-0000-000000000003', 'In ambito Polvere Tracciante (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- POTENZA (PZ) - Smart Contracts & DeFi ("Il Potere del Codice")
-- =================================================================================================

-- Mission 1: Immutabilità del Bug - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000004', 'PZ', 'Codice Scolpito',
    'Verba volant, Smart Contracts manent.',
    E'# Immutabilità\n\nUno Smart Contract caricato su Ethereum è come una statua di pietra.\nNon puoi modificarlo.\n\nSe c''è un bug che permette di rubare tutti i soldi, rimarrà lì per sempre.\nNon esiste `git revert` o "Patch del martedì".\nL''unica soluzione è creare un contratto NUOVO e dire a tutti di spostare i soldi (migrazione complessa).',
    'semplice', '5 min', 50, 'level_1', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000004', 'Cos''è un "Proxy Contract"?', 'multiple_choice', '["Un server", "Un trucco per rendere i contratti ''aggiornabili''. L''utente parla con il Proxy, che delega la logica a un altro contratto che PUÒ essere cambiato dall''admin", "Un virus", "Un voto"]', 1, 'Introduce un rischio di centralizzazione: se l''admin è cattivo, cambia la logica e ruba tutto.', NULL),
('ba510000-0000-0000-0000-000000000004', 'Cos''è un Audit di sicurezza?', 'multiple_choice', '["Un controllo fiscale", "Una revisione del codice fatta da esperti (es. OpenZeppelin) PRIMA del deploy per trovare bug. Non è una garanzia assoluta, ma riduce i rischi", "Un backup", "Una firma"]', 1, 'Mai investire in progetti "Unaudited".', NULL),
('ba510000-0000-0000-0000-000000000004', 'Se invii Token a un indirizzo contratto sbagliato, puoi annullare?', 'multiple_choice', '["Sì, chiami Vitalik", "No. Le transazioni Blockchain sono irreversibili (Finality). I fondi sono persi per sempre nell''abisso digitale", "Sì entro 10 minuti", "Dipende"]', 1, 'Essere la propria banca significa zero protezione errori.', NULL),
('ba510000-0000-0000-0000-000000000004', 'I DAO Hack avvengono perché gli hacker hanno password?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Sfruttano errori logici nel codice pubblico (es. Reentrancy Attack in The DAO), non furto di credenziali.', NULL),
('ba510000-0000-0000-0000-000000000004', 'In ambito Codice Scolpito (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Flash Loans - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000005', 'PZ', 'Milionario per un Secondo',
    'Prendi i soldi, manipoli il mercato, restituisci. Tutto in un respiro.',
    E'# Flash Loans\n\nIn DeFi, puoi prendere in prestito 100 Milioni di dollari SENZA garanzie (Collateral).\n\n**La regola:** Devi restituirli (con gli interessi) **entro la fine della stessa transazione**.\nSe non li restituisci, la transazione fallisce come se non fosse mai esistita.\n\nGli hacker usano questi fondi infiniti per manipolare i prezzi dei token (Oracle Manipulation) su un exchange e fare profitti enormi sull''altro.',
    'medio', '10 min', 75, 'level_2', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000005', 'Cos''è un attacco di "Oracle Manipulation"?', 'multiple_choice', '["Prevedere il futuro", "Usare un Flash Loan per comprare massicciamente un token su un DEX illiquido, far schizzare il prezzo alle stelle momentaneamente, e usare quel prezzo falso per farsi prestare soldi su un altro protocollo", "Mentire", "Rompe il computer"]', 1, 'Il prezzo spot di un DEX non dovrebbe mai essere usato come oracolo sicuro.', NULL),
('ba510000-0000-0000-0000-000000000005', 'I Flash Loan sono illegali?', 'multiple_choice', '["Sì", "No, sono una feature finanziaria legittima per l''arbitraggio. Diventano un vettore di attacco quando usati contro protocolli deboli", "Solo in Italia", "Boh"]', 1, 'Uno strumento neutro, potente e pericoloso.', NULL),
('ba510000-0000-0000-0000-000000000005', 'Come ci si difende dai Flash Loan Attacks?', 'multiple_choice', '["Vietando i prestiti", "Usando Oracoli decentralizzati (es. Chainlink) o TWAP (Time-Weighted Average Price) che non possono essere manipolati in una singola transazione istantanea", "Usando banche", "Chiudendo la domenica"]', 1, 'Chainlink prende la media da molte fonti, rendendo inutile la manipolazione locale.', NULL),
('ba510000-0000-0000-0000-000000000005', 'L''attacco richiede accesso ai server del protocollo?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Avviene interamente on-chain, interagendo con gli Smart Contract pubblici.', NULL),
('ba510000-0000-0000-0000-000000000005', 'Approfondimento su: PATTERN. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Front-Running (MEV) - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba510000-0000-0000-0000-000000000006', 'PZ', 'Il Panino Invisibile',
    'Ti hanno rubato il pranzo mentre lo ordinavi.',
    E'# MEV (Maximal Extractable Value)\n\nLa Blockchain è una foresta oscura.\nQuando invii una transazione, questa sosta nella "Mempool" (sala d''attesa pubblica) prima di essere confermata.\n\nRobot predatori (MEV Bots) vedono che stai comprando un token.\nPagano una tassa (Gas) più alta della tua per essere inseriti nel blocco **PRIMA** di te.\nComprano il token, ne alzano il prezzo, e te lo rivendono ("Sandwich Attack").',
    'difficile', '15 min', 150, 'level_3', 'Basilicata', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba510000-0000-0000-0000-000000000006', 'Come ti difendi dal Front-Running su Uniswap?', 'multiple_choice', '["Non puoi", "Impostando lo ''Slippage Tolerance'' basso (es. 0.5%). Se il prezzo cambia troppo a causa del bot, la tua transazione fallisce e non ti fai fregare (anche se perdi la Gas fee)", "Non pagare Gas", "Usare Bitcoin"]', 1, 'Slippage alto = Regalo ai bot.', NULL),
('ba510000-0000-0000-0000-000000000006', 'Chi colpiscono i Sandwich Bot?', 'multiple_choice', '["Solo i ricchi", "Chiunque faccia trade di importo significativo su DEX con bassa liquidità e alto Slippage", "I miner", "Gli hacker"]', 1, 'Sono parassiti automatizzati.', NULL),
('ba510000-0000-0000-0000-000000000006', 'Cos''è una "Private Transaction" (es. Flashbots)?', 'multiple_choice', '["Una transazione segreta", "Un modo per inviare la transazione direttamente ai Miner/Validator saltando la Mempool pubblica. I bot non la vedono finché non è già confermata. Difesa totale", "Un bonifico", "Illegale"]', 1, 'Flashbots Protect è lo scudo contro la Dark Forest.', NULL),
('ba510000-0000-0000-0000-000000000006', 'I Miner/Validator partecipano al MEV?', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Spesso sono loro stessi a riordinare le transazioni per profitto, o accettano tangenti dai bot.', NULL),
('ba510000-0000-0000-0000-000000000006', 'In ambito Il Panino Invisibile (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
