import React from 'react';
import { CyberModal } from '@/components/ui/CyberModal';
import { AlertTriangle } from 'lucide-react';

interface FeatureNotImplentedModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export function FeatureNotImplementedModal({ isOpen, onClose, zIndex }: FeatureNotImplentedModalProps & { zIndex?: number }) {
    return (
        <CyberModal
            isOpen={isOpen}
            onClose={onClose}
            title="COMING SOON"
            color="cyan"
            showCloseButton={true}
            zIndex={zIndex}
        >
            <div className="flex flex-col items-center justify-center p-6 space-y-6 text-center">
                <div className="w-16 h-16 rounded-full bg-cyan-900/30 flex items-center justify-center border border-cyan-500/30">
                    <AlertTriangle className="w-8 h-8 text-cyan-500" />
                </div>

                <div className="space-y-2">
                    <p className="text-lg text-white font-medium">Feature in sviluppo</p>
                    <p className="text-slate-400 text-sm">
                        Questa funzionalità sarà implementata nella<br />
                        <span className="text-cyan-400 font-bold">versione ufficiale</span>.
                    </p>
                </div>

                <button
                    onClick={onClose}
                    className="w-full py-3 bg-cyan-600 hover:bg-cyan-500 text-white rounded-lg font-orbitron tracking-wider transition-colors"
                >
                    OK
                </button>
            </div>
        </CyberModal>
    );
}
