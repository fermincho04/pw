<%-- 
    Document   : cuenta
    Created on : 23 nov 2025, 22:01:08
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String nombreSesion = (String) session.getAttribute("usuarioNombre");
    String rolSesion = (String) session.getAttribute("usuarioRol");

    // Si no hay usuario logueado, mandamos a login
    if (nombreSesion == null || rolSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi cuenta - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
</head>
<body>
<header>
    <nav>
        <a href="index.html">Inicio</a>
        <a href="Menu.jsp">Menú</a>
        <a href="contacto.html">Contacto</a>
        <a href="cuenta.jsp">Cuenta</a>
        <a href="logout.jsp">Cerrar sesión</a>
    </nav>
</header>

<div class="container">
    <main class="main-column card">
        <h1>Mi cuenta</h1>

        <p>Bienvenido, <strong><%= nombreSesion %></strong>.</p>
        <p>Tu rol es: <strong><%= rolSesion %></strong>.</p>

        <hr style="margin:20px 0;">

        <% if ("admin".equals(rolSesion)) { %>
            <h2>Opciones de administrador</h2>
            <ul>
                <li><a href="gestionar.jsp">Gestionar productos</a></li>
                <li><a href="usuarios.jsp">Control de usuarios</a></li>
            </ul>
        <% } else { %>
            <h2>Opciones de cliente</h2>
            <ul>
                <li><a href="Menu.jsp">Ver menú de burritos y bebidas</a></li>
                <!-- Aquí podrías agregar más cosas en el futuro (historial de pedidos, etc.) -->
            </ul>
        <% } %>

    </main>
</div>
        
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

