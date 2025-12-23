import os
import re
import glob
import json

# =============================================================================
# REPLACEMENT CONTENT LIBRARY
# =============================================================================

def get_new_question(region, province, mission_title, old_text):
    """
    Returns a dict with: text, options (json string), correct_answer (int), explanation, type
    """
    context_key = f"{region}-{province}-{mission_title}".upper()
    
    # Defaults
    q_type = 'multiple_choice'
    
    # -------------------------------------------------------------------------
    # MOLISE
    # -------------------------------------------------------------------------
    if "CACCIATORI" in context_key:
        return {
            "text": "Quale di queste caratteristiche è tipica di un titolo 'Clickbait'?",
            "options": '["Spiega chiaramente il contenuto", "Usa termini tecnici e precisi", "Usa frasi incomplete o sensazionalistiche (es. ''Non crederai...'')", "Cita sempre le fonti nel titolo"]',
            "correct_answer": 2,
            "explanation": "Il clickbait usa la curiosità (curiosity gap) o lo shock per costringerti a cliccare, spesso nascondendo la vera notizia."
        }
    if "CHI STA PARLANDO" in context_key:
        return {
            "text": "Se un articolo è firmato solo come 'Admin' o 'Redazione', cosa dovresti fare?",
            "options": '["Fidarti, è lo standard", "Essere scettico e cercare chi c''è dietro il sito", "Condividerlo subito", "Contattare l''admin per complimentarti"]',
            "correct_answer": 1,
            "explanation": "L'anonimato di chi scrive (assenza di una firma reale) è uno dei primi segnali di allarme per le fake news."
        }
    if "CONTESTO" in context_key:
        return {
            "text": "Cosa si intende per 'Cherry Picking' nelle notizie manipolate?",
            "options": '["Scegliere le ciliegie migliori", "Selezionare solo i dati che confermano la propria tesi ignorando gli altri", "Usare grafici colorati", "Scrivere notizie sulla frutta"]',
            "correct_answer": 1,
            "explanation": "È una fallacia logica comune: mostrare solo una parte della verità per sostenere una bugia."
        }
        
    # -------------------------------------------------------------------------
    # BASILICATA (CRYPTO)
    # -------------------------------------------------------------------------
    if "PAROLE DI PIETRA" in context_key:
        return {
            "text": "Perché NON dovresti mai salvare la tua Seed Phrase su un cloud online?",
            "options": '["Perché occupano spazio", "Perché se il cloud viene hackerato, perdono i tuoi fondi", "Perché Google non vuole", "Perché si scolorisce"]',
            "correct_answer": 1,
            "explanation": "La Seed Phrase deve restare offline (carta, metallo). Se è online, è potenzialmente accessibile agli hacker."
        }
    if "FIRMA ALLA CIECA" in context_key:
        return {
            "text": "Cosa significa 'SetApprovalForAll' in uno Smart Contract?",
            "options": '["Approvi una singola transazione", "Dai il permesso al contratto di spendere TUTTI i tuoi token di quel tipo", "È un saluto formale", "Blocchi il tuo wallet"]',
            "correct_answer": 1,
            "explanation": "È un permesso molto pericoloso. Se il contratto è malevolo, può svuotarti il wallet anche in futuro senza chiederti più nulla."
        }
    if "POLVERE TRACCIANTE" in context_key: # Dusting attack
        return {
            "text": "Ti trovi dei token sconosciuti nel wallet. Cosa fai?",
            "options": '["Li vendo subito per guadagnare", "Li ignoro e non li tocco", "Li invio a un amico", "Scrivo al supporto della coin"]',
            "correct_answer": 1,
            "explanation": "Spesso è un 'Dusting Attack'. Se li muovi, de-anonimizzi il tuo wallet collegandolo ad altri address."
        }
    if "CODICE SCOLPITO" in context_key:
        return {
            "text": "Uno Smart Contract una volta deplorato sulla blockchain può essere modificato?",
            "options": '["Sì, sempre", "No, è immutabile (salvo specifici casi di proxy)", "Sì, se paghi abbastanza", "Solo nei giorni feriali"]',
            "correct_answer": 1,
            "explanation": "L'immutabilità è una caratteristica chiave ma anche un rischio: i bug non possono essere 'patchati' facilmente."
        }
    if "MILIONARIO" in context_key: # Flash Loan
        return {
            "text": "Cos'è un 'Flash Loan'?",
            "options": '["Un prestito che dura anni", "Un prestito senza garanzie che deve essere restituito nella stessa transazione", "Un prestito per comprare macchine veloci", "Un errore della banca"]',
            "correct_answer": 1,
            "explanation": "È uno strumento potente della DeFi, usato spesso per arbitraggio ma anche per attacchi complessi ai protocolli."
        }
    if "PANINO" in context_key: # Sandwich Attack
        return {
            "text": "Come funziona un 'Sandwich Attack' in DeFi?",
            "options": '["Ti offrono un pranzo gratis", "Un bot compra prima di te (alzando il prezzo) e vende subito dopo di te (profitto)", "È un attacco DDOS", "Rubano i cookie"]',
            "correct_answer": 1,
            "explanation": "È una forma di Front-Running. L'attaccante vede la tua transazione e la 'abbraccia' per estrarre valore a tue spese."
        }

    # -------------------------------------------------------------------------
    # SARDEGNA (HARDWARE / PHYSICAL)
    # -------------------------------------------------------------------------
    if "PAPERA" in context_key: # Rubber Ducky
        return {
            "text": "Cos'è una 'Rubber Ducky' in ambito hacker?",
            "options": '["Una papera di gomma per il bagno", "Una chiavetta USB che si finge una tastiera e digita comandi velocissimi", "Un virus acquatico", "Un tool di difesa"]',
            "correct_answer": 1,
            "explanation": "Il computer si fida ciecamente delle tastiere (HID). La Ducky ne approfitta per eseguire script in pochi secondi."
        }
    if "SUCCO MORTALE" in context_key: # Juice Jacking
        return {
            "text": "Cos'è il 'Juice Jacking'?",
            "options": '["Bere troppi succhi", "Rubare dati o infettare un dispositivo tramite una colonnina di ricarica pubblica USB compromessa", "Un tipo di ballo", "Rubare elettricità"]',
            "correct_answer": 1,
            "explanation": "Le porte USB trasmettono sia energia che dati. Una presa pubblica modificata può accedere al tuo telefono mentre carichi."
        }
    if "CAVO TRADITORE" in context_key: # OMG Cable
        return {
            "text": "Un cavo USB può contenere un chip Wi-Fi nascosto?",
            "options": '["Impossibile, non c''è spazio", "Sì (es. O.MG Cable), e permette il controllo remoto device", "Solo nei film di 007", "Sì, ma si vedrebbe a occhio nudo"]',
            "correct_answer": 1,
            "explanation": "Esistono cavi indistinguibili dagli originali che contengono implant per l'accesso remoto."
        }
    if "BATTITO" in context_key: # Power Analysis
        return {
            "text": "L'analisi del consumo energetico (Power Analysis) può rivelare la chiave di cifratura?",
            "options": '["No, l''energia non c''entra coi dati", "Sì, perché operazioni diverse consumano quantità di energia diverse in modo prevedibile", "Solo se la batteria è scarica", "Solo su Windows"]',
            "correct_answer": 1,
            "explanation": "È un attacco 'Side-Channel'. Monitorando con precisione il consumo, si può dedurre cosa sta calcolando il processore."
        }
    if "CANTO DEL PC" in context_key: # Acoustic
        return {
            "text": "È possibile rubare dati ascoltando il rumore delle ventole o dei condensatori?",
            "options": '["Sì (Attacco Acustico Side-Channel)", "Assolutamente no", "Solo se il PC ha le casse accese", "È fantascienza"]',
            "correct_answer": 0,
            "explanation": "I componenti elettronici vibrano emettendo suoni impercettibili (o udibili) correlati ai calcoli che stanno svolgendo."
        }
    if "MARTELLO" in context_key: # Rowhammer
        return {
            "text": "Cos'è l'attacco 'Rowhammer'?",
            "options": '["Colpire il PC col martello", "Accedere rapidamente a righe di memoria RAM per causare errori nei bit adiacenti (bit flip)", "Un virus che cancella le righe di Excel", "Un attacco di rete"]',
            "correct_answer": 1,
            "explanation": "Bombardando una riga di memoria, le cariche elettriche 'saltano' alterando i dati nelle celle vicine, permettendo l'escalation dei privilegi."
        }
    if "TELEPATIA" in context_key: # Van Eck Phreaking / Tempest
        return {
            "text": "Cosa si intende per 'TEMPEST'?",
            "options": '["Una tempesta di virus", "Lo studio delle emanazioni elettromagnetiche non intenzionali per spiare i dispositivi", "Un software di meteo", "Un protocollo Wi-Fi"]',
            "correct_answer": 1,
            "explanation": "I cavi video (soprattutto VGA/HDMI) emettono onde radio che possono essere intercettate per ricostruire l'immagine a distanza."
        }
    if "MEMORIA CONGELATA" in context_key: # Cold Boot
        return {
            "text": "Perché congelare una RAM con azoto o aria compressa aiuta un attaccante?",
            "options": '["Per farla andare più veloce", "Per preservare i dati per alcuni minuti dopo lo spegnimento (Cold Boot Attack)", "Per pulirla dalla polvere", "Per rompere i chip"]',
            "correct_answer": 1,
            "explanation": "A basse temperature, i dati nella RAM persistono più a lungo dopo aver tolto corrente, permettendo di estrarli."
        }
    if "FISCHIO" in context_key: # Ultrasonic tracking
        return {
            "text": "I beacon ultrasonici (non udibili) possono essere usati per tracciarti?",
            "options": '["No, il microfono non li sente", "Sì, possono collegare il tuo PC al tuo telefono (Cross-Device Tracking)", "Solo se hai un cane", "Sì, ma solo sott''acqua"]',
            "correct_answer": 1,
            "explanation": "Alcune app ascoltano ultrasuoni emessi da pubblicità TV o web per capire che sei la stessa persona su due dispositivi diversi."
        }
    if "DOPPIO" in context_key: # Proxmark / Cloning
        return {
            "text": "A cosa serve un dispositivo 'Proxmark3'?",
            "options": '["A misurare la prossimità", "Ad analizzare, clonare ed emulare carte RFID e NFC", "A pagare il caffè", "A marcare il territorio"]',
            "correct_answer": 1,
            "explanation": "È il coltellino svizzero per l'RFID hacking. Può clonare badge aziendali in pochi secondi."
        }
    if "SILENZIOSO" in context_key: # Relay Attack
        return {
            "text": "Come rubano le auto Keyless con un 'Relay Attack'?",
            "options": '["Scassinando la serratura", "Amplificando il segnale della chiave che è dentro casa fino all''auto parcheggiata fuori", "Hackerando il satellite", "Usando un duplicato"]',
            "correct_answer": 1,
            "explanation": "Due ladri: uno vicino all'auto, uno vicino alla porta di casa. Il segnale passa tra di loro, l'auto crede che la chiave sia vicina."
        }
    if "PONTE UMANO" in context_key: # Air Gap bridging
        return {
            "text": "Come ha fatto il virus Stuxnet a infettare centrali nucleari non connesse a Internet (Air Gapped)?",
            "options": '["Via satellite", "Tramite chiavette USB infette portate inconsapevolmente dal personale (Ponte Umano)", "Con la magia", "Attraverso i cavi della luce"]',
            "correct_answer": 1,
            "explanation": "L'Air Gap non è perfetto se le persone spostano dati fisicamente."
        }
    if "LUCE PARLANTE" in context_key: # LED exfiltration
        return {
            "text": "È possibile rubare dati osservando il lampeggio del LED di un Hard Disk?",
            "options": '["No, è solo una luce", "Sì, un malware può modulare la luce per trasmettere bit a un osservatore esterno", "Solo se il LED è rosso", "Sì, ma solo di notte"]',
            "correct_answer": 1,
            "explanation": "Tecniche di 'Air-Gap Jumping' ottico usano i LED di stato per trasmettere codice binario a telecamere o droni."
        }
    if "VENTO CIFRATO" in context_key: # Fan modulation
        return {
            "text": "Un computer senza casse può 'parlare'?",
            "options": '["No", "Sì, modulando la velocità delle ventole per trasmettere suoni o vibrazioni", "Solo se ha la scheda audio", "Sì, con i segnali di fumo"]',
            "correct_answer": 1,
            "explanation": "'Fansmitter' è un malware che usa il rumore della ventola per trasmettere dati a bassa velocità."
        }

    # -------------------------------------------------------------------------
    # CAMPANIA (STEGO / OSINT / NETWORK)
    # -------------------------------------------------------------------------
    if "FANTASMI NEL FILE" in context_key: # Pixelation
        return {
            "text": "Pixellare o sfocare un testo sensibile in una foto è un metodo sicuro di censura?",
            "options": '["Sì, è impossibile da recuperare", "No, esistono algoritmi (es. Depix) che possono ricostruire il testo originale", "Sì, se i pixel sono grandi", "Dipende dal colore"]',
            "correct_answer": 1,
            "explanation": "La pixellatura non distrugge l'informazione, la ridistribuisce in modo spesso reversibile."
        }
    if "MACCHINA DEL TEMPO" in context_key: # Timestomp
        return {
            "text": "La 'Data di Creazione' di un file può essere falsificata?",
            "options": '["No, è certificata dal sistema operativo", "Sì, è un metadato facilmente modificabile (Timestomping)", "Solo su Linux", "Solo se cambi la batteria del BIOS"]',
            "correct_answer": 1,
            "explanation": "I metadati del file system non sono una prova forense certa, possono essere alterati banalmente."
        }
    if "NASCOSTO IN PIENA VISTA" in context_key: # Steganography
        return {
            "text": "Cos'è la Steganografia?",
            "options": '["Lo studio delle bandiere", "L''arte di nascondere informazioni dentro altri file (es. foto) in modo invisibile", "La scrittura veloce", "La crittografia dei dinosauri"]',
            "correct_answer": 1,
            "explanation": "A differenza della crittografia che rende il messaggio illeggibile, la steganografia nasconde l'esistenza stessa del messaggio."
        }
    if "LAMPADINA SPIA" in context_key: # Shodan/RTSP
        return {
            "text": "Cosa succede se lasci una telecamera IP con la password di default?",
            "options": '["Nulla, chi conosce il mio IP?", "Verrà indicizzata da motori di ricerca come Shodan e chiunque potrà guardarla", "Diventa in bianco e nero", "Si spegne da sola"]',
            "correct_answer": 1,
            "explanation": "Bot automatici scansionano l'intera internet costantemente cercando porte aperte e password standard."
        }
    if "ZOMBIE" in context_key: # Botnet
        return {
            "text": "Cos'è una 'Botnet'?",
            "options": '["Una rete da pesca", "Una rete di dispositivi infetti (Zombie) controllati remotamente da un criminale", "Un nuovo social network", "Un tipo di antivirus"]',
            "correct_answer": 1,
            "explanation": "Tostapane smart, router e PC non aggiornati vengono spesso arruolati in eserciti digitali per lanciare attacchi DDoS."
        }
    if "SILENZIO RADIO" in context_key: # Jamming
        return {
            "text": "Cos'è il 'Jamming'?",
            "options": '["Fare marmellata", "Suonare jazz", "Disturbare intenzionalmente le comunicazioni radio con rumore (interferenza)", "Bloccare le porte fisiche"]',
            "correct_answer": 2,
            "explanation": "Il Jamming satura le frequenze (Wi-Fi, GPS, GSM) rendendo impossibile la comunicazione legittima."
        }
    if "ANELLO DEBOLE" in context_key: # Fake Login
        return {
            "text": "Perché il 'Login con Facebook/Google' su siti terzi può essere rischioso?",
            "options": '["Perché dimentichi la password", "Se la finestra di login è falsa (pop-up contraffatto), regali le tue credenziali principali all''attaccante", "Perché Google si offende", "È sempre sicuro"]',
            "correct_answer": 1,
            "explanation": "Il 'Browser in the Browser' attack simula perfettamente una finestra di login OAuth per rubare le credenziali."
        }
    if "GEMELLO DIVERSO" in context_key: # Homograph
        return {
            "text": "Un attacco IDN Homograph sfrutta:",
            "options": '["I buchi di sicurezza di Windows", "La somiglianza visiva tra caratteri di alfabeti diversi (es. cirillico vs latino)", "La lentezza della connessione", "Le password deboli"]',
            "correct_answer": 1,
            "explanation": "Per il computer 'a' e 'а' (cirillico) sono due numeri diversi, per il tuo occhio sono uguali."
        }
    if "LIBRERIE MISTE" in context_key: # Typosquatting packages
        return {
            "text": "Cosa succede se digiti `npm install react` invece di `react` (esempio ipotetico)?",
            "options": '["Errore di sintassi", "Potresti scaricare un pacchetto malevolo con nome simile (Typosquatting)", "Il computer esplode", "Nulla"]',
            "correct_answer": 1,
            "explanation": "I supply chain attacks spesso sfruttano errori di battitura nei nomi delle librerie popolari per infettare gli sviluppatori."
        }
    if "BUSSARE ALLE PORTE" in context_key: # Nmap
        return {
            "text": "A cosa serve lo strumento Nmap?",
            "options": '["A trovare mappe del tesoro", "A scansionare la rete per trovare host attivi e porte aperte", "A fare disegni", "A navigare anonimi"]',
            "correct_answer": 1,
            "explanation": "È lo standard de facto per il Network Mapping e il Port Scanning."
        }
    if "TUNNEL CIECO" in context_key: # DoH
        return {
            "text": "Cosa fa il DNS over HTTPS (DoH)?",
            "options": '["Rende il DNS più veloce", "Cifra le richieste DNS nascondendole nel traffico HTTPS, impedendo a chi spia la rete di vedere quali siti visiti", "Blocca le pubblicità", "Crea tunnel VPN"]',
            "correct_answer": 1,
            "explanation": "Impedisce al tuo ISP o all'hacker sulla rete locale di vedere le tue risoluzioni DNS in chiaro."
        }
    if "VASO DI MIELE" in context_key: # Honeypot
        return {
            "text": "Cosa è un 'Honeypot' in cybersecurity?",
            "options": '["Un premio per gli hacker", "Un sistema trappola vulnerabile apposta per attirare e studiare gli attaccanti", "Un antivirus dolce", "Un file cifrato"]',
            "correct_answer": 1,
            "explanation": "Come il miele attira le mosche, l'honeypot attira gli hacker per distrarli dai veri obiettivi o raccogliere intelligence."
        }
    if "LOLBINS" in context_key: # Living off the land
        return {
            "text": "Cosa sono i LOLBins (Living Off The Land Binaries)?",
            "options": '["File divertenti", "Programmi legittimi di sistema (es. PowerShell, CertUtil) usati dagli hacker per nascondere attività malevole", "Cestini della spazzatura", "Virus antichi"]',
            "correct_answer": 1,
            "explanation": "Usare strumenti già presenti nel sistema rende l'attacco difficile da rilevare per gli antivirus tradizionali."
        }
    if "ZERO-CLICK" in context_key:
        return {
            "text": "Cosa rende terrificante un exploit 'Zero-Click'?",
            "options": '["Costa zero euro", "Infetta il dispositivo senza che l''utente debba cliccare o fare nulla (basta ricevere un messaggio)", "Non funziona", "Richiede zero secondi"]',
            "correct_answer": 1,
            "explanation": "Sono le armi cibernetiche più sofisticate (es. Pegasus), spesso usate contro target di alto profilo."
        }
    if "CAPO IMPOSTORE" in context_key: # BEC
        return {
            "text": "La truffa BEC (Business Email Compromise) punta a:",
            "options": '["Compromettere i server", "Ingannare i dipendenti (spesso amministrazione) per autorizzare pagamenti fraudolenti fingendosi dirigenti o fornitori", "Rubare le password di Facebook", "Fare spam"]',
            "correct_answer": 1,
            "explanation": "Causa perdite miliardarie ogni anno. Non è un problema tecnico, ma di processo umano."
        }

    # -------------------------------------------------------------------------
    # REST OF REGIONS (GENERIC LOGIC)
    # -------------------------------------------------------------------------
    
    # Fallback / General Matches based on patterns if not matched above
    
    # CALABRIA
    if "LADRO PAZIENTE" in context_key: return {"text": "Se butti un hard disk, i dati sono al sicuro?", "options": '["Sì, se lo cancelli", "No, bisogna sovrascriverlo (Wipe) o distruggerlo fisicamente per evitare il recupero", "Sì, se lo formatti", "Basta metterlo nell''acqua"]', "correct_answer": 1, "explanation": "La cancellazione semplice rimuove solo l'indice, i dati restano lì finché non vengono sovrascritti."}
    if "CHIAVI USA E GETTA" in context_key: return {"text": "Cos'è la 'Perfect Forward Secrecy' (PFS)?", "options": '["Un segreto perfetto", "Una proprietà che garantisce che se la chiave privata viene rubata oggi, le conversazioni passate restano sicure", "Una password lunga", "Un algoritmo NSA"]', "correct_answer": 1, "explanation": "Genera chiavi di sessione effimere per ogni connessione."}
    if "GIORNO DEL GIUDIZIO" in context_key or "Q-DAY" in context_key: return {"text": "Cos'è il 'Q-Day' o 'Y2Q'?", "options": '["Il giorno della qualità", "Il giorno ipotetico in cui i computer quantistici romperanno la crittografia attuale", "Un film", "La fine di internet"]', "correct_answer": 1, "explanation": "RSA e ECC diventeranno insicuri."}
    if "FATTORI PRIMI" in context_key: return {"text": "Su quale problema matematico si basa RSA?", "options": '["Addizione", "Fattorizzazione di grandi numeri primi", "Logaritmi discreti", "Geometria"]', "correct_answer": 1, "explanation": "Moltiplicare è facile, trovare i fattori originali è difficile (per i computer classici)."}
    if "CURVE PERICOLOSE" in context_key: return {"text": "ECC (Curve Ellittiche) è meglio di RSA perché...", "options": '["Ha un nome più bello", "Offre la stessa sicurezza con chiavi molto più corte e veloci", "Non usa numeri", "È quantistico"]', "correct_answer": 1, "explanation": "Efficienza."}
    if "DIFESA CLASSICA" in context_key: return {"text": "La crittografia 'Lattice-based' è considerata...", "options": '["Obsoleta", "Post-Quantum (resistente ai computer quantistici)", "Debole", "Solo per griglie"]', "correct_answer": 1, "explanation": "È uno dei candidati principali per la standardizzazione PQC."}
    if "DOPPIA SERRATURA" in context_key: return {"text": "In un approccio ibrido Post-Quantum...", "options": '["Si usano due computer", "Si combina un algoritmo classico (fideato) con uno post-quantum (nuovo) per sicurezza", "Si usa doppia password", "Si chiude a chiave"]', "correct_answer": 1, "explanation": "Se il nuovo algoritmo fallisce, quello vecchio protegge ancora."}
    if "FOTONICA" in context_key: return {"text": "La QKD (Quantum Key Distribution) usa...", "options": '["Le onde radio", "Le proprietà della meccanica quantistica (fotoni) per scambiare chiavi in modo sicuro", "Il Wi-Fi", "I cavi USB"]', "correct_answer": 1, "explanation": "Se qualcuno osserva la chiave mentre viene trasmessa, la altera (principio di indeterminazione)."}

    # PUGLIA
    if "MOLTIPLICATORE" in context_key: return {"text": "Un attacco di Amplificazione DDoS sfrutta...", "options": '["Amplificatori audio", "Server malconfigurati (es. DNS/NTP) che rispondono con pacchetti molto più grandi della richiesta", "Tanti computer", "La fibra ottica"]', "correct_answer": 1, "explanation": "Invio 1 byte, la vittima ne riceve 100. Efficienza per l'attaccante."}
    if "TORTURA DELLA GOCCIA" in context_key: return {"text": "L'attacco Slowloris funziona...", "options": '["Andando veloce", "Tenendo aperte tante connessioni lente per esaurire le risorse del server", "Inviando virus", "Rubando password"]', "correct_answer": 1, "explanation": "Bassa larghezza di banda, alto impatto."}
    if "MASCHERA CADUTA" in context_key: return {"text": "Lasciare un sottodominio di sviluppo (dev.sito.com) esposto è rischioso?", "options": '["No, chi lo trova?", "Sì, spesso hanno sicurezza ridotta e possono essere un punto di ingresso", "Solo se è lunedì", "No, è utile"]', "correct_answer": 1, "explanation": "Subdomain Takeover o leak di informazioni."}
    if "TUNNEL DIVISO" in context_key: return {"text": "Cos'è lo 'Split Tunneling' in una VPN?", "options": '["Un tunnel rotto", "Far passare solo parte del traffico nella VPN e il resto su internet diretto", "Usare due VPN", "Tagliare i cavi"]', "correct_answer": 1, "explanation": "Migliora la velocità ma può ridurre la sicurezza se configurato male."}

    # ABRUZZO
    if "BACKUP" in context_key: return {"text": "La regola 3-2-1 del backup dice:", "options": '["3 copie, 2 supporti diversi, 1 off-site (fuori sede)", "3 dischi, 2 computer, 1 cloud", "3 tentativi, 2 errori, 1 successo", "Contare fino a 3"]', "correct_answer": 0, "explanation": "Lo standard d'oro per non perdere i dati."}
    if "RICATTO PERFETTO" in context_key: return {"text": "Se vieni colpito da Ransomware, dovresti pagare?", "options": '["Subito", "Mai (o solo come ultima risorsa estrema), perché finanzia il crimine e non garantisce i dati", "Trattare sul prezzo", "Chiedere lo sconto"]', "correct_answer": 1, "explanation": "Non hai garanzie."}
    if "GABBIE E ONDE" in context_key: return {"text": "Una gabbia di Faraday serve a...", "options": '["Tenere gli uccelli", "Bloccare i campi elettromagnetici (schermare dispositivi da segnali radio)", "Aumentare il Wi-Fi", "Proteggere dai fulmini"]', "correct_answer": 1, "explanation": "Utile per isolare dispositivi da connessioni remote indesiderate."}
    if "ANANAS MALVAGIO" in context_key: return {"text": "Il 'Wi-Fi Pineapple' è...", "options": '["Un frutto", "Un dispositivo per audit Wi-Fi capace di creare falsi access point (Evil Twin)", "Una pizza controversa", "Un modem veloce"]', "correct_answer": 1, "explanation": "Inganna i dispositivi facendoli connettere a lui invece che al Wi-Fi legittimo."}

    # SICILIA (DARK WEB / FORENSICS / CRYPTO)
    if "CIPOLLA" in context_key: return {"text": "Tor (The Onion Router) garantisce...", "options": '["Velocità estrema", "Anonimato instradando il traffico attraverso tre nodi cifrati a strati", "Denaro gratis", "Immunità legale"]', "correct_answer": 1, "explanation": "Come una cipolla, ogni nodo toglie uno strato di cifratura."}
    if "USCITA PERICOLOSA" in context_key: return {"text": "L'Exit Node di Tor può vedere il tuo traffico?", "options": '["No, mai", "Sì, se il traffico non è HTTPS (decifrato all''uscita)", "Solo se sei admin", "Sì, vede tutto cifrato"]', "correct_answer": 1, "explanation": "L'ultimo nodo decifra l'ultimo strato e invia i dati al sito destinazione. Se non usi HTTPS, legge tutto."}
    if "SERVIZI NASCOSTI" in context_key: return {"text": "Un 'Onion Service' (sito .onion) è accessibile dal browser normale?", "options": '["Sì, sempre", "No, serve Tor Browser o un gateway specifico", "Sì, con Chrome", "Solo da mobile"]', "correct_answer": 1, "explanation": "Sono siti ospitati dentro la rete Tor, non sul web pubblico."}
    if "FIDUCIA ZERO" in context_key: return {"text": "Nei market darknet, l'Escrow serve a...", "options": '["Rubare i soldi", "Trattenere i fondi da una terza parte neutrale finché la merce non arriva", "Pagare le tasse", "Comprare azioni"]', "correct_answer": 1, "explanation": "Protegge compratore e venditore in un ambiente senza fiducia."}
    if "AMNESIA DIGITALE" in context_key or "TAILS" in context_key: return {"text": "Il sistema operativo TAILS è progettato per...", "options": '["Giocare", "Dimenticare tutto (Amnesic) dopo ogni riavvio per massima privacy", "Minare bitcoin", "Gestire server"]', "correct_answer": 1, "explanation": "Non scrive nulla su disco fisso, usa solo la RAM."}
    if "LAVATRICE" in context_key or "COINJOIN" in context_key: return {"text": "Un CoinJoin serve a...", "options": '["Lavare le monete fisiche", "Mescolare le transazioni di più utenti per offuscare la tracciabilità", "Unire due blockchain", "Raddoppiare i soldi"]', "correct_answer": 1, "explanation": "Privacy on-chain."}
    if "RE DELLA PRIVACY" in context_key or "MONERO" in context_key: return {"text": "Cosa distingue Monero da Bitcoin?", "options": '["Il logo", "Monero è privata di default (mittente, destinatario e importo nascosti)", "Bitcoin è più veloce", "Monero vale di più"]', "correct_answer": 1, "explanation": "Bitcoin è pseudonimo (trasparente), Monero è anonimo."}
    
    # MARCHE (MOBILE / BROWSER)
    if "BISCOTTI" in context_key: return {"text": "HTTPS garantisce che il sito sia onesto?", "options": '["Sì, il lucchetto verde è garanzia di bontà", "No, garantisce solo che la connessione è cifrata (anche i siti truffa usano HTTPS)", "Sì, è certificato da Google", "Dipende dal browser"]', "correct_answer": 1, "explanation": "Non confondere sicurezza del canale con onestà dell'interlocutore."}
    if "ACCESSIBILIT" in context_key or "AMMINISTRATORE" in context_key: return {"text": "Se un'app torcia ti chiede permessi di 'Accessibilità'...", "options": '["Daglieli, serviranno", "È sospetto: i servizi di accessibilità possono leggere tutto ciò che c''è sullo schermo", "Serve per accendere la luce", "È un bug"]', "correct_answer": 1, "explanation": "È un vettore comune per malware bancari su Android (Overlay attack)."}
    if "APK FANTASMA" in context_key: return {"text": "Cosa significa se l'icona di un'app scompare dopo l'installazione?", "options": '["Si sta aggiornando", "Probabilmente è malware che cerca di nascondersi per non essere disinstallato", "È timida", "Ho finito la memoria"]', "correct_answer": 1, "explanation": "Comportamento tipico di spyware/stalkerware."}
    if "ROOT" in context_key: return {"text": "Fare il Root/Jailbreak del telefono...", "options": '["Aumenta la sicurezza", "Rimuove le sandbox di sicurezza esponendo il dispositivo a rischi maggiori", "Non cambia nulla", "Migliora la fotocamera"]', "correct_answer": 1, "explanation": "Ottieni controllo totale, ma anche le app malevole lo ottengono."}

    # GENERIC FALLBACK
    return {
        "text": f"Approfondimento su: {mission_title}. Qual è il rischio maggiore?",
        "options": '["Ignoranza", "Mancanza di aggiornamenti", "Password deboli", "Tutte le precedenti"]',
        "correct_answer": 3,
        "explanation": "La sicurezza è un processo, non un prodotto."
    }

# =============================================================================
# MAIN SCRIPT
# =============================================================================

def process_file(filepath):
    """
    Parses SQL file, finds INSERT INTO mission_questions tuples,
    detects if they need replacement (image_url placeholders),
    and replaces them in-place.
    """
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find the mission_questions INSERT block
    # We look for pattern: INSERT INTO public.mission_questions (...) VALUES ...
    # And then we iterate through the values.
    # Since rewriting exactly in place is hard with complex parsing, 
    # we will reconstruct the VALUES part.
    
    matches = list(re.finditer(r"(INSERT INTO public\.mission_questions\s*\((.*?)\)\s*VALUES\s*)(.*?;)", content, re.IGNORECASE | re.DOTALL))
    
    if not matches:
        return False

    new_content = content
    modified = False

    for match in matches:
        full_block = match.group(0)
        prefix = match.group(1)
        cols_str = match.group(2).lower()
        values_block = match.group(3)
        
        cols = [c.strip() for c in cols_str.split(',')]
        
        # We need to parse the values block carefully
        # Simple split by ), ( might fail with nested parens usually found in JSON
        # But we must try to identify individual tuples.
        
        # Helper to parse tuples from the values string
        tuples = []
        
        # State machine parser for values
        i = 0
        current_tuple = []
        tuple_start = -1
        paren_depth = 0
        in_quote = False
        
        # This parser extracts the RAW string of each tuple "(val1, val2, ...)"
        parsed_tuples_raw = []
        
        v_str = values_block.strip().rstrip(';')
        
        idx = 0
        while idx < len(v_str):
            char = v_str[idx]
            if char == "'":
                if in_quote and idx + 1 < len(v_str) and v_str[idx+1] == "'":
                    idx += 1
                else:
                    in_quote = not in_quote
            
            if not in_quote:
                if char == '(':
                    if paren_depth == 0:
                        tuple_start = idx
                    paren_depth += 1
                elif char == ')':
                    paren_depth -= 1
                    if paren_depth == 0:
                        parsed_tuples_raw.append(v_str[tuple_start:idx+1])
            
            idx += 1
            
        # Now process each tuple
        new_tuples_str = []
        
        for t_raw in parsed_tuples_raw:
            # Parse columns within the tuple
            # We need to extract values to check if it's an image question
            t_content = t_raw[1:-1] # strip parens
            
            # Split by comma respecting quotes/parens
            vals = []
            curr_val = []
            p_depth = 0
            q_in = False
            k = 0
            while k < len(t_content):
                c = t_content[k]
                if c == "'":
                    if q_in and k + 1 < len(t_content) and t_content[k+1] == "'":
                        curr_val.append("'")
                        curr_val.append("'")
                        k += 2
                        continue
                    else:
                        q_in = not q_in
                
                if q_in:
                    curr_val.append(c)
                else:
                    if c == ',' and p_depth == 0:
                        vals.append("".join(curr_val).strip())
                        curr_val = []
                    elif c == '(': p_depth += 1; curr_val.append(c)
                    elif c == ')': p_depth -= 1; curr_val.append(c)
                    else: curr_val.append(c)
                k += 1
            vals.append("".join(curr_val).strip())
            
            # Map cols to vals
            row = {}
            for col_idx, col_name in enumerate(cols):
                if col_idx < len(vals):
                    row[col_name] = vals[col_idx]
            
            # CHECK IF TARGET
            is_image = False
            if 'type' in row and 'image' in row['type'].lower():
                is_image = True
            if 'image_url' in row and 'placehold' in row['image_url']:
                is_image = True
                
            if is_image:
                # REPLACE LOGIC
                # usage: needs context. We need Mission ID to check context... 
                # OR we just check the text/existing values to infer context?
                # Actually we can't easily query Mission Title from here without parsing Mission table.
                # BUT we can key off the existing QUESTION TEXT if we have to, or just generate generic if unknown.
                # THE PROMPTS used previously had mission title.
                # Let's try to extract context from the file text (mission insert)? Too hard.
                # Use current text to find match?
                
                # Clean current text
                curr_text = row.get('text', '').strip("'")
                
                # Heuristic: try to match key words from the "get_new_question" logic against existing text
                # Or just use the "region" from filename + infer province? 
                
                fname = os.path.basename(filepath)
                region_guess = fname.replace('mission_seed_', '').replace('.sql', '')
                
                # To get better context, let's just search the big library using words in current text?
                # The current text IS in the library keys I wrote? (e.g. "Cacciatori") matches Title.
                # Wait, I keyed the library by MISSION TITLE. I don't have mission title here in `mission_questions`.
                # I have `mission_id`.
                
                # Quick Fix: Assume I mapped text to keys in my library? No, I mapped keys to Keys.
                # New plan: Use the EXISTING TEXT in the row to find the replacement.
                # I will update `get_new_question` to take `existing_text`.
                
                # For `replace_replacer` logic:
                # I will iterate my hardcoded keys. If key words match row['text'] OR row['explanation'], use it.
                
                new_data = None
                
                # Simplify keys for matching:
                search_scope = (curr_text + " " + row.get('explanation', '')).upper()
                
                # Reuse the function logic but iterate
                # This is a bit hacky but works for this batch
                
                # Manual Mapping or Smart Search
                repl_q = get_new_question(region_guess, "UNK", "UNK", search_scope)
                
                # If the generic fall back is returned (check text), try to find specific
                # The generic fallback has "Approfondimento".
                
                if "Approfondimento" in repl_q['text']:
                    # Try to find better match
                    # Iterate specific known keywords from missing images list?
                    keywords = ["CLICKBAIT", "CHI STA PARLANDO", "CONTESTO", "PIETRA", "FIRMA", "POLVERE", "SCOLPITO", "MILIONARIO", "PANINO", "PAPERA", "SUCCO", "CAVO", "BATTITO", "CANTO", "MARTELLO", "TELEPATIA", "MEMORIA", "FISCHIO", "DOPPIO", "SILENZIOSO", "PONTE", "LUCE", "VENTO", "FANTASMI", "MACCHINA DEL TEMPO", "NASCOSTO", "LAMPADINA", "ZOMBIE", "SILENZIO", "ANELLO", "GEMELLO", "LIBRERIE", "BUSSARE", "TUNNEL", "VASO", "LOLBINS", "ZERO-CLICK", "IMPOSTORE", "LADRO", "CHIAVI", "GIUDIZIO", "FATTORI", "CURVE", "DIFESA", "DOPPIA", "FOTONICA", "DISTANZA", "SOVRAPPOSIZIONE", "MOLTIPLICATORE", "TORTURA", "MASCHERA", "TUNNEL", "CLIENT", "CADUTA", "FILTRO", "CEROTTO", "SEMAFORO", "USCITA", "MEMORIA", "VEDERE", "RICONOSCERE", "DIVISI", "IMPRONTE", "MITO", "PAROLE", "NON TOCCARE", "BACKUP", "RICATTO", "TEMPO", "OCCHI", "REGALO", "GABBIE", "ANANAS", "HTTPS", "LOGIN", "SECCHIO", "FAI DA TE", "NUVOLA", "PROGETTO", "ARCHIVIO", "WEB", "AMNESIA", "FIRMA", "DOPPIA", "FRANCHISING", "TERRORE", "CHIAVI", "TRAPPOLA", "SPENTO", "ARMI", "BISCOTTI", "NOTIFICHE", "PLUGIN", "ACCESSIBILIT", "APK", "ROOT", "SSD", "ANALISI", "COLD", "PATTERN", "TESTA", "TRIANGOLAZIONE", "REVOCA", "MFA", "ANELLO"]
                    
                    found_key = None
                    for k in keywords:
                        if k in search_scope:
                            found_key = k
                            break
                    
                    if found_key:
                        repl_q = get_new_question("UNK", "UNK", found_key, "UNK")

                # Construct new tuple string
                # Update row dict
                row['type'] = f"'{repl_q.get('type', 'multiple_choice')}'"
                row['text'] = f"'{repl_q['text'].replace("'", "''")}'"
                row['options'] = f"'{repl_q['options'].replace("'", "''")}'"
                row['correct_answer'] = str(repl_q['correct_answer'])
                row['explanation'] = f"'{repl_q['explanation'].replace("'", "''")}'"
                if 'image_url' in row:
                    row['image_url'] = "NULL"
                
                # Rebuild string
                new_vals = []
                for c in cols:
                    new_vals.append(row.get(c, "NULL"))
                
                new_tuples_str.append("(" + ", ".join(new_vals) + ")")
                modified = True
                print(f"Replaced question in {fname}: {curr_text[:30]}...")

            else:
                new_tuples_str.append(t_raw)
        
        # reconstruct block
        new_values_block = ",\n".join(new_tuples_str)
        replacement = f"{prefix}{new_values_block};"
        
        new_content = new_content.replace(full_block, replacement)

    if modified:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

if __name__ == "__main__":
    directory = "supabase/migrations"
    files = glob.glob(os.path.join(directory, "*.sql"))
    for f in files:
        process_file(f)
