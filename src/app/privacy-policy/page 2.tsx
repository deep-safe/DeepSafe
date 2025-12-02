import React from 'react';
import Link from 'next/link';
import { Shield, ArrowLeft } from 'lucide-react';

export default function PrivacyPolicyPage() {
    return (
        <div className="min-h-screen bg-black text-white p-6 pb-24">
            <div className="max-w-2xl mx-auto space-y-8">
                <Link href="/profile" className="inline-flex items-center text-cyber-blue hover:text-white transition-colors">
                    <ArrowLeft className="w-4 h-4 mr-2" />
                    Torna al Profilo
                </Link>

                <div className="space-y-4">
                    <div className="w-12 h-12 rounded-xl bg-cyber-blue/10 flex items-center justify-center text-cyber-blue">
                        <Shield className="w-6 h-6" />
                    </div>
                    <h1 className="text-3xl font-bold font-orbitron">Privacy Policy</h1>
                    <p className="text-zinc-400">Ultimo aggiornamento: 1 Dicembre 2025</p>
                </div>

                <div className="prose prose-invert prose-sm max-w-none space-y-6 text-zinc-300">
                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">1. Introduzione</h2>
                        <p>
                            Benvenuto in DeepSafe. La tua privacy è fondamentale per noi. Questa informativa descrive come raccogliamo, utilizziamo e proteggiamo i tuoi dati personali.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">2. Dati Raccolti</h2>
                        <p>
                            Raccogliamo le seguenti informazioni per fornire il servizio:
                        </p>
                        <ul className="list-disc pl-4 space-y-1">
                            <li>Informazioni dell'account (email, username, avatar)</li>
                            <li>Dati di progresso di gioco (XP, livelli completati, badge)</li>
                            <li>Preferenze dell'app (impostazioni notifiche, suoni)</li>
                        </ul>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">3. Utilizzo dei Dati</h2>
                        <p>
                            Utilizziamo i tuoi dati esclusivamente per:
                        </p>
                        <ul className="list-disc pl-4 space-y-1">
                            <li>Mantenere e migliorare il servizio di gioco</li>
                            <li>Sincronizzare i progressi tra dispositivi</li>
                            <li>Inviare notifiche relative al gioco (se abilitate)</li>
                        </ul>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">4. Eliminazione Account</h2>
                        <p>
                            Puoi richiedere l'eliminazione completa del tuo account e di tutti i dati associati in qualsiasi momento direttamente dalle impostazioni del profilo nell'app. Questa azione è irreversibile.
                        </p>
                    </section>

                    <section>
                        <h2 className="text-xl font-bold text-white font-orbitron">5. Contatti</h2>
                        <p>
                            Per domande sulla privacy, contattaci a: privacy@deepsafe.app
                        </p>
                    </section>
                </div>
            </div>
        </div>
    );
}
