import mysql from "mysql2/promise";

const connection = mysql.createPool({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "root",
    database: "test",
    waitForConnections: true,
    connectionLimit: 10,
    maxIdle: 10,
    idleTimeout: 60000,
    queueLimit: 0,
    enableKeepAlive: true,
    keepAliveInitialDelay: 0,
})

connection
  .getConnection()
  .then((connection) => {
    console.log("Connected with MySQL");
    connection.release();
  })
  .catch((err) => {
    console.log("Error connecting to database:", err);
    process.exit(1);
  });
  
export default connection;