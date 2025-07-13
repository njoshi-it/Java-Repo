<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"user".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<jsp:include page="../includes/header.jsp" />

<h2>Create New Poem</h2>

<form action="<%= request.getContextPath() %>/CreatePoemServlet" method="post">
    <label>Title:</label><br>
    <input type="text" name="title" required><br><br>

    <label>Category:</label><br>
    <select name="category_id" required>
        <option value="1">Romantic</option>
        <option value="2">Patriotic</option>
        <option value="3">Sarcastic</option>
        <option value="4">Nature</option>
    </select><br><br>

    <label>Content:</label><br>
    <textarea name="content" rows="6" cols="60" required></textarea><br><br>

    <button type="submit">Create</button>
</form>
