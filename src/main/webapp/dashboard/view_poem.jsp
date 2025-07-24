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


<div style="max-width: 700px; margin: auto; font-family: Arial, sans-serif;">
    <h2 style="color: #333; border-bottom: 2px solid #ddd; padding-bottom: 10px;">
        <%= poem.getTitle() %>
    </h2>
    <p style="color: #666; font-size: 14px;">By: <strong><%= creatorName %></strong></p>
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
                <button type="submit"
                        style="background: none; border: none; cursor: pointer; font-size: 24px; color: <%= filled ? "#f5c518" : "#ccc" %>;">
                    ★
                </button>
            </form>
        <%
            }
        %>
        &nbsp; <span style="font-weight: bold;">Avg: <%= String.format("%.1f", avgRating) %></span>
    </div>
</div>

<%@ include file="../includes/footer.jsp" %>
