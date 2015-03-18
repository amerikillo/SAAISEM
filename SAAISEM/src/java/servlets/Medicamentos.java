/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import conn.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Medicamentos extends HttpServlet {

    //ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
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
        ConectionDB con = new ConectionDB();
        ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();
        try {
            /*
             *Para actualizar Registros
             */
            if (request.getParameter("accion").equals("actualizar")) {
                //consql.conectar();
                con.conectar();
                try {
                    String clave = request.getParameter("Clave");
                    try {
                        int largoClave = request.getParameter("Clave").length();
                        int espacios = 5 - largoClave;
                        for (int i = 1; i <= espacios; i++) {
                            clave = " " + clave;
                        }
                    } catch (Exception e) {
                    }
                    //consql.actualizar("update TB_Provee set F_ClaPrv='" + clave + "', F_NomPrv='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                    con.actualizar("update provee_all set F_ClaPrv='" + clave + "', F_nomprov='" + request.getParameter("Nombre").toUpperCase() + "', F_Dir='" + request.getParameter("Direccion").toUpperCase() + "', F_Col='" + request.getParameter("Colonia").toUpperCase() + "', F_Pob='" + request.getParameter("Poblacion").toUpperCase() + "', F_CP='" + request.getParameter("CP").toUpperCase() + "', F_RFC='" + request.getParameter("RFC").toUpperCase() + "', F_Con='" + request.getParameter("CON").toUpperCase() + "', F_Cls='" + request.getParameter("CLS").toUpperCase() + "', F_Tel='" + request.getParameter("Telefono").toUpperCase() + "', F_Fax='" + request.getParameter("FAX").toUpperCase() + "', F_Mail='" + request.getParameter("Mail").toUpperCase() + "', F_Obs='" + request.getParameter("Observaciones").toUpperCase() + "' where F_ClaPrv='" + request.getParameter("id").toUpperCase() + "';");

                } catch (Exception e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Ya esta registrado ese proveedor')</script>");
                    out.println("<script>window.location='editar_proveedor.jsp'</script>");
                }
                con.cierraConexion();
                //consql.cierraConexion();

                out.println("<script>alert('Proveedor actualizado correctamente.')</script>");
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
            /*
             *Manda al jsp el id del registro a editar
             */
            if (request.getParameter("accion").equals("editar")) {
                request.getSession().setAttribute("id", request.getParameter("id"));
                response.sendRedirect("editar_proveedor.jsp");
            }
            /*
             *Para eliminar registro
             */
            if (request.getParameter("accion").equals("eliminar")) {
                //consql.conectar();
                con.conectar();
                try {
                    //consql.insertar("delete from TB_Provee where F_ClaPrv = '" + request.getParameter("id") + "' ");
                    con.insertar("delete from provee_all where F_ClaPrv = '" + request.getParameter("id") + "' ");
                } catch (SQLException e) {
                    System.out.println(e.getMessage());

                    out.println("<script>alert('Error al eliminar')</script>");
                    out.println("<script>window.location='catalogo.jsp'</script>");
                }
                con.cierraConexion();
                //consql.cierraConexion();

                out.println("<script>alert('Se elimino el proveedor correctamente')</script>");
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
            /*
             *Guarda Registros
             */
            if (request.getParameter("accion").equals("guardar")) {
                try {
                    String Nombre = "";
                    int TpMed = 0;
                    con.conectar();
                    //conModula.conectar();
                    try {

                        ResultSet rst_prov = con.consulta("SELECT F_ClaPro FROM tb_medica WHERE F_ClaPro='" + request.getParameter("Clave").toUpperCase() + "'");
                        while (rst_prov.next()) {
                            Nombre = rst_prov.getString("F_ClaPro");
                        }
                        if (!(Nombre.equals(""))) {
                            out.println("<script>alert('Ya esta registrado éste Medicamento')</script>");
                            out.println("<script>window.location='medicamento.jsp'</script>");

                        } else {
                            TpMed = Integer.parseInt(request.getParameter("list_medica").toUpperCase());
                            //conModula.ejecutar("insert into IMP_ARTICOLI (ART_OPERAZIONE, ART_ARTICOLO, ART_DES, ART_UMI, ART_MIN, ART_PROY) values ('I','" + request.getParameter("Clave").toUpperCase() + "','" + request.getParameter("Descripcion").toUpperCase() + "','PZ','" + request.getParameter("Min").toUpperCase() + "', 'ISSEMyM')");
                            con.insertar("insert into tb_medica values ('" + request.getParameter("Clave").toUpperCase() + "','" + request.getParameter("Descripcion").toUpperCase() + "','A','" + TpMed + "','" + request.getParameter("Costo").toUpperCase() + "','" + request.getParameter("PresPro").toUpperCase() + "','" + request.getParameter("F_Origen").toUpperCase() + "','" + request.getParameter("SAP").toUpperCase() + "');");
                            //con.insertar("insert into tb_maxmodula values('" + request.getParameter("Clave").toUpperCase() + "','" + request.getParameter("Max").toUpperCase() + "','" + request.getParameter("Min").toUpperCase() + "','0')");
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                        out.println("<script>alert('Error: " + e.getMessage() + "')</script>");
                        out.println("<script>window.location='medicamento.jsp'</script>");
                    }
                    //conModula.cierraConexion();
                    con.cierraConexion();

                    out.println("<script>alert('Medicamento capturado correctamente.')</script>");
                    out.println("<script>window.location='medicamento.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }
            if (request.getParameter("accion").equals("Actualizar")) {
                try {
                    conModula.conectar();
                    con.conectar();
                    ResultSet rset = con.consulta("select * from tb_medica");
                    while (rset.next()) {
                        int banMedicamento = 0;
                        ResultSet rset2 = con.consulta("select F_Id, F_Min from tb_maxmodula where F_ClaPro = '" + rset.getString("F_ClaPro") + "'");
                        while (rset2.next()) {
                            banMedicamento = 1;
                        }
                        if (banMedicamento == 0) {
                            try {
                                con.insertar("insert into tb_maxmodula values('" + rset.getString("F_ClaPro") + "','" + request.getParameter("Max" + rset.getString("F_ClaPro")) + "','" + request.getParameter("Min" + rset.getString("F_ClaPro")) + "','0')");
                            } catch (Exception e) {
                            }
                        } else {

                            try {

                                con.insertar("update tb_maxmodula set F_Max = '" + request.getParameter("Max" + rset.getString("F_ClaPro")) + "', F_Min ='" + request.getParameter("Min" + rset.getString("F_ClaPro")) + "' where F_ClaPro='" + rset.getString("F_ClaPro") + "'");
                            } catch (Exception e) {
                            }
                        }
                        rset2 = con.consulta("select F_Id, F_Min from tb_maxmodula where F_ClaPro = '" + rset.getString("F_ClaPro") + "'");
                        int min = 0;
                        while (rset2.next()) {
                            banMedicamento = 1;
                            min = rset2.getInt("F_Min");
                        }
                        conModula.ejecutar("insert into IMP_ARTICOLI (ART_OPERAZIONE, ART_ARTICOLO, ART_DES, ART_UMI, ART_MIN, ART_PROY) values ('I','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_DesPro") + "','PZ','" + min + "', 'ISSEMyM')");
                    }
                    conModula.cierraConexion();
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    out.println("<script>alert('Error: " + e.getMessage() + "')</script>");
                    out.println("<script>window.location='medicamento.jsp'</script>");
                }
                out.println("<script>window.location='medicamento.jsp'</script>");
            }
            if (request.getParameter("accion").equals("obtieneProvee")) {
                try {
                    out.println("<script>alert('Se obtuvieron los Proveedores Correctamente')</script>");
                } catch (Exception e) {
                    out.println("<script>alert('Error al obtener proveedores')</script>");
                }
                out.println("<script>window.location='catalogo.jsp'</script>");
            }
        } catch (SQLException e) {

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
