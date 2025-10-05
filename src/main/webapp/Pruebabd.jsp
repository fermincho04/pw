<%-- 
    Document   : Pruebabd
    Created on : 11 sept 2025, 00:47:55
    Author     : Fer_ITM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/estilos.css">
        <title>Menu</title>
    </head>
    <body>
        <h2>Tablas en la base de datos</h2>
        <%
            Connection conexion = null;
            ResultSet resultados = null;

            try {
                ConexionMySQL conexionBD = new ConexionMySQL();
                conexion = conexionBD.conectarMySQL();

                if(conexion != null){
                    out.println("<h3>Conexión Exitosa</h3>");
                    DatabaseMetaData metaDB = conexion.getMetaData();
                    resultados = metaDB.getTables(null, null, "%", new String[]{"TABLE"});

                    while(resultados.next()){
                        String nombreTabla = resultados.getString("TABLE_NAME");
                        out.println("Tabla: " + nombreTabla + "<br>");
                    }
                } else {
                    out.println("<h3 style='color:red;'>No se pudo conectar a la base</h3>");
                }
            } catch (SQLException e){
                out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            } finally {
                if(resultados != null) resultados.close();
                if(conexion != null) conexion.close();
            }
        %>
    </body>
</html>
