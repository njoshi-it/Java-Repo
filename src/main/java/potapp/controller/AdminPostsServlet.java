package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import potapp.dao.PoemDAO;
import potapp.model.Poem;

import java.io.IOException;
import java.util.List;

@WebServlet("/AdminPostsServlet")
public class AdminPostsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Poem> allPoems = new PoemDAO().getAllPoems();

        request.setAttribute("allPoems", allPoems);

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard/admin_posts.jsp");
        dispatcher.forward(request, response);
    }
}
