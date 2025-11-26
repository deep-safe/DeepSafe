export interface QuizQuestion {
    id: string;
    text: string;
    options: string[];
    correctAnswer: number; // Index of the correct option
    explanation: string;
}

export interface TrainingLesson {
    id: string;
    title: string;
    content: string; // Markdown or HTML content
    questions: QuizQuestion[];
    xpReward: number;
    estimatedTime: string; // e.g., "5 min"
}

export const quizData: Record<string, TrainingLesson> = {
    'mission-1': {
        id: 'mission-1',
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
        xpReward: 100,
        estimatedTime: '3 min'
    },
    'mission-2': {
        id: 'mission-2',
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
        xpReward: 150,
        estimatedTime: '5 min'
    }
};
