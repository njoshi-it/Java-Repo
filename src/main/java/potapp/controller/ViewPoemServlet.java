package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import potapp.dao.PoemDAO;
import potapp.model.Poem;
import potapp.model.User;

@WebServlet("/ViewPoemServlet")
public class ViewPoemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Get the poem by ID
            Poem poem = PoemDAO.getPoemById(id);

            if (poem != null) {
                // Get current logged in user from session
                HttpSession session = request.getSession(false);
                User currentUser = null;
                int currentUserId = 0;
                if (session != null) {
                    currentUser = (User) session.getAttribute("user");
                    if (currentUser != null) {
                        currentUserId = currentUser.getId();
                    }
                }

                // Fetch creator name and category name
                String creatorName = PoemDAO.getUserNameById(poem.getUserId());
                // Optional if you want category name
                // String categoryName = PoemDAO.getCategoryNameById(poem.getCategoryId());

                // Get rating info
                Double avgRating = PoemDAO.getAverageRating(poem.getId());
                Integer userRating = PoemDAO.getUserRating(poem.getId(), currentUserId);

                // Set attributes for JSP
                request.setAttribute("poem", poem);
                request.setAttribute("creatorName", creatorName);
                request.setAttribute("avgRating", (avgRating != null) ? avgRating : 0.0);
                request.setAttribute("userRating", (userRating != null) ? userRating : 0);

                // Forward to JSP
                RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard/view_poem.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("user_home.jsp?error=PoemNotFound");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("user_home.jsp?error=InvalidPoemId");
        }
    }
}
