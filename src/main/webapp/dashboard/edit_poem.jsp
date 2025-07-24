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

    Poem poem = (Poem) request.getAttribute("poem");
    if (poem == null) {
        out.println("Poem not found.");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Poem</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 30px;
        }

        .container {
            max-width: 800px;
            background: #fff;
            margin: auto;
            padding: 30px 40px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
        }

        h2 {
            margin-bottom: 25px;
            color: #343a40;
            font-size: 28px;
        }

        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 180px;
            transition: background 0.5s;
        }

        .form-group {
            margin-bottom: 20px;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 22px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            color: #007bff;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>

    <script>
        function applyBackgroundStyle() {
            const style = document.getElementById("backgroundStyle").value;
            const contentArea = document.getElementById("content");

            switch(style) {
                case "plain":
                    contentArea.style.background = "#ffffff";
                    break;
                case "parchment":
                    contentArea.style.background = "url('https://www.transparenttextures.com/patterns/old-mathematics.png')";
                    break;
                case "sky":
                    contentArea.style.background = "linear-gradient(#e0f7fa, #b2ebf2)";
                    break;
                case "dark":
                    contentArea.style.background = "#343a40";
                    contentArea.style.color = "#f8f9fa";
                    break;
                default:
                    contentArea.style.background = "#ffffff";
                    contentArea.style.color = "#000000";
            }

            if (style !== "dark") {
                contentArea.style.color = "#000000";
            }
        }
    </script>
</head>

<body>
    <div class="container">
        <h2>✏️ Edit Your Poem</h2>

        <form action="<%= request.getContextPath() %>/EditPoemServlet" method="post">
            <input type="hidden" name="id" value="<%= poem.getId() %>" />

            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" name="title" id="title" value="<%= poem.getTitle() %>" required />
            </div>

            <div class="form-group">
                <label for="category_id">Category:</label>
                <select name="category_id" id="category_id" required>
                    <option value="1" <%= (poem.getCategoryId() == 1 ? "selected" : "") %>>Romantic</option>
                    <option value="2" <%= (poem.getCategoryId() == 2 ? "selected" : "") %>>Patriotic</option>
                    <option value="3" <%= (poem.getCategoryId() == 3 ? "selected" : "") %>>Sarcastic</option>
                    <option value="4" <%= (poem.getCategoryId() == 4 ? "selected" : "") %>>Nature</option>
                </select>
            </div>

            <div class="form-group">
                <label for="backgroundStyle">Background Style:</label>
                <select id="backgroundStyle" onchange="applyBackgroundStyle()">
                    <option value="plain">Plain White</option>
                    <option value="parchment">Parchment</option>
                    <option value="sky">Sky Blue Gradient</option>
                    <option value="dark">Dark Mode</option>
                </select>
            </div>

            <div class="form-group">
                <label for="content">Poem Body:</label>
                <textarea name="content" id="content" required><%= poem.getContent() %></textarea>
            </div>

            <button type="submit">💾 Update Poem</button>
        </form>

        <a href="<%= request.getContextPath() %>/dashboard/user_posts.jsp" class="back-link">← Back to Posts</a>
    </div>

    <script>
        window.onload = applyBackgroundStyle; // apply default background on load
    </script>
</body>
</html>
