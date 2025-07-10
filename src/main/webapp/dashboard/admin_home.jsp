<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<jsp:include page="../includes/header.jsp" />

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<h2>Admin Dashboard</h2>
<p>Welcome, <%= currentUser.getName() %>!</p>

<!-- Add links to manage users, poems, stats etc -->

<jsp:include page="../includes/footer.jsp" />
