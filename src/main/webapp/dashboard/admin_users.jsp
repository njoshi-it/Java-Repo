<%@ page import="java.util.List, potapp.model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/includes/header.jsp" />

<div class="container mt-4">
    <h2>Admin Dashboard - Users</h2>

    <%
        List<User> users = (List<User>) request.getAttribute("users");

        if (users != null && !users.isEmpty()) {
    %>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (User user : users) { %>
                    <tr>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getRole() %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/EditUserServlet" method="get" style="display:inline;">
                                <input type="hidden" name="id" value="<%= user.getId() %>" />
                                <button class="btn btn-sm btn-warning">Edit</button>
                            </form>
                            <form action="<%= request.getContextPath() %>/DeleteUserServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure?');">
                                <input type="hidden" name="id" value="<%= user.getId() %>" />
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
        <div class="alert alert-info">No users found.</div>
    <%
        }
    %>
</div>

<jsp:include page="/includes/footer.jsp" />
