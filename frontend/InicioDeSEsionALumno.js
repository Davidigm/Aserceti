document.getElementById('login-alumno').addEventListener('submit', function (e) {
    e.preventDefault();

    const usuario = document.getElementById('usuario').value.trim();
    const password = document.getElementById('password').value;
    

    fetch('http://localhost:3000/login-alumno', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    credentials: 'include', // <--- ESTO ES VITAL
    body: JSON.stringify({ usuario, password })
})
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert('Inicio de sesión correcto ✅');
            window.location.href = 'SolicitarAsesoriaAlumno.html';
        } else {
            alert(data.message);
        }
    })
    .catch(() => {
        alert('Error al conectar con el servidor');
    });
});
