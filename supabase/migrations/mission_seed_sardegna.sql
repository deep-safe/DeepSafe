-- Mission Seed for Sardegna (Theme: "L'Isola Isolata: Hardware Hacking & Air Gap")
-- Region: Sardegna (HARD / TRICKY EDITION)
-- Provinces: Cagliari (CA), Sassari (SS), Nuoro (NU), Oristano (OR), Sud Sardegna (SU)

-- =================================================================================================
-- CAGLIARI (CA) - HID Attacks & BadUSB ("Il Cavallo di Troia USB")
-- =================================================================================================

-- Mission 1: Rubber Ducky - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000001', 'CA', 'La Papera di Gomma',
    'Sembra una chiavetta, morde come una tastiera.',
    E'# USB Rubber Ducky\n\nInserisci una chiavetta USB nel PC.\nIl PC dice: "Ah, è una TASTIERA! Mi fido delle tastiere".\n\nIn un millisecondo, la chiavetta (che ha un chip malvagio) inizia a digitare comandi alla velocità della luce:\n`Win+R` -> `cmd` -> `Scarica Virus` -> `Esegui`.\nL''antivirus non la ferma perché pensa sia TU che digiti.',
    'semplice', '5 min', 50, 'level_1', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000001', 'Come ci si difende da un attacco HID (Human Interface Device)?', 'multiple_choice', '["Non è facile. Bloccare le porte USB fisicamente (colla) o usare software ''USB Guard'' che blocca nuove tastiere se il PC è bloccato", "Installando un antivirus migliore", "Usando solo mouse Bluetooth", "Mettendo la password al BIOS"]', 0, 'Il protocollo USB è insicuro by design ("Trust").', NULL),
('da100000-0000-0000-0000-000000000001', 'Un Rubber Ducky può hackerare un PC bloccato (Lock Screen)?', 'multiple_choice', '["Di solito no, a meno che non conosca la password o sfrutti una falla specifica del Lock Screen. L''attacco simula un utente loggato", "Sì, può digitare la password corretta da solo", "Sì, bypassa il login elettricamente", "Dipende dalla marca della chiavetta"]', 0, 'Se il PC è bloccato, la tastiera finta digita nel vuoto (o nel campo password).', NULL),
('da100000-0000-0000-0000-000000000001', 'Bash Bunny è più potente di Rubber Ducky?', 'multiple_choice', '["Sì, è un computer Linux intero su USB. Può emulare tastiera, scheda di rete e storage contemporaneamente per attacchi complessi", "No, sono la stessa cosa ma di marca diversa", "No, è solo più carino", "Sì, ma funziona solo su Mac"]', 0, 'Bash Bunny è l''evoluzione multi-vector.', NULL),
('da100000-0000-0000-0000-000000000001', 'Disabilitare l''AutoRun protegge da Rubber Ducky?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. AutoRun bloccava i virus su chiavette STORAGE. Qui è una TASTIERA che digita fisicamente.', NULL),
('da100000-0000-0000-0000-000000000001', 'Questo script Ducky Script aprirà il terminale?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì: `GUI r` (Win+R) seguito da `STRING cmd` è la sequenza standard.', 'https://placehold.co/600x400?text=GUI+r+STRING+cmd');


-- Mission 2: Jucie Jacking - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000002', 'CA', 'Succo Mortale',
    'Caricare il telefono può costare caro.',
    E'# Juice Jacking\n\nSei in aeroporto. Batteria al 2%.\nColleghi il cavo alla colonnina USB pubblica.\n\n**Il trucco:** Il cavo USB ha 4 fili. 2 per corrente, 2 per DATI.\nLa colonnina (infetta) ti dà corrente, ma intanto usa i fili dati per copiare le tue foto o installare un malware.\nSoluzione: "USB Condom" (adattatore che taglia i pin dei dati).',
    'medio', '10 min', 75, 'level_2', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000002', 'Se il telefono chiede "Vuoi fidarti di questo computer?" mentre carichi, cosa significa?', 'multiple_choice', '["Che la colonnina sta provando ad accedere ai dati. Rifiuta immediatamente e stacca il cavo", "Che la ricarica rapida è attiva", "Che il cavo è originale Apple/Samsung", "Che la batteria è troppo calda"]', 0, 'È l''allarme rosso del sistema operativo.', NULL),
('da100000-0000-0000-0000-000000000002', 'Un cavo "Power Only" protegge dal Juice Jacking?', 'multiple_choice', '["Sì, perché mancano fisicamente i fili di connessione dati. Nessun bit può passare", "No, i virus moderni viaggiano sulla corrente", "Sì, ma ricarica molto lentamente", "No, serve un antivirus sul telefono"]', 0, 'La fisica (mancanza di rame) è la miglior difesa.', NULL),
('da100000-0000-0000-0000-000000000002', 'Le powerbank portatili possono essere infette?', 'multiple_choice', '["Sì, se te ne prestano una sconosciuta potrebbe contenere un chip BadUSB nascosto", "No, le powerbank hanno solo batterie al litio dentro", "Solo quelle con ricarica wireless", "No mai"]', 0, 'Mai fidarsi di hardware sconosciuto.', NULL),
('da100000-0000-0000-0000-000000000002', 'ADB (Android Debug Bridge) attivo aumenta il rischio?', 'true_false', '["Vero", "Falso"]', 0, 'Vero. Se il debug USB è attivo, l''attacco può installare app ed esfiltrare tutto senza conferme.', NULL),
('da100000-0000-0000-0000-000000000002', 'Questo piccolo adattatore è un "USB Condom"?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, si vede che mancano i pin centrali (D+ e D-), lasciando solo VCC e GND esterni.', 'https://placehold.co/600x400?text=USB+Condom+Pins');


-- Mission 3: O.MG Cable - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000003', 'CA', 'Il Cavo Traditore',
    'Sembra originale. Agisce come un hacker.',
    E'# O.MG Cable\n\nUn cavo Lightning o USB-C che sembra PERFETTAMENTE originale Apple/Samsung.\nMa dentro il connettore minuscolo c''è un chip Wi-Fi e un Web Server.\n\nL''hacker (a 100 metri di distanza) si collega al cavo via Wi-Fi e può lanciare comandi sul telefono o sul PC a cui è collegato, o registrare i tasti premuti (Keylogger).',
    'difficile', '15 min', 150, 'level_3', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000003', 'Come distingui visivamente un O.MG Cable da uno vero?', 'multiple_choice', '["Praticamente impossibile a occhio nudo. La miniaturizzazione è perfetta", "Il cavo finto è più spesso e rigido", "Il connettore ha un colore diverso", "C''è scritto OMG sopra"]', 0, 'È questo che lo rende terrificante per la supply chain attack.', NULL),
('da100000-0000-0000-0000-000000000003', 'Il cavo O.MG ha bisogno di driver?', 'multiple_choice', '["No, si presenta come tastiera/mouse HID standard, funzionante su Windows, Mac, Linux, Android, iOS", "Sì, devi installare i driver Hacker sul PC vittima", "Solo su Windows", "Funziona solo se il PC è sbloccato"]', 0, 'Plug & Pwn.', NULL),
('da100000-0000-0000-0000-000000000003', 'Può autodistruggersi?', 'multiple_choice', '["Sì, ha una funzione ''Kill'' che brucia il chip firmware rendendolo un cavo stupido normale per cancellare le prove", "No, l''hardware resta sempre rilevabile", "Sì, esplode fisicamente", "No"]', 0, 'Funzionalità anti-forensics avanzata.', NULL),
('da100000-0000-0000-0000-000000000003', 'L''attacco funziona anche se il cavo è collegato solo all''alimentatore a muro?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Deve essere collegato a una *Data Line* (PC/Telefono) per inviare comandi. Se è nel muro, ha corrente ma non può digitare nulla (a meno che non sia un keylogger passivo).', NULL),
('da100000-0000-0000-0000-000000000003', 'Questa radiografia mostra il chip nascosto nel connettore?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì. Si vede chiaramente l''elettronica aggiuntiva (SoC wireless) rispetto a un cavo standard.', 'https://placehold.co/600x400?text=X-Ray+Cable+Implant');


-- =================================================================================================
-- SASSARI (SS) - Side-Channel Attacks ("Ascoltare i Muri")
-- =================================================================================================

-- Mission 1: Power Analysis - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000004', 'SS', 'Battito Cardiaco',
    'La CPU consuma diversa energia se pensa 1 o se pensa 0.',
    E'# Power Analysis (SPA/DPA)\n\nLa crittografia è matematica sicura.\nMa l''hardware che la esegue è fisico.\n\nSe misuri con un oscilloscopio il consumo di corrente di una Smart Card mentre decifra:\n*   Processare un BIT 0 consuma X.\n*   Processare un BIT 1 consuma Y.\n\nGuardando il grafico dell''energia, leggi la chiave segreta (AES/RSA) senza rompere la matematica.',
    'semplice', '5 min', 50, 'level_1', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000004', 'Come si difende un chip dalla Power Analysis?', 'multiple_choice', '["Inserendo istruzioni ''dummy'' (inutili) casuali e rumore nel consumo per mascherare il pattern reale (Constant Time Execution)", "Usando batterie più grandi", "Raffreddando il chip con azoto", "Usando chiavi più corte"]', 0, 'Se il tempo/energia è costante indipendentemente dai dati, l''attacco fallisce.', NULL),
('da100000-0000-0000-0000-000000000004', 'L''attacco richiede accesso fisico al dispositivo?', 'multiple_choice', '["Sì, devi collegare sonde al chip. È difficile farlo da remoto (anche se esistono varianti software)", "No, si può fare via WiFi da chilometri", "Basta una foto del chip", "Sì, devi rompere il chip col martello"]', 0, 'È un attacco tipico contro Smart Card, SIM e Hardware Wallet rubati.', NULL),
('da100000-0000-0000-0000-000000000004', 'DPA (Differential Power Analysis) è più potente di SPA (Simple)?', 'multiple_choice', '["Sì, usa la statistica su migliaia di tracce per estrarre segnali debolissimi dal rumore di fondo", "No, SPA è migliore perché più veloce", "Sono uguali", "DPA funziona solo su Linux"]', 0, 'Con la DPA puoi rompere chip con molte contromisure.', NULL),
('da100000-0000-0000-0000-000000000004', 'RSA usa la "Modular Exponentiation". È vulnerabile?', 'true_false', '["Vero", "Falso"]', 0, 'Sì. L''algoritmo "Square and Multiply" classico ha un consumo molto diverso per le due operazioni.', NULL),
('da100000-0000-0000-0000-000000000004', 'Questo grafico mostra picchi di consumo correlati alla chiave?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, i picchi regolari (clock) interrotti da picchi diversi rivelano le operazioni interne.', 'https://placehold.co/600x400?text=Power+Trace+Graph');


-- Mission 2: Acoustic Cryptanalysis - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000005', 'SS', 'Il Canto del PC',
    'I condensatori fischiano la tua password.',
    E'# Acoustic Side-Channel\n\nQuando la CPU è sotto sforzo (es. decifrando GPG), i componenti elettronici vibrano (Coil Whine).\nQueste vibrazioni ultrasoniche cambiano frequenza in base ai calcoli.\n\nUn microfono o un telefono appoggiato sulla scrivania vicino al PC può registrare il "suono" della chiave RSA a 4096 bit e ricostruirla in un''ora.',
    'medio', '10 min', 75, 'level_2', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000005', 'Qual è una contromisura fisica contro l''attacco acustico?', 'multiple_choice', '["Isolamento acustico, resina epossidica sui componenti (potting) o rumore bianco generato dalle ventole", "Usare cuffie per coprire il suono", "Spegnere lo schermo", "Mettere il PC in frigo"]', 0, 'Smorzare le vibrazioni fisiche dei condensatori.', NULL),
('da100000-0000-0000-0000-000000000005', 'GenKey (l''attacco di Shamir) funziona con il microfono dello smartphone?', 'multiple_choice', '["Sì, se il telefono è a pochi cm dal processore/griglia di ventilazione", "No, serve un microfono da studio da 1000 euro", "Sì, ma solo se il PC ha le casse accese", "No, gli smartphone filtrano gli ultrasuoni"]', 0, 'Dimostrato nel 2013 dai ricercatori israeliani.', NULL),
('da100000-0000-0000-0000-000000000005', 'L''attacco funziona sui dischi SSD?', 'multiple_choice', '["No, riguarda la CPU per i calcoli crittografici. Gli SSD non fanno calcoli RSA intensivi", "Sì, i chip flash cantano", "Solo quelli NVMe", "Forse"]', 0, 'Il target è il processore centrale (CPU) durante la decifratura.', NULL),
('da100000-0000-0000-0000-000000000005', 'Il Coil Whine udibile è l''unico segnale?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Spesso i segnali utili sono negli ultrasuoni, inudibili all''orecchio umano ma non al microfono.', NULL),
('da100000-0000-0000-0000-000000000005', 'Questo spettrogramma mostra le frequenze della chiave RSA?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, le bande orizzontali corrispondono al loop di decifratura.', 'https://placehold.co/600x400?text=Acoustic+Spectrogram');


-- Mission 3: Rowhammer - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000006', 'SS', 'Martello di Bit',
    'Modificare la memoria senza scriverci sopra.',
    E'# Rowhammer Attack\n\nLe celle di memoria RAM sono microscopici condensatori, molto vicini tra loro.\nSe leggi/scrivi una riga di memoria milioni di volte al secondo ("Hammering"), le interferenze elettromagnetiche fanno saltare i bit della riga ADIACENTE (Bit Flip).\n\nDa 0 a 1.\nSe quel bit era "IsAdmin=0", ora sei Admin. Senza aver mai toccato quella cella via software.',
    'difficile', '15 min', 150, 'level_3', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000006', 'Le memorie ECC (Error Correcting Code) fermano Rowhammer?', 'multiple_choice', '["Lo rendono molto più difficile, ma non impossibile (nuovi attacchi bypassano ECC)", "Sì, ECC corregge tutti gli errori sempre", "No, ECC peggiora la situazione", "Solo su server IBM"]', 0, 'ECC corregge 1 bit. Se ne flippi 2 o usi pattern complessi, puoi evadere.', NULL),
('da100000-0000-0000-0000-000000000006', 'Rowhammer si può eseguire via Javascript (dal browser)?', 'multiple_choice', '["Sì! (Rowhammer.js). È terrificante perché non serve scaricare EXE, basta visitare un sito", "No, serve accesso kernel o root", "Solo se hai i privilegi di amministratore", "No, il browser è sandboxato"]', 0, 'Il browser ha accesso alla RAM. Se l''hardware è difettoso, la sandbox software non conta.', NULL),
('da100000-0000-0000-0000-000000000006', 'DDR4 e DDR5 con TRR (Target Row Refresh) sono immuni?', 'multiple_choice', '["Teoricamente dovrebbero, ma i ricercatori continuano a trovare bypass (es. Blacksmith)", "Sì, il problema è risolto per sempre", "No, sono peggio delle DDR3", "Dipende dalla marca della RAM"]', 0, 'È una corsa agli armamenti tra produttori di RAM e ricercatori.', NULL),
('da100000-0000-0000-0000-000000000006', 'Rowhammer è un bug software.', 'true_false', '["Vero", "Falso"]', 1, 'Falso. È un difetto fisico fondamentale della densità dei chip DRAM moderni.', NULL),
('da100000-0000-0000-0000-000000000006', 'Questo schema mostra l''aggressione alle righe adiacenti?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, martellando le righe "Aggressor", la riga "Victim" in mezzo subisce il leak di carica e flippa.', 'https://placehold.co/600x400?text=Rowhammer+Aggressor+Victim');


-- =================================================================================================
-- NUORO (NU) - TEMPEST & Radio ("Onde Invisibili")
-- =================================================================================================

-- Mission 1: Van Eck Phreaking - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000007', 'NU', 'Telepatia Elettronica',
    'Vedo quello che vedi, attraverso il muro.',
    E'# TEMPEST / Van Eck Phreaking\n\nI cavi video (VGA/HDMI) e i monitor emettono radiazioni elettromagnetiche (EMR) che corrispondono all''immagine a schermo.\n\nCon un sintonizzatore TV modificato (SDR) e un''antenna direzionale, un attaccante nel parcheggio può ricostruire l''immagine del tuo desktop in tempo reale.',
    'semplice', '5 min', 50, 'level_1', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000007', 'Cos''è una Gabbia di Faraday?', 'multiple_choice', '["Un involucro di metallo conduttivo che blocca i campi elettromagnetici esterni e interni", "Una gabbia per uccelli usata dai minatori", "Un antivirus per onde radio", "Un software di cifratura schermo"]', 0, 'L''unica difesa reale contro TEMPEST è schermare fisicamente la stanza o i cavi.', NULL),
('da100000-0000-0000-0000-000000000007', 'I cavi HDMI schermati aiutano?', 'multiple_choice', '["Sì, riducono drasticamente le emissioni rispetto ai cavi economici", "No, il segnale digitale è più facile da intercettare", "No, HDMI non emette onde", "Solo se placcati in oro"]', 0, 'La qualità del cavo conta per la sicurezza EMSEC.', NULL),
('da100000-0000-0000-0000-000000000007', 'L''attacco funziona sui laptop moderni?', 'multiple_choice', '["Sì, anche se i segnali sono più deboli (Low Voltage Differential Signaling), sono ancora captabili da vicino", "No, gli schermi LED non emettono nulla", "Solo se hanno la luminosità al massimo", "No, il Wi-Fi copre tutto"]', 0, 'Più difficile dei vecchi CRT, ma fattibile con equipaggiamento migliore.', NULL),
('da100000-0000-0000-0000-000000000007', 'Usare un font speciale (sfocato) può ingannare TEMPEST?', 'true_false', '["Vero", "Falso"]', 0, 'Sì (es. "SafeFonts"), ideati per minimizzare le emissioni EM ad alta frequenza dei bordi netti.', NULL),
('da100000-0000-0000-0000-000000000007', 'Questa immagine disturbata è il desktop intercettato?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, tipica ricostruzione SDR. Si leggono i titoli delle finestre grossolani.', 'https://placehold.co/600x400?text=SDR+Screen+Intercept');


-- Mission 2: Cold Boot Attack - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000008', 'NU', 'Memoria Congelata',
    'I dati non muoiono quando stacchi la spina.',
    E'# Cold Boot Attack\n\nCredi che la RAM si cancelli spegnendo il PC? Falso.\nI dati persistono per secondi o minuti (fading).\n\nSe l''hacker spruzza spray refrigerante (-50°C) sui banchi RAM, i dati si "congelano" e restano leggibili per ORE.\nL''hacker stacca la RAM, la mette nel suo lettore, e trova la chiave di cifratura del disco (BitLocker/FileVault) che era caricata in memoria.',
    'medio', '10 min', 75, 'level_2', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000008', 'Perché BitLocker chiede il PIN all''avvio (Pre-Boot)?', 'multiple_choice', '["Per evitare che la chiave di decifratura venga caricata automaticamente in RAM all''accensione", "Per bellezza", "Perché Windows è lento", "Per bloccare gli hacker remoti"]', 0, 'Senza PIN, il chip TPM sblocca il disco e mette la chiave in RAM. Se l''hacker fa Cold Boot, la ruba.', NULL),
('da100000-0000-0000-0000-000000000008', 'La RAM saldata sulla scheda madre (es. MacBook moderni) previene l''attacco?', 'multiple_choice', '["Lo rende molto più difficile perché non puoi staccare i banchi e spostarli, ma lettura in-situ è teoricamente possibile", "Sì, impossibile attaccare chip saldati", "No, basta usare una pinza", "Sì, Apple ha risolto la fisica"]', 0, 'Rende l''attacco meno pratico per il ladro comune.', NULL),
('da100000-0000-0000-0000-000000000008', 'Sovrascrivere la RAM allo spegnimento aiuta?', 'multiple_choice', '["Sì, alcuni OS lo fanno, ma richiede tempo e non funziona se l''attaccante tira la spina (blackout)", "No, la RAM è magnetica", "Sì, cancella tutto istantaneamente", "No"]', 0, 'Il Cold Boot sfrutta proprio lo spegnimento improvviso.', NULL),
('da100000-0000-0000-0000-000000000008', 'La RAM DDR3 perde i dati più velocemente della DDR2.', 'true_false', '["Vero", "Falso"]', 0, 'Vero, le celle più piccole e veloci hanno un fading time minore, ma col freddo resistono comunque.', NULL),
('da100000-0000-0000-0000-000000000008', 'Stai spruzzando aria compressa capovolta?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, tecnica casalinga per congelare i chip a -50C.', 'https://placehold.co/600x400?text=Freeze+Spray+RAM');


-- Mission 3: Ultrasonic Beacons - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000009', 'NU', 'Il Fischio del Marketing',
    'Il tuo telefono ascolta la tua TV.',
    E'# Cross-Device Tracking (uXDT)\n\nStai guardando una pubblicità in TV.\nLo spot emette un suono ad alta frequenza (18-20kHz), inudibile per te.\n\nIl tuo telefono (app con permessi microfono) "sente" il beacon.\nOra l''azienda sa che: Il Telefono ID 123 (Tu) sta guardando la TV ID 456 nello stesso salotto.\nIdentità collegate.',
    'difficile', '15 min', 150, 'level_3', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000009', 'Come difendersi dai Beacon ultrasonici?', 'multiple_choice', '["Revocare i permessi microfono alle app che non ne hanno bisogno (giochi, torce)", "Non guardare la TV", "Mettere il nastro adesivo sulla fotocamera", "Usare una VPN"]', 0, 'Se l''app non può ascoltare, il beacon fallisce.', NULL),
('da100000-0000-0000-0000-000000000009', 'L''attacco funziona anche via Web (Browser)?', 'multiple_choice', '["Sì, se visiti un sito che usa AudioContext API per emettere/ascoltare ultrasuoni", "No, i browser bloccano tutto l''audio", "Solo su Chrome", "No"]', 0, 'SilverPush è stato un caso famoso di tecnologia tracking di questo tipo.', NULL),
('da100000-0000-0000-0000-000000000009', 'Questa tecnologia è usata per de-anonimizzare gli utenti Tor?', 'multiple_choice', '["Possibile. Se un sito Tor emette un beacon e il tuo telefono reale lo sente, il collegamento è fatto (Deanonymization by sound)", "No, Tor blocca l''audio", "Impossibile tecnicamente", "Solo dalla CIA"]', 0, 'Superare l''Air Gap (o il Gap Logico) con l''audio è una tattica nota.', NULL),
('da100000-0000-0000-0000-000000000009', 'Gli animali domestici sentono questi beacon?', 'true_false', '["Vero", "Falso"]', 0, 'Vero, cani e gatti sentono benissimo i 20kHz e potrebbero infastidirsi.', NULL),
('da100000-0000-0000-0000-000000000009', 'Questo spettrogramma audio mostra segnale a 19kHz?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, una linea continua in alto, invisibile all''udito ma chiara strumentalmente.', 'https://placehold.co/600x400?text=Ultrasonic+Beacon+Spectrogram');


-- =================================================================================================
-- ORISTANO (OR) - RFID & NFC Hacking ("Identità Clonata")
-- =================================================================================================

-- Mission 1: Proxmark3 & Cloning - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000010', 'OR', 'Il Doppio',
    'Il tuo badge aziendale ha un gemello cattivo.',
    E'# RFID Cloning\n\nMolti badge aziendali usano tecnologie vecchie (125kHz EM4100) che trasmettono il loro ID in chiaro a chiunque chieda.\n\nCon un **Proxmark3** (o anche un Flipper Zero), posso avvicinarmi alla tua tasca in metro, leggere il badge in 1 secondo, e scriverlo su una tessera vuota.\nOra posso entrare nel tuo ufficio.',
    'semplice', '5 min', 50, 'level_1', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000010', 'Qual è la differenza tra LF (Low Frequency) e HF (High Frequency)?', 'multiple_choice', '["LF (125kHz) è spesso sola lettura e insicuro. HF (13.56MHz) supporta crittografia complessa (Mifare DESFire)", "LF è più sicuro perché ha meno raggio", "HF passa attraverso i muri", "Nessuna differenza"]', 0, 'Le vecchie tessere bianche spesse d''ufficio sono spesso LF e clonabili.', NULL),
('da100000-0000-0000-0000-000000000010', 'Le carte Mifare Classic sono sicure?', 'multiple_choice', '["No, la loro crittografia (Crypto-1) è stata rotta anni fa. Si clonano facilmente", "Sì, sono lo standard bancario", "Sì, se usano chiavi lunghe", "Solo quelle blu"]', 0, 'Mifare Classic è l''esempio da scuola di "Bad Crypto".', NULL),
('da100000-0000-0000-0000-000000000010', 'Una custodia schermata (RFID Blocking Wallet) funziona?', 'multiple_choice', '["Sì, crea una gabbia di Faraday attorno alla carta impedendo la lettura", "No, è marketing inutile", "Solo se avvolta nell''alluminio da cucina", "No, i lettori potenti bruciano la custodia"]', 0, 'Fisica elementare efficace.', NULL),
('da100000-0000-0000-0000-000000000010', 'Il Flipper Zero può clonare i badge moderni cifrati (DESFire)?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Può leggere il numero seriale (UID), ma non può estrarre le chiavi private per clonare l''autenticazione cifrata.', NULL),
('da100000-0000-0000-0000-000000000010', 'Questo è un Proxmark3?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, il coltellino svizzero dell''RFID hacking.', 'https://placehold.co/600x400?text=Proxmark3+Device');


-- Mission 2: Relay Attack - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000011', 'OR', 'Furto Silenzioso',
    'La tua auto è parcheggiata sotto casa. Tra un minuto non c''è più.',
    E'# Keyless Entry Relay Attack\n\nLe auto moderne si aprono se la chiave è vicina.\n1.  La chiave è sul mobiletto all''ingresso di casa.\n2.  Ladro A si avvicina alla porta di casa con un''antenna.\n3.  Ladro B sta vicino all''auto con un''altra antenna.\n4.  Fanno un "ponte" radio. L''auto crede che la chiave sia lì accanto e si apre.',
    'medio', '10 min', 75, 'level_2', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000011', 'Come difendersi dal Relay Attack a casa?', 'multiple_choice', '["Mettere le chiavi in una scatola di metallo (biscotti) o custodia Faraday quando si è in casa", "Lasciare le chiavi in auto", "Avvolgere l''auto nella carta stagnola", "Disattivare la batteria dell''auto"]', 0, 'Bloccare il segnale radio della chiave è l''unica via.', NULL),
('da100000-0000-0000-0000-000000000011', 'L''attacco richiede crittanalisi complessa?', 'multiple_choice', '["No, è un attacco di livello fisico. Si limitano a ''allungare'' il cavo wireless. La crittografia (Challenge-Response) passa intatta attraverso il ponte", "Sì, devono craccare il rolling code dell''auto in tempo reale", "Sì, serve un computer quantistico", "No, usano un passepartout"]', 0, 'La bellezza dell''attacco è che non tocca la crittografia.', NULL),
('da100000-0000-0000-0000-000000000011', 'L''auto si spegne se il ladro si allontana senza chiave?', 'multiple_choice', '["Di solito no, per sicurezza stradale (non spegnere il motore in corsa). Il ladro può guidare finché non spegne lui il motore o finisce la benzina", "Sì, si ferma dopo 100 metri", "Sì, esplode l''airbag", "No, torna indietro da sola"]', 0, 'Una volta in moto, l''auto non controlla più la chiave costantemente (o avvisa solo sul cruscotto).', NULL),
('da100000-0000-0000-0000-000000000011', 'L''UWB (Ultra Wide Band) nelle nuove chiavi risolve il problema?', 'true_false', '["Vero", "Falso"]', 0, 'Vero. UWB misura il "Time of Flight" (tempo di volo) del segnale. Se il segnale ci mette troppo tempo (perché fa il giro via ponte radio), l''auto capisce che la chiave è lontana e non apre.', NULL),
('da100000-0000-0000-0000-000000000011', 'Questi due ladri con zaino stanno facendo un Relay?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, uno vicino al muro di casa, l''altro vicino alla portiera. Classico.', 'https://placehold.co/600x400?text=Relay+Attack+Setup');


-- =================================================================================================
-- SUD SARDEGNA (SU) - Air Gap Jumping ("Il Salto nel Vuoto")
-- =================================================================================================

-- Mission 1: Stuxnet & Bridging - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000012', 'SU', 'Il Ponte Umano',
    'Se internet non c''è, portalo tu in tasca.',
    E'# Air Gap\n\nI sistemi critici (Centrali Nucleari, SCADA) sono "Air Gapped": fisicamente scollegati da Internet.\nSicuri, vero?\nStuxnet ha dimostrato il contrario.\n\nBasta infettare il laptop di un manutentore o lasciare chiavette USB infette nel parcheggio. Qualcuno, prima o poi, la collegherà alla rete interna.',
    'semplice', '5 min', 50, 'level_1', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000012', 'Cos''è un "Candy Drop" attack?', 'multiple_choice', '["Disperdere chiavette USB malevole in luoghi frequentati dai dipendenti bersaglio, sperando nella curiosità", "Regalare caramelle avvelenate", "Attacco phishing via email dolce", "Lanciare droni sul tetto"]', 0, 'La curiosità umana è la vulnerabilità zero-day eterna.', NULL),
('da100000-0000-0000-0000-000000000012', 'Come faceva Stuxnet ad aggiornarsi senza internet?', 'multiple_choice', '["Tramite Peer-to-Peer su chiavette USB. Quando una chiavetta passava da un PC infetto a uno nuovo (e viceversa), scambiavano aggiornamenti e dati rubati", "Usava i satelliti segreti", "Non si aggiornava mai", "Usava la telepatia"]', 0, 'Una rete P2P lenta, basata sullo spostamento fisico delle persone (Sneakernet).', NULL),
('da100000-0000-0000-0000-000000000012', 'Cosa colpiva Stuxnet?', 'multiple_choice', '["Le centrifughe di arricchimento uranio iraniane (PLC Siemens), facendole girare troppo veloci fino alla rottura", "I bancomat russi", "Le luci di New York", "I missili americani"]', 0, 'La prima vera cyber-arma cinetica della storia.', NULL),
('da100000-0000-0000-0000-000000000012', 'I sistemi Air Gapped non hanno bisogno di patch?', 'true_false', '["Vero", "Falso"]', 1, 'Falso. Hanno bisogno di patch critiche come tutti, ma applicarle è difficile e rischioso (vettore di infezione).', NULL),
('da100000-0000-0000-0000-000000000012', 'Questo PLC Siemens S7 è il target?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, l''hardware industriale specifico bersagliato da Stuxnet.', 'https://placehold.co/600x400?text=PLC+Siemens+Device');


-- Mission 2: LED Exfiltration - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000013', 'SU', 'Luce Parlante',
    'Il computer ti fa l''occhiolino, e i dati escono.',
    E'# Optical Covert Channel\n\nHai infettato un PC Air-Gapped.\nCome tiri fuori i dati (Exfiltration)?\nIl malware fa lampeggiare il LED dell''Hard Disk (o della tastiera) a frequenze altissime, invisibili all''occhio umano.\n\nUna telecamera o un drone fuori dalla finestra registra i lampeggi e li converte in file binary.',
    'medio', '10 min', 75, 'level_2', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000013', 'Qual è la limitazione principale dell''esfiltrazione LED?', 'multiple_choice', '["La velocità (Bandwidth) è bassissima. Pochi bit o byte al secondo. Buona per rubare password o chiavi RSA, inutile per rubare database da 100GB", "Nessuna, è velocissima come la fibra", "Richiede il buio totale", "Funziona solo su LED rossi"]', 0, 'Low Bandwidth Exfiltration.', NULL),
('da100000-0000-0000-0000-000000000013', 'Si possono usare le telecamere di sorveglianza (CCTV) contro l''azienda?', 'multiple_choice', '["Sì, se l''attaccante ha hackerato la CCTV che inquadra il PC, può leggere i segnali LED tramite quella", "No, le CCTV hanno risoluzione troppo bassa", "Solo se sono in bianco e nero", "No"]', 0, 'L''infrastruttura di sicurezza diventa vettore di attacco.', NULL),
('da100000-0000-0000-0000-000000000013', 'Coprire i LED col nastro adesivo aiuta?', 'multiple_choice', '["Sì, blocca il canale ottico. Una misura di sicurezza fisica semplice ed efficace", "No, la luce passa attraverso il nastro nero", "No, surriscalda il PC", "Solo se è nastro isolante giallo"]', 0, 'Low tech defense vs High tech attack.', NULL),
('da100000-0000-0000-0000-000000000013', 'Screen Watermarking (codici QR invisibili a schermo) è simile?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, un altro canale ottico per trasmettere info nascoste (steganografia visuale).', NULL),
('da100000-0000-0000-0000-000000000013', 'Questo drone fuori dalla finestra sta registrando i LED?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, scenario tipico di attacco Mordechai Guri (Ben-Gurion University).', 'https://placehold.co/600x400?text=Drone+LED+Exfiltration');


-- Mission 3: Fansmitter - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'da100000-0000-0000-0000-000000000014', 'SU', 'Vento Cifrato',
    'Se non c''è luce, usa il suono. Se non ci sono casse, usa le ventole.',
    E'# Fansmitter\n\nPC Air-Gapped senza casse audio e senza LED visibili.\nIl malware prende il controllo della ventola CPU (PWM).\n\nModulando la velocità di rotazione (3000 RPM -> 3100 RPM -> 3000 RPM), genera variazioni di rumore impercettibili / bassa frequenza.\nUno smartphone vicino decodifica il ronzio in dati (0 e 1).',
    'difficile', '15 min', 150, 'level_3', 'Sardegna', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('da100000-0000-0000-0000-000000000014', 'Fansmitter funziona se il PC è raffreddato a liquido passivo (senza ventole)?', 'multiple_choice', '["No, richiede una parte meccanica in movimento che generi rumore acustico variabile", "Sì, fa vibrare l''acqua", "Sì, usa il fischio della pompa", "Dipende dall''acqua"]', 0, 'Niente ventola, niente Fansmitter. (Ma potresti usare il Coil Whine!)', NULL),
('da100000-0000-0000-0000-000000000014', 'DiskFiltration (suono braccio HDD) è una variante?', 'multiple_choice', '["Sì, muovere la testina dell''hard disk meccanico genera rumori specifici controllabili via software (seek)", "No, gli HDD sono silenziosi", "Sì, ma solo sugli SSD", "No, rompe il disco"]', 0, 'Qualsiasi componente meccanico è un potenziale altoparlante.', NULL),
('da100000-0000-0000-0000-000000000014', 'Come ci si difende da esfiltrazione acustica in ambienti Top Secret (SCIF)?', 'multiple_choice', '["Vietando l''ingresso a qualsiasi dispositivo elettronico (cellulari, orologi) che possa fungere da ricevitore/microfono", "Mettendo la musica rock a tutto volume", "Usando PC sordi", "Non si può"]', 0, 'La policy "No Electronics" è l''unica difesa contro il ricevitore.', NULL),
('da100000-0000-0000-0000-000000000014', 'Modulare il calore (Thermal) è un altro canale side-channel?', 'true_false', '["Vero", "Falso"]', 0, 'Vero (BitWhisper). Due PC vicini possono comunicare "sentendo" il calore emesso dall''altro, molto lentamente.', NULL),
('da100000-0000-0000-0000-000000000014', 'Questo grafico mostra la variazione RPM della ventola?', 'image_true_false', '["Vero", "Falso"]', 0, 'Sì, l''onda quadra degli RPM corrisponde ai bit trasmessi.', 'https://placehold.co/600x400?text=Fan+RPM+Modulation');
