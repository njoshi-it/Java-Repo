<!-- /dashboard/users.jsp -->
<jsp:include page="../includes/header.jsp" />
<h3>Manage Users</h3>

<button style="margin-bottom: 10px;">➕ Add User</button>

<table border="1" cellpadding="10" style="width: 100%;">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <tr>
        <td>1</td>
        <td>Nabin Joshi</td>
        <td>nabin@example.com</td>
        <td>user</td>
        <td>
            <button>Edit</button>
            <button>Delete</button>
            <button>Reset Password</button>
        </td>
    </tr>

    <tr>
        <td>2</td>
        <td>Aman Sharma</td>
        <td>aman@example.com</td>
        <td>admin</td>
        <td>
            <button>Edit</button>
            <button>Delete</button>
            <button>Reset Password</button>
        </td>
    </tr>
</table>
<jsp:include page="../includes/footer.jsp" />