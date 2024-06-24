/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package mobilet_controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hamidrezagholami74
 */
public class addToCard extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String quantity = request.getParameter("quantity");
        String pid = request.getParameter("pid");
        String ptype = request.getParameter("type");
        String color = request.getParameter("color");
        HashMap<String, String> order = new HashMap<>();        
        if (MobiletSystem.isUser(request)) {
            if (quantity == null) {
                MobiletSystem.removeFromCart(request, pid);
                response.sendRedirect(MobiletSystem.mainPath + ptype + "/" + pid + "&show=1");
            } else {
                order.put(pid, quantity+"-"+color);
                MobiletSystem.addtocart(request, order);
                response.sendRedirect(MobiletSystem.mainPath + ptype + "/" + pid);
            }
        } else {
            if (quantity == null) {
                response.sendRedirect(MobiletSystem.mainPath + ptype + "/" + pid + "&show=1");
            }else{
                order.put(pid, quantity+"-"+color);
            }
            if (MobiletSystem.setTempCart(request, order)) {
                response.sendRedirect(MobiletSystem.mainPath + "login&show=1");
            } else {
                MobiletSystem.error("setcookie:temp_cart:ERROR");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {        
        response.sendRedirect(MobiletSystem.mainPath+"index");
    }
    

}
