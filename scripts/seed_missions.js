const { createClient } = require('@supabase/supabase-js');

// --- CONFIGURATION ---
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY; // MUST be Service Role Key to bypass RLS if needed, or ensuring policies allow insert

if (!supabaseUrl || !supabaseKey) {
    console.error('Error: Missing Supabase credentials. Set NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY.');
    console.error('Usage: NEXT_PUBLIC_SUPABASE_URL=... SUPABASE_SERVICE_ROLE_KEY=... node scripts/seed_missions.js');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// --- DATA (From quizData.ts) ---
const CONTENT_LIBRARY = {
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
                text: 'Qual è la lunghezza minima consigliata per una password sicura?',
                options: ['4 caratteri', '8 caratteri', '12 caratteri', '6 caratteri'],
                correctAnswer: 2,
                explanation: 'Le password con almeno 12 caratteri sono esponenzialmente più difficili da crackare.'
            },
            {
                text: 'Cosa dovresti fare se ricevi una email sospetta?',
                options: ['Cliccare sul link', 'Rispondere al mittente', 'Segnalarla e cancellarla', 'Inoltrarla a un amico'],
                correctAnswer: 2,
                explanation: 'Non interagire mai con link o allegati sospetti. Segnala sempre al team di sicurezza.'
            }
        ],
        xpReward: 100,
        estimatedTime: '3 min',
        level: 'TUTORIAL'
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
                text: 'Quale di questi è un dato PII (Personally Identifiable Information)?',
                options: ['Codice Fiscale', 'Meteo di oggi', 'Nome dell\'azienda', 'Versione del software'],
                correctAnswer: 0,
                explanation: 'Il Codice Fiscale è un dato univoco che identifica una persona fisica.'
            }
        ],
        xpReward: 150,
        estimatedTime: '5 min',
        level: 'SEMPLICE'
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
                text: 'Cosa significa OT in ambito cybersecurity?',
                options: ['Operational Technology', 'Over Time', 'Office Technology', 'Open Threat'],
                correctAnswer: 0,
                explanation: 'OT sta per Operational Technology, ovvero l\'hardware e il software che controllano i dispositivi fisici.'
            }
        ],
        xpReward: 200,
        estimatedTime: '6 min',
        level: 'DIFFICILE'
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
                text: 'Cos\'è un attacco BEC?',
                options: ['Un virus', 'Compromissione email aziendale', 'Un attacco DDoS', 'Un errore bancario'],
                correctAnswer: 1,
                explanation: 'BEC sta per Business Email Compromise, una truffa mirata alle aziende che effettuano bonifici.'
            }
        ],
        xpReward: 250,
        estimatedTime: '7 min',
        level: 'DIFFICILE'
    }
};

const PROVINCE_MAPPING = {
    'MI': 'financial-fraud',
    'TO': 'industrial-security',
    'RM': 'data-protection' // Mapping Roma to Data Protection
};

const REGION_MAPPING = {
    'Lombardia': 'industrial-security',
    'Piemonte': 'industrial-security',
    'Lazio': 'data-protection'
};

async function seed() {
    console.log('🌱 Starting Mission Seeding...');

    for (const [key, lesson] of Object.entries(CONTENT_LIBRARY)) {
        console.log(`Processing Lesson: ${lesson.title}`);

        // Determine Province/Region association
        // This is a bit simplistic: we might want to insert multiple copies if used in multiple places,
        // or just have a pool of missions. For now, we'll insert one "Master" copy.
        // If we want to link it to a specific province, we can.

        let provinceId = null;
        let region = null;

        // Find if this lesson is mapped to a specific province
        for (const [prov, contentId] of Object.entries(PROVINCE_MAPPING)) {
            if (contentId === key) {
                provinceId = prov;
                break;
            }
        }

        // 1. Insert Mission
        const { data: mission, error: missionError } = await supabase
            .from('missions')
            .upsert({
                title: lesson.title,
                content: lesson.content,
                xp_reward: lesson.xpReward,
                estimated_time: lesson.estimatedTime,
                level: lesson.level || 'SEMPLICE',
                province_id: provinceId, // Can be null
                description: `Missione: ${lesson.title}`
            }, { onConflict: 'title' }) // Avoid duplicates based on title if possible, or just insert
            .select()
            .single();

        if (missionError) {
            console.error(`❌ Error inserting mission ${lesson.title}:`, missionError);
            continue;
        }

        console.log(`✅ Mission Created: ${mission.title} (${mission.id})`);

        // 2. Insert Questions
        if (lesson.questions && lesson.questions.length > 0) {
            // First, delete existing questions for this mission to avoid duplicates on re-seed
            await supabase.from('mission_questions').delete().eq('mission_id', mission.id);

            const questionsPayload = lesson.questions.map(q => ({
                mission_id: mission.id,
                text: q.text,
                options: q.options,
                correct_answer: q.correctAnswer,
                explanation: q.explanation,
                type: 'multiple_choice'
            }));

            const { error: qError } = await supabase
                .from('mission_questions')
                .insert(questionsPayload);

            if (qError) {
                console.error(`  ❌ Error inserting questions:`, qError);
            } else {
                console.log(`  ✅ Inserted ${questionsPayload.length} questions.`);
            }
        }
    }

    console.log('🎉 Seeding Complete!');
}

seed();
