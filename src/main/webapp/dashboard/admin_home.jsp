<%@ page session="true" %>
<%@ include file="../includes/header.jsp" %>
<%@ page import="java.util.*, potapp.dao.PoemDAO, potapp.model.Poem, potapp.model.User" %>

<html>
<head>
    <title>Admin Home</title>
    <style>
        .category-section {
            margin-bottom: 30px;
        }

        .category-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .poem-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        .poem-card {
            background: #f4f4f4;
            border-radius: 10px;
            padding: 20px;
            cursor: pointer;
            position: relative;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: 1px solid #ccc;
        }

        .poem-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .poem-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .poem-body {
            color: #555;
            font-size: 14px;
            margin-bottom: 25px;
        }

        .poem-author {
            position: absolute;
            bottom: 15px;
            right: 20px;
            font-size: 13px;
            color: #888;
        }

        a.card-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

<div style="padding: 20px;">
    <%
        Map<Integer, List<Poem>> categoryMap = PoemDAO.getPoemsGroupedByCategory();
        for (Map.Entry<Integer, List<Poem>> entry : categoryMap.entrySet()) {
            int categoryId = entry.getKey();
            String categoryName = PoemDAO.getCategoryNameById(categoryId);
            List<Poem> poems = entry.getValue();
            if (poems != null && !poems.isEmpty()) {
    %>
    <div class="category-section">
        <div class="category-title"><%= categoryName %> Poems</div>
        <div class="poem-grid">
            <% for (Poem poem : poems) { %>
                <a class="card-link" href="<%= request.getContextPath() %>/ViewPoemServlet?id=<%= poem.getId() %>">
                    <div class="poem-card">
                        <div class="poem-title"><%= poem.getTitle() %></div>
                        <div class="poem-body">
                            <%= poem.getContent().length() > 100 ? poem.getContent().substring(0, 100) + "..." : poem.getContent() %>
                        </div>
                        <div class="poem-author">By: <%= poem.getUser().getName() %></div>
                    </div>
                </a>
            <% } %>
        </div>
    </div>
    <% 
            } 
        } 
    %>

</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>
