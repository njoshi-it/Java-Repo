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

<h2>My Posts</h2>

<button style="margin-bottom: 10px;">➕ Create New Post</button>

<table border="1" cellpadding="10" style="width: 100%;">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Category</th>
        <th>Rating</th>
        <th>Actions</th>
    </tr>

    <tr>
        <td>1</td>
        <td>Rain Kisses</td>
        <td>Romantic</td>
        <td>4.7</td>
        <td>
            <button>Edit</button>
            <button>Delete</button>
        </td>
    </tr>

    <tr>
        <td>2</td>
        <td>Why Monday Exists</td>
        <td>Sarcastic</td>
        <td>4.1</td>
        <td>
            <button>Edit</button>
            <button>Delete</button>
        </td>
    </tr>
</table>
