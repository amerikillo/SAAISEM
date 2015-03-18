/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class loginISEM extends HttpServlet {

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
                    String F_IdUsu = "", F_nombre = "", F_TipUsu = "";
                    int ban = 0;
                    ResultSet rset = con.consulta(" select F_IdUsu from tb_usuariosisem where F_Usuario = '" + request.getParameter("nombre") + "' and F_Clave = PASSWORD('" + request.getParameter("pass") + "')  ");
                    while (rset.next()) {
                        ban = 1;
                        F_IdUsu = rset.getString("F_IdUsu");
                    }
                    if (ban == 1) {//----------------------EL USUARIO ES VÁLIDO
                        sesion.setAttribute("Usuario", F_IdUsu);
                        con.insertar("insert into tb_entradasisem values ('"+request.getParameter("nombre")+"',NOW(),1,0)");
                        response.sendRedirect("capturaISEM.jsp");
                    } else {//--------------------------EL USUARIO NO ES VÁLIDO
                        sesion.setAttribute("mensaje", "Usuario no válido");
                        con.insertar("insert into tb_entradasisem values ('"+request.getParameter("nombre")+"',NOW(),0,0)");
                        response.sendRedirect("indexIsem.jsp");
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

}
