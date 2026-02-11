const preguntas = document.querySelectorAll('.estrellas');
let respuestas = {};

preguntas.forEach(div => {
  for (let i = 1; i <= 5; i++) {
    const star = document.createElement('span');
    star.innerHTML = '★';
    star.addEventListener('click', () => {
      respuestas[div.dataset.name] = i;
      pintar(div, i);
    });
    div.appendChild(star);
  }
});

function pintar(div, valor) {
  const stars = div.querySelectorAll('span');
  stars.forEach((s, index) => {
    s.classList.toggle('activa', index < valor);
  });
}

document.getElementById('formOpinion').addEventListener('submit', e => {
  e.preventDefault();

  const total = Object.values(respuestas).reduce((a, b) => a + b, 0);
  const promedio = Math.round(total / 6);

  const data = {
    estrellas: promedio,
    descripcion: document.getElementById('descripcion').value,
    registro: 1,        // id alumno (sesión)
    id_asesoria: 10     // asesoría actual
  };

  fetch('api/opiniones/crear.php', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
  })
  .then(res => res.json())
  .then(r => alert(r.mensaje));
});
