<%@ page import="java.util.*, potapp.model.Poem, potapp.dao.PoemDAO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/includes/header.jsp" />

<%
    Map<Integer, List<Poem>> poemsByCategory = (Map<Integer, List<Poem>>) request.getAttribute("poemsByCategory");
    Map<Integer, String> categoryNames = (Map<Integer, String>) request.getAttribute("categoryNames");
%>

<div class="container mt-4">
    <h2>Admin Dashboard - Poem Categories</h2>

    <%
        if (poemsByCategory != null && !poemsByCategory.isEmpty()) {
            for (Map.Entry<Integer, List<Poem>> entry : poemsByCategory.entrySet()) {
                Integer categoryId = entry.getKey();
                String categoryName = categoryNames.get(categoryId);
                List<Poem> poems = entry.getValue();
    %>
                <div class="card mt-4">
                    <div class="card-header bg-primary text-white">
                        <h5><%= categoryName %></h5>
                    </div>
                    <div class="card-body">
                        <% if (poems != null && !poems.isEmpty()) { %>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Created By</th>
                                        <th>Rating</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Poem poem : poems) { %>
                                        <tr>
                                            <td><%= poem.getTitle() %></td>
                                            <td><%= PoemDAO.getUserNameById(poem.getUserId()) %></td>
                                            <td><%= poem.getRating() %></td>
                                            <td>
                                                <form action="<%= request.getContextPath() %>/ViewPoemServlet" method="get" style="display:inline;">
                                                    <input type="hidden" name="id" value="<%= poem.getId() %>" />
                                                    <button class="btn btn-sm btn-info">View</button>
                                                </form>
                                                <form action="<%= request.getContextPath() %>/EditPoemServlet" method="get" style="display:inline;">
                                                    <input type="hidden" name="id" value="<%= poem.getId() %>" />
                                                    <button class="btn btn-sm btn-warning">Edit</button>
                                                </form>
                                                <form action="<%= request.getContextPath() %>/DeletePoemServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                                                    <input type="hidden" name="id" value="<%= poem.getId() %>" />
                                                    <button class="btn btn-sm btn-danger">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        <% } else { %>
                            <p>No poems found in this category.</p>
                        <% } %>
                    </div>
                </div>
    <%
            }
        } else {
    %>
        <div class="alert alert-info mt-4">No poems available to show.</div>
    <%
        }
    %>
</div>

<jsp:include page="/includes/footer.jsp" />
