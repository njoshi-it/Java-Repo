<%@ page session="true" %>
<%@ include file="../includes/header.jsp" %>
<%@ page import="potapp.model.Poem" %>
<%@ page import="potapp.dao.PoemDAO" %>
<%@ page import="potapp.model.User" %>

<%
    Poem poem = (Poem) request.getAttribute("poem");
    if (poem == null) {
        response.sendRedirect(request.getContextPath() + "/user_home.jsp?error=PoemNotFound");
        return;
    }

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String authorName = PoemDAO.getUserNameById(poem.getUserId());
    double avgRating = PoemDAO.getAverageRating(poem.getId());
    int userRating = PoemDAO.getUserRating(poem.getId(), currentUser.getId());
%>

<html>
<head>
    <title><%= poem.getTitle() %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f9f9f9;
        }
        .poem-card {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
            position: relative;
        }
        .poem-title {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        .poem-content {
            white-space: pre-wrap;
            font-size: 18px;
            line-height: 1.5;
            color: #444;
            margin-bottom: 60px;
        }
        .author-and-rating {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            position: absolute;
            bottom: 20px;
            right: 30px;
            font-size: 14px;
            color: #666;
            font-weight: 600;
        }
        .author-name {
            margin-right: 15px;
        }
        .star-rating {
            display: inline-flex;
            cursor: pointer;
            font-size: 22px;
            color: #ccc;
            user-select: none;
        }
        .star-rating .star {
            transition: color 0.2s ease;
            margin: 0 2px;
        }
        .star-rating .star.filled {
            color: #ffcc00;
        }
        .avg-rating {
            font-weight: 700;
            color: #333;
            min-width: 30px;
            text-align: left;
        }
    </style>
</head>
<body>

<div class="poem-card">
    <div class="poem-title"><%= poem.getTitle() %></div>
    <div class="poem-content"><%= poem.getContent() %></div>

    <div class="author-and-rating">
        <div class="author-name">By: <%= authorName %></div>

        <div id="rating-ui" class="star-rating" data-poem-id="<%= poem.getId() %>" data-user-rating="<%= userRating %>">
            <% for(int i=1; i<=5; i++) { %>
                <span class="star" data-value="<%= i %>">&#9733;</span>
            <% } %>
        </div>

        <div id="avg-rating" class="avg-rating"><%= String.format("%.1f", avgRating) %></div>
    </div>
</div>

<script>
(() => {
    const ratingUI = document.getElementById('rating-ui');
    const avgRatingDisplay = document.getElementById('avg-rating');
    const stars = ratingUI.querySelectorAll('.star');
    const poemId = ratingUI.getAttribute('data-poem-id');
    const initialUserRating = parseInt(ratingUI.getAttribute('data-user-rating'));

    function highlightStars(rating) {
        stars.forEach(star => {
            star.classList.toggle('filled', parseInt(star.dataset.value) <= rating);
        });
    }

    // Highlight user's existing rating if any
    if (!isNaN(initialUserRating) && initialUserRating > 0) {
        highlightStars(initialUserRating);
    }

    stars.forEach(star => {
        star.addEventListener('click', () => {
            const rating = star.dataset.value;
            fetch('<%= request.getContextPath() %>/RatePoemServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `poemId=${encodeURIComponent(poemId)}&rating=${encodeURIComponent(rating)}`
            })
            .then(response => response.text())
            .then(avg => {
                if (avg !== 'error') {
                    avgRatingDisplay.textContent = parseFloat(avg).toFixed(1);
                    highlightStars(parseInt(rating));
                } else {
                    alert('Error saving rating.');
                }
            })
            .catch(() => alert('Could not save rating.'));
        });
    });
})();
</script>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>
