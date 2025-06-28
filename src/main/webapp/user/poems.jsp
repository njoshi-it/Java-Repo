<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    PoemDAO poemDAO = new PoemDAO();
    List<Poem> poems = poemDAO.getPoemsByUserId(currentUser.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Poems</title>
</head>
<body>
    <h2>Your Poems</h2>

    <a href="createPoem.jsp">Create New Poem</a>

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>Title</th>
                <th>Content</th>
                <th>Value</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Poem poem : poems) { %>
                <tr>
                    <td><%= poem.getTitle() %></td>
                    <td><%= poem.getContent() %></td>
                    <td><%= poem.getValue() %></td>
                    <td>
                        <a href="editPoem.jsp?id=<%= poem.getId() %>">Edit</a> |
                        <a href="deletePoem?id=<%= poem.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
