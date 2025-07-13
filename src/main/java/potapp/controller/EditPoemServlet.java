package potapp.controller;

import potapp.dao.PoemDAO;
import potapp.model.Poem;
import potapp.model.User;
import potapp.util.DBUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditPoemServlet")
public class EditPoemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("user");
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
            response.sendRedirect("dashboard/user_posts.jsp"); // or show error
            return;
        }

        existing.setTitle(title);
        existing.setContent(content);
        existing.setCategoryId(categoryId);

        poemDAO.updatePoem(existing);
        response.sendRedirect(request.getContextPath() + "/dashboard/user_posts.jsp");
    }
}
