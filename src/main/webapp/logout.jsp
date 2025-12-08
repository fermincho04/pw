<%-- 
    Document   : logout
    Created on : 23 nov 2025, 21:23:30
    Author     : Fer_ITM
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    session.invalidate();             // borramos todo lo de la sesión
    response.sendRedirect("/login.jsp");
%>
