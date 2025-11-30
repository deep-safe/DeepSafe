/* Main JS */
document.addEventListener('DOMContentLoaded', () => {
    console.log('App initialized');

    const forms = document.querySelectorAll('.waitlist-form');

    forms.forEach(form => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const emailInput = form.querySelector('input[type="email"]');
            const email = emailInput.value;
            const btn = form.querySelector('button');
            const originalBtnText = btn.innerText;

            if (email) {
                // Check if the form has an action attribute (e.g., Formspree)
                const action = form.getAttribute('action');

                if (action) {
                    try {
                        btn.innerText = 'Invio in corso...';
                        btn.disabled = true;

                        const response = await fetch(action, {
                            method: form.method || 'POST',
                            body: new FormData(form),
                            headers: {
                                'Accept': 'application/json'
                            }
                        });

                        if (response.ok) {
                            alert('Grazie per esserti iscritto alla lista d\'attesa! A breve ti invieremo tutte le istruzioni per accedere all\'app');
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
                    // Fallback for demo/testing if no action is set
                    console.log(`Registered email (Demo): ${email}`);
                    alert('Grazie per esserti iscritto alla lista d\'attesa! A breve ti invieremo tutte le istruzioni per accedere all\'app');
                    form.reset();
                }
            } else {
                alert('Per favore inserisci un indirizzo email valido.');
            }
        });
    });
});
