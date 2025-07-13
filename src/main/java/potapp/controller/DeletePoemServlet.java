package potapp.controller;

import potapp.dao.PoemDAO;
import potapp.model.Poem;
import potapp.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeletePoemServlet")
public class DeletePoemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !"user".equals(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int poemId = Integer.parseInt(request.getParameter("id"));
        PoemDAO poemDAO = new PoemDAO();
        Poem poem = poemDAO.getPoemById(poemId);

        // Ensure that the user owns the poem
        if (poem != null && poem.getUserId() == currentUser.getId()) {
            poemDAO.deletePoem(poemId);
        }

        response.sendRedirect(request.getContextPath() + "/dashboard/user_posts.jsp");
    }
}
