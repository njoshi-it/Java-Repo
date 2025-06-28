<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
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
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; }
        nav a { margin-right: 15px; text-decoration: none; }
        .welcome { margin-bottom: 20px; }
    </style>
</head>
<body>

    <div class="welcome">
        <h2>Welcome, <%= user.getName() %> (Admin)</h2>
    </div>

    <nav>
        <a href="home.jsp">Home</a>
        <a href="users.jsp">Users</a>
        <a href="poems.jsp">Poems</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>

    <hr />

    <h3>Dashboard Overview</h3>
    <p>Put your admin summary and stats here.</p>

</body>
</html>
