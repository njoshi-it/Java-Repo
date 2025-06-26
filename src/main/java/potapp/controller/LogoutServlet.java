package potapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // fetch session if exists

        if (session != null) {
            session.invalidate(); // destroy session on logout
        }

        response.sendRedirect("login.jsp"); // redirect to login page after logout
    }
}
