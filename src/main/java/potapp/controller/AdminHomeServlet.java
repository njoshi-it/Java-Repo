package potapp.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import potapp.dao.PoemDAO;
import potapp.model.Poem;

import java.io.IOException;
import java.util.*;

@WebServlet("/AdminHomeServlet")
public class AdminHomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<Integer, List<Poem>> poemsByCategory = PoemDAO.getPoemsGroupedByCategory();
        Map<Integer, String> categoryNames = new HashMap<>();

        for (Integer catId : poemsByCategory.keySet()) {
            String name = PoemDAO.getCategoryNameById(catId);
            categoryNames.put(catId, name);
        }

        request.setAttribute("poemsByCategory", poemsByCategory);
        request.setAttribute("categoryNames", categoryNames);

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard/admin_home.jsp");
        dispatcher.forward(request, response);
    }
}
