<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Pot</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 400px; margin: 50px auto; }
        input[type="text"], input[type="password"], select {
            width: 100%; padding: 8px; margin: 8px 0;
        }
        .error { color: red; }
        a { text-decoration: none; color: blue; }
    </style>
</head>
<body>

<div class="container">
    <h2>Register</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } %>

    <form action="register" method="post">
        <label>Name:</label><br/>
        <input type="text" name="name" required /><br/>

        <label>Email:</label><br/>
        <input type="text" name="email" required /><br/>

        <label>Password:</label><br/>
        <input type="password" name="password" required /><br/>

        <label>Role:</label><br/>
        <select name="role" required>
            <option value="">--Select Role--</option>
            <option value="admin">Admin</option>
            <option value="user">User</option>
        </select><br/>

        <input type="submit" value="Register" />
    </form>

    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>

</body>
</html>
