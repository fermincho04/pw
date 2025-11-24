<%-- 
    Document   : usuarios
    Created on : 23 nov 2025, 20:57:49
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.pw.Usuario" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>

<%
    // Proteger la página: solo admin
    String rolSesion = (String) session.getAttribute("usuarioRol");
    if (rolSesion == null || !"admin".equals(rolSesion)) {
        response.sendRedirect("login.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    String mensaje = "";
    String tipoMensaje = "ok";

    String accion = request.getParameter("accion");
    if (accion == null) accion = "";

    ConexionMySQL db = new ConexionMySQL();

    // Procesar formulario (POST)
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        if ("eliminar".equals(accion)) {
            // eliminar usuario por id
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok = db.eliminarUsuario(id);
            if (ok) {
                mensaje = "Usuario eliminado correctamente.";
            } else {
                mensaje = "No se pudo eliminar el usuario.";
                tipoMensaje = "error";
            }

        } else { // registrar por default
            String nombre = request.getParameter("nombre");
            String password = request.getParameter("password");
            String rol = request.getParameter("rol");

            if (nombre == null) nombre = "";
            if (password == null) password = "";
            if (rol == null || rol.isEmpty()) rol = "cliente";

            if (nombre.trim().isEmpty() || password.trim().isEmpty()) {
                mensaje = "Nombre y contraseña son obligatorios.";
                tipoMensaje = "error";
            } else {
                boolean ok = db.registrarUsuario(nombre, password, rol);
                if (ok) {
                    mensaje = "Usuario registrado correctamente.";
                } else {
                    mensaje = "No se pudo registrar el usuario (¿nombre repetido?).";
                    tipoMensaje = "error";
                }
            }
        }
    }

    // Obtener lista para mostrar
    ArrayList<Usuario> listaUsuarios = db.obtenerUsuarios();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Control de Usuarios - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
</head>
<body>
<header>
    <nav>
        <a href="index.html">Inicio</a>
        <a href="Menu.jsp">Menú</a>
        <a href="contacto.html">Contacto</a>
        <a href="gestionar.jsp">Gestionar Productos</a>
        <a href="usuarios.jsp">Usuarios</a>
        <a href="logout.jsp">Cerrar sesión</a>
    </nav>
</header>

<div class="container">
    <main class="main-column card">
        <h1>Control de Usuarios</h1>
        <p>Registrar y administrar usuarios de la página.</p>

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

        <!-- Formulario de registro -->
        <form action="usuarios.jsp" method="POST" class="form-gestion">
            <input type="hidden" name="accion" value="registrar">
            <fieldset>
                <legend>Registrar nuevo usuario</legend>

                <label for="nombre">Nombre de usuario:</label>
                <input type="text" id="nombre" name="nombre" required>

                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>

                <label for="rol">Rol:</label>
                <select id="rol" name="rol">
                    <option value="admin">Administrador</option>
                    <option value="cliente">Cliente</option>
                </select>
            </fieldset>

            <div class="form-botones">
                <button type="submit" class="btn btn-agregar">Registrar Usuario</button>
            </div>
        </form>

        <hr style="margin:30px 0;">

        <!-- Lista de usuarios -->
        <h2>Usuarios registrados</h2>

        <% if (listaUsuarios != null && !listaUsuarios.isEmpty()) { %>
            <% for (Usuario u : listaUsuarios) { %>
                <div class="producto-item">
                    <h3><%= u.getNombre() %></h3>
                    <p>Rol: <%= u.getRol() %></p>
                    <!-- No mostramos la contraseña ni el hash -->

                    <form action="usuarios.jsp" method="POST" style="margin-top:10px;">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id" value="<%= u.getId() %>">
                        <button type="submit" class="btn btn-eliminar">Eliminar</button>
                    </form>
                </div>
            <% } %>
        <% } else { %>
            <p>No hay usuarios registrados.</p>
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
