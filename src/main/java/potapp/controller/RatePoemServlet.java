package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import potapp.dao.PoemDAO;
import potapp.model.User;

@WebServlet("/RatePoemServlet")
public class RatePoemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            int poemId = Integer.parseInt(request.getParameter("poemId"));
            int rating = Integer.parseInt(request.getParameter("rating"));

            // Save or update rating in DB
            PoemDAO.saveOrUpdateRating(poemId, user.getId(), rating);

            // Redirect back to the poem page to see updated rating
            response.sendRedirect(request.getContextPath() + "/ViewPoemServlet?id=" + poemId);

        } catch (NumberFormatException e) {
            // Invalid input, redirect somewhere
            response.sendRedirect(request.getContextPath() + "/user_home.jsp?error=InvalidInput");
        }
    }
}
