/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.mycompany.pw;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
// Agrega esta línea al inicio del archivo si no la tienes,
// para poder usar listas.
import java.util.ArrayList;

// ... (aquí va el resto de tu clase: getConnection, etc.)
/**
 *
 * @author Fer_ITM
 */
public class ConexionMySQL {
    // Librería de MySQL
    public String driver = "com.mysql.cj.jdbc.Driver";

    // Nombre de la base de datos
    public String database = "burritos";

    // Host
    public String hostname = "localhost";

    // Puerto
    public String port = "3306";

    // Ruta de nuestra base de datos (desactivamos el uso de SSL con "?useSSL=false")
    public String url = "jdbc:mysql://" + hostname + ":" + port + "/" + database 
                        + "?useSSL=false&serverTimezone=UTC";

    // Nombre de usuario
    public String username = "root";

    // Clave de usuario
    public String password = "";

    
    public Connection conectarMySQL() {
        Connection conn = null;

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return conn;
    }
    
    public Connection getConnection() {
        Connection cn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/burritos", "root", ""); // Ajusta tus credenciales
        } catch (Exception e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
        return cn;
    } 
    
    public ArrayList<item> obtenerBurritos() {
    ArrayList<item> burritos = new ArrayList<>();
    // Asegúrate de que tu método de conexión se llame getConnection() o ajústalo.
    Connection conn = this.getConnection(); 
    if (conn == null) return burritos;

    try {
        String query = "SELECT nombre, precio FROM BurritoID"; // Usamos el nombre de tu tabla
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(query);

        while (rs.next()) {
            String nombre = rs.getString("nombre");
            double precio = rs.getDouble("precio");
            burritos.add(new item(nombre, precio));
        }
        
        rs.close();
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println("Error al consultar burritos: " + e.getMessage());
    }
    return burritos;
}

/**
 * Obtiene todas las bebidas de la base de datos.
 * @return Una lista de objetos ItemMenu con las bebidas.
 */
public ArrayList<item> obtenerBebidas() {
    ArrayList<item> bebidas = new ArrayList<>();
    Connection conn = this.getConnection();
    if (conn == null) return bebidas;

    try {
        String query = "SELECT nombre, precio FROM BebidasID"; // Usamos el nombre de tu tabla
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(query);

        while (rs.next()) {
            String nombre = rs.getString("nombre");
            double precio = rs.getDouble("precio");
            bebidas.add(new item(nombre, precio));
        }
        
        rs.close();
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println("Error al consultar bebidas: " + e.getMessage());
    }
    return bebidas;
}

    
}
