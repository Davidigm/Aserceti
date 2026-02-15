const express = require('express');
const cors = require('cors');
const session = require('express-session');
const db = require('./db');

const app = express();

// 1. CONFIGURACIÓN DE CORS (DEBE IR PRIMERO)
app.use(cors({
    origin: 'http://127.0.0.1:5500', // Verifica que este sea el puerto de tu Live Server
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

// 2. OTROS MIDDLEWARES
app.use(express.json());

// 3. CONFIGURACIÓN DE SESIÓN
app.use(session({
    secret: 'mi_secreto_super_seguro',
    resave: false,
    saveUninitialized: false,
    cookie: { 
        secure: false, // false para HTTP (desarrollo local)
        sameSite: 'lax' 
    }
}));

// Prueba de servidor
app.get('/test', (req, res) => {
    res.json({ ok: true, message: 'Servidor funcionando' });
});

// Registro de alumno
app.post('/registro-alumno', async (req, res) => {
    const { usuario, nombre, password, grado, nivel, carrera } = req.body;

    console.log('Datos recibidos:', req.body);

    if (!/^\d{8}$/.test(usuario)) {
        return res.json({
            success: false,
            message: 'Usuario inválido'
        });
    }

    try {
        const [result] = await db.query(
            `INSERT INTO usuario (nombre, correo, password, rol, estado)
             VALUES (?, ?, ?, ?, ?)`,
            [nombre, usuario, password, 'Alumno', 'Activo']
        );

        const idUsuario = result.insertId;

        await db.query(
            `INSERT INTO alumno
             (Registro, Carrera, Grado, NivelAca, Estatus_Academico, id_usuario)
             VALUES (?, ?, ?, ?, ?, ?)`,
            [usuario, carrera, grado, nivel, 'Activo', idUsuario]
        );

        res.json({ success: true });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, message: 'Error al crear alumno' });
    }
});

// Login de alumno
app.post('/login-alumno', async (req, res) => {
    const { usuario, password } = req.body;

    try {
        const [results] = await db.query(
            `SELECT u.id_usuario, u.nombre, u.correo, u.rol
             FROM usuario u
             JOIN alumno a ON u.id_usuario = a.id_usuario
             WHERE a.Registro = ? AND u.password = ? AND u.rol = 'Alumno'`,
            [usuario, password]
        );

        if (results.length === 0) {
            return res.json({
                success: false,
                message: 'Usuario o contraseña incorrectos'
            });
        }

        req.session.userId = results[0].id_usuario; // Guardar ID de usuario en sesión

        res.json({ success: true, usuario: results[0] });
    } catch (err) {
        console.error(err);
        res.status(500).json({ success: false, message: 'Error en el servidor' });
    }
});

// Seleccionar materia
app.get('/seleccionarMateria', async (req, res) => {
    const userId = req.session.userId;

    if (!userId) {
        return res.status(401).json({ error: "No autorizado" });
    }
    try {
        const [rows] = await db.query(
            `SELECT m.nombre, m.division
             FROM alumno a
             INNER JOIN materia m 
                ON (m.id_carrera = a.id_carrera OR m.id_carrera IS NULL) -- Ajuste aquí
                AND m.nivel = a.Grado
             WHERE a.id_usuario = ?`, [userId]);
        res.json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Error al obtener materias" });
    }
});

// Registrar opinión de asesoría
app.post('/opiniones', async (req, res) => {
    const userId = req.session.userId; // ID del usuario logueado
    const { estrellas, descripcion, id_asesoria } = req.body;

    if (!userId) {
        return res.status(401).json({
            success: false,
            message: 'No autorizado'
        });
    }

    if (!estrellas || !id_asesoria) {
        return res.json({
            success: false,
            message: 'Datos incompletos'
        });
    }

    try {
        // Obtener registro del alumno
        const [alumno] = await db.query(
            `SELECT Registro FROM alumno WHERE id_usuario = ?`,
            [userId]
        );

        if (alumno.length === 0) {
            return res.json({
                success: false,
                message: 'Alumno no encontrado'
            });
        }

        const registro = alumno[0].Registro;

        // Verificar si ya opinó
        const [existe] = await db.query(
            `SELECT id_opinion 
             FROM opiniones 
             WHERE registro = ? AND id_asesoria = ?`,
            [registro, id_asesoria]
        );

        if (existe.length > 0) {
            return res.json({
                success: false,
                message: 'Ya registraste una opinión para esta asesoría'
            });
        }

        // Insertar opinión
        await db.query(
            `INSERT INTO opiniones 
             (estrellas, descripcion, registro, id_asesoria)
             VALUES (?, ?, ?, ?)`,
            [estrellas, descripcion || '', registro, id_asesoria]
        );

        res.json({
            success: true,
            message: 'Opinión registrada correctamente'
        });

    } catch (error) {
        console.error(error);
        res.status(500).json({
            success: false,
            message: 'Error en el servidor'
        });
    }
});

// Iniciar servidor en puerto 3000
app.listen(3000, () => {
    console.log('🚀 Servidor corriendo en http://localhost:3000');
});