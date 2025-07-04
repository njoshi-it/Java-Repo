<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Poem> topPoems = (List<Poem>) request.getAttribute("topPoems");
    List<Poem> allPoems = (List<Poem>) request.getAttribute("allPoems");

    String tab = request.getParameter("tab");
    if (tab == null) tab = "home";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Poem Portal</title>
    <style>
        body { font-family: Arial; margin: 0; }
        nav {
            background-color: #333;
            overflow: hidden;
        }
        nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }
        nav a.active {
            background-color: #04AA6D;
        }
        nav a:hover {
            background-color: #555;
        }
        .content { padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .actions a {
            margin-right: 10px;
            color: blue;
            text-decoration: none;
        }
    </style>
</head>
<body>

<nav>
    <a href="home.jsp?tab=home" class="<%= "home".equals(tab) ? "active" : "" %>">Home</a>
    <a href="home.jsp?tab=poems" class="<%= "poems".equals(tab) ? "active" : "" %>">Poems</a>
    <a href="../logout.jsp">Logout</a>
</nav>

<div class="content">
    <h2>Welcome, <%= currentUser.getName() %>!</h2>

    <% if ("home".equals(tab)) { %>
        <h3>Top 5 Poems by Rating</h3>
        <table>
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Date</th>
                <th>Rating</th>
            </tr>
            <%
                if (topPoems != null && !topPoems.isEmpty()) {
                    for (Poem p : topPoems) {
            %>
                <tr>
                    <td><%= p.getTitle() %></td>
                    <td><%= p.getCategory() %></td>
<%--                     <td><%= p.getCreatedDate() %></td> --%>
<%--                     <td><%= p.getRating() %></td> --%>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="4">No poems found.</td></tr>
            <%
                }
            %>
        </table>
    <% } else if ("poems".equals(tab)) { %>
        <h3>All My Poems</h3>
        <p>
            <a href="createPoem.jsp">+ Create New Poem</a>
        </p>
        <table>
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Date</th>
                <th>Rating</th>
                <th>Actions</th>
            </tr>
            <%
                if (allPoems != null && !allPoems.isEmpty()) {
                    for (Poem p : allPoems) {
            %>
                <tr>
                    <td><%= p.getTitle() %></td>
                    <td><%= p.getCategory() %></td>
<%--                     <td><%= p.getCreatedDate() %></td> --%>
<%--                     <td><%= p.getRating() %></td> --%>
                    <td class="actions">
                        <a href="editPoem.jsp?id=<%= p.getId() %>">Edit</a>
                        <a href="deletePoem?id=<%= p.getId() %>" onclick="return confirm('Delete this poem?');">Delete</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="5">No poems created yet.</td></tr>
            <%
                }
            %>
        </table>
    <% } %>

</div>

</body>
</html>
