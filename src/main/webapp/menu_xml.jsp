<%-- 
    Document   : menu_xml
    Created on : 6 oct 2025, 00:41:23
    Author     : EsthelaHC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.pw.item" %>
<%@ page import="com.mycompany.pw.LectorXML" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú - Burritows</title>
    <link rel="stylesheet" href="CSS/estilos.css">
</head>
<body>

    <header>
        <nav>
            <a href="index.html">Inicio</a>
            <a href="menu_xml.jsp">Menú</a>
            <a href="contacto.html">Contacto</a>
        </nav>
    </header>

    <div class="container">
        <main class="main-content">
            
            <section class="main-column card">
                <h1>Nuestro Menú (Cargado desde XML)</h1>
                
                <%
                    LectorXML lector = new LectorXML();
                    
                    String rutaArchivo = application.getRealPath("/WEB-INF/menu.xml");
                    
                    ArrayList<item> listaItems = lector.leerMenu(rutaArchivo);
                %>

                <h2>Menú Completo</h2>
                <ul>
                    <%
                        for (item item : listaItems) {
                            out.println("<li><strong>" + item.getNombre() + "</strong> - $" + item.getPrecio() + "</li>");
                        }
                    %>
                </ul>
            </section>

        </main>
    </div>

    <footer>
            <p>&copy; 2025 Tuburro - Todos los derechos reservados.</p>

            <div>
                <a href="https://validator.w3.org/check?uri=referer" target="_blank">
                    <img src="https://www.w3.org/Icons/valid-html401-blue" alt="¡HTML Válido!">
                </a>

                <a href="https://jigsaw.w3.org/css-validator/check/referer" target="_blank">
                    <img src="https://jigsaw.w3.org/css-validator/images/vcss-blue" alt="¡CSS Válido!">
                </a>
            </div>
        </footer>

</body>
</html>
