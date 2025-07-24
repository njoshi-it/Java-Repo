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

<style>
    .container {
        max-width: 800px;
        margin: 40px auto;
        padding: 30px;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .container h2 {
        text-align: center;
        margin-bottom: 25px;
        font-size: 28px;
        color: #333;
    }

    label {
        font-weight: 500;
        display: block;
        margin-bottom: 5px;
        color: #444;
    }

    input[type="text"], select, textarea {
        width: 100%;
        padding: 12px 15px;
        font-size: 16px;
        border-radius: 8px;
        border: 1px solid #ccc;
        margin-bottom: 20px;
        transition: border-color 0.3s;
    }

    input:focus, textarea:focus, select:focus {
        border-color: #3f51b5;
        outline: none;
    }

    textarea {
        resize: vertical;
    }

    .bg-selector {
        margin-bottom: 15px;
    }

    button[type="submit"] {
        background-color: #3f51b5;
        color: white;
        padding: 12px 25px;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button[type="submit"]:hover {
        background-color: #303f9f;
    }

    /* Background style options */
    .plain-bg {
        background: #ffffff;
        color: #333;
    }

    .gradient-bg {
        background: linear-gradient(to right, #fceabb, #f8b500);
        color: #000;
    }

    .parchment-bg {
        background: url('<%= request.getContextPath() %>/images/parchment-texture.png');
        background-size: cover;
        color: #3e2723;
    }

    .dark-bg {
        background: #2c3e50;
        color: #ecf0f1;
    }
</style>

<div class="container">
    <h2>📝 Create New Poem</h2>

    <form action="<%= request.getContextPath() %>/CreatePoemServlet" method="post">
        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required>

        <label for="category">Category:</label>
        <select name="category_id" id="category" required>
            <option value="1">Romantic</option>
            <option value="2">Patriotic</option>
            <option value="3">Sarcastic</option>
            <option value="4">Nature</option>
        </select>

        <label for="bg-style">Choose Background Style:</label>
        <select id="bg-style" name="bgStyle" class="bg-selector" onchange="applyBackgroundStyle()">
            <option value="plain">Plain</option>
            <option value="gradient">Gradient</option>
            <option value="parchment">Parchment</option>
            <option value="dark">Dark</option>
        </select>

        <label for="content">Content:</label>
        <textarea name="content" id="poemContent" rows="10" required class="poem-textarea plain-bg"></textarea>

        <button type="submit">Create</button>
    </form>
</div>

<script>
    function applyBackgroundStyle() {
        const textarea = document.getElementById('poemContent');
        const selectedStyle = document.getElementById('bg-style').value;

        // Remove all background classes first
        textarea.classList.remove("plain-bg", "gradient-bg", "parchment-bg", "dark-bg");

        // Apply selected background class
        textarea.classList.add(selectedStyle + "-bg");
    }
</script>
