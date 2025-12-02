import React from 'react';
import Link from 'next/link';
import { FileText, ArrowLeft } from 'lucide-react';

export default function TermsPage() {
    return (
        <div className="min-h-screen bg-black text-white p-6 pb-24">
            <div className="max-w-2xl mx-auto space-y-8">
                <Link href="/profile" className="inline-flex items-center text-cyber-blue hover:text-white transition-colors">
                    <ArrowLeft className="w-4 h-4 mr-2" />
                    Torna al Profilo
                </Link>

                <div className="space-y-4">
                    <div className="w-12 h-12 rounded-xl bg-cyber-purple/10 flex items-center justify-center text-cyber-purple">
                        <FileText className="w-6 h-6" />
                    </div>
                    <h1 className="text-3xl font-bold font-orbitron">Termini e Condizioni</h1>
                    <p className="text-zinc-400">Ultimo aggiornamento: 1 Dicembre 2025</p>
                </div>

                <div className="prose prose-invert prose-sm max-w-none space-y-6 text-zinc-300">
                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">1. Accettazione dei Termini</h2>
                        <p>
                            Scaricando o utilizzando l'app DeepSafe, accetti automaticamente questi termini. Assicurati di leggerli attentamente prima di utilizzare l'app.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">2. Uso dell'Applicazione</h2>
                        <p>
                            DeepSafe è un'applicazione educativa gamificata sulla sicurezza informatica. Ti impegni a utilizzare l'app in modo appropriato e legale. È vietato tentare di estrarre il codice sorgente, tradurre l'app in altre lingue o creare versioni derivate.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">3. Proprietà Intellettuale</h2>
                        <p>
                            L'app stessa e tutti i marchi, copyright, diritti di database e altri diritti di proprietà intellettuale ad essa correlati appartengono a DeepSafe Team.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">4. Modifiche al Servizio</h2>
                        <p>
                            Ci riserviamo il diritto di ritirare o modificare il servizio in qualsiasi momento senza preavviso. Non saremo responsabili se per qualsiasi motivo il servizio non dovesse essere disponibile.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">5. Limitazione di Responsabilità</h2>
                        <p>
                            L'app è fornita "così com'è". Non garantiamo che l'app sarà sempre sicura o priva di errori o che funzionerà sempre senza interruzioni.
                        </p>
                    </section>
                </div>
            </div>
        </div>
    );
}
