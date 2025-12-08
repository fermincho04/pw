<%-- 
    Document   : registroCliente
    Created on : 23 nov 2025, 22:00:06
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>

<%
    request.setCharacterEncoding("UTF-8");
    ConexionMySQL db = new ConexionMySQL();

    String mensaje = "";
    String tipoMensaje = "ok";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");

        if (nombre == null) nombre = "";
        if (password == null) password = "";

        if (db.existeUsuario(nombre)) {
            mensaje = "Ese nombre de usuario ya está ocupado.";
            tipoMensaje = "error";
        } else {
            boolean ok = db.registrarUsuario(nombre, password, "cliente");
            if (ok) {
                mensaje = "Cuenta creada correctamente. Ahora puedes iniciar sesión.";
                tipoMensaje = "ok";
            } else {
                mensaje = "Ocurrió un error al crear la cuenta.";
                tipoMensaje = "error";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear cuenta - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<header>
    <nav>
        <a href="/index.html">Inicio</a>
        <a href="/Menu.jsp">Menú</a>
        <a href="/contacto.html">Contacto</a>
        <a href="/login.jsp">Iniciar sesión</a>
        <a href="/cuenta.jsp">Cuenta</a>
    </nav>
</header>

<div class="container">
    <main class="main-column card">
        <h1>Crear cuenta</h1>
        <p>Regístrate como cliente para poder iniciar sesión.</p>

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

       
        <form action="registroCliente.jsp" method="POST" class="form-gestion">
            <fieldset>
                <legend>Datos de la cuenta</legend>

                <label for="nombre">Nombre de usuario:</label>
                <input type="text" id="nombre" name="nombre" required>
                <div id="mensaje-usuario" style="margin-top:5px; font-weight:bold;"></div>

                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" required>
            </fieldset>

            <div class="form-botones">
                <!-- AQUÍ está el id del botón -->
                <button type="submit" id="btnCrearCuenta" class="btn btn-agregar">
                    Crear cuenta
                </button>
            </div>
        </form>

        <p style="margin-top:15px;">
            ¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión aquí</a>.
        </p>
    </main>
</div>

<script>
    $(document).ready(function () {
        $("#nombre").on("blur keyup", function () {
            let nombre = $("#nombre").val().trim();

            $("#mensaje-usuario").text("");
            $("#btnCrearCuenta").prop("disabled", false);

            if (nombre === "") {
                $("#mensaje-usuario").css("color", "red")
                    .text("El nombre de usuario no puede ir vacío.");
                return;
            }
            $.ajax({
                url: "verificarUsuario.jsp",
                method: "GET",
                data: { nombre: nombre },
                success: function (respuesta) {
                    respuesta = respuesta.trim();

                    if (respuesta === "EXISTE") {
                        $("#mensaje-usuario").css("color", "red")
                            .text("Ese nombre de usuario ya está ocupado.");
                        $("#btnCrearCuenta").prop("disabled", true);
                    } else if (respuesta === "DISPONIBLE") {
                        $("#mensaje-usuario").css("color", "green")
                            .text("Nombre de usuario disponible.");
                        $("#btnCrearCuenta").prop("disabled", false);
                    } else {
                        $("#mensaje-usuario").css("color", "red")
                            .text("Escribe un nombre de usuario.");
                    }
                },
                error: function () {
                    $("#mensaje-usuario").css("color", "red")
                        .text("Error al verificar el usuario.");
                }
            });
        });
    });
</script>
</body>
</html>
