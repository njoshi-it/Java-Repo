package potapp.controller;

import potapp.dao.PoemDAO;
import potapp.model.Poem;
import potapp.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditPoemServlet")
public class EditPoemServlet extends HttpServlet {

    // ✅ Called when user clicks "Edit" button (GET)
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

        // Ensure user owns this poem
        if (poem == null || poem.getUserId() != currentUser.getId()) {
            response.sendRedirect(request.getContextPath() + "/dashboard/user_posts.jsp");
            return;
        }

        request.setAttribute("poem", poem);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/dashboard/edit_poem.jsp");
        dispatcher.forward(request, response);
    }

    // ✅ Called when form is submitted to save changes (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !"user".equals(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int categoryId = Integer.parseInt(request.getParameter("category_id"));

        PoemDAO poemDAO = new PoemDAO();
        Poem existing = poemDAO.getPoemById(id);

        if (existing == null || existing.getUserId() != currentUser.getId()) {
            response.sendRedirect(request.getContextPath() + "/dashboard/user_posts.jsp");
            return;
        }

        existing.setTitle(title);
        existing.setContent(content);
        existing.setCategoryId(categoryId);

        poemDAO.updatePoem(existing);
        response.sendRedirect(request.getContextPath() + "/dashboard/user_posts.jsp");
    }
}
