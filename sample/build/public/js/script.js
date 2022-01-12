window.addEventListener('load', e => {
    const trigger = document.getElementById('alert-trigger');
    trigger.addEventListener('click', () => {
        alert('I said! You got an alert from a JS script! =)')
    })
})