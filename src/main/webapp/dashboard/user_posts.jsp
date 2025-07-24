<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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


    .btn-primary, .btn-danger, .btn-secondary {
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: 600;
        transition: background-color 0.3s ease;
        font-size: 14px;
        margin-right: 5px;
    }
    .btn-primary {
        background-color: #007bff;
        color: white;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    .btn-danger {
        background-color: #dc3545;
        color: white;
    }
    .btn-danger:hover {
        background-color: #a71d2a;
    }
    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }
    .btn-secondary:hover {
        background-color: #4e555b;
    }

    .create-btn {
        display: inline-block;
        margin-bottom: 25px;
        text-decoration: none;
        font-size: 15px;
        background-color: #28a745;
        color: white;
        padding: 10px 20px;
        border-radius: 7px;
        font-weight: 600;
        box-shadow: 0 3px 8px rgba(40,167,69,0.4);
        transition: background-color 0.3s ease;
    }
    .create-btn:hover {
        background-color: #1e7e34;
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
    <h2>
  <span style="font-size: 1.5em; line-height: 1;">&#128218;</span> My Poems
</h2>


    <a href="create_poem.jsp" class="create-btn">➕ Create New Post</a>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Category</th>
                <th>Rating</th>
                <th>Created At</th>
                <th class="actions">Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (myPoems.isEmpty()) {
        %>
            <tr>
                <td colspan="5" style="text-align:center; font-style: italic; color: #777;">No poems found.</td>
            </tr>
        <%
            } else {
                for (Poem poem : myPoems) {
                    String categoryName = potapp.dao.PoemDAO.getCategoryNameById(poem.getCategoryId());
        %>
            <tr>
                <td data-label="Title"><%= poem.getTitle() %></td>
                <td data-label="Category"><%= categoryName %></td>
                <td data-label="Rating"><%= String.format("%.1f", poem.getRating()) %></td>
                <td data-label="Created At"><%= poem.getCreatedAt() %></td>
                <td class="actions" data-label="Actions">
                    <form action="<%= request.getContextPath() %>/EditPoemServlet" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-primary">Edit</button>
                    </form>

                    <form action="<%= request.getContextPath() %>/DeletePoemServlet" method="get" style="display:inline;" 
                          onsubmit="return confirm('Are you sure you want to delete this poem?');">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-danger">Delete</button>
                    </form>

                    <form action="<%= request.getContextPath() %>/ViewPoemServlet" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-secondary">View</button>
                    </form>
                </td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
