<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    String role = (currentUser != null) ? currentUser.getRole() : "";
    
    String homeLink = request.getContextPath() + "/login.jsp"; // default

    if (currentUser != null) {
        if ("admin".equals(currentUser.getRole())) {
            homeLink = request.getContextPath() + "/dashboard/admin_home.jsp";
        } else if ("user".equals(currentUser.getRole())) {
            homeLink = request.getContextPath() + "/dashboard/user_home.jsp";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Poem Portal</title>
    <style>
        nav { background: #333; padding: 10px; }
        nav a { color: white; margin-right: 20px; text-decoration: none; }
    </style>
</head>
<body>
<nav>
    <a href="<%= homeLink %>">Home</a>

    <% if ("admin".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/dashboard/admin_posts.jsp">Posts</a>
        <a href="<%= request.getContextPath() %>/dashboard/admin_users.jsp">Users</a>
    <% } %>

    <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
</nav>
<hr>
