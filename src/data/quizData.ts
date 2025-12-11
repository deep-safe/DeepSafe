import { provincesData } from './provincesData';
import { supabase } from '@/lib/supabase/client';
import { Database } from '@/types/supabase';

export interface QuizQuestion {
    id: string;
    text: string;
    options: string[];
    correctAnswer: number; // Index of the correct option
    explanation: string;
    type?: 'multiple_choice' | 'true_false' | 'image_true_false';
    image_url?: string | null;
}

export interface TrainingLesson {
    id: string;
    title: string;
    content: string; // Markdown or HTML content
    questions: QuizQuestion[];
    estimatedTime: string; // e.g., "5 min"
    level?: 'TUTORIAL' | 'SEMPLICE' | 'MEDIO' | 'DIFFICILE' | 'BOSS';
    description?: string;
    ncReward?: number;
}

// 1. Define the Content Library
const CONTENT_LIBRARY: Record<string, TrainingLesson> = {
    'cyber-basics': {
        id: 'cyber-basics',
        title: 'Fondamenti di Cybersecurity',
        content: `
# Benvenuto Agente.

La tua prima missione riguarda i fondamenti della sicurezza digitale.
In questo modulo imparerai a riconoscere le minacce più comuni.

## Phishing
Il phishing è un tentativo di truffa via email...

## Password Sicure
Una password sicura deve contenere almeno 12 caratteri...
        `,
        questions: [
            {
                id: 'q1',
                text: 'Qual è la lunghezza minima consigliata per una password sicura?',
                options: ['4 caratteri', '8 caratteri', '12 caratteri', '6 caratteri'],
                correctAnswer: 2,
                explanation: 'Le password con almeno 12 caratteri sono esponenzialmente più difficili da crackare.'
            },
            {
                id: 'q2',
                text: 'Cosa dovresti fare se ricevi una email sospetta?',
                options: ['Cliccare sul link', 'Rispondere al mittente', 'Segnalarla e cancellarla', 'Inoltrarla a un amico'],
                correctAnswer: 2,
                explanation: 'Non interagire mai con link o allegati sospetti. Segnala sempre al team di sicurezza.'
            }
        ],
        estimatedTime: '3 min'
    },
    'data-protection': {
        id: 'data-protection',
        title: 'Protezione Dati Sensibili',
        content: `
# Classificazione Dati

Non tutti i dati sono uguali. Impara a distinguere tra dati pubblici, interni e confidenziali.

## Dati Confidenziali
Includono informazioni personali (PII), dati finanziari...
        `,
        questions: [
            {
                id: 'q1',
                text: 'Quale di questi è un dato PII (Personally Identifiable Information)?',
                options: ['Codice Fiscale', 'Meteo di oggi', 'Nome dell\'azienda', 'Versione del software'],
                correctAnswer: 0,
                explanation: 'Il Codice Fiscale è un dato univoco che identifica una persona fisica.'
            }
        ],
        estimatedTime: '5 min'
    },
    'industrial-security': {
        id: 'industrial-security',
        title: 'Sicurezza Industriale (OT)',
        content: `
# Sicurezza nei Sistemi Industriali

Le regioni industriali sono bersagli critici. I sistemi SCADA e OT richiedono protezioni specifiche.

## Segregazione delle Reti
È fondamentale separare la rete IT (uffici) dalla rete OT (fabbrica)...
        `,
        questions: [
            {
                id: 'q1',
                text: 'Cosa significa OT in ambito cybersecurity?',
                options: ['Operational Technology', 'Over Time', 'Office Technology', 'Open Threat'],
                correctAnswer: 0,
                explanation: 'OT sta per Operational Technology, ovvero l\'hardware e il software che controllano i dispositivi fisici.'
            }
        ],
        estimatedTime: '6 min'
    },
    'financial-fraud': {
        id: 'financial-fraud',
        title: 'Prevenzione Frodi Finanziarie',
        content: `
# Difesa del Settore Finanziario

I centri finanziari sono sotto costante attacco. Impara a riconoscere le frodi avanzate.

## BEC (Business Email Compromise)
Una truffa in cui l'attaccante compromette account email aziendali per autorizzare pagamenti fraudolenti...
        `,
        questions: [
            {
                id: 'q1',
                text: 'Cos\'è un attacco BEC?',
                options: ['Un virus', 'Compromissione email aziendale', 'Un attacco DDoS', 'Un errore bancario'],
                correctAnswer: 1,
                explanation: 'BEC sta per Business Email Compromise, una truffa mirata alle aziende che effettuano bonifici.'
            }
        ],
        estimatedTime: '7 min'
    },
    // --- Nuove Missioni Phishing ---
    'phishing-mission-1': {
        id: 'phishing-mission-1',
        title: 'Fondamenti del Phishing',
        description: 'Impara a distinguere chi ti scrive davvero da chi finge di essere un amico o un servizio noto.',
        level: 'SEMPLICE',
        content: `
# Identificazione del Phishing

Il phishing è l'arte dell'inganno digitale. In questa missione imparerai a riconoscere i segnali di allarme immediati nelle comunicazioni sospette.

## Punti Chiave
- **Mittente**: Controlla sempre l'indirizzo email reale, non solo il nome visualizzato.
- **Urgenza**: Diffida di chi ti mette fretta.
- **Genericità**: "Gentile Cliente" è spesso un brutto segno.
        `,
        questions: [
            {
                id: 'pm1-q1',
                text: 'Ricevi una email da "supporto@goggle.com". Cosa noti?',
                options: ['Sembra legittima', 'C\'è un errore di battitura nel dominio (goggle.com)', 'È sicuramente sicura', 'È un indirizzo premium'],
                correctAnswer: 1,
                explanation: 'I truffatori spesso usano domini che somigliano a quelli reali (Typosquatting). Controlla sempre lettera per lettera.'
            },
            {
                id: 'pm1-q2',
                text: 'Una mail dice "Il tuo account verrà chiuso tra 1 ora se non clicchi qui". Cosa fai?',
                options: ['Clicco subito per non perdere l\'account', 'Rispondo chiedendo più tempo', 'Ignoro il link e controllo sul sito ufficiale', 'Inoltro la mail a tutti i colleghi'],
                correctAnswer: 2,
                explanation: 'L\'urgenza e la paura sono le armi preferite del phishing. Le aziende serie non ti minacciano di chiusura immediata via mail.'
            },
            {
                id: 'pm1-q3',
                text: 'La mail inizia con "Gentile Cliente" invece del tuo nome. Cosa suggerisce?',
                options: ['È indice di una mail massiva (potenziale phishing)', 'È un segno di rispetto', 'La banca ha dimenticato il mio nome', 'È la prassi standard'],
                correctAnswer: 0,
                explanation: 'Le organizzazioni con cui hai un rapporto usano solitamente il tuo nome. "Gentile Cliente" è spesso usato nelle campagne di phishing di massa.'
            },
            {
                id: 'pm1-q4',
                text: 'La tua "banca" ti chiede via mail di rispondere con la tua password per un "controllo di sicurezza".',
                options: ['Glie la mando, è per la sicurezza', 'La mando ma criptata', 'Nessuna banca chiede mai la password via mail', 'Chiedo prima il nome dell\'impiegato'],
                correctAnswer: 2,
                explanation: 'Le credenziali non vengono **mai** richieste via email o telefono dagli amministratori di sistema o dalle banche.'
            },
            {
                id: 'pm1-q5',
                text: 'Ricevi una fattura imprevista come allegato ".exe".',
                options: ['Apro per controllare', 'È sicuramente un virus, non aprire', 'È un formato standard per le fatture', 'L\'antivirus lo bloccherebbe se fosse pericoloso'],
                correctAnswer: 1,
                explanation: 'Le fatture sono solitamente PDF. Un file .exe è un programma eseguibile e quasi certamente installerà malware.'
            }
        ],
        estimatedTime: '5 min'
    },
    'phishing-mission-2': {
        id: 'phishing-mission-2',
        title: 'Analisi Avanzata dei Link',
        description: 'Non tutto ciò che luccica è un link legittimo. Allena l\'occhio a scovare le trappole negli URL.',
        level: 'MEDIO',
        content: `
# Analisi degli URL

Un link può mentire. Il testo che vedi non è sempre la destinazione reale.

## Tecniche Comuni
- **Sottodomini**: paypal.fake.com non è paypal.com.
- **Omografia**: Caratteri simili (es. 'a' cirillica) per ingannare l'occhio.
- **Shorteners**: bit.ly nasconde la destinazione reale.
        `,
        questions: [
            {
                id: 'pm2-q1',
                text: 'Analizza questo link: "https://paypal.supporto-sicurezza.com". Dove porta realmente?',
                options: ['Sul sito di PayPal', 'Su una pagina di supporto ufficiale', 'Su "supporto-sicurezza.com" (sito truffa)', 'È un sottodominio sicuro di PayPal'],
                correctAnswer: 2,
                explanation: 'In un URL, la parte "reale" è quella subito prima del .com/.it. Qui il dominio è "supporto-sicurezza.com", non PayPal.'
            },
            {
                id: 'pm2-q2',
                text: 'Un attaccante usa una \'a\' cirillica al posto della \'a\' latina in "amazon.com". Come si chiama questo attacco?',
                options: ['SQL Injection', 'Homograph Attack (IDN Homograph)', 'Brute Force', 'Man in the Middle'],
                correctAnswer: 1,
                explanation: 'L\'attaccante sfrutta caratteri visivamente identici ma con codici diversi per registrare domini falsi che sembrano veri.'
            },
            {
                id: 'pm2-q3',
                text: 'Il testo della mail dice "www.google.com" ma passando il mouse sopra vedi che punta a "bit.ly/xyz".',
                options: ['È normale redirection', 'È sospetto, l\'URL di destinazione è mascherato', 'Google usa bit.ly per i suoi link', 'È sicuro se inizia con https'],
                correctAnswer: 1,
                explanation: 'Se il testo visualizzato non corrisponde all\'URL di destinazione (visibile in basso a sinistra nel browser), è un forte segnale di pericolo.'
            },
            {
                id: 'pm2-q4',
                text: 'Ricevi un SMS dalla "Posta" con un link "bit.ly/pacco23". È affidabile?',
                options: ['Sì, le poste usano sempre bit.ly', 'No, le grandi aziende usano domini propri e shortener brandizzati', 'Dipende dall\'orario di invio', 'Sì, se il numero del mittente sembra italiano'],
                correctAnswer: 1,
                explanation: 'Le grandi aziende usano domini proprietari (es. poste.it) o shortener brandizzati. I link bit.ly generici sono sospetti in questo contesto.'
            },
            {
                id: 'pm2-q5',
                text: 'Clicchi un link e atterri su una pagina IDENTICA a quella di Microsoft 365, ma l\'URL è "login-microsoft-auth.net".',
                options: ['Inserisco le credenziali, la pagina è giusta', 'È un sito di phishing clonato', 'Microsoft ha cambiato dominio', 'È un server di backup'],
                correctAnswer: 1,
                explanation: 'È facile copiare la grafica di un sito. L\'unica cosa che un attaccante non può falsificare perfettamente è il dominio nella barra degli indirizzi.'
            }
        ],
        estimatedTime: '8 min'
    },
    'phishing-mission-3': {
        id: 'phishing-mission-3',
        title: 'Manipolazione Sociale',
        description: 'I truffatori hackerano le persone, non solo i computer. Riconosci le tecniche di manipolazione psicologica.',
        level: 'DIFFICILE',
        content: `
# Manipolazione Sociale

Il "fattore umano" è spesso l'anello debole.

## Tecniche Psicologiche
- **Autorità**: Fingersi un capo o un poliziotto.
- **Paura**: Minacciare conseguenze negative.
- **Curiosità**: Sfruttare la voglia di sapere (es. chiavetta USB trovata).
        `,
        questions: [
            {
                id: 'pm3-q1',
                text: 'Arriva una mail dal "CEO" che chiede un bonifico urgente su un conto estero per un\'operazione segreta.',
                options: ['Eseguo subito, è il capo', 'Verifico la procedura internamente (chiamata o protocollo)', 'Rispondo alla mail chiedendo conferma', 'Lo anticipo con la mia carta di credito'],
                correctAnswer: 1,
                explanation: 'Questa è la "Truffa del CEO". I truffatori fanno leva sulla gerarchia e la segretezza. Verifica sempre tramite un altro canale.'
            },
            {
                id: 'pm3-q2',
                text: 'Trovi una chiavetta USB nel parcheggio aziendale con etichetta "Stipendi Dirigenti 2024".',
                options: ['La inserisco nel PC per cercare il proprietario', 'La porto all\'ufficio oggetti smarriti/IT senza inserirla', 'La guardo a casa sul mio PC personale', 'La formatto e la uso'],
                correctAnswer: 1,
                explanation: 'È una trappola (Baiting). La chiavetta potrebbe contenere malware che si installa automaticamente appena inserita, o distruggere il PC (USB Killer).'
            },
            {
                id: 'pm3-q3',
                text: 'Ti chiama il "Supporto Tecnico Microsoft" dicendo che il tuo PC ha un virus e devono collegarsi da remoto.',
                options: ['Seguo le loro istruzioni', 'Microsoft non fa chiamate non sollecitate di supporto', 'Chiedo il loro numero di matricola e procedo', 'Do loro accesso solo per 5 minuti'],
                correctAnswer: 1,
                explanation: 'I grandi provider tech non ti chiamano mai a casa per dirti che hai un virus. È una truffa per installare RAT (Remote Access Trojan) o rubare soldi.'
            },
            {
                id: 'pm3-q4',
                text: 'Una persona con le mani impegnate da scatoloni ti chiede di tenergli aperta la porta riservata col badge.',
                options: ['Per gentilezza apro', 'Chiedo di vedere il badge o non apro', 'Apro solo se è vestito bene', 'Chiamo la polizia'],
                correctAnswer: 1,
                explanation: 'Il Tailgating sfrutta la cortesia per accedere ad aree riservate. La sicurezza fisica è il primo baluardo della cybersecurity.'
            },
            {
                id: 'pm3-q5',
                text: 'Qualcuno chiama fingendosi un fornitore e chiede "conferma" di alcuni dati interni per "aggiornare l\'anagrafica".',
                options: ['Fornisco i dati, sembrano innocui', 'Rifiuto e verifico l\'identità del fornitore chiamando il numero ufficiale', 'Chiedo di mandarmi una mail generica', 'Do dati falsi per vedere cosa succede'],
                correctAnswer: 1,
                explanation: 'Il Pretexting consiste nell\'inventare uno scenario (pretesto) per estorcere informazioni. Non dare mai dati aziendali a chiamante non verificati.'
            }
        ],
        estimatedTime: '10 min'
    }
};

// 2. Define Mappings
// Map specific Province IDs to Content IDs OR Array of Content IDs
const PROVINCE_CONTENT_MAP: Record<string, string | string[]> = {
    'MI': 'financial-fraud', // Milano -> Financial
    'CB': ['phishing-mission-1', 'phishing-mission-2', 'phishing-mission-3'], // Campobasso -> Phishing Series
    'TO': 'industrial-security', // Torino -> Industrial
};

// Map Region Names to Content IDs (Fallback)
const REGION_CONTENT_MAP: Record<string, string> = {
    'Lombardia': 'industrial-security',
    'Piemonte': 'industrial-security',
    'Lazio': 'data-protection', // Roma/Government -> Data Protection
};

const DEFAULT_CONTENT_ID = 'cyber-basics';

// --- Helper to get lesson for a province ---
// Client is already initialized

export const getLessonsForProvince = async (provinceId: string, region: string): Promise<TrainingLesson[]> => {
    // 1. Try to fetch specific missions for this province from Supabase
    try {
        const { data: missions, error } = await supabase
            .from('missions')
            .select(`
                *,
                mission_questions (*)
            `)
            .eq('province_id', provinceId);

        if (error) {
            console.error('Error fetching missions:', error);
        }

        if (missions && missions.length > 0) {
            return missions.map(mission => ({
                id: mission.id,
                title: mission.title,
                content: mission.content,
                questions: mission.mission_questions.map((q: any) => ({
                    id: q.id,
                    text: q.text,
                    options: q.options,
                    correctAnswer: q.correct_answer,
                    explanation: q.explanation,
                    type: q.type,
                    image_url: q.image_url
                })),

                estimatedTime: mission.estimated_time,
                level: mission.level,
                description: mission.description || undefined,
                ncReward: mission.nc_reward
            }));
        }
    } catch (err) {
        console.error('Unexpected error fetching missions:', err);
    }

    // 2. Fallback to hardcoded content if no DB mission exists
    const contentRef = PROVINCE_CONTENT_MAP[provinceId] || REGION_CONTENT_MAP[region] || DEFAULT_CONTENT_ID;

    // Check if it's an array of IDs
    if (Array.isArray(contentRef)) {
        return contentRef.map(id => CONTENT_LIBRARY[id]).filter(Boolean);
    }

    // Single ID
    const lesson = CONTENT_LIBRARY[contentRef];
    return lesson ? [lesson] : [CONTENT_LIBRARY[DEFAULT_CONTENT_ID]];
};

export const getMissionById = async (missionId: string): Promise<TrainingLesson | null> => {
    // 1. Try local content first (faster for hardcoded missions)
    if (CONTENT_LIBRARY[missionId]) {
        return CONTENT_LIBRARY[missionId];
    }

    // 2. Try Supabase
    try {
        const { data: mission, error } = await supabase
            .from('missions')
            .select(`
                *,
                mission_questions (*)
            `)
            .eq('id', missionId)
            .single();

        if (error) {
            // Only log if it's a real error, not just "not found" if we expected it might be in DB
            // console.error('Error fetching mission by ID:', error);
            return null;
        }

        if (mission) {
            return {
                id: mission.id,
                title: mission.title,
                content: mission.content,
                questions: mission.mission_questions.map((q: any) => ({
                    id: q.id,
                    text: q.text,
                    options: q.options,
                    correctAnswer: q.correct_answer,
                    explanation: q.explanation,
                    type: q.type,
                    image_url: q.image_url
                })),

                estimatedTime: mission.estimated_time,
                level: mission.level,
                description: mission.description || undefined,
                ncReward: mission.nc_reward
            };
        }
    } catch (err) {
        console.error('Unexpected error fetching mission by ID:', err);
    }
    return null;
};

// Export for backward compatibility if needed, but prefer getLessonForProvince
export const quizData = CONTENT_LIBRARY;
