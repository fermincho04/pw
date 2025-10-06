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
        <link rel="stylesheet" href="CSS/estilos.css">
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
        </header>
            <%
                ConexionMySQL db = new ConexionMySQL();
                ArrayList<item> listaBurritos = db.obtenerBurritos();
                ArrayList<item> listaBebidas = db.obtenerBebidas();
            %>
        
        <div class="container">
        <main class="main-content">
            <aside class="sidebar-column card">
                <h3>Burritos</h3>
                <%
                    for (item burrito : listaBurritos) {
                        out.println(burrito.getNombre()+ " " + burrito.getPrecio());
                    }
                %>
                <hr>
                <h3>Bebidas</h3>
                <%
                    for (item bebida : listaBebidas) {
                        out.println(bebida.getNombre()+ " " + bebida.getPrecio());
                    }
                %>
            </aside>

            </main>
        </div>
            <main>
                <h2>¡Los mejores burritos de la ciudad!</h2>
                <img src="imagenes\pork-burrito.jpg" alt="Imagen decorativa del menú" class="imagen-centrada">
                <p>
                    Bienvenidos a nuestro sitio. Explora nuestro menú...
                </p>
            </main>
            
        

    </body>
</html>