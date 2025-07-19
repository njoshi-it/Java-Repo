package potapp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import potapp.model.User;


import potapp.dao.PoemDAO;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/RatePoemServlet")
public class RatePoemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String poemIdStr = request.getParameter("poemId");
        String ratingStr = request.getParameter("rating");

        System.out.println("Received poemId: " + poemIdStr);
        System.out.println("Received rating: " + ratingStr);

        if (poemIdStr == null || poemIdStr.isEmpty() || ratingStr == null || ratingStr.isEmpty()) {
            System.out.println("Missing parameter(s)");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing poemId or rating");
            return;
        }

        try {
            int poemId = Integer.parseInt(poemIdStr);
            int rating = Integer.parseInt(ratingStr);
            User user = (User) request.getSession().getAttribute("user");
            int userId = user.getId();

            PoemDAO.saveRating(poemId, userId, rating);
            double average = PoemDAO.getAverageRating(poemId);

            response.setContentType("application/json");
            response.getWriter().write("{\"average\":" + average + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }
}
