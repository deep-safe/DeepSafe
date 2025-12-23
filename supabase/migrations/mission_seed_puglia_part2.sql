-- Mission Seed for Puglia (Part 2)
-- Region: Puglia (HARD / TRICKY EDITION)
-- Provinces: Foggia (FG), Brindisi (BR), Barletta-Andria-Trani (BT)

-- =================================================================================================
-- FOGGIA (FG) - DDoS & Amplification ("Il Granaio")
-- =================================================================================================

-- Mission 1: Amplification Attack - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000010', 'FG', 'Moltiplicatore di Forza',
    'Come abbattere un castello con un sassolino.',
    E'# Amplification DDoS\n\nL''hacker sfrutta protocolli UDP mal configurati (NTP, DNS).\n1.  L''hacker invia una richiesta piccola (1 byte) a un server pubblico, falsificando il mittente (IP della vittima).\n2.  Il server risponde alla vittima con una risposta enorme (500 byte).\n\nCon poca banda, l''hacker inonda la vittima di traffico spazzatura riflesso.',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000010', 'Perché gli attacchi di amplificazione usano UDP e non TCP?', 'multiple_choice', '["UDP è più veloce", "Perché UDP è connectionless (non c''è handshake). È facile falsificare l''IP mittente (Spoofing). Con TCP dovresti completare la connessione, impossibile se spoofi l''IP", "UDP è giallo", "Per errore"]', 1, 'Lo spoofing dell''IP sorgente è la chiave della "Reflection".', NULL),
('ba000100-0000-0000-0000-000000000010', 'Come si mitiga un attacco NTP Amplification?', 'multiple_choice', '["Spegnendo il server", "Configurando i server NTP per non rispondere alle query ''monlist'' pubbliche e usando Rate Limiting", "Cambiando l''ora", "Usando TCP"]', 1, 'È una misconfiguration nota del demone NTP.', NULL),
('ba000100-0000-0000-0000-000000000010', 'Se sei la VITTIMA di un attacco da 100Gbps, il firewall ti salva?', 'multiple_choice', '["Sì", "No, la tua linea (es. 1Gbps) è satura A MONTE del firewall. Il traffico buono non arriva nemmeno. Serve un servizio Anti-DDoS in cloud (Scrubbing Center)", "Sì, se è buono", "No, devi staccare il cavo"]', 1, 'Il DDoS volumetrico si combatte con la banda, non con la CPU.', NULL),
('ba000100-0000-0000-0000-000000000010', 'BCP 38 (Ingress Filtering) impedisce lo spoofing?', 'true_false', '["Vero", "Falso"]', 0, 'Sì. Se tutti gli ISP controllassero che i pacchetti in uscita dalla loro rete hanno IP sorgenti della loro rete, lo spoofing sarebbe impossibile.', NULL),
('ba000100-0000-0000-0000-000000000010', 'Tor Browser protegge la tua identità instradando il traffico:', 'multiple_choice', '["Direttamente al server", "Attraverso tre nodi casuali (Guard, Middle, Exit) cifrati a cipolla", "In incognito", "Via satellite"]', 1, 'Peeling the onion.', NULL);


-- Mission 2: Slowloris - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000011', 'FG', 'La Tortura della Goccia',
    'Non serve urlare per farsi sentire.',
    E'# Slowloris (Low & Slow)\n\nInvece di inondare il server, l''hacker apre 1000 connessioni simultanee.\nInvia un header HTTP parziale (`Host: ...`) e poi... aspetta.\nOgni 10 secondi manda un carattere per tenere la connessione viva.\n\nIl server web (Apache) tiene i thread aperti aspettando la fine della richiesta, finché finisce la memoria. Il sito va giù con pochissima banda.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000011', 'Come si ferma Slowloris?', 'multiple_choice', '["Aumentando la RAM", "Usando server asincroni (Nginx) che gestiscono migliaia di connessioni senza thread dedicati, o limitando il tempo di attesa per gli header incompleti", "Riavviando", "Bloccando l''IP"]', 1, 'È un attacco all''architettura del server web, non alla banda.', NULL),
('ba000100-0000-0000-0000-000000000011', 'Un firewall standard rileva Slowloris?', 'multiple_choice', '["Sì", "Spesso no, perché il traffico sembra legittimo (pochi pacchetti lenti). Serve un WAF o un modulo Anti-DDoS applicativo", "Sì, se costoso", "No, mai"]', 1, 'Non c''è "flood" da rilevare.', NULL),
('ba000100-0000-0000-0000-000000000011', 'Slowloris funziona su UDP?', 'multiple_choice', '["Sì", "No, richiede una connessione TCP stabilita da tenere appesa", "Forse", "Sì"]', 1, 'È specifico per TCP/HTTP.', NULL),
('ba000100-0000-0000-0000-000000000011', 'R.U.D.Y. (R-U-Dead-Yet?) è simile a Slowloris?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, ma agisce sulle richieste POST (invio form) invece degli header. Invia il corpo del messaggio 1 byte alla volta.', NULL),
('ba000100-0000-0000-0000-000000000011', 'Tor Browser protegge la tua identità instradando il traffico:', 'multiple_choice', '["Direttamente al server", "Attraverso tre nodi casuali (Guard, Middle, Exit) cifrati a cipolla", "In incognito", "Via satellite"]', 1, 'Peeling the onion.', NULL);


-- Mission 3: CDN & Scrubbing - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000012', 'FG', 'Maschera Caduta',
    'Nascondersi dietro Cloudflare serve a poco se lasci la porta sul retro aperta.',
    E'# Origin IP Leak\n\nProteggi il sito con una CDN (es. Cloudflare). Il mondo vede l''IP di Cloudflare, che assorbe gli attacchi.\n\nMA... se l''hacker scopre il tuo VERO IP (Origin IP) scansionando la rete o leggendo vecchi record DNS (DNS History), può attaccare direttamente quell''IP, bypassando completamente la protezione CDN.',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000012', 'Come proteggere l''Origin IP quando usi una CDN?', 'multiple_choice', '["Pregare", "Configurare il firewall del server Origine per accettare traffico SOLO dagli IP della CDN (Allowlist). Tutto il resto deve essere DROP", "Nascondere il dominio", "Cambiare porta"]', 1, 'Se l''IP risponde a tutti, la CDN è aggirabile.', NULL),
('ba000100-0000-0000-0000-000000000012', 'Un botnet IoT (Mirai) può attaccare un sito protetto da CDN?', 'multiple_choice', '["No", "Sì, può lanciare un attacco HTTP Flood (Livello 7) che la CDN deve filtrare (es. Challenge JS/Captcha). Se il flood è immenso, costa soldi o rallenta", "Solo se il sito è statico", "Boh"]', 1, 'Gli attacchi L7 sono costosi da mitigare.', NULL),
('ba000100-0000-0000-0000-000000000012', 'Cosa succede se il server invia una mail in uscita?', 'multiple_choice', '["Nulla", "L''header della mail rivela l''IP sorgente del server! Un errore classico per leakare l''Origin IP. Bisogna usare relay esterni (es. SendGrid)", "Arriva la mail", "Spam"]', 1, 'Le mail di notifica "Benvenuto Utente" spesso tradiscono l''IP reale.', NULL),
('ba000100-0000-0000-0000-000000000012', 'I record MX (Mail) possono rivelare l''IP del server web?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, se Mail e Web sono ospitati sullo stesso server fisico (pratica comune negli hosting economici).', NULL),
('ba000100-0000-0000-0000-000000000012', 'In ambito Maschera Caduta (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- BRINDISI (BR) - VPN & Eccezioni ("Il Porto Sicuro")
-- =================================================================================================

-- Mission 1: Split Tunneling - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000013', 'BR', 'Il Tunnel Diviso',
    'Azienda o YouTube? Chi decide?',
    E'# Split Tunneling\n\n*   **Full Tunnel:** Tutto il traffico del PC passa nella VPN aziendale. Sicuro, ma lento (Youtube intasa la rete dell''ufficio).\n*   **Split Tunnel:** Solo il traffico verso server interni passa nella VPN. Il resto va diretto su Internet.\n\n**Rischio:** Se l''utente prende un virus su Internet (canale diretto), il virus può saltare dentro la VPN (canale aziendale) bypassando le difese perimetrali.',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000013', 'Perché le aziende usano lo Split Tunneling se è rischioso?', 'multiple_choice', '["Per risparmiare banda sulla VPN e migliorare la velocità dell''utente (User Experience), specialmente per Cloud (Office 365, Zoom)", "Perché non sanno configurarlo", "Per errore", "Per spiare"]', 0, 'Il bilanciamento Performance/Security è eterno.', NULL),
('ba000100-0000-0000-0000-000000000013', 'Se usi una VPN pubblica "No Logs", sei sicuro che non ti traccino?', 'multiple_choice', '["Sì", "No. Devi fidarti ciecamente del provider VPN. Tecnicamente possono vedere e loggare tutto", "Sì se paghi", "Solo con Bitcoin"]', 1, 'La VPN sposta solo la fiducia dall''ISP al provider VPN.', NULL),
('ba000100-0000-0000-0000-000000000013', 'Una VPN protegge dai malware scaricati?', 'multiple_choice', '["Sì", "No. La VPN cifra il trasporto, non disinfetta il file. Se scarichi un virus HTTPS, arriva cifrato e ti infetta", "Sì, ha l''antivirus", "Forse"]', 1, 'La VPN è un tubo, non un filtro (a meno che non sia una Secure Web Gateway).', NULL),
('ba000100-0000-0000-0000-000000000013', 'Il protocollo WireGuard è più veloce di OpenVPN?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, è molto più leggero e moderno ("lean code base").', NULL),
('ba000100-0000-0000-0000-000000000013', 'Approfondimento su: TUNNEL. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 2: IPSec vs SSL VPN - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000014', 'BR', 'Client o Browser?',
    'Due modi per entrare da remoto.',
    E'# IPSec vs SSL (Clientless)\n\n*   **IPSec (IKEv2):** Connette il dispositivo alla rete (Livello 3). Richiede client o config OS. Accesso totale.\n*   **SSL VPN (Clientless/Portal):** Accedi via Browser a un portale web. Più facile, ma limitato alle app web.\n\nAttenzione: Le vulnerabilità nei portali SSL VPN (es. Pulse, Fortinet) sono la prima causa di infezione Ransomware nelle aziende.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000014', 'Perché i Ransomware amano le VPN SSL?', 'multiple_choice', '["Sono lente", "Perché spesso i portali VPN sono esposti su Internet senza MFA o con vulnerabilità non patchate (CVE). Una volta dentro, sei nella rete interna", "Sono vecchie", "Usano Java"]', 1, 'Il concentratore VPN è il bersaglio più prezioso.', NULL),
('ba000100-0000-0000-0000-000000000014', 'IPSec ESP (Encapsulating Security Payload) cifra tutto il pacchetto?', 'multiple_choice', '["No, solo l''header", "Sì, nel modo Tunnel ipsec cifra anche l''header IP originale (creandone uno nuovo esterno). Nel modo Transport cifra solo il payload", "Solo la password", "No"]', 1, 'Tunnel Mode è quello usato per le VPN Site-to-Site.', NULL),
('ba000100-0000-0000-0000-000000000014', 'È necessario installare un client per la VPN SSL?', 'multiple_choice', '["Sì", "Spesso no, basta il browser (Portal Mode). Ma per accesso di rete completo (Tunnel Mode) serve un agent leggero", "No, mai", "Dipende da Windows"]', 1, 'La facilità d''uso è il vantaggio di SSL.', NULL),
('ba000100-0000-0000-0000-000000000014', 'La "VPN Always-On" impedisce all''utente di disconnettersi.', 'true_false', '["Vero", "Falso"]', 0, 'Forza il traffico attraverso l''azienda sempre, migliorando la sicurezza dei lavoratori remoti.', NULL),
('ba000100-0000-0000-0000-000000000014', 'Approfondimento su: HTTPS. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Kill Switch - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000015', 'BR', 'Caduta nel Vuoto',
    'Se il tunnel crolla, i dati volano via?',
    E'# VPN Kill Switch\n\nStai scaricando un file segreto o usando BitTorrent (legalmente).\nLa VPN cade per un secondo.\n\n*   **Senza Kill Switch:** Il PC si riconnette automaticamente a Internet "normale" (in chiaro) e continua il download. Il tuo IP reale viene esposto!\n*   **Con Kill Switch:** Il PC blocca TUTTO il traffico di rete finché la VPN non torna su.',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000015', 'Come si implementa un Kill Switch robusto?', 'multiple_choice', '["Via software VPN", "Via regola Firewall OS: ''Block all connections if Interface != VPN''. È più sicuro del Kill Switch software dell''App che potrebbe crashare", "Staccando il cavo", "Non si può"]', 1, 'Il System-level Kill Switch è infallibile.', NULL),
('ba000100-0000-0000-0000-000000000015', 'DNS Leak durante la riconnessione VPN è pericoloso?', 'multiple_choice', '["Sì, rivela i siti che stai visitando all''ISP mentre la VPN negozia le chiavi", "No, tanto è un attimo", "Solo se piove", "No"]', 0, 'È un momento critico di esposizione.', NULL),
('ba000100-0000-0000-0000-000000000015', 'Tor Browser ha bisogno di una VPN con Kill Switch?', 'multiple_choice', '["Sì", "Non strettamente. Tor gestisce il routing in modo diverso, ma una VPN aggiunge un layer di difesa (Tor over VPN) per nascondere l''uso di Tor all''ISP", "No è vietato", "Fa conflitto"]', 1, 'Usare Tor senza VPN segnala all''ISP che "stai usando Tor" (sospetto).', NULL),
('ba000100-0000-0000-0000-000000000015', 'WebRTC nel browser può rivelare il tuo IP reale anche sotto VPN?', 'true_false', '["Vero", "Falso"]', 0, 'Verissimo. È una nota vulnerabilità (STUN requests). Va disabilitato.', NULL),
('ba000100-0000-0000-0000-000000000015', 'In ambito Caduta nel Vuoto (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- =================================================================================================
-- BARLETTA-ANDRIA-TRANI (BT) - Web Application Firewall (WAF) ("La Nuova Provincia")
-- =================================================================================================

-- Mission 1: SQL Injection Block - Facile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000016', 'BT', 'Il Filtro Intelligente',
    'Capire la lingua degli hacker.',
    E'# WAF vs Firewall\n\nUn Firewall normale (L3/L4) vede solo IP e Porte. Se la porta 80 è aperta, fa passare tutto.\nUn **WAF (Web Application Firewall)** (L7) legge il contenuto HTTP.\n\nSe vede qualcuno scrivere `'' OR 1=1 --` in un campo di login (tentativo di SQL Injection), lo blocca, anche se la porta 80 è aperta.',
    'semplice', '5 min', 50, 'level_1', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000016', 'Cos''è il "WAF Bypass" tramite Encoding?', 'multiple_choice', '["Scrivere veloce", "Codificare il payload malevolo (es. URL Encode `%27`, Double URL Encode, Unicode) sperando che il WAF non lo decodifichi ma il database sì", "Usare VPN", "Pagare"]', 1, 'Se il WAF ha regole deboli, la codifica lo inganna.', NULL),
('ba000100-0000-0000-0000-000000000016', 'I WAF basati su Regex (Espressioni Regolari) sono perfetti?', 'multiple_choice', '["Sì", "No, sono propensi a falsi positivi e bypassabili con sintassi SQL creativa che non matcha la regola esatta", "Sì, Google li usa", "No, sono lenti"]', 1, 'Le regole statiche sono fragili. Servono modelli semantici.', NULL),
('ba000100-0000-0000-0000-000000000016', 'Qual è la differenza tra lista "Positive Security" e "Negative Security"?', 'multiple_choice', '["L''umore", "La Negativa blocca il male noto (Blacklist). La Positiva permette SOLO il bene noto (Whitelist, es. ''questo campo accetta solo numeri'')", "Il costo", "Nessuna"]', 1, 'La Positive Security è molto più sicura ma difficile da mantenere.', NULL),
('ba000100-0000-0000-0000-000000000016', 'ModSecurity è un famoso WAF Open Source.', 'true_false', '["Vero", "Falso"]', 0, 'Lo standard de facto per i WAF self-hosted.', NULL),
('ba000100-0000-0000-0000-000000000016', 'In ambito Il Filtro Intelligente (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);


-- Mission 2: Virtual Patching - Medio
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000017', 'BT', 'Il Cerotto Digitale',
    'Riparare senza toccare il codice.',
    E'# Virtual Patching\n\nScopri una falla critica nel tuo sito e-commerce.\nPer riparare il codice PHP servono 2 settimane di sviluppo e test.\nNel frattempo sei vulnerabile.\n\n**Soluzione:** Configuri il WAF per intercettare e bloccare specificamente quel tipo di attacco PRIMA che arrivi al sito.\nHai "patchato" virtualmente la falla in 5 minuti.',
    'medio', '10 min', 75, 'level_2', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000017', 'La Virtual Patch è una soluzione definitiva?', 'multiple_choice', '["Sì", "No, è una misura temporanea (Mitigation). Il codice sottostante resta rotto e un hacker astuto potrebbe trovare un modo per aggirare il WAF", "Sì, risparmi i programmatori", "Forse"]', 1, 'Non sostituisce il Secure Coding.', NULL),
('ba000100-0000-0000-0000-000000000017', 'Perché preferire la Virtual Patch al patching immediato del codice?', 'multiple_choice', '["Pigrizia", "Per guadagnare tempo. Patchare il codice di fretta in produzione causa spesso nuovi bug o downtime", "Perché non si sa programmare", "Per risparmiare"]', 1, 'Time-to-fix immediato vs Time-to-develop.', NULL),
('ba000100-0000-0000-0000-000000000017', 'WAF in modalità "Learning" cosa fa?', 'multiple_choice', '["Studia", "Osserva il traffico normale per apprendere cosa è lecito, costruendo automaticamente la Whitelist", "Dorme", "Ruba dati"]', 1, 'Utile per creare policy positive.', NULL),
('ba000100-0000-0000-0000-000000000017', 'Log4Shell poteva essere bloccato con una Virtual Patch?', 'true_false', '["Vero", "Falso"]', 0, 'Sì, bloccando la stringa `${jndi:` negli header, e i WAF lo hanno fatto subito.', NULL),
('ba000100-0000-0000-0000-000000000017', 'Approfondimento su: TESTA. Qual è il rischio maggiore?', 'multiple_choice', '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]', 3, 'La sicurezza è un processo, non un prodotto.', NULL);


-- Mission 3: Rate Limiting & Bot - Difficile
INSERT INTO public.missions (id, province_id, title, description, content, level, estimated_time, nc_reward, tier, region, created_at)
VALUES (
    'ba000100-0000-0000-0000-000000000018', 'BT', 'Semaforo Rosso',
    'Troppe richieste? Fermati.',
    E'# Rate Limiting\n\nProtegge da Brute Force e Scraping.\n"Massimo 5 login al minuto per IP".\n\n**La sfida:** I bot moderni sono "Low & Slow" e distribuiti.\nSe hai una Botnet di 10.000 IP, e ognuno fa 1 richiesta all''ora, il Rate Limiting classico basato su IP non scatta, ma tu ricevi comunque 10.000 attacchi.',
    'difficile', '15 min', 150, 'level_3', 'Puglia', NOW()
) ON CONFLICT (id) DO UPDATE SET title=EXCLUDED.title, content=EXCLUDED.content, nc_reward=EXCLUDED.nc_reward, level=EXCLUDED.level;

INSERT INTO public.mission_questions (mission_id, text, type, options, correct_answer, explanation, image_url) VALUES
('ba000100-0000-0000-0000-000000000018', 'Come si rileva una Botnet distribuita che aggira il rate limiting IP?', 'multiple_choice', '["Impossibile", "Con il Device Fingerprinting (Canvas, Font, Comportamento mouse). Capisci che 1000 IP diversi sono in realtà lo stesso software bot", "Chiudendo il sito", "Con il Captcha sempre"]', 1, 'L''IP non è più un identificativo affidabile per l''utente.', NULL),
('ba000100-0000-0000-0000-000000000018', 'Cos''è il "Credential Stuffing"?', 'multiple_choice', '["Un tacchino ripieno", "Provare username/password rubati da ALTRI siti (Data Breach) per vedere se funzionano sul tuo. I bot lo fanno su scala massiva", "Un errore", "Un gioco"]', 1, 'Il riutilizzo delle password da parte degli utenti rende questo attacco micidiale.', NULL),
('ba000100-0000-0000-0000-000000000018', 'Un "Invisible Captcha" (reCAPTCHA v3) disturba l''utente?', 'multiple_choice', '["Sì", "No, analizza il comportamento (movimento mouse, click) in background e blocca solo se sospetto (punteggio basso)", "Sì, chiede i semafori", "No, non funziona"]', 1, 'Migliora la UX rispetto a "Seleziona i semafori".', NULL),
('ba000100-0000-0000-0000-000000000018', 'Bloccare gli IP TOR è una buona pratica di Rate Limiting?', 'true_false', '["Vero", "Falso"]', 0, 'Spesso sì, perché molto traffico malevolo e di scraping automatico proviene dagli Exit Node di Tor.', NULL),
('ba000100-0000-0000-0000-000000000018', 'In ambito Semaforo Rosso (Cybersecurity), qual è la regola d''oro?', 'multiple_choice', '["Fidarsi di tutti", "Zero Trust (Mai fidarsi, verificare sempre)", "Usare password 123456", "Non usare il computer"]', 1, 'La fiducia implicita è la vulnerabilità principale.', NULL);
