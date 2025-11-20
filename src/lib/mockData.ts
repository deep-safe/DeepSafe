export interface Question {
    id: string;
    text: string;
    options: string[];
    correctAnswer: number; // Index
    explanation: string;
}

export interface Quiz {
    id: string;
    title: string;
    description: string;
    xpReward: number;
    questions: Question[];
    completed: boolean;
    locked: boolean;
}

export const MOCK_QUIZZES: Quiz[] = [
    {
        id: '1',
        title: 'Intro to AI Safety',
        description: 'Learn the basics of AI and why safety matters.',
        xpReward: 10,
        completed: false,
        locked: false,
        questions: [
            {
                id: 'q1',
                text: 'What is a "Deepfake"?',
                options: [
                    'A deep ocean creature',
                    'AI-generated media that replaces a person\'s likeness',
                    'A fake account on social media',
                    'A type of computer virus'
                ],
                correctAnswer: 1,
                explanation: 'Deepfakes use deep learning to manipulate or generate visual and audio content.'
            },
            {
                id: 'q2',
                text: 'Which of these is a potential risk of AI?',
                options: [
                    'It will make coffee too hot',
                    'Bias and discrimination in decision making',
                    'It will run out of batteries',
                    'It will sleep too much'
                ],
                correctAnswer: 1,
                explanation: 'AI systems can perpetuate or amplify biases present in their training data.'
            }
        ]
    },
    {
        id: '2',
        title: 'Spotting Scams',
        description: 'How to identify AI-powered phishing attacks.',
        xpReward: 15,
        completed: false,
        locked: true,
        questions: []
    },
    {
        id: '3',
        title: 'Data Privacy',
        description: 'Protecting your digital footprint.',
        xpReward: 20,
        completed: false,
        locked: true,
        questions: []
    }
];
