const mysql = require('mysql2');

// Crear conexión
const conexion = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'aserceti',
  port: 3306,              // 👈 importante
  charset: 'utf8mb4'       // 👈 recomendado
});

// Conectar
conexion.connect((err) => {
  if (err) {
    console.error('❌ Error al conectar a MySQL:', err.message);
    return;
  }
  console.log('✅ Conectado a MySQL (aserceti)');
});

module.exports = conexion;
