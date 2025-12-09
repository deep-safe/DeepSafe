'use client';

import React from 'react';
import { PolicyLayout } from '@/components/layout/PolicyLayout';

export default function CookiePolicyPage() {
    return (
        <PolicyLayout title="Cookie Policy" lastUpdated="1 Dicembre 2025">
            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">Cosa sono i cookie?</h2>
                <p className="text-gray-300 leading-relaxed">
                    I cookie sono piccoli file di testo che i siti visitati dagli utenti inviano ai loro terminali, dove vengono memorizzati per essere ritrasmessi agli stessi siti in occasione di visite successive.
                </p>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">Tipologie di cookie utilizzati</h2>
                <p className="text-gray-300 leading-relaxed mb-4">DeepSafe utilizza le seguenti tipologie di cookie:</p>
                <ul className="list-disc pl-6 space-y-2 text-gray-300">
                    <li><strong>Cookie Tecnici:</strong> Necessari per il corretto funzionamento del sito e per permettere la navigazione; senza di essi il sito potrebbe non funzionare correttamente.</li>
                    <li><strong>Cookie Analitici:</strong> Utilizzati per raccogliere informazioni, in forma aggregata, sul numero degli utenti e su come questi visitano il sito stesso (es. Google Analytics).</li>
                </ul>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">Gestione dei cookie</h2>
                <p className="text-gray-300 leading-relaxed">
                    L'utente può decidere se accettare o meno i cookie utilizzando le impostazioni del proprio browser.
                    Attenzione: la disabilitazione totale o parziale dei cookie tecnici può compromettere l'utilizzo delle funzionalità del sito riservate agli utenti registrati.
                </p>
            </section>
        </PolicyLayout>
    );
}
