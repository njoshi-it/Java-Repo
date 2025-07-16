package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import potapp.dao.PoemDAO;
import potapp.model.Poem;

@WebServlet("/ViewPoemServlet")
public class ViewPoemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Get the poem by ID
            Poem poem = PoemDAO.getPoemById(id);

            if (poem != null) {
                // Fetch creator name and category name using helper methods in PoemDAO
                String creatorName = PoemDAO.getUserNameById(poem.getUserId());
                String categoryName = PoemDAO.getCategoryNameById(poem.getCategoryId());

                // Set attributes for JSP
                request.setAttribute("poem", poem);
                request.setAttribute("creatorName", creatorName);
                request.setAttribute("categoryName", categoryName);

                // Forward to view_poem.jsp inside dashboard folder
                RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard/view_poem.jsp");
                dispatcher.forward(request, response);
            } else {
                // Poem not found, redirect or show error
                response.sendRedirect("user_home.jsp?error=PoemNotFound");
            }

        } catch (NumberFormatException e) {
            // If id param is not a number
            response.sendRedirect("user_home.jsp?error=InvalidPoemId");
        }
    }
}
