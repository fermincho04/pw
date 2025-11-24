<%-- 
    Document   : verificarUsuario
    Created on : 23 nov 2025, 22:16:47
    Author     : Fer_ITM
--%>

<%@ page contentType="text/plain; charset=UTF-8" language="java" %>
<%@ page import="com.mycompany.pw.ConexionMySQL" %>

<%
    request.setCharacterEncoding("UTF-8");

    String nombre = request.getParameter("nombre");
    if (nombre == null) nombre = "";
    nombre = nombre.trim();

    if (nombre.isEmpty()) {
        out.print("VACIO");
        return;
    }

    ConexionMySQL db = new ConexionMySQL();
    boolean existe = db.existeUsuario(nombre);

    if (existe) {
        out.print("EXISTE");
    } else {
        out.print("DISPONIBLE");
    }
%>
