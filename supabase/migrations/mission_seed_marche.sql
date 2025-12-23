-- Mission Seed for Marche (Theme: "L'Artigiano Digitale: Costruire Difese Solide")
-- Region: Marche (HARD / TRICKY EDITION)
-- Provinces: Ancona (AN), Pesaro e Urbino (PU), Macerata (MC), Fermo (FM), Ascoli Piceno (AP)

-- =================================================================================================
-- ANCONA (AN) - Navigazione Web Consapevole ("Il Porto Digitale")
-- =================================================================================================

-- Mission 1: Biscotti Indigesti (Cookies) - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234001', 'AN', 'Biscotti Indigesti',
    'Non tutti i dolci fanno bene.',
    E'# I Cookie & Incognito\n\nI cookie sono utili, ma persistenti.\n\n*   **Persistenza:** Anche se chiudi la scheda, il cookie resta (se non scade).\n*   **Incognito:** La modalità in incognito NON ti rende invisibile al provider o al sito. Serve solo a non salvare la cronologia *locale* sul tuo PC.\n*   **Session Sharing:** Le schede in incognito condividono i cookie tra loro finché non le chiudi tutte.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234001', 'Apri una scheda in Incognito e fai login su Gmail. Poi apri una SECONDA scheda in Incognito. Sei loggato anche lì?', 'multiple_choice', '["No, ogni scheda è isolata", "Sì, le schede Incognito aperte contemporaneamente condividono la stessa sessione (cookie jar)", "Dipende dal meteo", "No, Google ti blocca"]', 1, 'Le schede Incognito condividono lo stato finché la sessione "Incognito" è attiva. Se ne chiudi una sola, l''altra resta loggata.', NULL),
('b849959f-4871-55e5-a955-356478234001', 'Hai rifiutato tutti i cookie ("Reject All"). Il sito può comunque tracciarti?', 'multiple_choice', '["No, è illegale", "Sì, tramite Browser Fingerprinting (risoluzione schermo, font installati, versione driver)", "No, senza cookie sono ciechi", "Solo se accendi la webcam"]', 1, 'Il Fingerprinting identifica il tuo dispositivo in modo univoco anche senza salvare file sul tuo PC.', NULL),
('b849959f-4871-55e5-a955-356478234001', 'Cosa succede se visiti un sito HTTP (non sicuro) e fai login?', 'multiple_choice', '["Il browser cripta la password in automatico", "La password viaggia in chiaro: chiunque sulla rete Wi-Fi può leggerla (Sniffing)", "Nulla, l''importante è che la password sia complessa", "Il sito ti blocca"]', 1, 'La complessità della password è inutile se viene urlata a tutti in chiaro.', NULL),
('b849959f-4871-55e5-a955-356478234001', 'Il sito "Meteo" ha un cookie che scade nel 2099. Se cancelli la cronologia di "oggi", quel cookie sparisce?', 'true_false', '["Vero", "Falso"]', 1, 'Spesso cancellare "l''ultima ora" non elimina i cookie persistenti vecchi. Devi selezionare "Tutto il periodo".', NULL),
('b849959f-4871-55e5-a955-356478234001', 'In ambito Biscotti Indigesti (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Notifiche Trappola - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234002', 'AN', 'Notifiche Trappola',
    'Il nemico che lavora mentre dormi.',
    E'# Service Workers\n\nQuando accetti le notifiche di un sito, il browser installa un piccolo programma ("Service Worker") che gira in background.\n\nAnche se chiudi il browser o visiti un altro sito, quel "lavoratore" è ancora lì, pronto a scaricare nuovi messaggi spam o script malevoli appena torni online.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234002', 'Hai chiuso Chrome/Edge. Puoi ancora ricevere notifiche spam da un sito malevolo?', 'multiple_choice', '["No, se il browser è chiuso è tutto spento", "Sì, i Service Workers possono girare in background o riattivarsi all''avvio del sistema", "Solo se hai un virus", "Solo su cellulare"]', 1, 'I browser moderni mantengono processi attivi per le notifiche push.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Un sito ti chiede: "Vuoi scaricare questo file?". Tu clicchi "Blocca". Il sito può chiedertelo ancora all''infinito?', 'multiple_choice', '["Sì, per sfinimento", "No, i browser moderni bloccano le richieste ripetute dopo il primo o secondo rifiuto (Quiet UI)", "Dipende dal sito", "Sì, finché non paghi"]', 1, 'I browser cercano di mitigare lo spam delle richieste, ma i truffatori usano overlay grafici falsi per ingannarti.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Se revochi il permesso di notifica a un sito, le notifiche già scaricate nel centro notifiche spariscono?', 'multiple_choice', '["Sì, magicamente", "No, quelle rimangono nella storia del sistema operativo finché non le cancelli tu", "Sì, il browser le cancella", "Diventano rosse"]', 1, 'La revoca ferma i *nuovi* arrivi, non cancella il passato.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Cliccare sulla "X" di un pop-up pubblicitario è sempre sicuro.', 'true_false', '["Vero", "Falso"]', 1, 'Spesso la "X" è finta ed è parte dell''immagine cliccabile che apre la pubblicità. Si usa ALT+F4 o Gestione Attività.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'In ambito Notifiche Trappola (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Il Plugin Traditore - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234003', 'AN', 'Il Plugin Traditore',
    'Fidarsi è bene, controllare i permessi è meglio.',
    E'# Permessi Estesi\n\nAttenzione alla differenza tra:\n*   `activeTab`: L''estensione legge solo la pagina che guardi ORA (più sicuro).\n*   `<all_urls>`: L''estensione legge TUTTO, sempre, ovunque (pericolosissimo).\n\nMolte estensioni chiedono "Tutto" per pigrizia degli sviluppatori o malizia.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234003', 'Un''estensione "Calcolatrice" chiede il permesso "Leggere e modificare i dati su tutti i siti web". È giustificato?', 'multiple_choice', '["Sì, deve calcolare i prezzi", "No, è un permesso eccessivo (Over-privileged), tipico di spyware", "Sì, le calcolatrici sono complesse", "Dipende dalla marca"]', 1, 'Una calcolatrice dovrebbe funzionare offline, non leggere la tua banca.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Hai un Password Manager installato nel browser. Un''estensione malevola può rubare le password salvate lì?', 'multiple_choice', '["No, sono programmi diversi", "Sì, se l''estensione ha il permesso di leggere il DOM (pagina web), può intercettare i tasti che digiti (Keylogging) o leggere i campi che il Manager riempie", "Solo se è lunedì", "Microsoft protegge tutto"]', 1, 'Quando il Password Manager "riempie" il campo password, quel campo diventa leggibile per le altre estensioni attive nella pagina.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'La modalità "Sviluppatore" del browser è pericolosa per un utente normale?', 'multiple_choice', '["No, serve a creare siti", "Sì, permette di installare estensioni non verificate (Unpacked) che aggirano i controlli di sicurezza dello Store", "No, è solo grafica", "Rallenta il PC"]', 1, 'Spesso i tutorial per "avere funzioni gratis" vi fanno attivare questa modalità per installare malware.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Disabilitare un''estensione è sicuro quanto disinstallarla.', 'true_false', '["Vero", "Falso"]', 0, 'Il codice rimane sul disco. Se c''è una vulnerabilità nel browser che attiva estensioni dormienti, sei a rischio. Meglio rimuovere.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Tor Browser protegge la tua identità instradando il traffico:', 'multiple_choice', '["Direttamente al server", "Attraverso tre nodi casuali (Guard, Middle, Exit) cifrati a cipolla", "In incognito", "Via satellite"]', 1, 'Peeling the onion.', NULL);


-- =================================================================================================
-- PESARO E URBINO (PU) - Mobile Security ("Il Mondo in Tasca")
-- =================================================================================================

-- Mission 1: Torcia Ficcanaso - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234004', 'PU', 'Accessibilità Abusiva',
    'Il permesso più pericoloso che nessuno conosce.',
    E'# Servizi di Accessibilità\n\nSu Android, i "Servizi di Accessibilità" servono ad aiutare i non vedenti (leggono lo schermo).\n\nI malware bancari ("Bankers") richiedono questo permesso per:\n1.  Leggere cosa c''è scritto sullo schermo (es. saldo, OTP).\n2.  Cliccare bottoni al posto tuo (es. confermare bonifici).\n\nSe un''app strana ti chiede "Accessibilità", **NEGA SUBITO**.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234004', 'Perché un malware vuole i permessi di Accessibilità?', 'multiple_choice', '["Per cambiare i colori", "Perché gli permette di leggere il contenuto di ALTRE app (es. Banca) e simulare tocchi sullo schermo", "Per sentire meglio", "Per risparmiare batteria"]', 1, 'È il modo principale con cui i trojan aggirano la Sandbox di Android.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Un''app "Pulizia Telefono" ti chiede di installare un "Profilo di Configurazione" (iOS) o "Certificato". Lo fai?', 'multiple_choice', '["Sì, pulisce meglio", "Assolutamente NO, un profilo MDM può prendere il controllo totale del dispositivo e intercettare il traffico HTTPS", "Sì, se è gratis", "Chiedo a Siri"]', 1, 'Mai installare profili o certificati root sconosciuti. È un attacco Man-in-the-Middle perfetto.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Il "Pallino Verde" in alto a destra su Android/iOS significa...', 'multiple_choice', '["Che il telefono è carico", "Che un''app sta usando la fotocamera o il microfono in questo momento", "Che sei online", "Che hai un messaggio"]', 1, 'Se si accende mentre non stai facendo nulla, qualcuno ti ascolta.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Disattivare il GPS impedisce totalmente al telefono di sapere dove sei.', 'true_false', '["Vero", "Falso"]', 1, 'Il telefono può triangolare la posizione usando le reti Wi-Fi vicine e le celle telefoniche, anche senza GPS satellitare.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'In ambito Accessibilità Abusiva (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: APK & Sideloading - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234005', 'PU', 'APK Fantasma',
    'Sembra l''app vera, ma non lo è.',
    E'# Overlay Attack\n\nHai scaricato un APK infetto.\nQuando apri la tua vera App della Banca, il malware se ne accorge e disegna **sopra** una finestra finta, identica a quella della banca.\n\nTu inserisci username e password nella finestra finta. Il malware li ruba e poi chiude la finestra finta, lasciandoti entrare in quella vera. Non ti accorgi di nulla.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234005', 'Cos''è un attacco Overlay?', 'multiple_choice', '["Un''app che cambia lo sfondo", "Una finestra fake che si sovrappone all''app legittima per rubare le credenziali (Phishing locale)", "Un errore grafico", "Una notifica"]', 1, 'Tecnica classica dei Banking Trojan moderni (es. Cerberus, Anubis).', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Se provi ad aggiornare un''app di sistema con un APK avente firma digitale diversa, cosa succede?', 'multiple_choice', '["L''aggiornamento riesce", "Android blocca l''installazione per conflitto di firme", "Il telefono esplode", "Diventa blu"]', 1, 'La firma crittografica garantisce che l''aggiornamento venga dallo stesso autore dell''originale.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Cosa si rischia abilitando "Origini Sconosciute" per sempre?', 'multiple_choice', '["Nulla", "Che un Drive-by Download installi app automaticamente senza chiederti conferma esplicita ogni volta", "Che il telefono vada più veloce", "Nessuno"]', 1, 'L''opzione va abilitata "solo per questa installazione" se proprio necessario, poi spenta.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Un APK da 2MB che promette di essere "GTA V Mobile" (4GB) è probabilmente vero.', 'true_false', '["Vero", "Falso"]', 1, 'È tecnicamente impossibile. È sicuramente un downloader di malware.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Approfondimento su: NASCOSTO. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Jailbreak & Root - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234006', 'PU', 'Root e Conseguenze',
    'Amministratore o vittima?',
    E'# Secure Enclave Compromessa\n\nI telefoni moderni hanno un chip di sicurezza separato (Secure Enclave / Titan M) per le password e i dati biometrici.\n\nIl Rooting/Jailbreak spesso compromette la "Catena di Fiducia" (Chain of Trust) tra il processore e questo chip.\nRisultato: Funzioni come Google Pay o Apple Pay smettono di funzionare per sempre su quel dispositivo, o diventano insicure.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234006', 'Fare un Factory Reset rimuove COMPLETAMENTE ogni traccia del Root?', 'multiple_choice', '["Sì, sempre", "Non necessariamente: se il malware si è installato nella partizione di Sistema (/system), sopravvive al reset", "No, devi buttare il telefono", "Dipende dalla cover"]', 1, 'Alcuni rootkit modificano l''immagine di avvio del telefono. Serve il "Reflashing" della ROM originale.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Cos''è "Magisk Hide"?', 'multiple_choice', '["Un gioco di magia", "Un tool per nascondere il Root alle app bancarie", "Un virus", "Un antivirus"]', 1, 'È una corsa continua: Magisk nasconde il root, le banche aggiornano i controlli, Magisk si aggiorna...', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Un telefono con Bootloader sbloccato è vulnerabile a un "Evil Maid Attack"?', 'multiple_choice', '["No", "Sì, un attaccante con accesso fisico può flashare un kernel malevolo in pochi minuti", "Solo se ha la password", "Cos''è una Maid?"]', 1, 'Senza il blocco del Bootloader, chiunque abbia il cavo USB può modificare il sistema operativo.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Il Jailbreak aumenta la sicurezza del dispositivo perché è open source.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Rimuove le protezioni (Sandbox, Code Signing) rendendo il dispositivo più permeabile agli attacchi.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'In ambito Root e Conseguenze (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- MACERATA (MC) - Igiene del Dispositivo ("Il Ciclo di Vita")
-- =================================================================================================

-- Mission 1: Il Cestino non basta - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234007', 'MC', 'SSD vs HDD',
    'La memoria moderna ha regole diverse.',
    E'# Il comando TRIM\n\nSugli **SSD** moderni, quando cancelli un file, il sistema operativo invia il comando **TRIM**.\nL''SSD "pulisce" davvero quelle celle poco dopo per ottimizzare le prestazioni.\n\nQuindi: Su un vecchio Hard Disk (HDD) recuperare dati cancellati è facile. Su un SSD moderno è molto più difficile (ma non impossibile per un esperto forense).',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234007', 'Perché sugli SSD il recupero dati è più difficile che sugli HDD?', 'multiple_choice', '["Sono più piccoli", "Il Garbage Collection e il comando TRIM cancellano fisicamente i dati in background", "Sono magnetici", "Non è vero"]', 1, 'È una differenza architetturale fondamentale.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'Se vendi una chiavetta USB, basta formattarla?', 'multiple_choice', '["Sì", "No, le chiavette USB spesso non supportano TRIM, quindi i dati sono recuperabili facilmente", "Sì, se è Windows 11", "Dipende dal colore"]', 1, 'Per le memorie esterne, serve sempre un software di Wiping (sovrascrittura).', NULL),
('b849959f-4871-55e5-a955-356478234007', 'La "Formattazione Basso Livello" moderna esiste?', 'multiple_choice', '["Sì, la fa Windows", "No, la vera formattazione a basso livello la fa solo la fabbrica. Oggi facciamo Zero-Fill", "Solo su Linux", "Boh"]', 1, 'Il termine è usato impropriamente oggi per indicare la sovrascrittura con zeri.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'Se cripti il disco, non serve fare il Wiping prima di venderlo.', 'true_false', '["Vero", "Falso"]', 0, 'In teoria vero (Crypto-Shredding), ma "Defense in Depth" suggerisce di fare comunque un wipe se possibile.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'In ambito SSD vs HDD (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Rifiuti Preziosi (RAEE) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234008', 'MC', 'Analisi Forense',
    'Cosa può trovare la polizia (o un ladro) nel tuo telefono rotto?',
    E'# Chip-Off Forensics\n\nSe il tuo telefono è caduto in mare o è stato investito, i dati sono persi? No.\n\nGli esperti possono dissaldare il chip di memoria (Chip-Off) e leggerlo con un lettore speciale.\nL''unica cosa che ferma questa tecnica è la **Crittografia**. Se i dati nel chip sono criptati, senza PIN sono inutili. Se non lo sono, si legge tutto.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234008', 'Un Factory Reset su un vecchio Android (es. versione 5.0) è sicuro?', 'multiple_choice', '["Sì", "No, nelle vecchie versioni la crittografia non era di default, quindi i dati cancellati sono recuperabili", "Dipende dalla batteria", "Sì, Google protegge tutto"]', 1, 'Sui vecchi dispositivi è fondamentale attivare la crittografia manualmente PRIMA di resettare.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Perché le aziende distruggono fisicamente (tritano) gli hard disk?', 'multiple_choice', '["Per divertimento", "Perché è l''unico metodo certificato per dati Top Secret che costa meno del wiping certificato", "Per riciclare l''alluminio", "Per errore"]', 1, 'Il tempo tecnico per fare wiping di 1000 dischi costa più che tritarli.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Cosa sono i metadati nelle foto recuperate?', 'multiple_choice', '["Il colore", "Informazioni nascoste (EXIF) come coordinate GPS, data e modello fotocamera", "Virus", "Pixel bruciati"]', 1, 'Recuperare una foto significa spesso recuperare anche DOVE abitava il proprietario.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Le fotocopiatrici moderne salvano copia dei documenti su disco interno.', 'true_false', '["Vero", "Falso"]', 0, 'Sì! Molti scandali aziendali nascono da fotocopiatrici dismesse vendute all''asta con l''hard disk pieno.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'In ambito Analisi Forense (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Crypto-Shredding - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234009', 'MC', 'Cold Boot Attack',
    'La RAM dimentica, ma lentamente.',
    E'# Cold Boot Attack\n\nLa crittografia protegge il disco a computer spento.\nMa quando il PC è acceso, la chiave di decifrazione è nella RAM.\n\nSe un attaccante spegne brutalmente il PC e congela i banchi di RAM (letteralmente, con spray ghiacciante), può leggerli su un altro PC prima che i dati svaniscano (remanence) e recuperare la chiave.\nSembra un film, ma è scienza.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234009', 'A cosa serve il TPM (Trusted Platform Module)?', 'multiple_choice', '["A velocizzare i giochi", "A custodire le chiavi crittografiche e verificare che il sistema non sia stato manomesso all''avvio", "A raffreddare la CPU", "A nulla"]', 1, 'BitLocker usa il TPM per non chiederti la password a ogni avvio, se il PC è integro.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'Se il tuo PC criptato va in "Sospensione" (Sleep), i dati sono al sicuro?', 'multiple_choice', '["Sì, come spento", "No, la chiave è ancora nella RAM alimentata. Meglio usare Ibernazione o Spegnimento", "Dipende dal mouse", "Sì, lo schermo è nero"]', 1, 'In Sleep Mode la RAM è attiva. Un attacco DMA (Direct Memory Access) può estrarre la chiave.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'L''ibernazione è più sicura della sospensione?', 'multiple_choice', '["Sì, perché la RAM viene svuotata su disco e il PC si spegne totalmente", "No, è uguale", "No, è peggio", "Solo in inverno"]', 0, 'Sì, richiedendo l''auth al riavvio (Pre-Boot Authentication) se configurata.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'Le password del BIOS proteggono i dati sull''hard disk.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Basta togliere l''hard disk e leggerlo su un altro PC. Solo la crittografia protegge i dati.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'In ambito Cold Boot Attack (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- FERMO (FM) - Shopping & Brand ("L'Affare")
-- =================================================================================================

-- Mission 1: L'affare impossibile - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234010', 'FM', 'I Pattern del Falso',
    'La bellezza sta nei dettagli (sbagliati).',
    E'# Cybersquatting & Typosquatting\n\n*   **Typosquatting:** `goggle.com` invece di `google.com`. Sfrutta i tuoi errori di digitazione.\n*   **Homograph Attack:** Usare caratteri cirillici che sembrano latini (es. la "a" cirillica è identica alla "a" latina, ma per il computer sono diverse). Il sito sembra `apple.com` ma è un altro.\n\nControlla sempre il certificato!',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234010', 'Un sito creato "Oggi" è affidabile?', 'multiple_choice', '["Sì, è nuovo e moderno", "Altamente sospetto. I siti di e-commerce legittimi hanno uno storico (Whois domain age)", "Sì, se ha belle foto", "No, serve un mese"]', 1, 'La "Domain Age" è un fattore chiave di trust.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Se paghi con carta su un sito truffa, qual è il rischio oltre a perdere i soldi dell''acquisto?', 'multiple_choice', '["Nessuno", "Che clonino la carta per fare abbonamenti nascosti o prelievi futuri", "Che ti arrivi merce brutta", "Che la banca rida"]', 1, 'Spesso il "prodotto non spedito" è solo l''esca per avere il numero completo della tua carta (CC Fullz).', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Cos''è il "CVV" (le 3 cifre dietro la carta)?', 'multiple_choice', '["Il PIN", "Card Verification Value: prova che hai la carta fisica in mano. Non va mai salvato dai siti", "Il numero di serie", "La data"]', 1, 'Secondo gli standard PCI-DSS, i negozi non possono salvare il CVV nei loro database.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Le carte prepagate sono inutili contro le truffe.', 'true_false', '["Vero", "Falso"]', 1, 'Limitano il danno al saldo disponibile, quindi sono utilissime.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'In ambito I Pattern del Falso (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Recensioni Fake - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234011', 'FM', 'Testa di Ponte',
    'La recensione vera di un prodotto diverso.',
    E'# Review Hijacking (Bait and Switch)\n\nUn venditore vende un prodotto ottimo ed economico (es. cavo USB) che ottiene 1000 recensioni a 5 stelle.\nPoi **modifica** la pagina del prodotto: ora vende un PC costoso e scarso.\n\nLe recensioni vecchie restano! Tu vedi "PC Gaming - 5 Stelle" ma se leggi i commenti dicono "Ottimo cavo, ricarica veloce".\nLeggi sempre il TESTO, non guardare solo le stelle.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234011', 'Perché leggi "Ottime cuffie" sotto la foto di un Tostapane?', 'multiple_choice', '["La gente è pazza", "È un caso di Review Hijacking: la pagina è stata riciclata per mantenere le stelle alte", "Errore di Amazon", "Sono cuffie calde"]', 1, 'Trucco molto diffuso sui marketplace.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'L''etichetta "Acquisto Verificato" garantisce che la recensione sia onesta?', 'multiple_choice', '["Sì, al 100%", "No, i venditori rimborsano via PayPal gli utenti dopo l''acquisto in cambio di 5 stelle (Recensioni Incentivate)", "Solo se c''è scritto in verde", "Ni"]', 1, 'Il sistema vede un acquisto reale, ma non vede il rimborso sottobanco.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Quale distribuzione di voti è più naturale?', 'multiple_choice', '["Tutte 5 stelle", "Una curva a J (molte 5, poche 4-3-2, qualche 1 per difetti reali)", "Tutte 1 stella", "Meta 5 metà 1"]', 1, 'La perfezione non esiste. Un prodotto vero ha sempre qualche recensione media o negativa.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Un concorrente può comprare recensioni negative false contro un rivale?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, "Negative SEO" o sabotaggio reputazionale.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'In ambito Testa di Ponte (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Grey Market & Dropshipping - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234012', 'FM', 'La Triangolazione',
    'Tu paghi, il truffatore paga... con la carta di un altro.',
    E'# Truffa della Triangolazione\n\n1.  Tu compri un oggetto su un sito fake a 50€.\n2.  Il truffatore usa una carta di credito rubata per comprare davvero l''oggetto su Amazon (a 100€) e spedirtelo.\n3.  Tu ricevi l''oggetto e sei felice.\n4.  La polizia bussa alla TUA porta per ricettazione, perché risulta spedito a te pagato con carta rubata.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234012', 'Nella Truffa della Triangolazione, chi ci rimette alla fine?', 'multiple_choice', '["Il truffatore", "Il titolare della carta rubata e TU (che vieni coinvolto nelle indagini)", "Amazon", "Il corriere"]', 1, 'Tu diventi il destinatario della "refurtiva", il truffatore intasca i tuoi soldi puliti e sparisce.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Come difendersi dalla triangolazione?', 'multiple_choice', '["Non comprare online", "Diffidare di prezzi troppo bassi su siti sconosciuti che non accettano PayPal", "Aprire il pacco col guanto", "Pagare in Bitcoin"]', 1, 'Se è troppo bello per essere vero, è una triangolazione.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Acquistare "Mystery Box" tech non reclamate è sicuro?', 'multiple_choice', '["Sì, si fanno affari", "No, sono quasi sempre fondi di magazzino senza valore o truffe totali", "Sì, ci sono iPhone", "Dipende"]', 1, 'È gioco d''azzardo non regolamentato, spesso truccato.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Se compri una chiave software Volume (VLK) da un sito grey market, è legale per uso domestico?', 'true_false', '["Vero", "Falso"]', 1, 'No, le licenze Volume sono contrattualmente riservate alle aziende. Microsoft può disattivarle.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'In ambito La Triangolazione (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- ASCOLI PICENO (AP) - Identità Digitale ("La Fortezza")
-- =================================================================================================

-- Mission 1: Accedi con Google? - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234013', 'AP', 'Revoca Accessi',
    'Lasciare le chiavi al vecchio inquilino.',
    E'# Revoca dei Token\n\nQuando usi "Accedi con Google" su un''app (es. Gioco), crei un **Token** di accesso.\nSe disinstalli il gioco, il Token **resta valido**. L''azienda del gioco può continuare a leggere i dati del tuo profilo per anni.\n\nDevi andare nelle impostazioni del tuo Account Google -> "App con accesso al tuo account" e REVOCARE manualmente.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234013', 'Disinstallare un''app dal telefono revoca il suo accesso OAuth (Login con Google/FB)?', 'multiple_choice', '["Sì, automatico", "No, l''accesso lato server rimane attivo finché non lo rimuovi dalle impostazioni dell''account provider", "Solo su iPhone", "Sì, se spegni il telefono"]', 1, 'Errore comune: disinstallare non scollega l''account.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Cosa succede se revochi l''accesso a un sito dove ti eri registrato solo con Google?', 'multiple_choice', '["Nulla", "Non potrai più fare login su quel sito finché non lo riautorizzi", "Il sito viene cancellato", "Google ti multa"]', 1, 'Perdi la "chiave" per entrare.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Se un sito OAuth viene hackerato, devi cambiare la tua password di Google?', 'multiple_choice', '["Sì, subito", "No, il sito aveva solo un Token, non la tua password. Basta revocare quel Token", "Sì, e anche quella della banca", "No, tanto è perso"]', 1, 'Questo è il vantaggio di OAuth: la password reale non viene mai condivisa col sito terzo.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Un''app "Torcia" può chiedere accesso al tuo Google Drive via OAuth?', 'true_false', '["Vero", "Falso"]', 0, 'Tecnicamente può chiederlo. Se tu clicchi "Consenti" senza leggere, le dai accesso ai tuoi file.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'In ambito Revoca Accessi (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Chi sei davvero? (2FA) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234014', 'AP', 'MFA Fatigue',
    'Se ti chiedono di entrare 100 volte, dirai di sì?',
    E'# MFA Fatigue (Bombing)\n\nL''hacker ha la tua password. Ti manda una notifica sul telefono: "Sei tu? Clicca Sì".\nTu non clicchi.\nLui te ne manda altre 50 di fila alle 3 di notte.\n\nPer sfinimento o per sbaglio, clicchi "Sì" per far smettere al telefono di suonare.\n**Sei stato hackerato.**',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234014', 'Qual è la difesa migliore contro l''MFA Fatigue?', 'multiple_choice', '["Cliccare Sì", "Usare la modalità Number Matching (l''app ti chiede di inserire un numero mostrato sullo schermo del PC)", "Spegnere il telefono", "Disabilitare 2FA"]', 1, 'Il Number Matching obbliga ad avere davanti lo schermo del login, bloccando gli attacchi remoti.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Cosa sono i "Codici di Backup" (Recovery Codes)?', 'multiple_choice', '["Codici sconto", "Codici statici da stampare e nascondere, vitali se perdi il telefono con l''Authenticator", "Codici per i giochi", "Password del Wi-Fi"]', 1, 'Senza quelli, se perdi il telefono, sei chiuso fuori dal tuo account per sempre.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Se un hacker clona la tua SIM (SIM Swapping), ha accesso al tuo Google Authenticator?', 'multiple_choice', '["Sì, sempre", "No, Authenticator è legato al dispositivo hardware, non al numero di telefono", "Sì, se è Android", "Dipende dall''operatore"]', 1, 'Le App TOTP (Authenticator) sono immuni al SIM Swapping. Gli SMS no.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'L''email è un buon secondo fattore di autenticazione?', 'true_false', '["Vero", "Falso"]', 1, 'No, perché se l''hacker ha la password del sito, spesso ha violato anche la tua email (password reuse). Meglio un device separato.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Approfondimento su: NOTIFICHE. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Password Manager - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234015', 'AP', 'L''Anello Debole',
    'Dove tieni la chiave della cassaforte?',
    E'# Recovery del Password Manager\n\nIl Password Manager è la tua cassaforte. Ma se dimentichi la Master Password?\n\nLa maggior parte dei servizi sicuri **NON ha il reset della password** via mail.\nSe la perdi, hai PERSO TUTTO.\n\nDevi impostare un "Contatto di Emergenza" o salvare la "Secret Part" su carta in cassaforte.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234015', 'Cosa significa che un Password Manager è "Cloud-based"?', 'multiple_choice', '["Che piove", "Che le password cifrate sono sincronizzate sui server del fornitore per averle su tutti i device", "Che sono leggere", "Che sono gratis"]', 1, 'È comodo, ma devi fidarti della crittografia del fornitore (Zero Knowledge).', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Cos''è il "Salt" (Sale) in una password hash?', 'multiple_choice', '["Un condimento", "Dati casuali aggiunti alla password prima dell''hashing per proteggere contro le Rainbow Tables", "Un errore", "La lunghezza"]', 1, 'Rende unico l''hash anche se due utenti hanno la stessa password "123456".', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Perché dovresti disattivare il "Riempimento Automatico" (Autofill) del Password Manager?', 'multiple_choice', '["Perché è lento", "Perché script invisibili in una pagina web potrebbero chiedere le credenziali e il Manager le fornirebbe senza che tu te ne accorga", "Perché consuma batteria", "Non serve"]', 1, 'Meglio il "Click-to-fill" o drag & drop per evitare furti silenziosi.', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Il Clipboard (Copia-Incolla) è sicuro per le password?', 'true_false', '["Vero", "Falso"]', 1, 'No, altre app possono leggere la clipboard. I Manager buoni la svuotano dopo 30 secondi.', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Perché gli hacker colpiscono i fornitori di un''azienda (Supply Chain Attack)?', 'multiple_choice', '["Sono più simpatici", "Spesso hanno accesso ai sistemi del cliente finale ma difese molto povere, agendo da cavallo di Troia", "Hanno uffici più belli", "Per sbaglio"]', 1, 'Si attacca l''anello debole della catena per raggiungere il bersaglio forte.', NULL);
