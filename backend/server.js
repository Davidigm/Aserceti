const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();

app.use(cors());
app.use(express.json());

//prueba de servidor
app.get('/test', (req, res) => {
    res.json({ ok: true, message: 'Servidor funcionando' });
});



// Ruta para registrar alumno
app.post('/registro-alumno', (req, res) => {
    const { usuario, nombre, password, grado, nivel, carrera } = req.body;

    console.log('Datos recibidos:', req.body);

    if (!/^\d{8}$/.test(usuario)) {
        return res.json({
            success: false,
            message: 'Usuario inválido'
        });
    }

    const sqlUsuario = `
        INSERT INTO usuario (nombre, correo, password, rol, estado)
        VALUES (?, ?, ?, ?, ?)
    `;

    db.query(
        sqlUsuario,
        [nombre, usuario, password, 'Alumno', 'Activo'],
        (err, result) => {
            if (err) {
                console.error(err);
                return res.status(500).json({
                    success: false,
                    message: 'Error al crear usuario'
                });
            }

            const idUsuario = result.insertId;

            const sqlAlumno = `
                INSERT INTO alumno
                (Registro, Carrera, Grado, NivelAca, Estatus_Academico, id_usuario)
                VALUES (?, ?, ?, ?, ?, ?)
            `;

            db.query(
                sqlAlumno,
                [
                    usuario,
                    carrera,
                    grado,
                    nivel,
                    'Activo',
                    idUsuario
                ],
                (err) => {
                    if (err) {
                        console.error(err);
                        return res.status(500).json({
                            success: false,
                            message: 'Error al crear alumno'
                        });
                    }

                    res.json({ success: true });
                }
            );
        }
    );
});


// Inicio de sesion
app.post('/login-alumno', (req, res) => {
    const { usuario, password } = req.body;
    const sql = `
        SELECT u.id_usuario, u.nombre, u.correo, u.rol
        FROM usuario u
        JOIN alumno a ON u.id_usuario = a.id_usuario
        WHERE u.correo = ? AND u.password = ? AND u.rol = 'Alumno'
    `;
    db.query(sql, [usuario, password], (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).json({   
                success: false,
                message: 'Error en el servidor'
            });
        }
        if (results.length === 0) {
            return res.json({
                success: false,
                message: 'Usuario o contraseña incorrectos'
            });
        }
        res.json({
            success: true,
            usuario: results[0]
        });
    }
    );
});


app.listen(3000, () => {
    console.log('🚀 Servidor corriendo en http://localhost:3306');
});
