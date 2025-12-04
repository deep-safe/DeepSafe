'use client';

import React from 'react';
import { PolicyLayout } from '@/components/layout/PolicyLayout';

export default function PrivacyPolicyPage() {
    return (
        <PolicyLayout title="Privacy Policy" lastUpdated="1 Dicembre 2025">
            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">1. Introduzione</h2>
                <p className="text-gray-300 leading-relaxed">
                    Benvenuto in DeepSafe. La tua privacy è fondamentale per noi. Questa informativa descrive come raccogliamo, utilizziamo e proteggiamo i tuoi dati personali.
                </p>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">2. Dati Raccolti</h2>
                <p className="text-gray-300 leading-relaxed mb-4">
                    Raccogliamo le seguenti informazioni per fornire il servizio:
                </p>
                <ul className="list-disc pl-6 space-y-2 text-gray-300">
                    <li>Informazioni dell'account (email, username, avatar)</li>
                    <li>Dati di progresso di gioco (XP, livelli completati, badge)</li>
                    <li>Preferenze dell'app (impostazioni notifiche, suoni)</li>
                </ul>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">3. Utilizzo dei Dati</h2>
                <p className="text-gray-300 leading-relaxed mb-4">
                    Utilizziamo i tuoi dati esclusivamente per:
                </p>
                <ul className="list-disc pl-6 space-y-2 text-gray-300">
                    <li>Mantenere e migliorare il servizio di gioco</li>
                    <li>Sincronizzare i progressi tra dispositivi</li>
                    <li>Inviare notifiche relative al gioco (se abilitate)</li>
                </ul>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">4. Eliminazione Account</h2>
                <p className="text-gray-300 leading-relaxed">
                    Puoi richiedere l'eliminazione completa del tuo account e di tutti i dati associati in qualsiasi momento direttamente dalle impostazioni del profilo nell'app. Questa azione è irreversibile.
                </p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">5. Contatti</h2>
                <p className="text-gray-300 leading-relaxed">
                    Per domande sulla privacy, contattaci a: <a href="mailto:privacy@deepsafe.app" className="text-[#00f3ff] hover:underline">privacy@deepsafe.app</a>
                </p>
            </section>
        </PolicyLayout>
    );
}
