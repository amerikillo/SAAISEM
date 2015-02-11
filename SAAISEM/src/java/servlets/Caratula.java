/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;
//import sun.org.mozilla.javascript.internal.ast.Loop;

/**
 *
 * @author Sistemas
 */
public class Caratula extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
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
        try {
                          
           
            String F_FacGNKLAgr="",Fecha1="",Fecha2="";
            int ban=0;
            DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            ConectionDB con = new ConectionDB();                
            con.conectar();
            HttpSession sesion = request.getSession(true);                
            F_FacGNKLAgr = request.getParameter("folios");
            Fecha1 = request.getParameter("fecha_ini1");
            Fecha2 = request.getParameter("fecha_fin1");
            ban = Integer.parseInt(request.getParameter("ban"));
            
           
            
            if (ban == 1){
                if((Fecha1 !="") && (Fecha2 !="") && (F_FacGNKLAgr !="")){                    
                    out.println(" <script>window.open('ReportesPuntos/ReporteCaratula.jsp?factura="+F_FacGNKLAgr+"&ban=1', '', 'width=1200,height=800,left=50,top=50,toolbar=no'); </script>");
                    out.println("<script>alert('se Genero Caratula Correctamente.')</script>");
                    out.println("<script>window.history.back()</script>");
                }else{
                    out.println("<script>alert('No se Genero Caratula.')</script>");
                    out.println("<script>window.history.back()</script>");
                }
            }else{
                if((Fecha1 !="") && (Fecha2 !="")){                    
                    out.println(" <script>window.open('ReportesPuntos/ReporteCaratula.jsp?Fecha1="+Fecha1+"&Fecha2="+Fecha2+"&ban=2', '', 'width=1200,height=800,left=50,top=50,toolbar=no'); </script>");
                    out.println("<script>alert('se Genero Caratula Correctamente.')</script>");
                    out.println("<script>window.history.back()</script>");
                }else{
                    out.println("<script>alert('No se Genero Caratula.')</script>");
                    out.println("<script>window.history.back()</script>");
                }
            }
         
                    
                    
                            
                          //  out.println(" <script>window.open('ReportesPuntos/ReporteHorizontal.jsp?F_Title="+F_Title+"&F_FecIni="+F_FecIni+"&F_FecFin="+F_FecFin+"&F_SecIni="+F_SecIni+"&F_SecFin="+F_SecFin+"&F_Surti="+F_Surti+"&F_Cober="+F_Cober+"&F_Sumi="+F_Sumi+"&F_Cvepro="+F_Cvepro+"&F_DesRegion="+F_DesRegion+"&FolCon="+F_FolCon+"', '', 'width=1200,height=800,left=50,top=50,toolbar=no'); </script>");
                            
                                                    
                   
            con.cierraConexion();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        /*String folio_sp = request.getParameter("sp_pac");
         System.out.println(folio_sp);
         out.println(folio_sp);*/
    }
    
public static void main (String[] args) 
    {
       
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
