-- Mission Seed for Torino (TO) - Filter Bubbles & Algoritmi

-- 1. Missione Semplice: La Bolla Invisibile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'TO', 
    'La Bolla Invisibile', 
    'Scopri perché i social ti mostrano sempre ciò che ti piace e come questo limita la tua visione del mondo.', 
    E'# La tua Bolla Personale\n\nI social network non sono specchi della realtà.\n\n### Come funziona l''algoritmo?\nIl suo obiettivo è **tenerti incollato allo schermo** per mostrarti pubblicità. \n\nPer farlo, ti propone solo contenuti che:\n1. Ti piacciono (Like).\n2. Ti fanno arrabbiare (Commenti).\n3. Condividi spesso.\n\nRisultato? Finisci in una **Filter Bubble** (Bolla di Filtraggio): vedi solo opinioni simili alle tue.', 
    'semplice', 
    '5 min', 
    100, 
    'level_1', 
    'Piemonte', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 1
DELETE FROM public.mission_questions WHERE mission_id = '123e4567-e89b-12d3-a456-426614174001';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'Perché l''algoritmo di TikTok o Instagram ti mostra certi video?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Perché mi vuole bene', 'Per massimizzare il tempo che passo sull''app', 'Per informarmi in modo imparziale', 'È casuale']), 
    1, 
    'Le piattaforme guadagnano con la tua attenzione. Ti mostrano ciò che ti intrattiene, non necessariamente ciò che è vero o importante.'
),
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'Cos''è una "Filter Bubble"?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Un filtro per le foto', 'Una marca di sapone', 'L''isolamento intellettuale creato dagli algoritmi', 'Una protezione antivirus']), 
    2, 
    'Il termine, coniato da Eli Pariser, descrive come gli algoritmi ci isolino in una "bolla" di informazioni che confermano solo i nostri pregiudizi.'
),
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'Se tutti i tuoi amici online la pensano come te, cosa sta succedendo?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Siamo geni', 'Ho ragione su tutto', 'Sono in una Echo Chamber (Camera dell''Eco)', 'È una coincidenza']), 
    2, 
    'Le Echo Chambers sono ambienti in cui le stesse idee vengono ripetute e amplificate, escludendo il dissenso o punti di vista alternativi.'
),
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'L''algoritmo usa il microfono per ascoltarti di nascosto?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Sì, sempre', 'No, è un mito. Usa i tuoi dati comportamentali (click, tempo di visione)', 'Solo se dico "Hey Siri"', 'Dipende dal meteo']), 
    1, 
    'È una leggenda metropolitana. Gli algoritmi sono così bravi a prevedere i tuoi interessi basandosi sui tuoi comportamenti passati che *sembra* ti ascoltino.'
),
(
    '123e4567-e89b-12d3-a456-426614174001', 
    'Qual è il primo passo per "scoppiare" la bolla?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Cancellarsi dai social', 'Seguire pagine con opinioni diverse dalle tue', 'Comprare un nuovo telefono', 'Usare solo la TV']), 
    1, 
    'Seguire fonti diverse e cercare attivamente opinioni opposte costringe l''algoritmo a offrirti una dieta informativa più varia.'
);


-- 2. Missione Media: Confirmation Bias
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'TO', 
    'Il Bias di Conferma', 
    'Come il nostro cervello e gli algoritmi lavorano insieme per ingannarci.', 
    E'# Bias di Conferma\n\nIl nostro cervello ama aver ragione.\n\nCerchiamo inconsciamente informazioni che confermano ciò che crediamo e ignoriamo quelle che ci smentiscono. \n\n**Gli algoritmi sfruttano questa debolezza**: se credi che la terra sia piatta, YouTube ti mostrerà video sulla terra piatta, convincendoti ancora di più.', 
    'medio', 
    '10 min', 
    200, 
    'level_2', 
    'Piemonte', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 2
DELETE FROM public.mission_questions WHERE mission_id = '123e4567-e89b-12d3-a456-426614174002';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'Cos''è il "Confirmation Bias" (Bias di Conferma)?', 
    'multiple_choice', 
    to_jsonb(ARRAY['La tendenza a cercare solo prove a favore delle nostre idee', 'Un errore del computer', 'La conferma di lettura su WhatsApp', 'Un test psicologico']), 
    0, 
    'È un errore cognitivo comune. Se credi in X, noterai solo le prove di X e ignorerai le prove di Y.'
),
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'Perché la polarizzazione politica è aumentata con i social?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Perché la gente è più cattiva', 'Perché i social creano gruppi separati che non si parlano mai', 'È sempre stata così', 'Colpa dei politici']), 
    1, 
    'Vivendo in bolle separate, destra e sinistra (o altri gruppi) smettono di vedere l''umanità e le ragioni degli altri, vedendo solo versioni estreme e caricaturali.'
),
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'Come reagisce l''algoritmo se ti soffermi su una notizia che ti indigna?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Ti chiede scusa', 'Smette di mostrarti cose brutte', 'Te ne mostra altre simili perché l''indignazione genera click', 'Chiude l''app']), 
    2, 
    'La rabbia è l''emozione più virale. I contenuti divisivi generano più engagement, quindi l''algoritmo li premia.'
),
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'Cosa succede se cerchi "Il vaccino fa male" su Google?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Google ti corregge', 'Troverai risultati che confermano la tua ricerca (Bias di Ricerca)', 'Non esce nulla', 'Google si blocca']), 
    1, 
    'I motori di ricerca cercano di darti ciò che chiedi. Se la domanda è tendenziosa ("perché i gatti sono spie aliene"), i risultati tenderanno a confermarlo.'
),
(
    '123e4567-e89b-12d3-a456-426614174002', 
    'Qual è un segnale che sei vittima del Bias di Conferma?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Ti senti confuso', 'Leggi notizie noiose', 'Ti senti sempre intelligente e moralmente superiore a chi la pensa diversamente', 'Hai sonno']), 
    2, 
    'Se tutto ciò che leggi ti fa pensare "Ecco, lo sapevo, gli altri sono idioti", probabilmente sei dentro una bolla cognitiva.'
);


-- 3. Missione Difficile: Hackerare l'Algoritmo
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'TO', 
    'Uscire dalla Matrix', 
    'Strategie pratiche per riprendere il controllo del tuo feed e delle tue informazioni.', 
    E'# Riprendi il Controllo\n\nNon subire passivamente il feed.\n\n### Strategie:\n1. **Navigazione in Incognito**: Per fare ricerche senza influenzare lo storico.\n2. **Like Tattici**: Metti like a cose diverse (scienza, arte, opinioni opposte) per confondere il profilo.\n3. **Cronologia**: Disattiva la cronologia delle posizioni e delle ricerche nelle impostazioni Google.', 
    'difficile', 
    '15 min', 
    500, 
    'level_3', 
    'Piemonte', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 3
DELETE FROM public.mission_questions WHERE mission_id = '123e4567-e89b-12d3-a456-426614174003';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'A cosa serve la modalità "Incognito" o "Anonima"?', 
    'multiple_choice', 
    to_jsonb(ARRAY['A diventare invisibili alla polizia', 'A non salvare cookie e cronologia locale, evitando di influenzare i suggerimenti futuri', 'A proteggersi dai virus', 'A navigare nel Dark Web']), 
    1, 
    'È ottima per cercare argomenti neutri senza che l''algoritmo inizi a bombardarti di pubblicità o video correlati per settimane.'
),
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'Come puoi "addestrare" il tuo algoritmo a essere migliore?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Non si può', 'Cliccando "Non mi interessa" su contenuti spazzatura e cercando attivamente contenuti di qualità', 'Insultando nei commenti', 'Smettendo di seguirlo']), 
    1, 
    'L''algoritmo impara dai tuoi feedback. Usa i tre puntini "..." e seleziona "Non mi interessa" per pulire il tuo feed.'
),
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'Cos''è il "Lateral Reading" (Lettura Laterale)?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Leggere stesi sul fianco', 'Aprire altre schede per verificare la fonte *mentre* leggi l''articolo', 'Leggere solo i titoli', 'Leggere da destra a sinistra']), 
    1, 
    'I fact-checker professionisti non leggono verticalmente. Appena vedono un nome o un fatto, aprono una nuova scheda per verificare "Chi è questa persona?" o "Cosa dicono altri?".'
),
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'Perché diversificare le fonti di informazione è cruciale?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Per confondersi le idee', 'Per avere una visione più completa e ridurre il rischio di manipolazione', 'Per perdere tempo', 'Perché lo dice la legge']), 
    1, 
    'Nessuna fonte è perfetta. Incrociando diverse prospettive (anche internazionali), puoi avvicinarti di più alla verità dei fatti.'
),
(
    '123e4567-e89b-12d3-a456-426614174003', 
    'Se un servizio online è GRATIS, qual è il prodotto?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Non c''è prodotto, sono gentili', 'Tu (i tuoi dati e la tua attenzione)', 'Il computer', 'La connessione internet']), 
    1, 
    'Se non paghi per il prodotto, tu sei il prodotto. I tuoi dati vengono venduti agli inserzionisti per targettizzarti con precisione.'
);
