<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"user".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Poem poem = (Poem) request.getAttribute("poem");
    if (poem == null) {
        out.println("Poem not found.");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Poem</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        label { font-weight: bold; }
        input, textarea, select { width: 100%; padding: 8px; margin-top: 5px; margin-bottom: 15px; }
        button { padding: 8px 16px; background-color: #007BFF; color: white; border: none; }
        button:hover { background-color: #0056b3; cursor: pointer; }
    </style>
</head>
<body>

<h2>Edit Poem</h2>

<form action="<%= request.getContextPath() %>/EditPoemServlet" method="post">
    <input type="hidden" name="id" value="<%= poem.getId() %>" />

    <label for="title">Title:</label>
    <input type="text" name="title" id="title" value="<%= poem.getTitle() %>" required />

    <label for="category_id">Category:</label>
    <select name="category_id" id="category_id" required>
        <option value="1" <%= (poem.getCategoryId() == 1 ? "selected" : "") %>>Romantic</option>
        <option value="2" <%= (poem.getCategoryId() == 2 ? "selected" : "") %>>Patriotic</option>
        <option value="3" <%= (poem.getCategoryId() == 3 ? "selected" : "") %>>Sarcastic</option>
        <option value="4" <%= (poem.getCategoryId() == 4 ? "selected" : "") %>>Nature</option>
    </select>

    <label for="content">Content:</label>
    <textarea name="content" id="content" rows="8" required><%= poem.getContent() %></textarea>

    <button type="submit">Update Poem</button>
</form>

<p><a href="<%= request.getContextPath() %>/dashboard/user_posts.jsp">← Back to Posts</a></p>

</body>
</html>
