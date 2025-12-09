/* Main JS */
document.addEventListener('DOMContentLoaded', () => {
    console.log('App initialized');

    // Modal Logic
    const modal = document.getElementById('success-modal');
    const closeBtns = [document.getElementById('modal-close-btn'), document.getElementById('close-modal-main-btn')];

    function openModal() {
        if (modal) {
            modal.classList.add('active');
            document.body.style.overflow = 'hidden'; // Prevent scrolling
        } else {
            // Fallback if modal is missing (e.g., on other pages if they don't have it yet)
            alert('Grazie per esserti iscritto alla lista d\'attesa! A breve ti invieremo tutte le istruzioni per accedere all\'app');
        }
    }

    function closeModal() {
        if (modal) {
            modal.classList.remove('active');
            document.body.style.overflow = '';
        }
    }

    closeBtns.forEach(btn => {
        if (btn) {
            btn.addEventListener('click', closeModal);
        }
    });

    if (modal) {
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                closeModal();
            }
        });

        // Close on Escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modal.classList.contains('active')) {
                closeModal();
            }
        });
    }

    // Form Handling
    const forms = document.querySelectorAll('.waitlist-form');

    forms.forEach(form => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const emailInput = form.querySelector('input[type="email"]');
            const email = emailInput.value;
            const btn = form.querySelector('button');
            const originalBtnText = btn.innerText;

            if (email) {
                const action = form.getAttribute('action');

                // Simulate loading state
                btn.innerText = 'Invio...';
                btn.disabled = true;

                if (action) {
                    try {
                        const response = await fetch(action, {
                            method: form.method || 'POST',
                            body: new FormData(form),
                            headers: {
                                'Accept': 'application/json'
                            }
                        });

                        if (response.ok) {
                            openModal();
                            form.reset();
                        } else {
                            alert('C\'è stato un problema. Riprova più tardi.');
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        alert('Errore di connessione. Riprova più tardi.');
                    } finally {
                        btn.innerText = originalBtnText;
                        btn.disabled = false;
                    }
                } else {
                    // Demo/Testing fallback
                    console.log(`Registered email (Demo): ${email}`);

                    // Simulate network delay for effect
                    setTimeout(() => {
                        openModal();
                        form.reset();
                        btn.innerText = originalBtnText;
                        btn.disabled = false;
                    }, 800);
                }
            } else {
                alert('Per favore inserisci un indirizzo email valido.');
            }
        });
    });
});
