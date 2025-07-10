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

<h2>All Poems by Everyone (Grouped by Category)</h2>

<h3>Romantic</h3>
<ul>
    <li>🌸 *Rain Kisses* by Nabin Joshi</li>
    <li>💕 *Midnight Confession* by Priya Lama</li>
</ul>

<h3>Sarcastic</h3>
<ul>
    <li>😂 *Why Monday Exists* by Aman Sharma</li>
    <li>🙃 *Wifi of Doom* by Kiran Pandey</li>
</ul>

<h3>Patriotic</h3>
<ul>
    <li>🇳🇵 *Voice of My Land* by Arjun Rai</li>
</ul>
<jsp:include page="../includes/footer.jsp" />