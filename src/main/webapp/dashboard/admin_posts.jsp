<%@ page import="java.util.List, potapp.model.Poem, potapp.dao.PoemDAO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/includes/header.jsp" />

<div class="container mt-4">
    <h2>Admin Dashboard - All Poems</h2>

    <%
        List<Poem> poems = (List<Poem>) request.getAttribute("allPoems");

        if (poems != null && !poems.isEmpty()) {
    %>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Category</th>
                    <th>Rating</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Poem poem : poems) { %>
                    <tr>
                        <td><%= poem.getTitle() %></td>
                        <td><%= PoemDAO.getUserNameById(poem.getUserId()) %></td>
                        <td><%= PoemDAO.getCategoryNameById(poem.getCategoryId()) %></td>
                        <td><%= poem.getRating() %></td>
                        <td><%= poem.getCreatedAt() %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/ViewPoemServlet" method="get" style="display:inline;">
                                <input type="hidden" name="id" value="<%= poem.getId() %>"/>
                                <button class="btn btn-sm btn-info">View</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/EditPoemServlet" method="get" style="display:inline;">
                                <input type="hidden" name="id" value="<%= poem.getId() %>"/>
                                <button class="btn btn-sm btn-warning">Edit</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/DeletePoemServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                                <input type="hidden" name="id" value="<%= poem.getId() %>"/>
                                <button class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <%
        } else {
    %>
        <div class="alert alert-info">No poems found.</div>
    <%
        }
    %>
</div>

<jsp:include page="/includes/footer.jsp" />
