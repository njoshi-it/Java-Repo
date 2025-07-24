<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.model.User" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Poem poem = (Poem) request.getAttribute("poem");
    String authorName = (String) request.getAttribute("authorName");
    Double avgRatingObj = (Double) request.getAttribute("avgRating");
    double avgRating = (avgRatingObj != null) ? avgRatingObj : 0.0;

    Integer userRatingObj = (Integer) request.getAttribute("userRating");
    int userRating = (userRatingObj != null) ? userRatingObj : 0;
    if (poem == null) {
%>
    <p>Poem not found.</p>
<%
        return;
    }
%>

<!-- Simple Back Button -->
<div style="padding: 20px;">
    <form action="<%= request.getContextPath() %>/<%= currentUser.getRole().equals("admin") ? "dashboard/admin_posts.jsp" : "dashboard/user_posts.jsp" %>">
        <button style="background-color: #eee; border: 1px solid #ccc; padding: 8px 12px; font-size: 14px; cursor: pointer; border-radius: 6px;">← Back</button>
    </form>
</div>

<!-- Poem Content -->
<div style="max-width: 700px; margin: auto; font-family: Arial, sans-serif;">
    <h2 style="color: #333; border-bottom: 2px solid #ddd; padding-bottom: 10px;">
        <%= poem.getTitle() %>
    </h2>
    <p style="color: #666; font-size: 14px;">By: <strong><%= authorName %></strong></p>
    <div style="background: #f9f9f9; padding: 20px; border-radius: 8px; margin-top: 20px;">
        <pre style="white-space: pre-wrap; font-family: inherit;"><%= poem.getContent() %></pre>
    </div>

    <!-- Rating Section -->
    <div style="margin-top: 30px;">
        <p style="margin-bottom: 5px;">Rate this poem:</p>
        <%
            for (int i = 1; i <= 5; i++) {
                boolean filled = (userRating >= i);
        %>
            <form action="<%= request.getContextPath() %>/RatePoemServlet" method="post" style="display:inline;">
                <input type="hidden" name="poemId" value="<%= poem.getId() %>">
                <input type="hidden" name="rating" value="<%= i %>">
                <button type="submit" style="background: none; border: none; cursor: pointer; font-size: 24px; color: <%= filled ? "#f5c518" : "#ccc" %>;">
                    ★
                </button>
            </form>
        <%
            }
        %>
        &nbsp; <span style="font-weight: bold;">Avg: <%= String.format("%.1f", avgRating) %></span>
    </div>
</div>
