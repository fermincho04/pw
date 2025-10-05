<%-- 
    Document   : Menu
    Created on : 5 oct 2025, 14:10:19
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.pw.item" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nuestro Menú</title>
        <link rel="stylesheet" href="css/estilos.css">
    </head>
    <body>

        <header>
            <h1>Nuestro Menú</h1>
            <header>
                <nav>
                    <a href="index.html">Inicio</a>
                    <a href="Menu.jsp">Menú</a>
                    <a href="contacto.html">Contacto</a>
                    </nav>

            </header>
            <p>¡Todo preparado al momento con los mejores ingredientes!</p>

            <img src="imagen.png" alt="Imagen decorativa del menú" width="400">
        </header>

        <main>
            <%
                ConexionMySQL db = new ConexionMySQL();
                ArrayList<item> listaBurritos = db.obtenerBurritos();
                ArrayList<item> listaBebidas = db.obtenerBebidas();
            %>

            <h2>Burritos</h2>
            <ul>
                <%
                    for (item burrito : listaBurritos) {
                        out.println("<li>" + burrito.getNombre() + " - $" + burrito.getPrecio() + "</li>");
                    }
                %>
            </ul>

            <h2>Bebidas</h2>
            <ul>
                <%
                    for (item bebida : listaBebidas) {
                        out.println("<li>" + bebida.getNombre() + " - $" + bebida.getPrecio() + "</li>");
                    }
                %>
            </ul>
        </main>

    </body>
</html>