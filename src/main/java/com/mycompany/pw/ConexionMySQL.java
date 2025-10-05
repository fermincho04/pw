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
import java.util.ArrayList;

/**
 *
 * @author Fer_ITM
 */
public class ConexionMySQL {
    public String driver = "com.mysql.cj.jdbc.Driver";
    public String database = "burritos";
    public String hostname = "localhost";
    public String port = "3306";
    public String url = "jdbc:mysql://" + hostname + ":" + port + "/" + database 
                        + "?useSSL=false&serverTimezone=UTC";
    public String username = "root";
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
        // Usamos tu método de conexión
        Connection conn = this.conectarMySQL(); 
        if (conn == null) return burritos;

        try {
            String query = "SELECT nombre, precio FROM tipodeburro";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                String nombre = rs.getString("nombre");
                double precio = rs.getDouble("precio");
                burritos.add(new item(nombre, precio));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return burritos;
    }
    
    public ArrayList<item> obtenerBebidas() {
        ArrayList<item> bebidas = new ArrayList<>();
        Connection conn = this.conectarMySQL();
        if (conn == null) return bebidas;
    
        try {
            String query = "SELECT nombre, precio FROM bebidas";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
    
            while (rs.next()) {
                String nombre = rs.getString("nombre");
                double precio = rs.getDouble("precio");
                bebidas.add(new item(nombre, precio));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bebidas;
    }

    
}
