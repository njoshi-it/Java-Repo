<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="potapp.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.UserDAO" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Admin - Users Management</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 80%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        nav a { margin-right: 15px; text-decoration: none; }
    </style>
</head>
<body>

    <h2>Users Management</h2>
    <nav>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="home.jsp">Home</a>
        <a href="poems.jsp">Poems</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>

    <hr />

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <!-- Add actions column for edit/delete if needed -->
            </tr>
        </thead>
        <tbody>
            <% for (User u : users) { %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getRole() %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
