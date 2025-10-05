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
</head>
<body>

    <header>
        <h1>Nuestro Menú</h1>
        <header>
            <nav>
                <a href="index.html">Inicio</a>
                <a href="menu.jsp">Menú</a>
                </nav>

        </header>
        <p>¡Todo preparado al momento con los mejores ingredientes!</p>
        
        <img src="imagen.png" alt="Imagen decorativa del menú" width="400">
    </header>

    <main>
        <%
            // --- Bloque de código Java que se ejecuta en el servidor ---
            
            // 1. Creamos una instancia de nuestra clase de conexión.
            ConexionMySQL db = new ConexionMySQL();
            
            // 2. Llamamos a los métodos que creamos para obtener las listas de productos.
            ArrayList<item> listaBurritos = db.obtenerBurritos();
            ArrayList<item> listaBebidas = db.obtenerBebidas();
            
            // --- Fin del bloque de código Java ---
        %>

        <h2>Burritos</h2>
        <ul>
            <%
                // Recorremos la lista de burritos y creamos un <li> por cada uno.
                for (item burrito : listaBurritos) {
                    out.println("<li>" + burrito.getNombre() + " - $" + burrito.getPrecio() + "</li>");
                }
            %>
        </ul>

        <h2>Bebidas</h2>
        <ul>
            <%
                // Hacemos lo mismo con la lista de bebidas.
                for (item bebida : listaBebidas) {
                    out.println("<li>" + bebida.getNombre() + " - $" + bebida.getPrecio() + "</li>");
                }
            %>
        </ul>
    </main>

</body>
</html>