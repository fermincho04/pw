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
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.security.MessageDigest;





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

        // Cifrar contraseña con SHA-256
    public static String hashPassword(String passwordPlano) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(passwordPlano.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b)); // convierte a hex
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
        public boolean registrarUsuario(String nombre, String passwordPlano, String rol) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = conectarMySQL();
                if (conn == null) {
                    return false;
                }

                String sql = "INSERT INTO usuarios (nombre, password, rol) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setString(2, hashPassword(passwordPlano)); // guardamos el hash
                ps.setString(3, rol);

                int filas = ps.executeUpdate();
                return filas > 0;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }

        public ArrayList<Usuario> obtenerUsuarios() {
            ArrayList<Usuario> usuarios = new ArrayList<>();
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                conn = conectarMySQL();
                if (conn == null) {
                    return usuarios;
                }

                String sql = "SELECT id, nombre, password, rol FROM usuarios";
                st = conn.createStatement();
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String nombre = rs.getString("nombre");
                    String pass = rs.getString("password");
                    String rol = rs.getString("rol");

                    usuarios.add(new Usuario(id, nombre, pass, rol));
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (conn != null) conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

            return usuarios;
        }

        public boolean eliminarUsuario(int idUsuario) {
            Connection conn = null;
            PreparedStatement ps = null;

            try {
                conn = conectarMySQL();
                if (conn == null) {
                    return false;
                }

                String sql = "DELETE FROM usuarios WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, idUsuario);

                int filas = ps.executeUpdate();
                return filas > 0;

            } catch (Exception e) {
                e.printStackTrace();
                return false;
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }

    public Usuario validarUsuario(String nombre, String passwordPlano) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conectarMySQL();
            if (conn == null) {
                return null;
            }

            String sql = "SELECT id, nombre, password, rol FROM usuarios WHERE nombre = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, hashPassword(passwordPlano)); // comparamos contra el hash

            rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String nom = rs.getString("nombre");
                String pass = rs.getString("password");
                String rol = rs.getString("rol");

                // Usuario es la clase que creamos para manejar usuarios
                return new Usuario(id, nom, pass, rol);
            } else {
                // usuario o contraseña incorrectos
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    
        public boolean existeUsuario(String nombre) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = conectarMySQL();
            if (conn == null) {
                return false;
            }

            String sql = "SELECT id FROM usuarios WHERE nombre = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);

            rs = ps.executeQuery();
            // si hay al menos un resultado, el usuario ya existe
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }


}
