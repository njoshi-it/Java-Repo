<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Pot</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 400px; margin: 50px auto; }
        input[type="text"], input[type="password"] {
            width: 100%; padding: 8px; margin: 8px 0;
        }
        .error { color: red; }
        .success { color: green; }
        a { text-decoration: none; color: blue; }
    </style>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% String registered = request.getParameter("registered"); %>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <% if ("true".equals(registered)) { %>
        <p class="success">Registration successful! Please login.</p>
    <% } %>

    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
        <label>Email:</label><br/>
        <input type="text" name="email" required /><br/>

        <label>Password:</label><br/>
        <input type="password" name="password" required /><br/>

        <input type="submit" value="Login" />
    </form>

    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</div>

</body>
</html>
