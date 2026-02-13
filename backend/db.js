const mysql = require('mysql2/promise');

// Crear conexión con soporte de promesas
const conexion = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'aserceti',
  port: 3306,              // Puerto de MySQL
  charset: 'utf8mb4',      // Recomendado para soportar acentos y emojis
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

module.exports = conexion;