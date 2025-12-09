'use client';

import React from 'react';
import { PolicyLayout } from '@/components/layout/PolicyLayout';

export default function TermsPage() {
    return (
        <PolicyLayout title="Termini e Condizioni" lastUpdated="1 Dicembre 2025">
            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">1. Accettazione dei Termini</h2>
                <p className="text-gray-300 leading-relaxed">
                    Scaricando o utilizzando l'app DeepSafe, accetti automaticamente questi termini. Assicurati di leggerli attentamente prima di utilizzare l'app.
                </p>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">2. Uso dell'Applicazione</h2>
                <p className="text-gray-300 leading-relaxed">
                    DeepSafe è un'applicazione educativa gamificata sulla sicurezza informatica. Ti impegni a utilizzare l'app in modo appropriato e legale. È vietato tentare di estrarre il codice sorgente, tradurre l'app in altre lingue o creare versioni derivate.
                </p>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">3. Proprietà Intellettuale</h2>
                <p className="text-gray-300 leading-relaxed">
                    L'app stessa e tutti i marchi, copyright, diritti di database e altri diritti di proprietà intellettuale ad essa correlati appartengono a DeepSafe Team.
                </p>
            </section>

            <section className="mb-8">
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">4. Modifiche al Servizio</h2>
                <p className="text-gray-300 leading-relaxed">
                    Ci riserviamo il diritto di ritirare o modificare il servizio in qualsiasi momento senza preavviso. Non saremo responsabili se per qualsiasi motivo il servizio non dovesse essere disponibile.
                </p>
            </section>

            <section>
                <h2 className="text-2xl font-bold text-white font-['Orbitron'] mb-4">5. Limitazione di Responsabilità</h2>
                <p className="text-gray-300 leading-relaxed">
                    L'app è fornita "così com'è". Non garantiamo che l'app sarà sempre sicura o priva di errori o che funzionerà sempre senza interruzioni.
                </p>
            </section>
        </PolicyLayout>
    );
}
