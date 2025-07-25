<%@ page import="java.util.List" %>
<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.Poem" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/includes/header.jsp" />

<%
    List<Poem> poems = (List<Poem>) request.getAttribute("allPoems");
%>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #f7f9fc;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 1000px;
        margin: 40px auto;
        background: white;
        padding: 30px 40px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    h2 {
        margin-top: 10px;
        margin-bottom: 40px;
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
    <h2><span style="font-size: 1.5em;">📜</span> All Poems</h2>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Rating</th>
                <th>Created At</th>
                <th class="actions">Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (poems == null || poems.isEmpty()) {
        %>
            <tr>
                <td colspan="6" style="text-align:center; font-style: italic; color: #777;">No poems found.</td>
            </tr>
        <%
            } else {
                for (Poem poem : poems) {
                	String authorName = PoemDAO.getUserNameById(poem.getUserId());
                    String categoryName = PoemDAO.getCategoryNameById(poem.getCategoryId());
                    double avgRating = PoemDAO.getAverageRating(poem.getId());
        %>
            <tr>
                <td data-label="Title"><%= poem.getTitle() %></td>
        <td data-label="Author"><%= authorName %></td>
        <td data-label="Category"><%= categoryName %></td>
        <td data-label="Rating"><%= String.format("%.1f", avgRating) %></td>
        <td data-label="Created At"><%= poem.getCreatedAt() %></td>
                <td class="actions" data-label="Actions">
                    <form action="<%= request.getContextPath() %>/ViewPoemServlet" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-secondary">View</button>
                    </form>
                    <form action="<%= request.getContextPath() %>/EditPoemServlet" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-primary">Edit</button>
                    </form>
                    <form action="<%= request.getContextPath() %>/DeletePoemServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this poem?');">
                        <input type="hidden" name="id" value="<%= poem.getId() %>">
                        <button type="submit" class="btn-danger">Delete</button>
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

<jsp:include page="/includes/footer.jsp" />
