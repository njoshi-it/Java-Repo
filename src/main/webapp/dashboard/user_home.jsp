<%@ page import="potapp.model.User" %>
<%@ page session="true" %>
<jsp:include page="../includes/header.jsp" />

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null || !"user".equals(currentUser.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<h2>User Dashboard</h2>
<p>Welcome, <%= currentUser.getName() %>!</p>

<!-- Add sections to show user’s poems, create new poem, etc -->

<jsp:include page="../includes/footer.jsp" />
