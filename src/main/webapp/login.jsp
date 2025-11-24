<%-- 
    Document   : login
    Created on : 19 nov 2025, 21:22:41
    Author     : EsthelaHC
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>
<%@ page import="com.mycompany.pw.Usuario" %>

<%
    request.setCharacterEncoding("UTF-8");

    String mensaje = "";
    String tipoMensaje = "ok";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");

        if (nombre == null) nombre = "";
        if (password == null) password = "";

        if (nombre.trim().isEmpty() || password.trim().isEmpty()) {
            mensaje = "Por favor ingresa usuario y contraseña.";
            tipoMensaje = "error";
        } else {
            ConexionMySQL db = new ConexionMySQL();
            Usuario u = db.validarUsuario(nombre, password);

            if (u != null) {
                session.setAttribute("usuarioNombre", u.getNombre());
                session.setAttribute("usuarioRol", u.getRol());

                if ("admin".equals(u.getRol())) {
                    response.sendRedirect("gestionar.jsp");
                } else {
                    response.sendRedirect("index.html");
                }
                return;
            } else {
                mensaje = "Usuario o contraseña incorrectos.";
                tipoMensaje = "error";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesión - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
</head>
<body>
<header>
    <nav>
        <a href="index.html">Inicio</a>
        <a href="Menu.jsp">Menú</a>
        <a href="contacto.html">Contacto</a>
        <a href="login.jsp">Iniciar sesión</a>
        <a href="cuenta.jsp">Cuenta</a>
    </nav>
</header>


<div class="container">
    <main class="main-column card">
        <h1>Iniciar sesión</h1>
        <p>Ingresa tu usuario y contraseña.</p>

        <% if (mensaje != null && !mensaje.isEmpty()) { %>
            <div style="margin-bottom:15px; padding:10px; border-radius:6px;
                        <% if ("error".equals(tipoMensaje)) { %>
                            background-color:#f8d7da; color:#721c24; border:1px solid #f5c6cb;
                        <% } else { %>
                            background-color:#d4edda; color:#155724; border:1px solid #c3e6cb;
                        <% } %>">
                <%= mensaje %>
            </div>
        <% } %>
        
        <p style="margin-top:15px;">
            ¿No tienes cuenta? 
            <a href="registroCliente.jsp">Crear cuenta</a>
        </p>

        <form action="login.jsp" method="POST" class="form-gestion">
            <fieldset>
                <legend>Datos de acceso</legend>

                <label for="nombre">Usuario:</label>
                <input type="text" id="nombre" name="nombre" required>

                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>
            </fieldset>

            <div class="form-botones">
                <button type="submit" class="btn btn-agregar">Entrar</button>
            </div>
        </form>
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
