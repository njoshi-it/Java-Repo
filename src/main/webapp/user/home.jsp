<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.CategoryDAO" %>
<%@ page import="potapp.model.Category" %>

<%
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categories = categoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Home - Poem Categories</title>
</head>
<body>
    <h2>Poem Categories</h2>
    <ul>
        <% for (Category cat : categories) { %>
            <li><a href="poems.jsp?categoryId=<%= cat.getId() %>"><%= cat.getName() %></a></li>
        <% } %>
    </ul>
</body>
</html>
