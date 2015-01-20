/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ISEM;

import Correo.*;
import conn.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class CapturaPedidos extends HttpServlet {

    ConectionDB con = new ConectionDB();
    DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    CancelaCompra correoCancela = new CancelaCompra();
    Correo correo = new Correo();

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
            if (request.getParameter("accion").equals("verFolio")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select o.F_NoCompra, p.F_NomPro, DATE_FORMAT(o.F_FecSur, '%d/%m/%Y'), F_HorSur, p.F_ClaProve from tb_pedidoisem o, tb_proveedor p where o.F_Provee = p.F_ClaProve and F_NoCompra = '" + request.getParameter("NoCompra") + "'  group by o.F_NoCompra");
                    while (rset.next()) {

                        sesion.setAttribute("NoOrdCompra", rset.getString(1));
                        sesion.setAttribute("proveedor", rset.getString(2));
                        sesion.setAttribute("fec_entrega", rset.getString(3));
                        sesion.setAttribute("hor_entrega", rset.getString(4));
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
                response.sendRedirect("verFoliosIsem.jsp");
            }
            if (request.getParameter("accion").equals("eliminaClave")) {
                con.conectar();
                try {
                    con.insertar("delete from tb_pedidoisem where F_IdIsem = '" + request.getParameter("id") + "' ");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
                response.sendRedirect("capturaISEM.jsp");
            }
            if (request.getParameter("accion").equals("Actualizar")) { 
                sesion.setAttribute("NoOrdCompra", request.getParameter("NoCompra"));
                out.println("<script>window.location='capturaISEM.jsp'</script>");
            }
            if (request.getParameter("accion").equals("Clave")) {
                System.out.println("Hola");
                int ordenCapturada = 0;
                try {
                    con.conectar();
                    ResultSet rset2 = con.consulta("select F_IdIsem from tb_pedidoisem where F_Provee = '" + request.getParameter("Proveedor") + "' and F_FecSur = '" + df.format(df2.parse(request.getParameter("Fecha"))) + "' and F_NoCompra !='" + request.getParameter("NoCompra") + "' and F_StsPed!='2' ");
                    while (rset2.next()) {
                        ordenCapturada = 1;
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                if (ordenCapturada == 1) {
                    out.println("<script>alert('Orden Ya Capturada Previamente')</script>");
                    out.println("<script>window.location='capturaISEM.jsp'</script>");
                } else {
                    String NoCompra = (String) sesion.getAttribute("NoCompra");
                    int ban = 0;
                    con.conectar();
                    try {
                        ResultSet rset = con.consulta("select F_ClaPro, F_DesPro from tb_medica where F_ClaPro = '" + request.getParameter("Clave") + "'");
                        while (rset.next()) {
                            ban = 1;
                            sesion.setAttribute("clave", rset.getString(1));
                            sesion.setAttribute("descripcion", rset.getString(2));
                        }
                        sesion.setAttribute("proveedor", request.getParameter("Proveedor"));
                        sesion.setAttribute("fec_entrega", request.getParameter("Fecha"));
                        sesion.setAttribute("hor_entrega", request.getParameter("Hora"));
                        sesion.setAttribute("NoOrdCompra", request.getParameter("NoCompra"));

                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();

                    if (ban == 1) {
                        try {
                            if (NoCompra.equals("") || NoCompra == null) {
                                try {
                                    int ban2 = 0;
                                    con.conectar();
                                    ResultSet rset = con.consulta("select F_IdIsem from tb_pedidoisem where F_NoCompra = '" + request.getParameter("NoCompra") + "'");
                                    while (rset.next()) {
                                        ban2 = 1;
                                    }
                                    con.cierraConexion();
                                    if (ban2 == 1) {
                                        sesion.setAttribute("NoOrdCompra", "");
                                        sesion.setAttribute("clave", "");
                                        sesion.setAttribute("descripcion", "");
                                        out.println("<script>alert('Número de Compra ya utilizado')</script>");
                                        out.println("<script>window.location='capturaISEM.jsp'</script>");
                                    }
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            }
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }

                        out.println("<script>window.location='capturaISEM.jsp'</script>");
                    } else {
                        sesion.setAttribute("clave", "");
                        sesion.setAttribute("descripcion", "");
                        out.println("<script>alert('Insumo Inexistente')</script>");
                        out.println("<script>window.location='capturaISEM.jsp'</script>");
                    }
                }

            }

            if (request.getParameter("accion").equals("Descripcion")) {
                String NoCompra = (String) sesion.getAttribute("NoCompra");
                int ban = 0;
                con.conectar();
                try {
                    ResultSet rset = con.consulta("select F_ClaPro, F_DesPro from tb_medica where F_DesPro = '" + request.getParameter("Descripcion") + "'");
                    while (rset.next()) {
                        ban = 1;
                        sesion.setAttribute("clave", rset.getString(1));
                        sesion.setAttribute("descripcion", rset.getString(2));
                    }
                    sesion.setAttribute("proveedor", request.getParameter("Proveedor"));
                    sesion.setAttribute("fec_entrega", request.getParameter("Fecha"));
                    sesion.setAttribute("hor_entrega", request.getParameter("Hora"));
                    sesion.setAttribute("NoOrdCompra", request.getParameter("NoCompra"));

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();

                if (ban == 1) {
                    try {
                        if (NoCompra.equals("") || NoCompra == null) {
                            try {
                                int ban2 = 0;
                                con.conectar();
                                ResultSet rset = con.consulta("select F_IdIsem from tb_pedidoisem where F_NoCompra = '" + request.getParameter("NoCompra") + "'");
                                while (rset.next()) {
                                    ban2 = 1;
                                }
                                con.cierraConexion();
                                if (ban2 == 1) {
                                    sesion.setAttribute("NoOrdCompra", "");
                                    sesion.setAttribute("clave", "");
                                    sesion.setAttribute("descripcion", "");
                                    out.println("<script>alert('Número de Compra ya utilizado')</script>");
                                    out.println("<script>window.location='capturaISEM.jsp'</script>");
                                }
                            } catch (Exception e) {
                                System.out.println(e.getMessage());
                            }
                        }
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }

                    out.println("<script>window.location='capturaISEM.jsp'</script>");
                } else {
                    sesion.setAttribute("clave", "");
                    sesion.setAttribute("descripcion", "");
                    out.println("<script>alert('Insumo Inexistente')</script>");
                    out.println("<script>window.location='capturaISEM.jsp'</script>");
                }
            }
            if (request.getParameter("accion").equals("capturar")) {
                try {
                    con.conectar();
                    String ClaPro = "", Priori = "", Lote = "", Cadu = "", Cant = "", Observaciones = "";
                    ClaPro = request.getParameter("ClaPro");
                    Priori = request.getParameter("Prioridad");
                    Lote = request.getParameter("LotPro");
                    Cadu = request.getParameter("CadPro");
                    Cant = request.getParameter("CanPro");
                    byte[] a = request.getParameter("Observaciones").getBytes("ISO-8859-1");
                    Observaciones = (new String(a, "UTF-8")).toUpperCase();
                    if (Priori.equals("")) {
                        Priori = "-";
                    }
                    if (Lote.equals("")) {
                        Lote = "-";
                    }
                    if (Cadu.equals("")) {
                        Cadu = "00/00/0000";
                    }
                    int i = 0, cantAnt = 0;
                    String F_IdIsem = "";
                    ResultSet rset = con.consulta("select F_IdIsem, F_Cant from tb_pedidoisem where F_NoCompra = '" + (String) sesion.getAttribute("NoOrdCompra") + "' and F_Clave = '" + ClaPro + "' ");
                    while (rset.next()) {
                        F_IdIsem = rset.getString("F_IdIsem");
                        i = 1;
                        cantAnt = rset.getInt("F_Cant");
                    }
                    if (i == 1) {
                        con.insertar("update tb_pedidoisem set F_Cant = '" + (cantAnt + Integer.parseInt(Cant)) + "' where F_IdIsem='" + F_IdIsem + "'");
                    } else {

                        con.insertar("insert into tb_pedidoisem values(0,'" + (String) sesion.getAttribute("NoOrdCompra") + "','" + (String) sesion.getAttribute("proveedor") + "','" + ClaPro + "','','" + Priori + "','" + Lote + "','" + df.format(df2.parse(Cadu)) + "','" + Cant + "','" + Observaciones + "',CURRENT_TIMESTAMP(),'" + (String) sesion.getAttribute("fec_entrega") + "','" + (String) sesion.getAttribute("hor_entrega") + "','" + (String) sesion.getAttribute("Usuario") + "','0','0')");
                    }
                    sesion.setAttribute("clave", "");
                    sesion.setAttribute("descripcion", "");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                con.cierraConexion();
                out.println("<script>window.location='capturaISEM.jsp'</script>");
            }
            if (request.getParameter("accion").equals("cancelaOrden")) {
                con.conectar();
                try {
                    byte[] a = request.getParameter("Observaciones").getBytes("ISO-8859-1");
                    String Obser = (new String(a, "UTF-8")).toUpperCase();
                    try {
                        con.insertar("update tb_pedidoisem set F_StsPed = '2' where F_NoCompra = '" + request.getParameter("NoCompra") + "'  ");
                    } catch (Exception e) {
                    }
                    try {
                        con.insertar("insert into tb_obscancela values('" + request.getParameter("NoCompra") + "','" + Obser + "')");
                    } catch (Exception e) {
                    }
                    try {
                        correoCancela.cancelaCompra(request.getParameter("NoCompra"), (String) sesion.getAttribute("Usuario"));
                    } catch (Exception e) {
                    }
                    sesion.setAttribute("clave", "");
                    sesion.setAttribute("descripcion", "");
                    sesion.setAttribute("proveedor", "");
                    sesion.setAttribute("fec_entrega", "");
                    sesion.setAttribute("hor_entrega", "");
                    sesion.setAttribute("NoOrdCompra", "");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
                response.sendRedirect("verFoliosIsem.jsp");
            }
            if (request.getParameter("accion").equals("cancelar")) {
                con.conectar();
                try {
                    con.insertar("delete from tb_pedidoisem where F_IdUsu = '" + (String) sesion.getAttribute("Usuario") + "'  ");
                    sesion.setAttribute("clave", "");
                    sesion.setAttribute("descripcion", "");
                    sesion.setAttribute("proveedor", "");
                    sesion.setAttribute("fec_entrega", "");
                    sesion.setAttribute("hor_entrega", "");
                } catch (Exception e) {
                }
                con.cierraConexion();
                response.sendRedirect("capturaISEM.jsp");
            }
            if (request.getParameter("accion").equals("eliminarRemi")) {
                con.conectar();
                try {
                    con.insertar("delete from tb_pedidoisem where F_NoCompra = '" + request.getParameter("F_NoCompra") + "'");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
                //response.sendRedirect("ordenesCompra.jsp");
                out.println("<script>alert('Se eliminó la orden " + request.getParameter("F_NoCompra") + " corrercetamente')</script>");
                out.println("<script>window.location='ordenesCompra.jsp'</script>");
            }
            if (request.getParameter("accion").equals("confirmarRemi")) {
                con.conectar();
                try {
                    con.insertar("update tb_pedidoisem set F_StsPed = '1' where F_NoCompra = '" + request.getParameter("F_NoCompra") + "'");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
                //response.sendRedirect("ordenesCompra.jsp");
                out.println("<script>alert('Se validó la orden " + request.getParameter("F_NoCompra") + " corrercetamente')</script>");
                out.println("<script>window.location='ordenesCompra.jsp'</script>");
            }
            if (request.getParameter("accion").equals("confirmar")) {
                con.conectar();
                try {
                    con.insertar("update tb_pedidoisem set F_StsPed = '1' where F_NoCompra = '" + (String) sesion.getAttribute("NoOrdCompra") + "'  and F_IdUsu = '" + (String) sesion.getAttribute("Usuario") + "' ");
                    //correo.enviaCorreo((String) sesion.getAttribute("NoCompra"));
                    sesion.setAttribute("clave", "");
                    sesion.setAttribute("descripcion", "");
                    sesion.setAttribute("proveedor", "");
                    sesion.setAttribute("fec_entrega", "");
                    sesion.setAttribute("hor_entrega", "");
                    sesion.setAttribute("NoOrdCompra", "");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
                response.sendRedirect("capturaISEM.jsp");
            }
            if (request.getParameter("accion").equals("reactivar")) {
                con.conectar();
                try {
                    con.insertar("update tb_pedidoisem set F_Recibido='0' where F_NoCompra = '" + request.getParameter("NoCompra") + "'  ");
                    //con.insertar("delete from tb_compratemp where F_OrdCom = '"+request.getParameter("NoCompra")+"'  ");
                } catch (Exception e) {
                }
                con.cierraConexion();
                out.println("<script>alert('Se reactivo la orden " + request.getParameter("NoCompra") + " corrercetamente')</script>");
                out.println("<script>window.location='ordenesCompra.jsp'</script>");
            }
            if (request.getParameter("accion").equals("cerrar")) {
                con.conectar();
                try {
                    con.insertar("update tb_pedidoisem set F_Recibido='1' where F_NoCompra = '" + request.getParameter("NoCompra") + "'  ");
                    con.insertar("delete from tb_compratemp where F_OrdCom = '" + request.getParameter("NoCompra") + "'  ");
                } catch (Exception e) {
                }
                con.cierraConexion();
                out.println("<script>alert('Se cerró la orden " + request.getParameter("NoCompra") + " corrercetamente')</script>");
                out.println("<script>window.location='ordenesCompra.jsp'</script>");
            }
        } catch (Exception e) {
        }
    }

    public String noCompra() {
        String indice = "0";
        try {
            con.conectar();
            ResultSet rset = con.consulta("select F_IndIsem from tb_indice");
            while (rset.next()) {
                indice = rset.getString(1);
                con.insertar("update tb_indice set F_IndIsem = '" + (rset.getInt(1) + 1) + "'");
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return indice;
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
