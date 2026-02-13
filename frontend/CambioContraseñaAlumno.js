document.getElementById('loginForm').addEventListener('submit', function (e) {
    e.preventDefault();

    const usuario = document.getElementById('usuario').value.trim();
    const nombre = document.getElementById('nombre').value.trim();
    const password = document.getElementById('password').value;
    const grado = document.getElementById('semestre').value;
    const carrera = document.getElementById('carrera').value;
    const nivel = document.querySelector('input[name="nivel"]:checked').value;

    if (!/^\d{8}$/.test(usuario)) {
        alert('El usuario debe ser un número de 8 dígitos');
        return;
    }

    if (nombre.length < 3) {
        alert('El nombre es demasiado corto');
        return;
    }

    fetch('http://localhost:3000/registro-alumno', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify({
            usuario,
            nombre,
            password,
            grado,
            nivel,
            carrera
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            alert('Alumno registrado correctamente ✅');
            window.location.href = 'InicioDeSesionAlumno.html';
        } else {
            alert(data.message);
        }
    })
    .catch(err => {
        console.error(err);
        alert('Error al conectar con el servidor');
    });
});
