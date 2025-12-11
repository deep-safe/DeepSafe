-- Mission Seed for Friuli Venezia Giulia (Theme: La Frontiera Digitale - Network Security)
-- Provinces: Trieste (TS), Udine (UD), Pordenone (PN), Gorizia (GO)

-- =================================================================================================
-- TRIESTE (TS) - Public Wi-Fi & VPN ("Il Porto Aperto")
-- =================================================================================================

-- Mission 1: Il Porto Aperto (Wi-Fi Pubblico)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D0E1F2A3-B4C5-4678-9012-345678901ABC', 'TS', 'Il Porto Aperto',
    'Il Wi-Fi pubblico è come una piazza affollata: chiunque può ascoltare.',
    E'# I pericoli del Wi-Fi Pubblico\n\nQuando ti connetti a un Wi-Fi aperto (senza password) in aeroporto o al bar, i dati viaggiano "in chiaro".\n\n### Man-in-the-Middle (MitM)\nUn hacker connesso alla stessa rete può intercettare tutto ciò che invii: password, email, foto.\n\n**Regola d''oro:** Non fare MAI acquisti o banking su Wi-Fi pubblico senza protezione.',
    'semplice', '5 min', 50, 'level_1', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D0E1F2A3-B4C5-4678-9012-345678901ABC', 'È sicuro controllare il conto in banca dal Wi-Fi del bar?', 'multiple_choice', '["Sì, se il bar è di lusso", "No, mai farlo senza VPN", "Sì, se la connessione è veloce", "Solo di mattina"]', 1, 'Le reti pubbliche sono facili da intercettare.'),
('D0E1F2A3-B4C5-4678-9012-345678901ABC', 'Cosa significa che i dati viaggiano "in chiaro"?', 'multiple_choice', '["Che sono scritti in bianco", "Che chiunque li intercetti può leggerli", "Che sono molto leggeri", "Che sono criptati"]', 1, 'Senza crittografia, i dati sono leggibili da chiunque sulla stessa rete.');

-- Mission 2: Il Tunnel Segreto (VPN)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D0E1F2A3-B4C5-4678-9012-345678901DEF', 'TS', 'Il Tunnel Segreto',
    'Come attraversare un territorio ostile senza essere visti.',
    E'# Cos''è una VPN?\n\nLa VPN (Virtual Private Network) crea un "tunnel" criptato tra te e internet.\n\nAnche se un hacker intercetta i dati sul Wi-Fi, vedrà solo una stringa di caratteri incomprensibili.\n\n**Uso:** Attivala SEMPRE quando usi reti non fidate.',
    'medio', '10 min', 75, 'level_2', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D0E1F2A3-B4C5-4678-9012-345678901DEF', 'A cosa serve principalmente una VPN su Wi-Fi pubblico?', 'multiple_choice', '["A navigare più veloce", "A criptare i dati e proteggere la privacy", "A scaricare giochi", "A risparmiare batteria"]', 1, 'La crittografia è la funzione chiave per la sicurezza in reti insicure.'),
('D0E1F2A3-B4C5-4678-9012-345678901DEF', 'La VPN ti rende invisibile al 100%?', 'multiple_choice', '["Sì, diventi un fantasma", "No, protegge il traffico ma non ti rende anonimo ai siti in cui ti logghi", "Sì, nessuno saprà chi sei", "Solo se paghi"]', 1, 'Se accedi a Facebook via VPN, Facebook sa comunque chi sei.');

-- Mission 3: Il Gemello Cattivo (Evil Twin)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'D0E1F2A3-B4C5-4678-9012-345678901012', 'TS', 'Il Gemello Cattivo',
    'Quando il Wi-Fi "Free Airport" non è quello che sembra.',
    E'# Evil Twin Attack\n\nUn hacker crea un hotspot Wi-Fi con lo stesso nome di uno legittimo (es. "Starbucks_Guest").\n\nSe ti colleghi al "Gemello Cattivo", l''hacker controlla tutto il tuo traffico e può reindirizzarti su siti falsi per rubare le tue credenziali.\n\n**Difesa:** Chiedi sempre conferma del nome esatto della rete ai gestori e disattiva la connessione automatica.',
    'difficile', '15 min', 100, 'level_3', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('D0E1F2A3-B4C5-4678-9012-345678901012', 'Cos''è un Evil Twin?', 'multiple_choice', '["Un virus", "Un Wi-Fi falso che imita uno legittimo", "Un doppio account", "Un errore del router"]', 1, 'L''obiettivo è ingannare l''utente facendogli credere di essere connesso a una rete sicura.'),
('D0E1F2A3-B4C5-4678-9012-345678901012', 'Come puoi evitare di connetterti a un Evil Twin?', 'multiple_choice', '["Cliccando sul primo che trovo", "Disattivando la connessione automatica e verificando la rete", "Usando solo il 4G", "Guardando il segnale"]', 1, 'La connessione automatica è pericolosa perché i dispositivi si collegano ai nomi noti senza verificare.');


-- =================================================================================================
-- UDINE (UD) - Malware & Antivirus ("Le Mura di Difesa")
-- =================================================================================================

-- Mission 1: L'Invasore (Tipi di Malware)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'E1F2A3B4-C5D6-4789-0123-456789012ABC', 'UD', 'L''Invasore',
    'Conosci il tuo nemico: Virus, Trojan e Worm.',
    E'# Malware 101\n\n"Malware" sta per Malicious Software. Non sono tutti uguali:\n\n*   **Virus:** Si attacca a un file ed ha bisogno di te per diffondersi (es. aprire l''allegato).\n*   **Worm:** Si diffonde da solo nella rete sfruttando vulnerabilità.\n*   **Trojan:** Sembra un programma utile (es. gioco gratis) ma nasconde un "soldato" nemico all''interno.',
    'semplice', '5 min', 50, 'level_1', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('E1F2A3B4-C5D6-4789-0123-456789012ABC', 'Qual è la differenza principale tra Virus e Worm?', 'multiple_choice', '["Il Virus è verde, il Worm è rosso", "Il Virus richiede azione umana, il Worm si diffonde da solo", "Il Worm è per Apple, il Virus per Windows", "Nessuna"]', 1, 'I Worm sono autonomi e per questo molto pericolosi nelle reti aziendali.'),
('E1F2A3B4-C5D6-4789-0123-456789012ABC', 'Cos''è un Trojan?', 'multiple_choice', '["Un errore hardware", "Software malevolo mascherato da programma legittimo", "Un antivirus", "Un cavallo vero"]', 1, 'Prende il nome dal Cavallo di Troia proprio per questa tecnica di inganno.');

-- Mission 2: I Sintomi dell'Infezione
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'E1F2A3B4-C5D6-4789-0123-456789012DEF', 'UD', 'Sintomi dell''Infezione',
    'Come capire se le mura sono state brecciate.',
    E'# Sei stato infettato?\n\nNon sempre appare un teschio rosso sullo schermo. Ecco segnali più sottili:\n*   Il PC è molto lento all''improvviso.\n*   La ventola gira al massimo anche se non fai nulla.\n*   Compaiono nuove toolbar nel browser o pop-up strani.\n*   L''antivirus si disattiva da solo.',
    'medio', '10 min', 75, 'level_2', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('E1F2A3B4-C5D6-4789-0123-456789012DEF', 'Se il computer diventa improvvisamente lentissimo, cosa dovresti fare?', 'multiple_choice', '["Comprarne uno nuovo", "Eseguire una scansione antivirus completa", "Batterlo sul fianco", "Ignorarlo"]', 1, 'Un rallentamento improvviso può indicare un processo malevolo (es. cryptomining) in background.'),
('E1F2A3B4-C5D6-4789-0123-456789012DEF', 'Perché l''antivirus potrebbe disattivarsi da solo?', 'multiple_choice', '["È stanco", "Alcuni malware provano a disattivare le difese come prima azione", "È scaduto", "Risparmio energetico"]', 1, 'È una tecnica di autoprotezione del malware.');

-- Mission 3: La Sentinella (EDR vs Antivirus)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'E1F2A3B4-C5D6-4789-0123-456789012012', 'UD', 'La Sentinella Moderna',
    'Oltre l''antivirus classico: l''era dell''EDR.',
    E'# Antivirus vs EDR\n\nL''Antivirus classico funziona con le **Firme**: riconosce i ladri perché ha la loro foto segnaletica (file hash). Se il ladro cambia faccia (nuovo malware), l''antivirus non lo vede.\n\nL''**EDR (Endpoint Detection and Response)** analizza il **Comportamento**: se un programma calcolatrice inizia a scaricare file da internet, l''EDR lo blocca, anche se non ha mai visto quel malware prima.',
    'difficile', '15 min', 100, 'level_3', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('E1F2A3B4-C5D6-4789-0123-456789012012', 'Qual è il limite dell''antivirus tradizionale a firme?', 'multiple_choice', '["Costa troppo", "Non riconosce virus nuovi o modificati (Zero-Day)", "È troppo pesante", "Non funziona su Mac"]', 1, 'Le firme funzionano solo su minacce già note.'),
('E1F2A3B4-C5D6-4789-0123-456789012012', 'Cosa analizza un EDR?', 'multiple_choice', '["Il colore delle icone", "Il comportamento dei programmi in esecuzione", "La polvere sulla ventola", "La marca del PC"]', 1, 'L''analisi comportamentale permette di fermare minacce sconosciute.');


-- =================================================================================================
-- PORDENONE (PN) - Updates & Zero-Day ("L'Innovazione Sicura")
-- =================================================================================================

-- Mission 1: Aggiornare o Morire
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'F2A3B4C5-D6E7-4890-1234-567890123ABC', 'PN', 'Aggiornare o Morire',
    'Perché quel pop-up di aggiornamento è il tuo migliore amico.',
    E'# Non solo nuove icone\n\nMolti ignorano gli aggiornamenti di sistema (Windows, iOS, Android) per noia. Errore grave.\n\nGli aggiornamenti contengono **Patch di Sicurezza** che chiudono buchi scoperti nel codice. Un sistema non aggiornato è come una casa con la porta aperta.',
    'semplice', '5 min', 50, 'level_1', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('F2A3B4C5-D6E7-4890-1234-567890123ABC', 'Cosa contiene principalmente un aggiornamento di sicurezza?', 'multiple_choice', '["Nuovi sfondi", "Correzioni per vulnerabilità (Patch)", "Giochi", "Pubblicità"]', 1, 'Le patch "tappano" i buchi usati dagli hacker.'),
('F2A3B4C5-D6E7-4890-1234-567890123ABC', 'Quanto tempo dovresti aspettare per installare un aggiornamento critico?', 'multiple_choice', '["Un mese", "Minuti o ore (il prima possibile)", "Un anno", "Mai"]', 1, 'Più aspetti, più tempo dai agli hacker per sfruttare la vulnerabilità.');

-- Mission 2: Corsa contro il tempo (Zero-Day)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'F2A3B4C5-D6E7-4890-1234-567890123DEF', 'PN', 'Corsa contro il tempo',
    'Quando la vulnerabilità è scoperta prima della cura.',
    E'# Zero-Day Exploit\n\nUno "Zero-Day" è una vulnerabilità scoperta dagli hacker *prima* che il produttore (es. Microsoft, Apple) lo sappia e rilasci la patch.\n\nIn quel lasso di tempo (da 0 giorni fino alla patch), sei vulnerabile anche se sei aggiornato. L''unica difesa è la "Defense in Depth" (più strati di sicurezza) e il comportamento prudente.',
    'medio', '10 min', 75, 'level_2', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('F2A3B4C5-D6E7-4890-1234-567890123DEF', 'Perché si chiama "Zero-Day"?', 'multiple_choice', '["Dura zero giorni", "Gli sviluppatori hanno avuto 0 giorni per risolverlo prima che venisse usato", "Costa zero euro", "Nessuna delle precedenti"]', 1, 'Indica l''assenza di tempo per preparare una difesa specifica.'),
('F2A3B4C5-D6E7-4890-1234-567890123DEF', 'Come ci si difende da uno Zero-Day?', 'multiple_choice', '["Non si può", "Con strati multipli di sicurezza (es. EDR, Permessi minimi) e prudenza", "Spegnendo tutto", "Cambiando PC"]', 1, 'Poiché non c''è patch, servono altri meccanismi per bloccare l''attacco.');

-- Mission 3: Il Vecchio PC (End of Life)
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'F2A3B4C5-D6E7-4890-1234-567890123012', 'PN', 'Il Vecchio PC',
    'Windows 7 era bello, ma ora è una trappola.',
    E'# End of Life (EOL)\n\nQuando un software raggiunge l''End of Life (es. Windows 7, vecchi Android), il produttore smette di rilasciare aggiornamenti di sicurezza.\n\nContinuare a usare sistemi EOL connessi a internet è rischiosissimo: ogni nuova vulnerabilità scoperta resterà lì per sempre.',
    'difficile', '15 min', 100, 'level_3', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('F2A3B4C5-D6E7-4890-1234-567890123012', 'Cosa significa che un software è EOL (End of Life)?', 'multiple_choice', '["Che è morto", "Che non riceve più aggiornamenti di sicurezza dal produttore", "Che non funziona più", "Che è gratis"]', 1, 'Senza update, diventa un colabrodo di sicurezza.'),
('F2A3B4C5-D6E7-4890-1234-567890123012', 'È sicuro usare Windows 7 oggi per l''home banking?', 'multiple_choice', '["Sì, è stabile", "Assolutamente no, è pieno di falle non patchate", "Sì, se ho l''antivirus", "Solo di notte"]', 1, 'L''antivirus da solo non può proteggere falle strutturali del sistema operativo non corrette.');


-- =================================================================================================
-- GORIZIA (GO) - Cloud Security & Sharing ("Il Confine Invisibile")
-- =================================================================================================

-- Mission 1: La Nuvola non esiste
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A3B4C5D6-E7F8-4901-2345-678901234ABC', 'GO', 'La Nuvola non esiste',
    'Il Cloud è solo il computer di qualcun altro.',
    E'# Cos''è il Cloud?\n\nQuando salvi file su Google Drive, iCloud o Dropbox, non vanno in cielo. Vengono copiati su server fisici (computer) gestiti da aziende.\n\nLa sicurezza fisica è loro responsabilità, ma la sicurezza dell''accesso (la tua password) è TUA responsabilità.',
    'semplice', '5 min', 50, 'level_1', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A3B4C5D6-E7F8-4901-2345-678901234ABC', 'Chi è responsabile della tua password del Cloud?', 'multiple_choice', '["Google/Apple", "Tu", "Il governo", "L''amministratore di condominio"]', 1, 'Modello di Responsabilità Condivisa: tu proteggi l''accesso, loro l''infrastruttura.'),
('A3B4C5D6-E7F8-4901-2345-678901234ABC', 'Dov''è fisicamente il "Cloud"?', 'multiple_choice', '["Nell''atmosfera", "In data center pieni di server fisici", "Nel tuo telefono", "Non esiste"]', 1, 'Sono enormi stanze piene di computer ultra-potenti.');

-- Mission 2: Link Condivisi Male
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A3B4C5D6-E7F8-4901-2345-678901234DEF', 'GO', 'Link Condivisi Male',
    'Chiunque abbia il link può vedere questo file.',
    E'# Permessi di Condivisione\n\nQuando condividi un file dal Cloud, fai attenzione alle opzioni:\n\n*   **PERICOLOSO:** "Chiunque abbia il link può visualizzare/modificare". Se il link finisce nella chat sbagliata, chiunque accede.\n*   **SICURO:** Condividi solo con indirizzi email specifici (es. mario.rossi@email.com).',
    'medio', '10 min', 75, 'level_2', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A3B4C5D6-E7F8-4901-2345-678901234DEF', 'Qual è il modo più sicuro di condividere un documento riservato?', 'multiple_choice', '["Link pubblico su Facebook", "Link aperto a chiunque", "Invito diretto all''email del destinatario", "Stampandolo"]', 1, 'Così controlli esattamente chi accede e puoi revocare l''accesso.'),
('A3B4C5D6-E7F8-4901-2345-678901234DEF', 'Se crei un link "Chiunque può modificare", cosa può succedere?', 'multiple_choice', '["Nulla", "Qualcuno può cancellare o alterare i tuoi dati", "Il file diventa più bello", "Google ti paga"]', 1, 'Dai il potere di scrittura a sconosciuti.');

-- Mission 3: Shadow IT
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'A3B4C5D6-E7F8-4901-2345-678901234012', 'GO', 'Shadow IT',
    'Usare WeTransfer aziendale di nascosto è un problema.',
    E'# Shadow IT\n\nSi verifica quando i dipendenti usano software o servizi cloud non approvati dall''azienda (es. mandare dati sensibili via WeTransfer personale o WhatsApp).\n\nL''azienda perde il controllo sui dati: non sa dove sono, chi li vede e se son protetti. Se quel servizio viene bucato, i dati aziendali sono compromessi.',
    'difficile', '15 min', 100, 'level_3', 'Friuli Venezia Giulia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation) VALUES
('A3B4C5D6-E7F8-4901-2345-678901234012', 'Cos''è lo Shadow IT?', 'multiple_choice', '["Lavorare al buio", "L''uso di software/servizi non autorizzati dall''IT aziendale", "Un tipo di hacker", "Un gioco di ombre"]', 1, 'È l''informatica "ombra" che sfugge al controllo e alla protezione aziendale.'),
('A3B4C5D6-E7F8-4901-2345-678901234012', 'Perché è pericoloso usare il Cloud personale per lavoro?', 'multiple_choice', '["Perché è gratis", "Perché i dati escono dal perimetro di sicurezza aziendale", "Perché il capo si arrabbia", "Perché occupa spazio"]', 1, 'L''azienda non può proteggere dati che non sa dove siano.');
