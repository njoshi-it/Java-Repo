<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    String role = (currentUser != null) ? currentUser.getRole() : "";
    
    String homeLink = request.getContextPath() + "/login.jsp"; // default

    if (currentUser != null) {
        if ("admin".equals(role)) {
            homeLink = request.getContextPath() + "/AdminHomeServlet";
        } else if ("user".equals(role)) {
            homeLink = request.getContextPath() + "/dashboard/user_home.jsp";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Poem Portal</title>
    <style>
        /* Reset some default */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
        }

        nav {
            background-color: #24292e;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-left, .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-left a, .nav-right a {
            color: #e1e4e8;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            padding: 6px 12px;
            border-radius: 6px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .nav-left a:hover, .nav-right a:hover {
            background-color: #0366d6;
            color: white;
            box-shadow: 0 2px 8px rgba(3, 102, 214, 0.6);
        }

        .nav-brand {
            font-weight: 800;
            font-size: 20px;
            color: #58a6ff;
            letter-spacing: 1.5px;
            user-select: none;
        }

        @media (max-width: 600px) {
            nav {
                flex-direction: column;
                gap: 10px;
                padding: 12px 15px;
            }

            .nav-left, .nav-right {
                flex-wrap: wrap;
                gap: 10px;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<nav>
    <div class="nav-left">
        <a href="<%= homeLink %>" class="nav-brand">PoemPortal</a>
        <% if ("admin".equals(role)) { %>
            <a href="<%= request.getContextPath() %>/AdminPostsServlet">Posts</a>
            <a href="<%= request.getContextPath() %>/AdminUsersServlet">Users</a>
        <% } else if ("user".equals(role)) { %>
            <a href="<%= request.getContextPath() %>/dashboard/user_posts.jsp">Posts</a>
        <% } %>
    </div>
    <div class="nav-right">
        <% if (currentUser != null) { %>
            <span style="color: #e1e4e8; font-weight: 500; font-size: 14px; user-select:none;">Hello, <%= currentUser.getName() %>!</span>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login.jsp">Login</a>
            <a href="<%= request.getContextPath() %>/register.jsp">Register</a>
        <% } %>
    </div>
</nav>
<hr style="border: none; border-top: 1px solid #e1e4e8; margin: 0;" />
