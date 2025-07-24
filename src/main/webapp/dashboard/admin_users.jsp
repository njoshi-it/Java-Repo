<%@ page import="java.util.List, potapp.model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/includes/header.jsp" />

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f7f9fc;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 900px;
        margin: 40px auto;
        background: white;
        padding: 30px 40px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    h2 {
        margin-top: 10px;    /* reduce top margin */
        margin-bottom: 40px; /* increase bottom margin */
        font-weight: 700;
        color: #333;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 10px;
    }

    thead th {
        text-align: left;
        font-weight: 700;
        padding: 12px 15px;
        background-color: #f0f0f0;
        color: #555;
        border-radius: 8px;
    }

    tbody tr {
        background: white;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        border-radius: 8px;
    }

    tbody tr:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.15);
    }

    tbody td {
        padding: 14px 15px;
        color: #444;
        vertical-align: middle;
        font-size: 15px;
    }

    .actions {
        white-space: nowrap;
    }

    .btn-warning, .btn-danger {
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 600;
        transition: background-color 0.3s ease;
        font-size: 14px;
        margin-right: 5px;
        color: white;
    }

    .btn-warning {
        background-color: #ffc107;
    }

    .btn-warning:hover {
        background-color: #d39e00;
    }

    .btn-danger {
        background-color: #dc3545;
    }

    .btn-danger:hover {
        background-color: #a71d2a;
    }

    /* Responsive for smaller screens */
    @media (max-width: 600px) {
        .container {
            padding: 20px;
            margin: 20px;
        }

        table, thead, tbody, th, td, tr {
            display: block;
        }

        thead tr {
            display: none;
        }

        tbody tr {
            margin-bottom: 20px;
            box-shadow: none;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
        }

        tbody td {
            padding: 10px 5px;
            text-align: right;
            position: relative;
            font-size: 14px;
        }

        tbody td::before {
            content: attr(data-label);
            position: absolute;
            left: 15px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 12px;
            color: #777;
            text-align: left;
        }

        .actions {
            text-align: center;
        }
    }
</style>

<div class="container">
    <h2>👥 Admin Dashboard - Users</h2>

    <%
        List<User> users = (List<User>) request.getAttribute("users");

        if (users == null || users.isEmpty()) {
    %>
        <p style="text-align:center; font-style: italic; color: #777;">No users found.</p>
    <%
        } else {
    %>
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th class="actions">Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (User user : users) { %>
                <tr>
                    <td data-label="Name"><%= user.getName() %></td>
                    <td data-label="Email"><%= user.getEmail() %></td>
                    <td data-label="Role"><%= user.getRole() %></td>
                    <td class="actions" data-label="Actions">
                        <form action="<%= request.getContextPath() %>/EditUserServlet" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= user.getId() %>" />
                            <button type="submit" class="btn-warning">Edit</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/DeleteUserServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                            <input type="hidden" name="id" value="<%= user.getId() %>" />
                            <button type="submit" class="btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <%
        }
    %>
</div>

<jsp:include page="/includes/footer.jsp" />
