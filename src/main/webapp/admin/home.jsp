<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="potapp.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin Home</title>
    <style>
        body { font-family: Arial, sans-serif; }
        nav a { margin-right: 15px; text-decoration: none; }
        .category-list { margin-top: 20px; }
    </style>
</head>
<body>

    <h2>Admin Home</h2>
    <nav>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="users.jsp">Users</a>
        <a href="poems.jsp">Poems</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>

    <hr />

    <h3>Poem Categories</h3>
    <div class="category-list">
        <%-- 
            Here, you could list categories dynamically.
            For now, a static example:
        --%>
        <ul>
            <li>Romantic</li>
            <li>Patriotic</li>
            <li>Sarcastic</li>
            <li>Nature</li>
        </ul>
    </div>

</body>
</html>
