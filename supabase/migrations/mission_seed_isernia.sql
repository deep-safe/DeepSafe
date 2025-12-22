-- Mission Seed for Isernia (IS) - Molise
-- Theme: Disinformation Defense ("Difesa dalla Disinformazione")
-- Province: Isernia (IS)

-- =================================================================================================
-- ISERNIA (IS) - Fake News & Fact-Checking
-- =================================================================================================

-- Mission 1: Cacciatori di Clickbait - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'd86f3455-8822-4a0b-9d45-92892976d001', 'IS', 'Cacciatori di Clickbait',
    'Non tutto ciò che luccica è notizia.',
    E'# Clickbait\n\nIl "Clickbait" (esca da click) è progettato per spegnere il tuo cervello razionale e accendere quello emotivo.\n\nUsa tre leve principali:\n1.  **Paura:** "Stanno per toglierci tutto!"\n2.  **Rabbia:** "Guarda cosa ha fatto questo politico!"\n3.  **Curiosità Estrema:** "Non crederai ai tuoi occhi..."\n\nSe un titolo ti fa battere il cuore prima di averlo letto, probabilmente ti sta manipolando.',
    'semplice', '5 min', 50, 'level_1', 'Molise', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('d86f3455-8822-4a0b-9d45-92892976d001', 'Quale di questi titoli è un classico Clickbait?', 'multiple_choice', '["Nuova legge approvata in parlamento ieri", "I 5 Segreti che le banche NON vogliono farti sapere (Il numero 3 ti scioccherà!)", "Meteo: previste piogge nel weekend", "Aumentano le tariffe dei treni del 2%"]', 1, 'L''uso di liste numerate, segreti proibiti e promesse di shock emotivo sono firme del clickbait.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d001', 'Perché i siti usano il clickbait?', 'multiple_choice', '["Per informare meglio", "Per vendere pubblicità (più click = più soldi)", "Per beneficenza", "Per errore"]', 1, 'È un modello di business basato sull''attenzione. Non gli importa se la notizia è vera, basta che tu clicchi.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d001', 'Vedi un post: "CONDIVIDI PRIMA CHE LO CANCELLINO!!". Cosa fai?', 'multiple_choice', '["Condivido subito per sicurezza", "Mi fermo. È una tattica di urgenza per impedirti di verificare.", "Lo stampo", "Chiamo la polizia"]', 1, 'L''urgenza artificiale serve a bypassare il tuo pensiero critico.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d001', 'Una foto scioccante in un articolo garantisce che la notizia sia vera?', 'true_false', '["Vero", "Falso"]', 1, 'Assolutamente no. Le foto sono spesso prese da altri contesti (es. una foto di un film usata per descrivere una guerra attuale).', NULL),
('d86f3455-8822-4a0b-9d45-92892976d001', 'Questo titolo è affidabile?', 'image_true_false', '["Vero", "Falso"]', 1, 'L''uso eccessivo di MAIUSCOLE e punti esclamativi (!!!) è un segnale di allarme per scarsa professionalità e sensazionalismo.', 'https://placehold.co/600x400?text=TITOLO+SHOCK!!!');


-- Mission 2: Verifica delle Fonti - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'd86f3455-8822-4a0b-9d45-92892976d002', 'IS', 'Chi sta parlando?',
    'Impara a guardare il messaggero, non solo il messaggio.',
    E'# Verifica Laterale (Lateral Reading)\n\nI Fact-Checker professionisti non leggono l''articolo in verticale (dall''inizio alla fine).\nLeggono il titolo, aprono un''altra scheda, e cercano **chi è l''autore** o il sito.\n\n*   Il sito "ilfattoquotidaino.it" NON è "ilfattoquotidiano.it".\n*   Cerca "Nome Sito + affidabilità" o "Nome Sito + bufale".\n*   Se l''autore non esiste o è "Admin", diffida.',
    'medio', '10 min', 75, 'level_2', 'Molise', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('d86f3455-8822-4a0b-9d45-92892976d002', 'Cos''è il "Typosquatting" nelle Fake News?', 'multiple_choice', '["Fare squat in palestra", "Registrare un dominio simile a uno famoso ma con un errore di battitura (es. reppublica.it)", "Scrivere in dialetto", "Usare font strani"]', 1, 'Sfrutta la distrazione visiva per sembrare una fonte autorevole.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d002', 'Se un sito "medico" è pieno di pubblicità per cure miracolose e integratori, è affidabile?', 'multiple_choice', '["Sì, devono pur mantenersi", "Probabilmente no. C''è un conflitto di interessi: creano la paura (malattia falsa) per vendere la soluzione", "Sì, se ha il camice bianco", "Dipende dal colore"]', 1, 'Il movente economico è spesso la chiave per smascherare la pseudoscienza.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d002', 'Cos''è la "Lettura Laterale"?', 'multiple_choice', '["Leggere sdraiati", "Leggere un libro di lato", "Aprire nuove schede nel browser per verificare cosa dicono ALTRE fonti sulla notizia o sull''autore", "Leggere solo i titoli"]', 2, 'È la tecnica n.1 dei fact-checker di Stanford. Non restare nella pagina che ti sta mentendo.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d002', 'La pagina "Chi Siamo" di un sito di notizie affidabile dovrebbe contenere nomi reali dei giornalisti ed editore.', 'true_false', '["Vero", "Falso"]', 0, 'La trasparenza è il primo requisito del giornalismo. Se è anonimo o generico, è sospetto.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d002', 'In questa URL "www.news24-sky.com", il dominio principale è sky.com?', 'image_true_false', '["Vero", "Falso"]', 1, 'Il dominio è "news24-sky.com", che è di proprietà di chiunque l''abbia comprato, non di Sky. Sky userebbe "news.sky.com" (sottodominio).', 'https://placehold.co/600x400?text=URL+Analysis');


-- Mission 3: Manipulation & Context - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'd86f3455-8822-4a0b-9d45-92892976d003', 'IS', 'Il Contesto è Re',
    'Una foto vera può mentire se la didascalia è falsa.',
    E'# Cheapfakes & Contesto\n\nNon serve l''AI per mentire. Basta:\n1.  **Riciclare:** Prendere una foto di una protesta del 2011 e dire "Guardate cosa succede OGGI!".\n2.  **Cropping:** Ritagliare una foto per nascondere che le persone si stanno in realtà salutando, non picchiando.\n3.  **Fallacie Logiche:** Attaccare la persona invece dell''argomento (Ad Hominem) o inventare un nemico facile da abbattere (Strawman).',
    'difficile', '15 min', 150, 'level_3', 'Molise', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('d86f3455-8822-4a0b-9d45-92892976d003', 'Cos''è la fallacia "Strawman" (Uomo di Paglia)?', 'multiple_choice', '["Un pupazzo utile", "Inventare una versione esagerata e ridicola dell''argomento dell''avversario per poterla attaccare facilmente", "Bruciare il grano", "Mentire sul meteo"]', 1, 'Esempio: "Vuoi regolamentare i social? Allora odi la libertà di parola!". Semplificazione estrema per vincere facile.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d003', 'Vedi una foto di una piazza piena di spazzatura con didascalia "La città è nel degrado OGGI". Come verifichi?', 'multiple_choice', '["Mi arrabbio", "Faccio una Ricerca Inversa per Immagini (Google Lens / TinEye) per vedere se la foto è vecchia o di un''altra città", "Commento insultando il sindaco", "Metto like"]', 1, 'La Reverse Image Search è l''arma letale contro il riciclo di foto vecchie.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d003', 'Il "Quote Mining" significa...', 'multiple_choice', '["Cercare oro", "Estrarre una frase dal suo contesto originale per farle dire l''opposto di ciò che intendeva l''autore", "Citare le fonti", "Scrivere poesie"]', 1, 'Classico trucco: "Non credo che uccidere sia sbagliato... [se per legittima difesa]" -> "Lui ha detto: Non credo che uccidere sia sbagliato!"', NULL),
('d86f3455-8822-4a0b-9d45-92892976d003', 'Un grafico dove l''asse Y non parte da zero è spesso usato per manipolare la percezione.', 'true_false', '["Vero", "Falso"]', 0, 'Vero. "Truncated Graph". Fa sembrare un aumento dell''1% come un raddoppio visivo della colonna.', NULL),
('d86f3455-8822-4a0b-9d45-92892976d003', 'Questa immagine è un "Cheapfake"?', 'image_true_false', '["Vero", "Falso"]', 0, 'Un cheapfake è una manipolazione "povera" (ritaglio, didascalia falsa, velocità alterata) senza uso di AI complessa, ma molto efficace.', 'https://placehold.co/600x400?text=Cheapfake+Example');
