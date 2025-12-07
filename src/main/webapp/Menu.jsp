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
            <nav>
                <a href="index.html">Inicio</a>
                <a href="Menu.jsp">Menú</a>
                <a href="contacto.html">Contacto</a>
                <a href="cuenta.jsp">Cuenta</a>
                <a href="login.jsp">Iniciar sesión</a>
            </nav>
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
                    <ul>
                    <% for (item burrito : listaBurritos) { %>
                        <li><%= burrito.getNombre() %> - $<%= burrito.getPrecio() %></li>
                    <% } %>
                    </ul>

                    <hr>

                    <h3>Bebidas</h3>
                    <ul>
                    <% for (item bebida : listaBebidas) { %>
                        <li><%= bebida.getNombre() %> - $<%= bebida.getPrecio() %></li>
                    <% } %>
                    </ul>
            </aside>

            </main>
        </div>
        <img src="imagenes/pork-burrito.jpg" alt="Imagen decorativa del menú" width="400" class="imagen-centrada">

        
        <footer>
            <p>&copy; 2025 Burritows - Todos los derechos reservados.</p>

            <div>
                <a href="https://validator.w3.org/check?uri=referer" target="_blank">
                    <img src="https://www.w3.org/Icons/valid-html401-blue" alt="¡HTML Válido!">
                </a>

                <a href="https://jigsaw.w3.org/css-validator/check/referer" target="_blank">
                    <img src="https://jigsaw.w3.org/css-validator/images/vcss-blue" alt="¡CSS Válido!">
                </a>
            </div>
        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function(){
                $("#btnTogglePromo").click(function(){
                    $("#promoContenido").toggle(); 

                    if ($("#promoContenido").is(":visible")) {
                        $(this).text("Ocultar");
                    } else {
                        $(this).text("Mostrar");
                    }
                });
            });
        </script>

    </body>
</html>