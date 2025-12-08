<%-- 
    Document   : gestionar
    Created on : 23 nov 2025, 16:26:35
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.pw.item" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>

<%
    String rol = (String) session.getAttribute("usuarioRol");
    if (rol == null || !"admin".equals(rol)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<%
    request.setCharacterEncoding("UTF-8");

    String mensaje = "";
    String tipoMensaje = "ok"; // "ok" o "error"

    String accion = request.getParameter("accion");
    if (accion == null) accion = "";

    // ----------- ALTA / ELIMINAR -------------
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String categoria = request.getParameter("categoria");
        String nombre    = request.getParameter("nombre");
        String precioStr = request.getParameter("precio");
        String descripcion = request.getParameter("descripcion"); // por ahora no se guarda

        if (categoria == null) categoria = "";
        if (nombre == null) nombre = "";
        if (precioStr == null) precioStr = "";

        // Decidimos la tabla según la categoría
        String tabla;
        if ("burrito".equals(categoria)) {
            tabla = "tipodeburro";
        } else {
            tabla = "bebidas";
        }

        // ----- ELIMINAR -----
        if ("eliminar".equals(accion)) {
            try {
                double precio = Double.parseDouble(precioStr);

                ConexionMySQL db = new ConexionMySQL();
                Connection conn = db.conectarMySQL();

                if (conn == null) {
                    mensaje = "No se pudo conectar a la base de datos.";
                    tipoMensaje = "error";
                } else {
                    String sql = "DELETE FROM " + tabla + " WHERE nombre = ? AND precio = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, nombre);
                    ps.setDouble(2, precio);

                    int filas = ps.executeUpdate();
                    if (filas > 0) {
                        mensaje = "Producto eliminado correctamente.";
                        tipoMensaje = "ok";
                    } else {
                        mensaje = "No se encontró el producto a eliminar.";
                        tipoMensaje = "error";
                    }

                    ps.close();
                    conn.close();
                }
            } catch (Exception e) {
                mensaje = "Error al eliminar el producto.";
                tipoMensaje = "error";
            }

        // ----- AGREGAR (por default) -----
        } else {
            if (nombre.trim().isEmpty() || precioStr.trim().isEmpty()) {
                mensaje = "Por favor captura al menos nombre y precio.";
                tipoMensaje = "error";
            } else {
                try {
                    double precio = Double.parseDouble(precioStr);

                    ConexionMySQL db = new ConexionMySQL();
                    Connection conn = db.conectarMySQL();

                    if (conn == null) {
                        mensaje = "No se pudo conectar a la base de datos.";
                        tipoMensaje = "error";
                    } else {
                        String sql = "INSERT INTO " + tabla + " (nombre, precio) VALUES (?, ?)";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, nombre);
                        ps.setDouble(2, precio);

                        int filas = ps.executeUpdate();
                        if (filas > 0) {
                            mensaje = "Producto agregado al menú con éxito ✅";
                            tipoMensaje = "ok";
                        } else {
                            mensaje = "No se pudo guardar el producto.";
                            tipoMensaje = "error";
                        }

                        ps.close();
                        conn.close();
                    }
                } catch (NumberFormatException e) {
                    mensaje = "El precio no es un número válido.";
                    tipoMensaje = "error";
                } catch (Exception e) {
                    mensaje = "Ocurrió un error al guardar el producto.";
                    tipoMensaje = "error";
                }
            }
        }
    }

    // ----------- CARGAR LISTAS PARA MOSTRAR -------------
    ConexionMySQL dbListado = new ConexionMySQL();
    ArrayList<item> listaBurritos = dbListado.obtenerBurritos();
    ArrayList<item> listaBebidas  = dbListado.obtenerBebidas();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Menú - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <header>
        <nav>
            <a href="/index.html">Inicio</a>
            <a href="/Menu.jsp">Menú</a>
            <a href="/contacto.html">Contacto</a>
            <a href="/gestionar.jsp">Gestionar</a>
        </nav>
    </header>

    <div class="container">
        <!-- Ojo: usamos main-column para que no se haga flex raro -->
        <main class="main-column card">
            <h1>Gestionar Productos</h1>
            <p>Usa este formulario para añadir items al menú (se guardan en la base de datos).</p>

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

            <div id="mensajes-error" style="color:red; margin-bottom:15px; font-weight:bold;"></div>

            <!-- ---------- FORMULARIO PARA AGREGAR ---------- -->
            <form action="gestionar.jsp" method="POST" class="form-gestion">
                <!-- Para que el servidor sepa que esta acción es "agregar" -->
                <input type="hidden" name="accion" value="agregar">

                <fieldset>
                    <legend>Datos del Producto</legend>

                    <label for="categoria">Categoría:</label>
                    <select id="categoria" name="categoria">
                        <option value="burrito">Burrito</option>
                        <option value="bebida">Bebida</option>
                    </select>

                    <label for="nombre">Nombre del Producto:</label>
                    <input type="text" id="nombre" name="nombre"
                           placeholder="Ej: Burrito de Arrachera" required>

                    <label for="precio">Precio:</label>
                    <input type="number" id="precio" name="precio"
                           placeholder="Ej: 120.50" step="0.01" required>

                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion"
                              placeholder="Ingredientes y detalles del producto."></textarea>
                </fieldset>

                <div class="form-botones">
                    <button type="submit" class="btn btn-agregar">Añadir Producto</button>
                </div>
            </form>

            <hr style="margin:30px 0;">

            <!-- ---------- LISTADO DE PRODUCTOS ---------- -->
            <h2>Productos actuales en el menú</h2>

            <h3>Burritos</h3>
            <% if (listaBurritos != null && !listaBurritos.isEmpty()) { %>
                <% for (item b : listaBurritos) { %>
                    <div class="producto-item">
                        <h3><%= b.getNombre() %></h3>
                        <p>Precio: $<%= b.getPrecio() %></p>

                        <form action="gestionar.jsp" method="POST" style="margin-top:10px;">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="categoria" value="burrito">
                            <input type="hidden" name="nombre" value="<%= b.getNombre() %>">
                            <input type="hidden" name="precio" value="<%= b.getPrecio() %>">
                            <button type="submit" class="btn btn-eliminar">Eliminar</button>
                        </form>
                    </div>
                <% } %>
            <% } else { %>
                <p>No hay burritos registrados.</p>
            <% } %>

            <h3>Bebidas</h3>
            <% if (listaBebidas != null && !listaBebidas.isEmpty()) { %>
                <% for (item be : listaBebidas) { %>
                    <div class="producto-item">
                        <h3><%= be.getNombre() %></h3>
                        <p>Precio: $<%= be.getPrecio() %></p>

                        <form action="gestionar.jsp" method="POST" style="margin-top:10px;">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="categoria" value="bebida">
                            <input type="hidden" name="nombre" value="<%= be.getNombre() %>">
                            <input type="hidden" name="precio" value="<%= be.getPrecio() %>">
                            <button type="submit" class="btn btn-eliminar">Eliminar</button>
                        </form>
                    </div>
                <% } %>
            <% } else { %>
                <p>No hay bebidas registradas.</p>
            <% } %>

        </main>
    </div>

    <!-- Validación sencilla en el cliente -->
    <script>
        $(document).ready(function () {
            $(".form-gestion").on("submit", function (e) {
                $("#mensajes-error").html("");

                let nombre = $("#nombre").val().trim();
                let precio = $("#precio").val().trim();
                let errores = [];

                if (nombre === "") {
                    errores.push("El nombre del producto no puede estar vacío.");
                }

                if (precio === "") {
                    errores.push("El precio no puede estar vacío.");
                } else if (isNaN(precio) || parseFloat(precio) <= 0) {
                    errores.push("El precio debe ser un número mayor a cero.");
                }

                if (errores.length > 0) {
                    e.preventDefault(); // no mandamos al servidor si hay errores
                    $("#mensajes-error").html(errores.join("<br>"));
                }
            });
        });
    </script>
</body>
</html>
