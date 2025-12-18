-- Mission Seed for Marche (Theme: "L'Artigiano Digitale: Costruire Difese Solide")
-- Region: Marche
-- Provinces: Ancona (AN), Pesaro e Urbino (PU), Macerata (MC), Fermo (FM), Ascoli Piceno (AP)

-- =================================================================================================
-- ANCONA (AN) - Navigazione Web Consapevole ("Il Porto Digitale")
-- =================================================================================================

-- Mission 1: Biscotti Indigesti (Cookies) - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234001', 'AN', 'Biscotti Indigesti',
    'Non tutti i dolci fanno bene.',
    E'# I Cookie\n\nI cookie sono piccoli file di testo che i siti salvano nel tuo browser.\n\n*   **Cookie Tecnici:** Servono a far funzionare il sito (es. tenere gli oggetti nel carrello).\n*   **Cookie di Profilazione:** Tracciano cosa guardi per venderti pubblicità.\n*   **Session Hijacking:** Se un hacker ruba il tuo "biscotto di sessione", può entrare nel tuo account senza password. Per questo il **LOGOUT** è importante sui PC pubblici.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234001', 'A cosa servono i cookie tecnici?', 'multiple_choice', '["A spiarti", "A far funzionare correttamente il sito (es. carrello, login)", "A riempire l''hard disk", "A nulla"]', 1, 'Sono indispensabili per l''uso normale del web moderno.', NULL),
('b849959f-4871-55e5-a955-356478234001', 'Cosa succede se non fai Logout su un computer pubblico?', 'multiple_choice', '["Nulla, scade da solo subito", "Chi arriva dopo di te può usare il tuo cookie di sessione per entrare nel tuo profilo", "Il computer esplode", "Arriva la polizia"]', 1, 'Il cookie di sessione rimane valido finché non scade o viene revocato (logout).', NULL),
('b849959f-4871-55e5-a955-356478234001', 'I cookie di terze parti (Third-Party) sono creati...', 'multiple_choice', '["Dal sito che visiti", "Da domini esterni (es. inserzionisti) per tracciarti attraverso più siti web", "Dal tuo mouse", "Dal governo"]', 1, 'Per questo vengono spesso bloccati dai browser moderni per privacy.', NULL),
('b849959f-4871-55e5-a955-356478234001', 'Cancellare la cronologia cancella automaticamente anche i cookie?', 'true_false', '["Vero", "Falso"]', 1, 'Spesso sono opzioni separate nel browser ("Cancella dati di navigazione").', NULL),
('b849959f-4871-55e5-a955-356478234001', 'È sicuro accettare cookie su un sito HTTP (non sicuro)?', 'image_true_false', '["Vero", "Falso"]', 1, 'Senza HTTPS, i cookie viaggiano in chiaro e possono essere intercettati facilmente.', 'https://placehold.co/600x400?text=Cookie+on+HTTP');

-- Mission 2: Notifiche Trappola - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234002', 'AN', 'Notifiche Trappola',
    'Dì di NO al robot che vuole parlarti.',
    E'# Browser Notification Spam\n\nMolti siti malevoli usano un trucco: \n"Clicca su CONSENTI per confermare che non sei un robot".\n\nIn realtà, stai dando il permesso a inviarti notifiche desktop. Pochi minuti dopo, il tuo PC si riempie di pop-up falsi: "IL TUO PC È INFETTO! CLICCA QUI!".\nNon è un virus, è solo un permesso che hai dato per sbaglio.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234002', 'Se vedi un pop-up "Hai vinto un iPhone" sul desktop, cosa è probabile che sia?', 'multiple_choice', '["Vero", "Una notifica spam del browser autorizzata per sbaglio", "Un regalo di Apple", "Un bug di Windows"]', 1, 'Spesso provengono da siti di streaming o download illegali a cui hai dato l''ok.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Come si rimuovono queste notifiche?', 'multiple_choice', '["Formattando il  PC", "Comprando un antivirus", "Revocando i permessi di notifica nelle impostazioni del browser", "Cambiando schermo"]', 2, 'Basta togliere il sito dalla lista "Allowed" nelle impostazioni Privacy.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Perché i siti usano il trucco "Clicca Allow per vedere il video"?', 'multiple_choice', '["Per gentilezza", "È un Dark Pattern (Inganno) per ottenere il permesso di inviarti spam", "Perché il video è pesante", "Per verificare l''età"]', 1, 'Ingannano la tua abitudine ai CAPTCHA.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Queste notifiche possono scaricare virus da sole senza che tu clicchi.', 'true_false', '["Vero", "Falso"]', 1, 'No, la notifica in sé è testo. Il pericolo è se ci CLICCHI sopra e scarichi il software che propongono.', NULL),
('b849959f-4871-55e5-a955-356478234002', 'Questa finestra di richiesta permessi è legittima?', 'image_true_false', '["Vero", "Falso"]', 0, 'Spesso imitano grafiche di sistema per sembrarti messaggi di Windows/macOS.', 'https://placehold.co/600x400?text=Fake+Allow+Prompt');


-- Mission 3: Il Plugin Traditore - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234003', 'AN', 'Il Plugin Traditore',
    'Quando l''aiutante diventa la spia.',
    E'# Estensioni Malevole\n\nLe estensioni del browser (AdBlockers, Traduttori, Coupon Finders) hanno un potere enorme: possono **leggere e modificare tutti i dati sui siti che visiti**.\n\nUna estensione malevola può:\n1.  Leggere le password che digiti.\n2.  Cambiare l''indirizzo del portafoglio Crypto quando fai un copia-incolla.\n3.  Iniettare pubblicità ovunque.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234003', 'Quale permesso è più pericoloso per un''estensione?', 'multiple_choice', '["Leggere la cronologia", "Leggere e modificare tutti i dati sui siti visitati", "Gestire i download", "Cambiare il tema"]', 1, 'Equivale a dare le chiavi di casa. Possono vedere tutto ciò che vedi tu, incluse le banche.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Cosa succede se un''estensione onesta viene venduta a un''azienda cattiva?', 'multiple_choice', '["Nulla", "L''estensione si aggiorna automaticamente e può diventare malevola (Malware Injection)", "Smette di funzionare", "Ti avvisa"]', 1, 'È successo spesso: estensioni popolari diventano spyware con un aggiornamento automatico.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Come minimizzare il rischio?', 'multiple_choice', '["Installando tutto", "Installare solo estensioni strettamente necessarie, di sviluppatori fidati, e rimuoverle se non usate", "Usare due mouse", "Non usare internet"]', 1, 'Less is More. Ogni estensione è una potenziale porta d''ingresso.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Le estensioni funzionano anche in Modalità Incognito/Privata di default.', 'true_false', '["Vero", "Falso"]', 1, 'Di solito i browser le disabilitano in Incognito per sicurezza, salvo tua autorizzazione esplicita.', NULL),
('b849959f-4871-55e5-a955-356478234003', 'Un''estensione PDF Converter che chiede accesso alla tua fotocamera è sospetta?', 'image_true_false', '["Vero", "Falso"]', 0, 'Principio del minimo privilegio: perché un convertitore PDF dovrebbe vederti?', 'https://placehold.co/600x400?text=Suspicious+Permissions');


-- =================================================================================================
-- PESARO E URBINO (PU) - Mobile Security ("Il Mondo in Tasca")
-- =================================================================================================

-- Mission 1: Torcia Ficcanaso - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234004', 'PU', 'Torcia Ficcanaso',
    'Perché la calcolatrice vuole sapere dove sei?',
    E'# Permessi delle App\n\nQuando installi un''app, ti chiede dei permessi.\n\nSe un''app "Torcia" ti chiede accesso a:\n*   Posizione GPS\n*   Rubrica Contatti\n*   Microfono\n\n**C''è qualcosa che non va.** Sta raccogliendo dati per rivenderli. Usa sempre il principio del **"Least Privilege"**: dai solo i permessi indispensabili.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234004', 'Cosa significa "Least Privilege"?', 'multiple_choice', '["Il privilegio di essere ultimi", "Dare a un''app o utente solo i permessi minimi necessari per funzionare", "Essere poveri", "Non usare password"]', 1, 'Riduce la superficie di attacco se l''app viene compromessa o è malevola.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Perché un gioco gratuito potrebbe volere accesso al Microfono?', 'multiple_choice', '["Per sentirti urlare", "Per profilarti ascoltando l''ambiente (es. Tv) a fini pubblicitari", "Per migliorare la grafica", "Per sbaglio"]', 1, 'È una tecnica di profilazione avanzata (Cross-Device Tracking).', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Puoi revocare un permesso dopo averlo dato?', 'multiple_choice', '["No, è per sempre", "Sì, dalle impostazioni Privacy del telefono", "Solo formattando", "Solo pagando"]', 1, 'Controlla periodicamente i permessi delle tue app!', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Le app preinstallate sono sempre sicure.', 'true_false', '["Vero", "Falso"]', 1, 'Spesso contengono "Bloatware" che traccia gli utenti, anche se vengono dal produttore.', NULL),
('b849959f-4871-55e5-a955-356478234004', 'Questa schermata di richiesta permessi è sospetta per un''app di Sfondi?', 'image_true_false', '["Vero", "Falso"]', 0, 'Chiede contatti e chiamate: assolutamente ingiustificato per dei wallpaper.', 'https://placehold.co/600x400?text=Suspicious+App+Permissions');


-- Mission 2: APK & Sideloading - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234005', 'PU', 'APK Moddati',
    'Spotify Premium gratis? Il prezzo sei tu.',
    E'# Sideloading\n\nInstallare app fuori dagli store ufficiali (APK su Android) si chiama **Sideloading**.\n\nScaricare "WhatsApp Gold" o "Spotify Cracked" da siti sconosciuti è il modo n.1 per infettare il telefono.\nSpesso queste app contengono il servizio vero (funzionano!) ma impacchettato insieme a uno **Spyware** che legge i tuoi SMS bancari.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234005', 'Cos''è un APK?', 'multiple_choice', '["Un fucile", "Il formato dei file di installazione delle app Android", "Una marca di scarpe", "Un codice fiscale"]', 1, 'Android Package Kit.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Qual è il rischio principale delle app "Cracked" o "Mod"?', 'multiple_choice', '["Smettono di funzionare", "Possono contenere malware (Trojan) nascosto nel codice", "Consumano troppa batteria", "Sono brutte"]', 1, 'Nessuno regala nulla. Se il servizio premium è gratis, c''è un trojan.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Google Play Protect serve a...', 'multiple_choice', '["Giocare meglio", "Scansionare le app per cercare malware conosciuti", "Proteggere lo schermo", "Fare foto"]', 1, 'È l''antivirus integrato di Android, ma non è infallibile.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Su iPhone (iOS) è facile installare app da fuori store come su Android?', 'true_false', '["Vero", "Falso"]', 1, 'Apple blocca il sideloading (Walled Garden), rendendolo molto difficile per l''utente medio.', NULL),
('b849959f-4871-55e5-a955-356478234005', 'Scaricare app da questo sito è sicuro?', 'image_true_false', '["Vero", "Falso"]', 1, 'Siti pieni di pulsanti "Download" lampeggianti e pubblicità ingannevoli sono quasi sempre fonte di malware.', 'https://placehold.co/600x400?text=Shady+APK+Site');


-- Mission 3: Jailbreak & Root - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234006', 'PU', 'Rompere le Gabbie',
    'Essere amministratore del proprio telefono: libertà o rischio?',
    E'# Rooting (Android) & Jailbreak (iOS)\n\nSignifica ottenere i privilegi di "Amministratore Totale" (Root) sul dispositivo, aggirando le restrizioni del produttore.\n\n*   **Pro:** Puoi disinstallare app di sistema, personalizzare tutto.\n*   **Contro:** Rompi la "Sandbox" di sicurezza. Un''app malevola ora può leggere i dati di TUTTE le altre app (es. rubare i token della banca).\n\nPer questo le app bancarie non funzionano su telefoni rootati.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234006', 'Cosa si intende per "Sandbox" in sicurezza mobile?', 'multiple_choice', '["Giocare con la sabbia", "Isolamento: ogni app vive in una scatola chiusa e non può toccare i dati delle altre", "Un deserto", "La spiaggia"]', 1, 'Il Rooting abbatte queste pareti.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Perché le banche bloccano le loro app sui telefoni rootati?', 'multiple_choice', '["Per antipatia", "Perché non possono più garantire la sicurezza delle chiavi crittografiche salvate sul dispositivo", "Perché occupano troppa memoria", "Per errore"]', 1, 'In ambiente rootato, un malware può leggere la memoria RAM della banca.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Il rooting invalida la garanzia del produttore?', 'multiple_choice', '["Mai", "Quasi sempre", "Solo di domenica", "No"]', 1, 'In genere sì, o è molto complicato ripristinarla.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Una volta fatto il Root, gli aggiornamenti di sistema (OTA) funzionano sempre.', 'true_false', '["Vero", "Falso"]', 1, 'Spesso gli aggiornamenti ufficiali falliscono o rimuovono il root.', NULL),
('b849959f-4871-55e5-a955-356478234006', 'Un telefono in queste condizioni è più vulnerabile?', 'image_true_false', '["Vero", "Falso"]', 0, 'Le schermate di bootloader sbloccato indicano che le verifiche di integrità all''avvio sono disabilitate.', 'https://placehold.co/600x400?text=Unlocked+Bootloader+Warning');


-- =================================================================================================
-- MACERATA (MC) - Igiene del Dispositivo ("Il Ciclo di Vita")
-- =================================================================================================

-- Mission 1: Il Cestino non basta - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234007', 'MC', 'Il Cestino non basta',
    'Cancellare un file non lo elimina davvero.',
    E'# Cancellazione vs Sovrascrittura\n\nQuando svuoti il Cestino, il computer non cancella i dati (che sono "pesanti"). Si limita a segnare quello spazio come "libero". I dati sono ancora lì!\n\nChiunque con un software di recupero gratuito può rileggerli.\nPer eliminare davvero, serve il **Wiping** (o Secure Delete), che sovrascrive i dati con zeri e uni casuali più volte.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234007', 'Cosa fa realmente il comando "Svuota Cestino"?', 'multiple_choice', '["Brucia i file", "Rimuove solo l''indice del file, lasciando il contenuto sul disco finché non viene sovrascritto", "Formatta il PC", "Chiama la polizia"]', 1, 'Rende lo spazio disponibile, ma non pulito.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'Come posso recuperare un file cancellato per sbaglio?', 'multiple_choice', '["Non si può", "Usando software di Data Recovery (se non è stato sovrascritto)", "Pregando", "Scuotendo il PC"]', 1, 'Finché lo spazio non viene riutilizzato, il file è recuperabile.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'Cos''è il "Secure Wipe"?', 'multiple_choice', '["Una salvietta", "La sovrascrittura ripetuta dei dati per renderli irrecuperabili", "Un antivirus", "Un backup"]', 1, 'È l''unico modo software per essere sicuri.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'Formattare "velocemente" un disco cancella i dati definitivamente.', 'true_false', '["Vero", "Falso"]', 1, 'La formattazione veloce ricrea solo il file system, i dati restano sotto.', NULL),
('b849959f-4871-55e5-a955-356478234007', 'In questa immagine, i dati cancellati sono ancora visibili?', 'image_true_false', '["Vero", "Falso"]', 0, 'Il software mostra chiaramente i file "eliminati" pronti al recupero.', 'https://placehold.co/600x400?text=Data+Recovery+Software');


-- Mission 2: Rifiuti Preziosi (RAEE) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234008', 'MC', 'Rifiuti Preziosi',
    'Cosa succede al tuo vecchio telefono?',
    E'# Data Remanence nei RAEE\n\nI Rifiuti Elettronici (RAEE) sono miniere d''oro per i criminali. Comprano vecchi PC o telefoni usati per recuperare: \n*   Password salvate.\n*   Foto private.\n*   Documenti d''identità.\n\nPrima di vendere o buttare un dispositivo, devi assicurarti che sia vergine (**Factory Reset** + Wiping).',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234008', 'Cosa fare PRIMA di vendere il tuo vecchio smartphone?', 'multiple_choice', '["Pulirlo con un panno", "Fare il logout dagli account, cifrare e poi fare un Factory Reset completo", "Togliere la cover", "Niente"]', 1, 'Solo il reset di fabbrica su memoria cifrata garantisce sicurezza.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Rompere l''hard disk col martello è un metodo sicuro?', 'multiple_choice', '["No", "Sì, la distruzione fisica (Shredding) è il metodo più sicuro in assoluto", "Forse", "Solo se è lunedì"]', 1, 'Se il disco è polverizzato, i dati non si leggono. Metodo preferito dai militari.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Le stampanti aziendali hanno un hard disk?', 'multiple_choice', '["No", "Sì, e spesso conserva copie di tutti i documenti stampati/scansionati", "Solo quelle laser", "Mai"]', 1, 'Le stampanti usate sono una fonte enorme di dati aziendali persi.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'La scheda SD va tolta prima di buttare il telefono.', 'true_false', '["Vero", "Falso"]', 0, 'Assolutamente. Il reset del telefono spesso NON cancella la SD esterna.', NULL),
('b849959f-4871-55e5-a955-356478234008', 'Questo Hard Disk è sicuro da buttare?', 'image_true_false', '["Vero", "Falso"]', 1, 'Se è solo bucato col trapano in un punto, i piatti magnetici intatti contengono ancora gigabyte di dati leggibili con microscopi.', 'https://placehold.co/600x400?text=Drilled+HDD');


-- Mission 3: Crypto-Shredding - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234009', 'MC', 'Crypto-Shredding',
    'Perdesti la chiave, perdesti tutto (per fortuna).',
    E'# Cifratura del Disco (Full Disk Encryption)\n\nSe usi BitLocker (Windows) o FileVault (Mac), tutti i dati sul disco sono cifrati.\n\nPer cancellare istantaneamente e sicuramente un disco da 10 TB, non serve sovrascriverlo tutto (ci vorrebbero ore). Basta **cancellare la chiave di decifrazione**.\nSenza chiave, i dati sono solo "rumore bianco" irrecuperabile. Si chiama **Crypto-Shredding**.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234009', 'Qual è il vantaggio del Crypto-Shredding?', 'multiple_choice', '["È istantaneo e sicuro", "È divertente", "Costa meno", "Non serve computer"]', 0, 'Cancelli 32 byte (la chiave) e rendi illeggibili Terabyte di dati.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'Su iPhone/Android moderni, i dati sono cifrati di default?', 'multiple_choice', '["No", "Sì, la cifratura è hardware-based", "Solo se paghi", "Solo le foto"]', 1, 'Per questo il Factory Reset su mobile è così veloce: butta via la chiave.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'Se dimentichi la password di BitLocker e perdi la Recovery Key...', 'multiple_choice', '["Chiami Microsoft", "Puoi dire addio ai tuoi dati per sempre", "Usi un magnete", "Riavvii"]', 1, 'Non c''è backdoor. Senza chiave, non entri.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'La cifratura rallenta notevolmente i computer moderni.', 'true_false', '["Vero", "Falso"]', 1, 'I processori moderni (AES-NI) gestiscono la cifratura a velocità native senza rallentamenti percettibili.', NULL),
('b849959f-4871-55e5-a955-356478234009', 'L''icona del lucchetto sul disco C: indica che BitLocker è attivo?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, indica che il volume è protetto da cifratura.', 'https://placehold.co/600x400?text=BitLocker+Icon');


-- =================================================================================================
-- FERMO (FM) - Shopping & Brand ("L'Affare")
-- =================================================================================================

-- Mission 1: L'affare impossibile - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234010', 'FM', 'L''affare impossibile',
    'Scarpe firmate a 10 euro? Certo...',
    E'# Scam E-commerce\n\nSe un prodotto costa l''80% in meno del prezzo di mercato, è una truffa.\nSegnali di pericolo:\n*   Timer ansiogeni ("L''offerta scade tra 2 minuti!").\n*   URL strano (es. `nike-scarpe-outlet-scontate.xyz`).\n*   Pagamento solo con Carta o Bonifico (niente PayPal).',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234010', 'Quale metodo di pagamento è più sicuro online?', 'multiple_choice', '["Bonifico Bancario", "Ricarica Postepay", "PayPal o Carte Virtuali", "Contanti spediti per posta"]', 2, 'Offrono la protezione acquisti e non espongono il conto principale.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'A cosa servono i "Countdown" finti sui siti truffa?', 'multiple_choice', '["A dirti l''ora", "A creare urgenza (FOMO) per farti comprare senza ragionare", "A scadenzare il latte", "Sono veri"]', 1, 'Fear Of Missing Out. Se hai fretta, non controlli.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Se compri merce contraffatta, rischi sanzioni?', 'multiple_choice', '["No, mai", "Sì, l''incauto acquisto o ricettazione possono essere reati", "Solo se sono rosse", "Dipende dalla marca"]', 1, 'Oltre a finanziare la criminalità, rischi multe alla dogana.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Il lucchetto HTTPS garantisce che il sito non sia una truffa.', 'true_false', '["Vero", "Falso"]', 1, 'Falso! Anche i siti truffa usano HTTPS. Garantisce la cifratura, non l''onestà del venditore.', NULL),
('b849959f-4871-55e5-a955-356478234010', 'Un sito con questo indirizzo è affidabile: "apple-iphone-discount-store.net"?', 'image_true_false', '["Vero", "Falso"]', 1, 'È un chiaro esempio di Cybersquatting/Typosquatting.', 'https://placehold.co/600x400?text=Fake+URL');


-- Mission 2: Recensioni Fake - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234011', 'FM', 'Recensioni Fake',
    '5 stelle! Ottimo prodotto! (Scritto da un bot)',
    E'# Astroturfing\n\nMolte recensioni su Amazon o TripAdvisor sono false, comprate dai venditori.\n\nCome riconoscerle:\n*   Tante recensioni a 5 stelle tutte nello stesso giorno.\n*   Linguaggio generico ("Bello", "Prodotto top").\n*   Foto che sembrano da catalogo.\nUsa strumenti come **Fakespot** per analizzarle.',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234011', 'Cos''è l''Astroturfing?', 'multiple_choice', '["Giardinaggio", "Creare una falsa impressione di supporto popolare o soddisfazione clienti (recensioni fake)", "Vendere scarpe", "Andare nello spazio"]', 1, 'Simula un movimento "dal basso" (grassroots) che in realtà è artificiale (astro-turf).', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Quale pattern di recensioni è sospetto?', 'multiple_choice', '["Recensioni miste nel tempo", "100 recensioni a 5 stelle tutte il 14 Agosto", "Recensioni lunghe e dettagliate", "Nessuna recensione"]', 1, 'I picchi improvvisi indicano spesso una campagna acquistata.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Le aziende oneste comprano recensioni?', 'multiple_choice', '["Sì, tutti lo fanno", "No, è contro i termini di servizio e l''etica", "Solo a Natale", "Dipende"]', 1, 'È una pratica vietata e punita dalle piattaforme.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Se un prodotto ha solo 5 stelle e nessuna critica, è perfetto.', 'true_false', '["Vero", "Falso"]', 1, 'Probabilmente le recensioni negative vengono cancellate o quelle positive sono false. Nulla è perfetto.', NULL),
('b849959f-4871-55e5-a955-356478234011', 'Un profilo utente che recensisce 50 prodotti al giorno è reale?', 'image_true_false', '["Vero", "Falso"]', 1, 'È un comportamento tipico di un bot o di un lavoratore di click-farm.', 'https://placehold.co/600x400?text=Bot+Reviewer+Profile');


-- Mission 3: Grey Market & Dropshipping - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234012', 'FM', 'I Mercanti Grigi',
    'Compri qui, arriva dalla Cina (forse).',
    E'# Dropshipping & Grey Market\n\n*   **Dropshipping:** Il sito non ha la merce. Prende i tuoi soldi, ordina su AliExpress a metà prezzo e lo fa spedire a te. Rischi: tempi biblici, nessuna garanzia, i tuoi dati (indirizzo, telefono) finiscono a fornitori sconosciuti.\n*   **Grey Market:** Vendita di codici software (es. chiavi Windows a 2€) destinati ad altri mercati. Spesso vengono disattivate dopo mesi.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234012', 'Qual è il rischio privacy del Dropshipping?', 'multiple_choice', '["Il pacco arriva rotto", "I tuoi dati personali vengono girati a terze parti (fornitori esteri) senza il tuo controllo", "Costa troppo", "Nessuno"]', 1, 'Perdi il controllo su chi possiede il tuo indirizzo di casa.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Perché una licenza Windows costa 2 euro sul Grey Market?', 'multiple_choice', '["Microsoft è generosa", "Spesso sono licenze rubate, o Volume License vendute illegalmente al dettaglio", "Sono usate", "Sono in bianco e nero"]', 1, 'Funzionano inizialmente, ma violano la licenza e possono essere revocate.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Come riconosci un sito di Dropshipping?', 'multiple_choice', '["Tempi di spedizione molto lunghi (20-30 giorni) e immagini stock generiche", "Vende solo acqua", "È velocissimo", "Ha sede in Italia"]', 0, 'L''assenza di magazzino fisico è la chiave.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Il Grey Market è illegale?', 'true_false', '["Vero", "Falso"]', 1, 'È una zona grigia (da cui il nome). Spesso legale l''acquisto, ma viola i contratti di distribuzione.', NULL),
('b849959f-4871-55e5-a955-356478234012', 'Se la foto del prodotto è identica a quella su AliExpress, è Dropshipping?', 'image_true_false', '["Vero", "Falso"]', 0, 'Puoi verificarlo con "Cerca per immagine" su Google.', 'https://placehold.co/600x400?text=Reverse+Image+Search');


-- =================================================================================================
-- ASCOLI PICENO (AP) - Identità Digitale ("La Fortezza")
-- =================================================================================================

-- Mission 1: Accedi con Google? - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234013', 'AP', 'Accedi con Google?',
    'Comodo, veloce, rischioso.',
    E'# Social Login (OAuth)\n\n"Entra con Facebook" o "Entra con Google" è comodo: una password in meno da ricordare.\n\n**Ma il rischio è centralizzato:** Se un hacker viola il tuo account Google, entra automaticamente in TUTTI i siti dove hai usato Google per accedere (Spotify, Airbnb, Giornali, ecc.).\nÈ come avere una chiave che apre tutte le porte.',
    'semplice', '5 min', 50, 'level_1', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234013', 'Cos''è OAuth?', 'multiple_choice', '["Un''auto", "Un protocollo che permette di accedere a un servizio usando le credenziali di un altro (es. Google) senza dargli la password", "Un giuramento", "Un virus"]', 1, 'È la tecnologia dietro ai pulsanti "Log in with...".', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Qual è il pericolo del Social Login?', 'multiple_choice', '["È lento", "Single Point of Failure: se perdi l''account principale, perdi l''accesso a tutto", "Costa denaro", "Nessuno"]', 1, 'Stai mettendo tutte le uova nello stesso paniere.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Usando "Accedi con Facebook", condividi i tuoi dati?', 'multiple_choice', '["No", "Sì, l''app riceve i dati del tuo profilo pubblico e spesso email/amici", "Solo il nome", "Mai"]', 1, 'Leggi sempre quali dati stai autorizzando a condividere.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Devi avere una password diversa per ogni sito.', 'true_false', '["Vero", "Falso"]', 0, 'Assolutamente sì, per evitare il Credential Stuffing.', NULL),
('b849959f-4871-55e5-a955-356478234013', 'Questa schermata ti dice cosa stai condividendo?', 'image_true_false', '["Vero", "Falso"]', 0, 'Le schermate di consenso OAuth mostrano sempre l''elenco dei permessi richiesti.', 'https://placehold.co/600x400?text=OAuth+Consent+Screen');


-- Mission 2: Chi sei davvero? (2FA) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234014', 'AP', 'La Seconda Chiave',
    'La password non basta più.',
    E'# Multi-Factor Authentication (MFA)\n\nPer entrare serve:\n1.  **Qualcosa che sai:** Password.\n2.  **Qualcosa che hai:** Telefono (Codice SMS, App Authenticator) o Chiavetta Hardware.\n\n**Attenzione:** Gli SMS non sono sicuri (SIM Swapping). Meglio usare App come Google Authenticator o chiavi fisiche (YubiKey).',
    'medio', '10 min', 75, 'level_2', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234014', 'Perché l''SMS è il metodo 2FA meno sicuro?', 'multiple_choice', '["Costa troppo", "È vulnerabile al SIM Swapping (clonazione della SIM) e intercettazione SS7", "È lento", "Non funziona all''estero"]', 1, 'Un hacker può "rubare" il tuo numero di telefono e ricevere i codici.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Cos''è una OTP?', 'multiple_choice', '["One Time Password (Password usa e getta)", "Old Time Pizza", "On The Phone", "Un protocollo"]', 0, 'È il codice a 6 cifre che cambia ogni 30 secondi.', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Cos''è una YubiKey?', 'multiple_choice', '["Un giocattolo", "Una chiave di sicurezza hardware fisica per la 2FA", "Una chiavetta USB di memoria", "Un apribottiglie"]', 1, 'È il metodo più sicuro in assoluto (phishing-resistant).', NULL),
('b849959f-4871-55e5-a955-356478234014', 'La biometria (FaceID) è un fattore "Che hai".', 'true_false', '["Vero", "Falso"]', 1, 'No, è un fattore "Che SEI" (Inerenza).', NULL),
('b849959f-4871-55e5-a955-356478234014', 'Un codice Authenticator funziona anche senza internet?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, è generato maticamente in base all''ora locale del dispositivo.', 'https://placehold.co/600x400?text=Authenticator+App');


-- Mission 3: Password Manager - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'b849959f-4871-55e5-a955-356478234015', 'AP', 'Il Custode delle Chiavi',
    'Ricordarne una per domarle tutte.',
    E'# Password Manager\n\nNon puoi ricordare 100 password diverse e complesse (`Xy7#b9!m...`).\n\nUsa un **Password Manager** (Bitwarden, 1Password, Keepass).\nDevi ricordare solo UNA **Master Password** (che deve essere lunghissima e impossibile da indovinare). Il manager ricorda e compila le altre per te.',
    'difficile', '15 min', 150, 'level_3', 'Marche', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('b849959f-4871-55e5-a955-356478234015', 'Se perdi la Master Password del tuo Password Manager...', 'multiple_choice', '["Ti mandano una mail", "Perdi accesso a tutte le tue password per sempre (se è Zero Knowledge)", "Chiami Bill Gates", "Ne crei una nuova"]', 1, 'La sicurezza Zero Knowledge significa che nemmeno l''azienda può recuperare i tuoi dati.', NULL),
('b849959f-4871-55e5-a955-356478234015', 'È meglio salvare le password nel browser o in un Manager dedicato?', 'multiple_choice', '["Nel browser è più comodo", "Manager dedicato: è più sicuro, portabile su più device e ha funzioni avanzate", "Scriverle su un post-it", "Nessuna delle due"]', 1, 'I browser sono target primari dei malware ("Stealers").', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Cos''è una Passphrase?', 'multiple_choice', '["Una frase magica", "Una password composta da più parole casuali (es. Cavallo-Batteria-Spilla-Corretto)", "Una password corta", "Un codice fiscale"]', 1, 'È più facile da ricordare per gli umani ma difficile per i computer (alta entropia).', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Il Password Manager può generare password sicure per te.', 'true_false', '["Vero", "Falso"]', 0, 'È una delle funzioni principali.', NULL),
('b849959f-4871-55e5-a955-356478234015', 'Salvare le password in un file Excel "password.xlsx" è sicuro?', 'image_true_false', '["Vero", "Falso"]', 1, 'È la prima cosa che un hacker cerca nel tuo PC.', 'https://placehold.co/600x400?text=Passwords+Excel+File');
