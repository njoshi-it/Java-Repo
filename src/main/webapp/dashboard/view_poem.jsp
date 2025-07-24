<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<%@ include file="../includes/header.jsp" %>

<%
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Poem poem = (Poem) request.getAttribute("poem");
    String creatorName = (String) request.getAttribute("creatorName");
    double avgRating = 0.0;
    int userRating = 0;

    Object avgRatingObj = request.getAttribute("avgRating");
    if (avgRatingObj != null) avgRating = (Double) avgRatingObj;

    Object userRatingObj = request.getAttribute("userRating");
    if (userRatingObj != null) userRating = (Integer) userRatingObj;

    if (poem == null) {
%>
    <p>Poem not found.</p>
<%
        return;
    }
%>

<style>
    .view-container {
        max-width: 700px;
        margin: 30px auto;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #fff;
        padding: 25px 30px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    }

    .view-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 10px;
        color: #2c3e50;
        border-bottom: 2px solid #eee;
        padding-bottom: 8px;
    }

    .view-author {
        font-size: 15px;
        color: #7f8c8d;
        margin-bottom: 25px;
    }

    .view-content {
        background-color: #f4f4f4;
        padding: 20px;
        border-radius: 8px;
        font-size: 17px;
        color: #2d3436;
        line-height: 1.7;
        white-space: pre-wrap;
    }

    .rating-section {
        margin-top: 35px;
    }

    .rating-section p {
        font-size: 15px;
        margin-bottom: 8px;
        font-weight: 500;
        color: #333;
    }

    .star-btn {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 28px;
        color: #ccc;
        transition: transform 0.2s;
    }

    .star-btn:hover {
        transform: scale(1.2);
    }

    .star-filled {
        color: #f1c40f;
    }

    .avg-rating {
        font-weight: bold;
        font-size: 15px;
        margin-left: 10px;
        color: #444;
    }
</style>

<div class="view-container">
    <div class="view-title"><%= poem.getTitle() %></div>
    <div class="view-author">By: <strong><%= creatorName %></strong></div>

    <div class="view-content">
        <%= poem.getContent() %>
    </div>

    <!-- Rating Section -->
    <div class="rating-section">
        <p>Rate this poem:</p>
        <%
            for (int i = 1; i <= 5; i++) {
                boolean filled = (userRating >= i);
        %>
            <form action="<%= request.getContextPath() %>/RatePoemServlet" method="post" style="display:inline;">
                <input type="hidden" name="poemId" value="<%= poem.getId() %>">
                <input type="hidden" name="rating" value="<%= i %>">
                <button type="submit"
                        class="star-btn <%= filled ? "star-filled" : "" %>">
                    ★
                </button>
            </form>
        <%
            }
        %>
        <span class="avg-rating">Avg: <%= String.format("%.1f", avgRating) %></span>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>
