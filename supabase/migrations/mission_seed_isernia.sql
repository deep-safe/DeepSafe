-- Mission Seed for Isernia (IS) - Fake News & Fact-Checking

-- 1. Missione Semplice: Riconosci la Satira e il Clickbait
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    '7bd48873-1256-46bf-8516-72433060a80e', 
    'IS', 
    'Satira o Fake News?', 
    'Impara a distinguere tra notizie false dannose e semplice satira o titoli acchiappa-clic.', 
    E'# Fake News Base\n\nNon tutto ciò che leggi online è vero.\n\n### 3 Regole d''Oro:\n1. **Controlla la fonte**: "Il Fatto Quotidaino" non è "Il Fatto Quotidiano".\n2. **Leggi oltre il titolo**: Spesso il titolo è esagerato (Clickbait) ma l''articolo spiega la verità.\n3. **Cerca conferme**: Se lo dice solo un sito sconosciuto, probabilmente è falso.', 
    'semplice', 
    '5 min', 
    100, 
    'level_1', 
    'Molise', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 1
DELETE FROM public.mission_questions WHERE mission_id = '7bd48873-1256-46bf-8516-72433060a80e';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    '7bd48873-1256-46bf-8516-72433060a80e', 
    'Un sito chiamato "Lercio.it" pubblica una notizia assurda. Di cosa si tratta probabilmente?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Una notizia vera ma incredibile', 'Satira (scherzo)', 'Un errore di stampa', 'Hacking']), 
    1, 
    'Lercio è un famoso sito di satira. Le sue notizie sono inventate per far ridere, non per ingannare (anche se molti ci cascano!).'
),
(
    '7bd48873-1256-46bf-8516-72433060a80e', 
    'Cos''è il "Clickbait"?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Un virus che si scarica cliccando', 'Un titolo sensazionalistico per attirare click', 'Un tipo di password', 'Un software antivirus']), 
    1, 
    'Il Clickbait (esca per click) usa titoli esagerati o incompleti ("Non crederai a cosa è successo...") per spingerti a visitare la pagina per guadagnare con la pubblicità.'
),
(
    '7bd48873-1256-46bf-8516-72433060a80e', 
    'Se leggi "CONDIVIDI PRIMA CHE LO CENSURINO!", cosa dovresti fare?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Condividere subito per sicurezza', 'Diffidare e verificare la notizia', 'Stampare la pagina', 'Niente']), 
    1, 
    'Gli appelli all''emozione e all''urgenza ("Censura!", "Vergogna!") sono segnali tipici delle Fake News progettate per diventare virali senza verifica.'
);


-- 2. Missione Media: Verifica delle Fonti
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a', 
    'IS', 
    'Investigatore di Fonti', 
    'Analizza URL, autori e date per smascherare le bufale più sofisticate.', 
    E'# Fact-Checking\n\nDiventa un detective digitale.\n\nQuando trovi una notizia sospetta:\n- **Chi l''ha scritta?** L''autore esiste davvero?\n- **Quando?** Spesso vecchie notizie vengono riciclate come nuove.\n- **Dove?** Controlla l''URL. `repubblica-news.com` NON è `repubblica.it`.', 
    'medio', 
    '10 min', 
    200, 
    'level_2', 
    'Molise', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 2
DELETE FROM public.mission_questions WHERE mission_id = 'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a', 
    'Quale di questi URL è probabilmente una trappola o una fake news?', 
    'multiple_choice', 
    to_jsonb(ARRAY['www.corriere.it', 'www.ilsole24ore.com', 'www.corriere-della-sera-news24.com', 'www.ansa.it']), 
    2, 
    'I siti affidabili usano domini brevi e ufficiali. I siti fake aggiungono spesso parole extra (news24, live, blog) o usano domini diversi (.net invece di .it) per confondere.'
),
(
    'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a', 
    'Trovi una foto scioccante di un''alluvione a Isernia. Come verifichi se è vera?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Guardo quanti like ha', 'Faccio una Ricerca Immagini Inversa (Reverse Image Search)', 'Leggo i commenti', 'Mi fido dell''amico che l''ha postata']), 
    1, 
    'La Ricerca Inversa (su Google Images o TinEye) ti permette di vedere se la foto è vecchia o se proviene da un altro luogo/evento.'
),
(
    'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a', 
    'L''articolo cita "Un famoso scienziato tedesco" senza fare nome. È affidabile?', 
    'multiple_choice', 
    to_jsonb(ARRAY['No, le fonti affidabili citano nomi e dati verificabili', 'Sì, se è tedesco è serio', 'Sì, per proteggere la privacy', 'Dipende dal sito']), 
    0, 
    'L''appello all''autorità anonima ("scienziati dicono", "fonti interne") è una tecnica classica per dare credibilità a bugie. Una notizia vera cita Chi, Dove e Quando.'
),
(
    'a2c5a1d8-9f3b-4e7c-8b1a-5d6e9f0c3b2a', 
    'Perché è importante controllare la data di un articolo condiviso sui social?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Per fare gli auguri all''autore', 'Perché le notizie vecchie spesso vengono ricondivise fuori contesto per creare rabbia', 'Per sapere se è mattina o sera', 'Non è importante']), 
    1, 
    'Le "Fake News Zombie" sono notizie vere ma vecchie di anni, ripubblicate oggi per sembrare attuali e scatenare indignazione immotivata.'
);


-- 3. Missione Difficile: Deepfakes e Manipolazione AI
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES 
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'IS', 
    'Inganno dell''Intelligenza Artificiale', 
    'Riconosci Deepfake audio/video e testi generati dall''AI per manipolare l''opinione pubblica.', 
    E'# AI e Disinformazione\n\nLa tecnologia ora può creare falsi perfetti.\n\n### Deepfakes\nVideo o audio dove il volto/voce di una persona viene sovrapposto a un altro. \n\n**Segnali di allerta:**\n- Movimento delle labbra innaturale.\n- Battito di ciglia assente o strano.\n- Audio "metallico" o monotono.', 
    'difficile', 
    '15 min', 
    500, 
    'level_3', 
    'Molise', 
    NOW()
)
ON CONFLICT (id) DO UPDATE 
SET title = EXCLUDED.title, description = EXCLUDED.description, content = EXCLUDED.content, nc_reward = EXCLUDED.nc_reward;

-- Domande Missione 3
DELETE FROM public.mission_questions WHERE mission_id = 'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b';
INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation)
VALUES
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'Cos''è un "Deepfake"?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Un video molto profondo e filosofico', 'Un video manipolato dall''AI che fa dire o fare cose false a persone reali', 'Un fake account sui social', 'Un virus del deep web']), 
    1, 
    'I Deepfakes usano l''apprendimento automatico (Deep Learning) per sostituire volti e voci con estremo realismo, creando prove false di eventi mai accaduti.'
),
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'In un video sospetto di un politico, cosa dovresti osservare attentamente?', 
    'multiple_choice', 
    to_jsonb(ARRAY['La cravatta', 'I bordi del viso, il battito delle palpebre e la sincronia labiale', 'Lo sfondo', 'Se sta sorridendo']), 
    1, 
    'I Deepfake spesso falliscono nei dettagli fini: bordi sfocati intorno al viso, occhi che non sbattono mai o movimenti della bocca che non corrispondono perfettamente all''audio.'
),
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'Ricevi un audio su WhatsApp dalla "voce" del Sindaco che annuncia un''emergenza segreta. Cosa fai?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Lo inoltro a tutti i gruppi', 'Vado sul sito ufficiale del Comune per verificare', 'Mi chiudo in casa', 'Rispondo all''audio chiedendo dettagli']), 
    1, 
    'L''audio cloning (clonazione vocale) è facile oggi. Non fidarti mai di catene WhatsApp non verificate. Controlla sempre i canali ufficiali (Sito, Pagina FB verificata).'
),
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'Perché i bot usano l''AI per generare commenti falsi?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Per sembrare intelligenti', 'Per creare l''illusione che "tutti la pensino così" (Astroturfing)', 'Per testare l''algoritmo', 'Per fare amicizia']), 
    1, 
    'L''Astroturfing è la creazione di un falso consenso popolare. Migliaia di bot generano commenti simili per far credere che un''idea (spesso falsa o d''odio) sia supportata dalla maggioranza.'
),
(
    'e5f6a1b2-c3d4-4e5f-6a7b-8c9d0e1f2a3b', 
    'Qual è la difesa migliore contro la disinformazione AI?', 
    'multiple_choice', 
    to_jsonb(ARRAY['Non usare internet', 'Pensiero critico e verifica incrociata (Lateral Reading)', 'Installare un antivirus potente', 'Segnalare tutto']), 
    1, 
    'Nessun software è perfetto. La tua mente critica è l''arma migliore: chiediti sempre "Chi lo dice?", "Quali prove porta?" e "Cosa dicono altre fonti indipendenti?".'
);
