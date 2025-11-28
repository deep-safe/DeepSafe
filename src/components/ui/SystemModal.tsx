'use client';

import React from 'react';
import { useSystemUI } from '@/context/SystemUIContext';
import { ShieldAlert, Lock } from 'lucide-react';
import { CyberModal } from './CyberModal';

export const SystemModal = () => {
    const { modal, closeModal } = useSystemUI();

    return (
        <CyberModal
            isOpen={modal.visible}
            onClose={closeModal}
            title={modal.title}
            icon={<ShieldAlert className="w-full h-full p-2" />}
            color={modal.type === 'alert' ? 'red' : 'cyan'}
        >
            <div className="space-y-6">
                <p className="text-zinc-300 text-lg leading-relaxed border-l-2 border-current pl-4 opacity-80">
                    {modal.message}
                </p>

                <div className="flex flex-col sm:flex-row gap-3">
                    {modal.actionLabel && modal.onAction && (
                        <button
                            onClick={() => {
                                modal.onAction?.();
                                closeModal();
                            }}
                            className="flex-1 py-3 rounded-lg bg-cyan-500 text-black font-bold font-mono hover:bg-cyan-400 transition-all shadow-[0_0_15px_rgba(6,182,212,0.3)] flex items-center justify-center gap-2"
                        >
                            <Lock className="w-4 h-4" />
                            {modal.actionLabel}
                        </button>
                    )}
                    <button
                        onClick={closeModal}
                        className="flex-1 py-3 rounded-lg border border-white/10 bg-white/5 text-white font-bold font-mono hover:bg-white/10 transition-all"
                    >
                        ANNULLA
                    </button>
                </div>
            </div>
        </CyberModal>
    );
};
