<%@ page import="java.util.List, java.sql.*, java.io.*" %>
<%@ page session="true" %>
<%
    int idToRemove = Integer.parseInt(request.getParameter("id"));
    @SuppressWarnings("unchecked")
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");

    if (cart != null) {
        cart.remove(Integer.valueOf(idToRemove));
        session.setAttribute("cart", cart);
    }
    response.sendRedirect("view_cart.jsp");
%>