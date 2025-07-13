<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"user".equals(currentUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int poemId = Integer.parseInt(request.getParameter("id"));
    PoemDAO poemDAO = new PoemDAO();
    Poem poem = poemDAO.getPoemById(poemId);

    if (poem == null || poem.getUserId() != currentUser.getId()) {
        out.println("Access denied or poem not found.");
        return;
    }
%>

<jsp:include page="../includes/header.jsp" />

<h2>Edit Poem</h2>

<form action="<%= request.getContextPath() %>/EditPoemServlet" method="post">
    <input type="hidden" name="id" value="<%= poem.getId() %>">

    <label>Title:</label><br>
    <input type="text" name="title" value="<%= poem.getTitle() %>" required><br><br>

    <label>Category:</label><br>
    <select name="category_id" required>
        <option value="1" <%= (poem.getCategoryId() == 1 ? "selected" : "") %>>Romantic</option>
        <option value="2" <%= (poem.getCategoryId() == 2 ? "selected" : "") %>>Patriotic</option>
        <option value="3" <%= (poem.getCategoryId() == 3 ? "selected" : "") %>>Sarcastic</option>
        <option value="4" <%= (poem.getCategoryId() == 4 ? "selected" : "") %>>Nature</option>
    </select><br><br>

    <label>Content:</label><br>
    <textarea name="content" rows="6" cols="60" required><%= poem.getContent() %></textarea><br><br>

    <button type="submit">Update</button>
</form>
