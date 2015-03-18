/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import java.sql.*;
import conn.*;// package que contiene la Clase ConectionDBS

/**
 *
 * @author wence
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

    ConectionDB con = new ConectionDB();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        try {
            /* TODO output your page here. You may use following sample code. */
            try {
                con.conectar();
                try {
                    String F_Usu = "", F_nombre = "", F_TipUsu = "";
                    int ban = 0;
                    ResultSet rset = con.consulta(" select F_Usu, F_nombre, F_Status, F_TipUsu from tb_usuario where F_Usu = '" + request.getParameter("nombre") + "' and F_Pass = MD5('" + request.getParameter("pass") + "')  ");
                    while (rset.next()) {
                        ban = 1;
                        F_Usu = rset.getString("F_Usu");
                        F_nombre = rset.getString("F_nombre");
                        F_TipUsu = rset.getString("F_TipUsu");
                    }
                    if (ban == 1) {//----------------------EL USUARIO ES VÁLIDO
                        sesion.setAttribute("Usuario", F_Usu);
                        sesion.setAttribute("nombre", F_nombre);
                        sesion.setAttribute("Tipo", F_TipUsu);
                        sesion.setAttribute("posClave", "0");
                        con.insertar("insert into tb_registroentradas values ('" + request.getParameter("nombre") + "',NOW(),1,0)");
                        response.sendRedirect("main_menu.jsp");
                    } else {//--------------------------EL USUARIO NO ES VÁLIDO
                        out.println("hola");
                        con.insertar("insert into tb_registroentradas values ('" + request.getParameter("nombre") + "',NOW(),0,0)");
                        sesion.setAttribute("mensaje", "Usuario no válido");
                        response.sendRedirect("index.jsp");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}// end of the Class
