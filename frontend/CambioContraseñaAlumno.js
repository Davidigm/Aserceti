const radioIngeniero = document.getElementById("ingeniero");
const nivelTexto = document.getElementById("nivelTexto");

radioIngeniero.addEventListener("change", () => {
    if (radioIngeniero.checked) {
        nivelTexto.textContent = "Ingeniero";
    } else {
        nivelTexto.textContent = "Tecnólogo";
    }
});
