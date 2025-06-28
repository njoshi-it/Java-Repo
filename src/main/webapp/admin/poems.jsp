<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="potapp.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.Poem" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    PoemDAO poemDAO = new PoemDAO();
    List<Poem> poems = poemDAO.getAllPoems();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin - Poems Management</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 90%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        nav a { margin-right: 15px; text-decoration: none; }
    </style>
</head>
<body>

    <h2>Poems Management</h2>
    <nav>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="home.jsp">Home</a>
        <a href="users.jsp">Users</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>

    <hr />

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>User ID</th>
                <th>Content</th>
                <!-- Optional: actions like edit/delete -->
            </tr>
        </thead>
        <tbody>
            <% for (Poem poem : poems) { %>
                <tr>
                    <td><%= poem.getId() %></td>
                    <td><%= poem.getTitle() %></td>
                    <td><%= poem.getCategory() %></td>
                    <td><%= poem.getUserId() %></td>
                    <td><%= poem.getContent() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
