<%@ page import="java.util.List" %>
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

    PoemDAO poemDAO = new PoemDAO();
    List<Poem> myPoems = poemDAO.getPoemsByUserId(currentUser.getId());
%>

<jsp:include page="../includes/header.jsp" />

<h2>📚 My Poems</h2>

<a href="create_poem.jsp">
    <button>➕ Create New Post</button>
</a>

<br><br>

<table border="1" cellpadding="10" cellspacing="0">
    <tr style="background-color: #f0f0f0;">
        <th>Title</th>
        <th>Category ID</th>
        <th>Rating</th>
        <th>Created At</th>
        <th>Actions</th>
    </tr>

    <%
        for (Poem poem : myPoems) {
    %>
    <tr>
        <td><%= poem.getTitle() %></td>
        <td><%= poem.getCategoryId() %></td>
        <td><%= poem.getRating() %></td>
        <td><%= poem.getCreatedAt() %></td>
        <td>
            <form action="<%= request.getContextPath() %>/EditPoemServlet" method="get" style="display:inline;">
                <input type="hidden" name="id" value="<%= poem.getId() %>">
                <button>Edit</button>
            </form>

            <form action="<%= request.getContextPath() %>/DeletePoemServlet" method="get" style="display:inline;" 
      onsubmit="return confirm('Are you sure you want to delete this poem?');">
    <input type="hidden" name="id" value="<%= poem.getId() %>">
    <button type="submit" style="background-color:red; color:white;">Delete</button>
</form>
<form action="<%= request.getContextPath() %>/ViewPoemServlet" method="get" style="display:inline;">
    <input type="hidden" name="id" value="<%= poem.getId() %>">
    <button>View</button>
</form>


        </td>
    </tr>
    <%
        }
        if (myPoems.isEmpty()) {
    %>
    <tr>
        <td colspan="5" style="text-align:center;">No poems found.</td>
    </tr>
    <%
        }
    %>
</table>
