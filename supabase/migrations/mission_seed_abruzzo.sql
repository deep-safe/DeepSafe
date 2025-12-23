-- Mission Seed for Abruzzo (Theme: "La Rocca Digitale: Resilienza e Disaster Recovery")
-- Region: Abruzzo (HARD / TRICKY EDITION)
-- Provinces: L'Aquila (AQ), Teramo (TE), Pescara (PE), Chieti (CH)

-- =================================================================================================
-- L'AQUILA (AQ) - Disaster Recovery & Backup ("La Ricostruzione")
-- =================================================================================================

-- Mission 1: La Regola del 3-2-1 - Facile (ma Tricky)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345001', 'AQ', 'Backup o Sync?',
    'Se cancelli qui, sparisce anche lì.',
    E'# Sync vs Backup\n\nGoogle Drive, Dropbox e OneDrive sono strumenti di **Sincronizzazione**, NON di Backup.\n\nSe un ransomware cripta i file sul tuo PC, il software di sync vede i file "modificati" e sincronizza subito la versione criptata anche sul cloud, sovrascrivendo quella buona.\nIl Backup vero deve essere "Cold" (staccato) o "Immutable" (Versioning impossibile da cancellare).',
    'semplice', '5 min', 50, 'level_1', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345001', 'Usi Google Drive Desktop. Un virus cancella tutti i tuoi file locali. Cosa succede sul Cloud?', 'multiple_choice', '["I file sul Cloud sono salvi", "Il programma di Sync cancella istantaneamente anche i file sul Cloud (perché specchia le modifiche)", "Google ti chiama", "Il virus muore"]', 1, 'Sync = Specchio. Se rompi l''oggetto, rompi l''immagine. Serve il "Cestino" o "Version History" per salvarsi (se attivo).', NULL),
('c951060f-5982-66f6-b066-467589345001', 'Cosa dice la regola del Backup 3-2-1?', 'multiple_choice', '["3 Copie, 2 Supporti diversi, 1 Off-site (fuori sede)", "3 Password, 2 Account, 1 PC", "3 Minuti, 2 Secondi, 1 Click", "3 Amici, 2 Nemici, 1 Capo"]', 1, 'Avere 3 copie sullo stesso Hard Disk esterno non conta!', NULL),
('c951060f-5982-66f6-b066-467589345001', 'Un Hard Disk USB sempre collegato al PC è un backup sicuro contro Ransomware?', 'multiple_choice', '["Sì, è esterno", "No, se è montato come lettera (E:), il ransomware lo cripta insieme al disco C:", "Sì, se ha la lucina verde", "Dipende dalla marca"]', 1, 'Il backup deve essere "Air Gapped" (scollegato) o protetto da credenziali diverse.', NULL),
('c951060f-5982-66f6-b066-467589345001', 'Il RAID (es. RAID 1 Mirroring) è un Backup.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Il RAID protegge dalla rottura del DISCO, non dalla cancellazione per errore o virus. Se cancelli un file, il RAID lo cancella da entrambi i dischi istantaneamente.', NULL),
('c951060f-5982-66f6-b066-467589345001', 'La regola 3-2-1 del backup dice:', 'multiple_choice', '["3 copie, 2 supporti diversi, 1 off-site (fuori sede)", "3 dischi, 2 computer, 1 cloud", "3 tentativi, 2 errori, 1 successo", "Contare fino a 3"]', 0, 'Lo standard d''oro per non perdere i dati.', NULL);


-- Mission 2: Ransomware & Snapshot - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345002', 'AQ', 'Il Ricatto Perfetto',
    'I tuoi dati sono ostaggi. Pagare o no?',
    E'# Shadow Copies\n\nWindows crea copie automatiche dei file (Shadow Copies/Punti di Ripristino).\nSembra la salvezza contro i Ransomware.\n\n**Il trucco:** Il 99% dei Ransomware moderni, come prima cosa, esegue il comando `vssadmin delete shadows /all /quiet` per cancellare tutte le copie locali prima di criptare.\nNon contare mai sulle copie locali.',
    'medio', '10 min', 75, 'level_2', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345002', 'Perché pagare il riscatto è sconsigliato (oltre che eticamente sbagliato)?', 'multiple_choice', '["Costa troppo", "Non hai garanzia di ricevere la chiave (il 40% non la riceve) e finisci nella lista dei ''pagatori'' per futuri attacchi", "È illegale", "La polizia ti arresta"]', 1, 'Un pagatore è un cliente fidelizzato per i criminali.', NULL),
('c951060f-5982-66f6-b066-467589345002', 'Come fa un Ransomware a criptare 1 Terabyte in pochi secondi?', 'multiple_choice', '["È magia", "Non cripta tutto: usa la ''Intermittent Encryption'' (cripta solo l''inizio del file o pezzetti casuali) rendendo comunque il file illeggibile velocemente", "Usa la GPU", "Scarica RAM"]', 1, 'Corrompere il file system è molto più veloce che criptare ogni singolo bit.', NULL),
('c951060f-5982-66f6-b066-467589345002', 'Cos''è la "Double Extortion"?', 'multiple_choice', '["Pagare doppio", "Prima di criptare i dati, i criminali ne rubano una copia e minacciano di pubblicarli online se non paghi (GDPR leak)", "Due virus insieme", "Pagare in Bitcoin e Monero"]', 1, 'Anche se hai il backup e ripristini, devi pagare per evitare il data leak pubblico.', NULL),
('c951060f-5982-66f6-b066-467589345002', 'L''antivirus gratuito rileva sempre un Ransomware zero-day.', 'true_false', '["Vero", "Falso"]', 1, 'Assolutamente no. Gli Zero-Day non hanno firma. Servono sistemi comportamentali (EDR) avanzati, e spesso non bastano.', NULL),
('c951060f-5982-66f6-b066-467589345002', 'In ambito Il Ricatto Perfetto (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Il Piano B (BCPD) - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345003', 'AQ', 'Tempo vs Dati',
    'Quanto tempo puoi permetterti di stare fermo?',
    E'# RTO & RPO\n\nNel Disaster Recovery ci sono due metriche vitali:\n*   **RTO (Recovery Time Objective):** Quanto tempo serve per ripartire? (es. 4 ore).\n*   **RPO (Recovery Point Objective):** Quanti dati siamo disposti a perdere? (es. l''ultima ora).\n\nSe fai il backup su nastro una volta a settimana, il tuo RPO è **7 giorni**. Se succede qualcosa venerdì, perdi il lavoro di tutta la settimana.',
    'difficile', '15 min', 150, 'level_3', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345003', 'Se il tuo RPO è "Zero", cosa ti serve?', 'multiple_choice', '["Un backup notturno", "Replica sincrona dei dati in tempo reale su un secondo sito", "Un disco veloce", "Un quaderno"]', 1, 'RPO=0 costa carissimo, perché ogni dato scritto a Milano deve essere confermato a Roma prima di proseguire.', NULL),
('c951060f-5982-66f6-b066-467589345003', 'Hai ripristinato i server dal backup, ma i dipendenti non sanno cosa fare. Cosa mancava?', 'multiple_choice', '["Il caffè", "Il Business Continuity Plan (BCP): le procedure umane e organizzative per lavorare in emergenza", "Internet", "Le sedie"]', 1, 'La tecnologia è solo metà del ripristino. Le persone devono sapere come operare.', NULL),
('c951060f-5982-66f6-b066-467589345003', 'Testare il restore (ripristino) dei backup è opzionale.', 'true_false', '["Vero", "Falso"]', 1, 'Un backup non testato si chiama "Speranza". Spesso i backup sembrano riusciti ma i file sono corrotti.', NULL),
('c951060f-5982-66f6-b066-467589345003', 'Cos''è un "Cold Site"?', 'multiple_choice', '["Una sala server raffreddata", "Uno spazio ufficio vuoto, cablato ma senza computer, pronto per essere allestito in emergenza (più economico ma lento)", "Un sito web brutto", "Un frigorifero"]', 1, 'A differenza dell''Hot Site (già pronto con server accesi e dati specchiati).', NULL),
('c951060f-5982-66f6-b066-467589345003', 'La regola 3-2-1 del backup dice:', 'multiple_choice', '["3 copie, 2 supporti diversi, 1 off-site (fuori sede)", "3 dischi, 2 computer, 1 cloud", "3 tentativi, 2 errori, 1 successo", "Contare fino a 3"]', 0, 'Lo standard d''oro per non perdere i dati.', NULL);


-- =================================================================================================
-- TERAMO (TE) - Sicurezza Fisica ("Il Gran Sasso")
-- =================================================================================================

-- Mission 1: Shoulder Surfing - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345004', 'TE', 'Occhi Indiscreti',
    'La password più sicura del mondo cade se qualcuno ti guarda digitarla.',
    E'# Visual Hacking\n\nNon serve un software costoso per rubare una password. Basta guardare sopra la spalla (**Shoulder Surfing**).\n\nIn treno, in aereo o al bar: \n*   I "Privacy Filter" (pellicole scure) proteggono solo lateralmente.\n*   Le telecamere di sicurezza (CCTV) a soffitto spesso hanno lo zoom sufficiente per leggere cosa scrivi sullo smartphone.',
    'semplice', '5 min', 50, 'level_1', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345004', 'Dove è più rischioso inserire password sensibili?', 'multiple_choice', '["In cantina", "In luoghi affollati con telecamere o persone alle spalle (Aeroporti, Treni, Bar)", "A casa", "Nel bosco"]', 1, 'Lo Shoulder Surfing è la tecnica n.1 di Ingegneria Sociale fisica.', NULL),
('c951060f-5982-66f6-b066-467589345004', 'Il Privacy Screen protegge da chi ti sta esattamente dietro?', 'multiple_choice', '["Sì, diventa nero per tutti", "No, funziona polarizzando la luce lateralmente. Chi è in asse (dietro di te) vede tutto oscurato ma leggibile", "Sì, cripta lo schermo", "Dipende dalla marca"]', 1, 'Non protegge dallo sguardo diretto da dietro.', NULL),
('c951060f-5982-66f6-b066-467589345004', 'Digitare il PIN coprendo la mano con l''altra è paranoico?', 'multiple_choice', '["Sì, inutile", "No, è una pratica base di sicurezza fisica contro telecamere nascoste (Skimmer)", "Fa ridere", "È maleducato"]', 1, 'Dovrebbe essere un riflesso automatico.', NULL),
('c951060f-5982-66f6-b066-467589345004', 'Se lasci il PC sbloccato per andare in bagno "solo 30 secondi", cosa può succedere?', 'true_false', '["Nulla", "Installazione di keylogger hardware o software, furto sessione, o invio mail a nome tuo"]', 1, 'Windows+L (Lock) sempre, ogni volta che ti alzi.', NULL),
('c951060f-5982-66f6-b066-467589345004', 'In ambito Occhi Indiscreti (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Evil Maid & USB - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345005', 'TE', 'Il Regalo Avvelenato',
    'Hai trovato una chiavetta USB da 128GB nel parcheggio! Che fortuna... o no?',
    E'# USB Baits (Rubber Ducky)\n\nLa curiosità uccide il gatto (e la rete aziendale).\nGli hacker lasciano chiavette USB infette nei parcheggi delle aziende target.\n\nAlcune non sono memorie, ma **tastiere emulate** (HID Spoofing). Appena le inserisci, digitano comandi a velocità sovrumana per installare backdoor, prima che tu possa vedere qual è il contenuto.',
    'medio', '10 min', 75, 'level_2', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345005', 'Cos''è l''attacco "Evil Maid"?', 'multiple_choice', '["Una cameriera cattiva", "Un attacco che richiede accesso fisico al dispositivo lasciato incustodito (es. pulizie in camera d''hotel)", "Un virus che pulisce", "Un film horror"]', 1, 'In 5 minuti di accesso fisico si può compromettere quasi ogni device non cifrato.', NULL),
('c951060f-5982-66f6-b066-467589345005', 'Perché una "Rubber Ducky" USB è pericolosa anche se hai l''antivirus?', 'multiple_choice', '["Perché è di gomma", "Perché il computer la riconosce come TASTIERA (device fidato), non come memoria. L''antivirus non blocca le tastiere che scrivono", "Perché ha il Wi-Fi", "Perché è gialla"]', 1, 'La fiducia implicita nei dispositivi HID (Human Interface Device) è il problema.', NULL),
('c951060f-5982-66f6-b066-467589345005', 'Cosa fare se trovi una chiavetta USB aziendale per terra?', 'multiple_choice', '["Guardare cosa c''è dentro per trovare il proprietario", "Consegnarla immediatamente all''IT Security senza inserirla nel PC", "Formattarla e usarla", "Buttarla"]', 1, 'Non inserirla MAI. Nemmeno per curiosità.', NULL),
('c951060f-5982-66f6-b066-467589345005', 'I cavi di ricarica "trovati in giro" (cavi O.MG) possono rubare dati?', 'true_false', '["Vero", "Falso"]', 1, 'Esistono cavi Lightning/USB che contengono chip Wi-Fi e keylogger nascosti nel connettore.', NULL),
('c951060f-5982-66f6-b066-467589345005', 'Approfondimento su: CAVO. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Cold Storage - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345006', 'TE', 'Gabbie e Onde',
    'Proteggere l''hardware dalle minacce invisibili.',
    E'# Faraday & Tempest\n\n*   **Gabbia di Faraday:** Schermatura che blocca i segnali radio (RF). Utile per impedire che un telefono venga cancellato da remoto o tracciato.\n*   **Attacchi Tempest:** Leggere ciò che scrivi sullo schermo captando le impercettibili radiazioni elettromagnetiche emesse dal cavo video attraverso il muro.\n\nLa sicurezza estrema richiede la fisica.',
    'difficile', '15 min', 150, 'level_3', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345006', 'Mettere il telefono nel microonde (SPENTO) funziona come Gabbia di Faraday?', 'multiple_choice', '["Sì, ma non è perfetta (le microonde hanno frequenza diversa dal 4G/5G)", "No, è plastica", "Sì, blocca tutto al 100%", "Solo se acceso"]', 0, 'I forni sono calibrati sui 2.4GHz. Il segnale cellulare (800/900MHz) potrebbe passare. Meglio le buste apposite.', NULL),
('c951060f-5982-66f6-b066-467589345006', 'A cosa serve una "Faraday Bag" per le chiavi dell''auto?', 'multiple_choice', '["Per non graffiarle", "Per prevenire il Relay Attack (furto auto amplificando il segnale della chiave dall''interno della casa)", "Per moda", "Per non perderle"]', 1, 'I ladri amplificano il segnale della chiave sul comodino per aprire l''auto parcheggiata fuori.', NULL),
('c951060f-5982-66f6-b066-467589345006', 'Cos''è l''Air Gap?', 'multiple_choice', '["Lo spazio tra i denti", "L''isolamento fisico totale di un computer da qualsiasi rete (Internet/LAN)", "Un volo aereo", "Una marca"]', 1, 'Un computer Air-Gapped non può essere hackerato da remoto (ma da USB sì).', NULL),
('c951060f-5982-66f6-b066-467589345006', 'Avvolgere il telefono nella carta stagnola blocca il segnale.', 'true_false', '["Vero", "Falso"]', 1, 'Più strati di alluminio creano una gabbia di Faraday abbastanza efficace in emergenza.', NULL),
('c951060f-5982-66f6-b066-467589345006', 'In ambito Gabbie e Onde (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- PESCARA (PE) - Wi-Fi & Reti ("Il Ponte sul Mare")
-- =================================================================================================

-- Mission 1: L'Ananas Malvagio - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345007', 'PE', 'L''Ananas Malvagio',
    'Il tuo telefono grida i nomi dei tuoi ex (Wi-Fi).',
    E'# Probe Requests & Wi-Fi Pineapple\n\nQuando il Wi-Fi è acceso ma non collegato, il tuo telefono urla continuamente: "C''è il Wi-Fi ''Casa_Mario''? C''è ''Hotel_Roma''?".\n\nUn hacker con un dispositivo chiamato **Wi-Fi Pineapple** risponde "Sì sono io!" a TUTTE queste chiamate.\nRisultato: Ti connetti automaticamente all''hacker credendo di essere a casa.',
    'semplice', '5 min', 50, 'level_1', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345007', 'Per evitare l''attacco Karma/Pineapple, cosa devi fare?', 'multiple_choice', '["Usare una password lunga", "Spegnere il Wi-Fi quando sei fuori casa e usare comandi per ''Dimenticare'' le reti vecchie", "Comprare un iPhone", "Pregare"]', 1, 'Le reti salvate ("Auto-join") sono il vettore di attacco.', NULL),
('c951060f-5982-66f6-b066-467589345007', 'Cos''è un "Evil Twin"?', 'multiple_choice', '["Un gemello cattivo", "Un punto Wi-Fi falso con lo stesso nome (SSID) di quello legittimo (es. ''Airport_Free'')", "Un virus", "Un cavo rotto"]', 1, 'Se ci sono due reti con lo stesso nome, il tuo telefono sceglie quella col segnale più forte (spesso l''hacker vicino a te).', NULL),
('c951060f-5982-66f6-b066-467589345007', 'Cosa può vedere l''hacker se ti connetti al suo Pineapple?', 'multiple_choice', '["Solo il meteo", "Tutto il traffico non cifrato, i siti che visiti (DNS), e può tentare attacchi diretti al dispositivo", "Nulla, HTTPS protegge tutto", "Le foto in galleria"]', 1, 'È una posizione Man-in-the-Middle (MitM) privilegiata.', NULL),
('c951060f-5982-66f6-b066-467589345007', 'Nascondere l''SSID (rete nascosta) ti rende invisibile.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Per connettersi a una rete nascosta, il TUO dispositivo deve trasmettere attivamente il nome della rete per cercarla, rendendoti PIÙ tracciabile.', NULL),
('c951060f-5982-66f6-b066-467589345007', 'In ambito L''''Ananas Malvagio (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: HTTPS su Wi-Fi Pubblico - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345008', 'PE', 'HTTPS non basta',
    'Il lucchetto non ti salva dal guardone.',
    E'# Limiti di HTTPS\n\nSei in un bar collegato a un Wi-Fi pubblico malevolo.\nNavighi su `https://banca.it`.\n\n*   **Cosa NON vedono:** La tua password (grazie a HTTPS).\n*   **Cosa VEDONO:** L''indirizzo `banca.it` (DNS Leak o SNI), quanto tempo stai connesso, quanti dati scambi.\nInoltre, possono provare **SSL Stripping** per forzarti a usare HTTP.',
    'medio', '10 min', 75, 'level_2', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345008', 'Cos''è l''SSL Stripping?', 'multiple_choice', '["Uno spogliarello", "Un attacco MitM che degrada la connessione da HTTPS a HTTP trasparente all''utente", "Un errore del server", "Un cavo spellato"]', 1, 'Se non vedi il lucchetto o l''errore certificato, sei in HTTP in chiaro.', NULL),
('c951060f-5982-66f6-b066-467589345008', 'La VPN ti protegge su Wi-Fi pubblico?', 'multiple_choice', '["No, rallenta solo", "Sì, crea un tunnel cifrato che nasconde TUTTO il traffico (incluso il DNS) all''admin del Wi-Fi", "Solo se a pagamento", "Dipende dall''orario"]', 1, 'La VPN è la difesa definitiva sulle reti ostili.', NULL),
('c951060f-5982-66f6-b066-467589345008', 'Cosa sono i DNS Leaks?', 'multiple_choice', '["Perdite d''acqua", "Quando le richieste di ''nome sito'' viaggiano in chiaro fuori dal tunnel VPN", "Errori di stampa", "Virus"]', 1, 'L''ISP o l''hacker sanno QUALI siti visiti, anche se non vedono COSA fai dentro.', NULL),
('c951060f-5982-66f6-b066-467589345008', 'Usare i dati mobili (4G/5G) è più sicuro del Wi-Fi pubblico?', 'true_false', '["Vero", "Falso"]', 0, 'In generale sì. Intercettare il GSM/4G richiede attrezzature molto più costose (IMSI Catcher) rispetto a sniffare il Wi-Fi.', NULL),
('c951060f-5982-66f6-b066-467589345008', 'In ambito HTTPS non basta (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Captive Portals Fake - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345009', 'PE', 'Login Wi-Fi Falso',
    'La pagina dell''hotel sa troppe cose.',
    E'# Captive Portal Malevolo\n\nTi colleghi e appare la pagina: "Benvenuto all''Hotel Excelsior. Fai login per navigare".\nTi chiede: Email, Password, o "Accedi con Facebook".\n\n**Il trucco:** Quella non è la pagina dell''hotel. È una pagina servita dall''hacker. Se inserisci le tue vere credenziali social o email per "avere internet", gliele stai regalando.',
    'difficile', '15 min', 150, 'level_3', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345009', 'Un vero Captive Portal (es. aeroporto) ha bisogno della tua password di Facebook?', 'multiple_choice', '["Sì, per sicurezza", "No. Al massimo chiede l''OAuth (senza farti inserire la password lì) o un numero di stanza. Mai la password diretta", "Sì, per marketing", "Dipende"]', 1, 'Se vedi un campo "Password FB" direttamente nella pagina del Wi-Fi, è phishing.', NULL),
('c951060f-5982-66f6-b066-467589345009', 'Cosa fare se il Wi-Fi chiede di scaricare un "Certificato di Accesso"?', 'multiple_choice', '["Scaricarlo", "Rifiutare e disconnettersi. Serve per decifrare il tuo traffico HTTPS (Man-in-the-Middle)", "Chiedere alla reception", "Riavviare"]', 1, 'Installare una root CA di terzi compromette la sicurezza di TUTTO il dispositivo.', NULL),
('c951060f-5982-66f6-b066-467589345009', 'Usare un''email temporanea (es. 10minutemail) per i Wi-Fi pubblici è una buona idea?', 'multiple_choice', '["No, illegale", "Sì, protegge la tua casella vera dallo spam e database marketing", "No, non funziona", "Inutile"]', 1, 'Ottima pratica di igiene digitale.', NULL),
('c951060f-5982-66f6-b066-467589345009', 'I Captive Portal interrompono le VPN.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Devi prima autenticarti nel portale "in chiaro", e SOLO DOPO attivare la VPN. Questo è un momento di vulnerabilità.', NULL),
('c951060f-5982-66f6-b066-467589345009', 'In ambito Login Wi-Fi Falso (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- CHIETI (CH) - Cloud Security ("L'Industria Eterea")
-- =================================================================================================

-- Mission 1: Il Secchio Bucato - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345010', 'CH', 'Il Secchio Bucato',
    'Pubblico per errore, indicizzato per sempre.',
    E'# S3 Bucket Leaks\n\nGli spazi Cloud (es. AWS S3 Buckets) sono sicuri, MA di default spesso vengono configurati male dagli umani.\n\nBasta spuntare "Public Read Access" per errore, e tutti i documenti aziendali, backup e foto caricati lì diventano visibili a chiunque conosca l''indirizzo. Google li trova e li indicizza in poche ore.',
    'semplice', '5 min', 50, 'level_1', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345010', 'Cosa significa "Security by Obscurity" nel cloud?', 'multiple_choice', '["Usare sfondi scuri", "Sperare che nessuno trovi il link del tuo file perché ha un nome strano, senza mettere password. (Non funziona)", "Crittografia forte", "Usare la VPN"]', 1, 'Gli scanner automatici trovano TUTTO. L''oscurità non è sicurezza.', NULL),
('c951060f-5982-66f6-b066-467589345010', 'Se trovi un link Google Drive "Chiunque abbia il link può visualizzare", è sicuro metterci dati sensibili?', 'multiple_choice', '["Sì, il link è lungo", "No. Basta che una persona condivida quel link per sbaglio e i dati sono pubblici per sempre", "Dipende dal file", "Sì, Google protegge"]', 1, 'Mai usare "Anyone with the link" per dati confidenziali. Usare inviti via email specifici.', NULL),
('c951060f-5982-66f6-b066-467589345010', 'Chi è colpevole se lasci un Bucket S3 aperto: Amazon o Tu?', 'multiple_choice', '["Amazon", "Tu (Misconfiguration)", "Gli hacker", "Nessuno"]', 1, 'Data Breach per negligenza.', NULL),
('c951060f-5982-66f6-b066-467589345010', 'I motori di ricerca come Google indicizzano i PDF pubblici nel cloud.', 'true_false', '["Vero", "Falso"]', 0, 'Verissimo. Si usa il "Google Dorking" per trovarli.', NULL),
('c951060f-5982-66f6-b066-467589345010', 'Approfondimento su: CANTO. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: Shadow IT - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345011', 'CH', 'Fai da Te Pericoloso',
    'Usare strumenti comodi che l''azienda non conosce.',
    E'# Shadow IT\n\nSuccede quando i dipendenti usano software non approvati (Dropbox personale, WeTransfer, ChatGPT, WhatsApp) per scambiarsi file di lavoro "perché l''IT è lento".\n\n**Rischi:**\n1.  I dati escono dal perimetro di sicurezza.\n2.  Nessun backup aziendale.\n3.  Se il dipendente se ne va, i dati restano nel suo Dropbox personale.',
    'medio', '10 min', 75, 'level_2', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345011', 'Incollare codice proprietario o dati clienti in ChatGPT (versione free) è un problema?', 'multiple_choice', '["No, l''AI dimentica", "Sì, i dati vengono usati per il training e potrebbero essere rivelati ad altri utenti in futuro (Data Leak)", "Solo se in inglese", "No, aiuta a lavorare"]', 1, 'Samsung e altre aziende hanno subito leak proprio così.', NULL),
('c951060f-5982-66f6-b066-467589345011', 'Perché l''IT odia lo Shadow IT?', 'multiple_choice', '["Sono cattivi", "Perdita di visibilità e controllo sui dati (Data Loss Prevention impossibile)", "Vogliono vendere software", "Per noia"]', 1, 'Non puoi proteggere ciò che non sai che esiste.', NULL),
('c951060f-5982-66f6-b066-467589345011', 'Usare WhatsApp per mandare la foto della carta d''identità di un cliente è conforme GDPR?', 'multiple_choice', '["Sì, è criptato E2E", "No, stai mischiando dati personali sensibili con un account consumer non gestito dall''azienda", "Sì, se la cancelli", "Dipende dal telefono"]', 1, 'È una violazione delle policy di trattamento dati.', NULL),
('c951060f-5982-66f6-b066-467589345011', 'Se usi la tua email personale per registrarti a Canva per lavoro, a chi appartengono i progetti?', 'multiple_choice', '["All''azienda", "A te (legalmente problematico in caso di licenziamento)", "A Canva", "A nessuno"]', 1, 'L''azienda perde la proprietà intellettuale.', NULL),
('c951060f-5982-66f6-b066-467589345011', 'In ambito Fai da Te Pericoloso (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 3: Shared Responsibility - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'c951060f-5982-66f6-b066-467589345012', 'CH', 'La Nuvola non ti salva',
    'Di chi è la colpa se i dati spariscono?',
    E'# Shared Responsibility Model\n\nNel Cloud (AWS/Azure/Google), la sicurezza è condivisa:\n\n*   **Provider:** Protegge il Cloud (Hardware, Rete, Data Center).\n*   **Tu (Cliente):** Proteggi cosa c''è NEL Cloud (I tuoi Dati, le tue Password, gli Aggiornamenti del sistema operativo nelle VM).\n\nSe la tua password è "123456", Amazon non può salvarti.',
    'difficile', '15 min', 150, 'level_3', 'Abruzzo', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('c951060f-5982-66f6-b066-467589345012', 'In un modello SaaS (es. Microsoft 365), chi deve fare il backup dei dati per recupero granulare?', 'multiple_choice', '["Microsoft lo fa per te", "TU. Microsoft garantisce la disponibilità del servizio, non il ripristino di una mail cancellata da te 3 mesi fa", "Nessuno", "Il Papa"]', 1, 'Microsoft offre "Retention Policy", ma il Backup vero è a carico tuo (Terze parti).', NULL),
('c951060f-5982-66f6-b066-467589345012', 'Se crei una Virtual Machine sul cloud e non aggiorni Windows, e prendi un virus. Di chi è la colpa?', 'multiple_choice', '["Del Cloud Provider", "Tua (Patch Management è responsabilità del cliente in IaaS)", "Di Windows", "Del destino"]', 1, 'Il Cloud Provider ti affitta l''infrastruttura, la manutenzione dell''OS ospite è tua.', NULL),
('c951060f-5982-66f6-b066-467589345012', 'Crittografare i dati prima di caricarli sul Cloud (Client-side encryption) serve?', 'multiple_choice', '["No, il cloud è sicuro", "Sì, protegge i dati anche dagli amministratori del Cloud Provider o da richieste legali", "Rallenta troppo", "È vietato"]', 1, 'È la massima forma di privacy (Bring Your Own Key).', NULL),
('c951060f-5982-66f6-b066-467589345012', 'Il Cloud Provider ha accesso fisico ai tuoi dati.', 'true_false', '["Vero", "Falso"]', 0, 'Sì, i tecnici del data center hanno accesso fisico ai dischi. Le procedure e le chiavi di cifratura impediscono loro di leggere, ma la fiducia è necessaria.', NULL),
('c951060f-5982-66f6-b066-467589345012', 'Approfondimento su: CLIENT. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);
