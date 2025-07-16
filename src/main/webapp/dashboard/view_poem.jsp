<%@ page import="potapp.model.Poem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    Poem poem = (Poem) request.getAttribute("poem");
    String creatorName = (String) request.getAttribute("creatorName");
    String categoryName = (String) request.getAttribute("categoryName");

    if (poem == null) {
%>
    <p>Poem not found.</p>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Poem</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .poem-container {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .poem-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .poem-meta {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .poem-content {
            font-size: 16px;
            white-space: pre-line;
        }
        .back-btn {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="poem-container">
    <div class="poem-title"><%= poem.getTitle() %></div>
    <div class="poem-meta">
        Category: <strong><%= categoryName %></strong><br>
        Created by: <strong><%= creatorName %></strong><br>
        Created at: <strong><%= poem.getCreatedAt() %></strong>
    </div>
    <div class="poem-content">
        <%= poem.getContent() %>
    </div>
    <div class="back-btn">
        <a href="user_posts.jsp">← Back to Posts</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />

</body>
</html>
