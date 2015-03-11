/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Facturacion;

import conn.*;
import Inventario.Devoluciones;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import servlets.Facturacion;
import ISEM.*;
import Modula.RequerimientoModula;
import java.sql.SQLException;

/**
 *
 * @author Amerikillo
 */
public class FacturacionManual extends HttpServlet {

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

        ConectionDB con = new ConectionDB();
        Devoluciones dev = new Devoluciones();
        //ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
        Facturacion fact = new Facturacion();
        NuevoISEM objSql = new NuevoISEM();
        java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
        java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        try {
            if (!request.getParameter("accionEliminar").equals("")) {

                //sesion.setAttribute("F_IndGlobal", null);
                con.conectar();
                ResultSet rset = con.consulta("select * from tb_facttemp where F_Id = '" + request.getParameter("accionEliminar") + "'");
                while (rset.next()) {
                    con.insertar("insert into tb_facttemp_elim values ('" + rset.getString(1) + "','" + rset.getString(2) + "','" + rset.getString(3) + "','" + rset.getString(4) + "','" + rset.getString(5) + "','" + rset.getString(6) + "','" + rset.getString(7) + "', '" + (String) sesion.getAttribute("nombre") + "', NOW())");
                }
                con.insertar("delete from tb_facttemp where F_Id = '" + request.getParameter("accionEliminar") + "' ");
                con.cierraConexion();
                out.println("<script>alert('Clave Eliminada Correctamente')</script>");
                out.println("<script>window.location='facturacionManual.jsp'</script>");
            }
        } catch (Exception e) {
        }
        try {
            if (request.getParameter("accion").equals("reintegrarInsumo")) {
                String F_ClaDoc = request.getParameter("F_ClaDoc");
                try {
                    con.conectar();
                    //consql.conectar();
                    String ClaPro = "", CantSur = "", ClaDoc = "", Proveedor = "", Monto = "", Costo = "", FolLote = "", F_IdFact;
                    int FolioMovi = 0, FolMov;
                    ResultSet rset = con.consulta("select f.F_ClaCli, f.F_IdFact, f.F_StsFact, f.F_ClaPro, l.F_ClaLot, l.F_FecCad, DATE_FORMAT(l.F_FecCad,'%d/%m/%Y') AS FECAD, f.F_CantSur, f.F_FecEnt, f.F_Ubicacion, f.F_ClaDoc, l.F_ClaOrg, l.F_FecFab, DATE_FORMAT(l.F_FecFab,'%d/%m/%Y') AS FEFAB, l.F_Cb, l.F_ClaMar, f.F_Monto, f.F_Costo, f.F_Lote, f.F_Iva from tb_factdevol f, tb_lote l where f.F_Lote = l.F_FolLot and f.F_ClaDoc='" + F_ClaDoc + "' and f.F_FactSts = 0 group by f.F_IdFact");
                    while (rset.next()) {
                        CantSur = rset.getString("F_CantSur");
                        ClaDoc = rset.getString("F_ClaDoc");
                        Proveedor = rset.getString("F_ClaOrg");
                        Monto = rset.getString("F_Monto");
                        Costo = rset.getString("F_Costo");
                        FolLote = rset.getString("F_Lote");
                        F_IdFact = rset.getString("F_IdFact");
                        ClaPro = rset.getString("F_ClaPro");

                        //CONSULTA INDICE MOVIMIENTO MYSQL
                        ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                        while (FolioMov.next()) {
                            FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                        }
                        FolMov = FolioMovi + 1;
                        con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");

                        /*
                         * Insercion a lotes
                         */
                        String idLote = "";
                        int CantLote = 0;
                        ResultSet rsetLote = con.consulta("select F_IdLote, SUM(F_ExiLot) from tb_lote where F_FolLot ='" + FolLote + "' AND F_Ubica in ('NUEVA', 'REJA', 'REDFRIA') group by F_IdLote");
                        while (rsetLote.next()) {
                            idLote = rsetLote.getString("F_IdLote");
                            CantLote = rsetLote.getInt(2);
                        }
                        con.insertar("update tb_lote set F_ExiLot ='" + (Integer.parseInt(CantSur) + CantLote) + "' where F_IdLote = '" + idLote + "'");

                        //Insercion de movimientos
                        con.insertar("insert into tb_movinv values (0,curdate(),'" + ClaDoc + "','3', '" + ClaPro + "', '" + CantSur + "', '" + Costo + "', '" + Monto + "' ,'1', '" + FolLote + "', 'NUEVA', '" + Proveedor + "',curtime(),'" + (String) sesion.getAttribute("nombre") + "') ");

                        con.insertar("update tb_factdevol set F_FactSts=1 where F_IdFact = '" + F_IdFact + "'");
                    }
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                sesion.setAttribute("F_IndGlobal", null);
                response.sendRedirect("reimp_factura.jsp");
            }
            if (request.getParameter("accion").equals("devolucion")) {
                String idFact = request.getParameter("IdFact");
                try {
                    con.conectar();
                    int cantDevol = Integer.parseInt(request.getParameter("CantDevolver"));
                    //consql.conectar();
                    String ClaCli = "", StsFact = "", ClaPro = "", ClaLot = "", FecCad = "", CantSur = "", FecEnt = "", Ubicacion = "", ClaDoc = "", Proveedor = "", FecFab = "", CB = "", Marca = "", Monto = "", FecCadSQL = "", FecFabSQL = "", Costo = "", FolLote = "", IVA = "", F_Hora = "", F_User = "";
                    String FolioLoteSQL = "";
                    int FolioMovi = 0, FolMov, FolioMoviSQL = 0, FolMovSQL;
                    ResultSet rset = con.consulta("select f.F_ClaCli, f.F_StsFact, f.F_ClaPro, l.F_ClaLot, l.F_FecCad, DATE_FORMAT(l.F_FecCad,'%d/%m/%Y') AS FECAD, f.F_CantSur, f.F_FecEnt, f.F_Ubicacion, f.F_ClaDoc, l.F_ClaOrg, l.F_FecFab, DATE_FORMAT(l.F_FecFab,'%d/%m/%Y') AS FEFAB, l.F_Cb, l.F_ClaMar, f.F_Monto, f.F_Costo, f.F_Lote, f.F_Iva, f.F_Hora, f.F_User from tb_factura f, tb_lote l where f.F_Lote = l.F_FolLot and f.F_IdFact='" + idFact + "'");
                    while (rset.next()) {
                        ClaCli = rset.getString("F_ClaCli");
                        StsFact = rset.getString("F_StsFact");
                        ClaPro = rset.getString("F_ClaPro");
                        ClaLot = rset.getString("F_ClaLot");
                        FecCad = rset.getString("F_FecCad");
                        CantSur = rset.getString("F_CantSur");
                        FecEnt = rset.getString("F_FecEnt");
                        Ubicacion = rset.getString("F_Ubicacion");
                        ClaDoc = rset.getString("F_ClaDoc");
                        Proveedor = rset.getString("F_ClaOrg");
                        FecFab = rset.getString("F_FecFab");
                        CB = rset.getString("F_Cb");
                        Marca = rset.getString("F_ClaMar");
                        Monto = rset.getString("F_Monto");
                        FecCadSQL = rset.getString("FECAD");
                        FecFabSQL = rset.getString("FEFAB");
                        Costo = rset.getString("F_Costo");
                        FolLote = rset.getString("F_Lote");
                        IVA = rset.getString("F_Iva");
                        F_Hora = rset.getString("F_Hora");
                        F_User = rset.getString("F_User");
                    }
                    byte[] a = request.getParameter("Obser").getBytes("ISO-8859-1");
                    String Observaciones = (new String(a, "UTF-8")).toUpperCase();

                    if (Integer.parseInt(CantSur) - cantDevol == 0) {
                        con.insertar("update tb_factura set F_StsFact = 'C', F_Obs='" + Observaciones + "' where F_IdFact = '" + idFact + "'");

                        ResultSet rsetfact = con.consulta("select * from tb_factura where F_IdFact = '" + idFact + "' ");
                        while (rsetfact.next()) {
                            con.insertar("insert into tb_factdevol values ('" + rsetfact.getString(1) + "','" + rsetfact.getString(2) + "','" + rsetfact.getString(3) + "','" + rsetfact.getString(4) + "','" + rsetfact.getString(5) + "','" + rsetfact.getString(6) + "','" + rsetfact.getString(7) + "','" + rsetfact.getString(8) + "','" + rsetfact.getString(9) + "','" + rsetfact.getString(10) + "','" + rsetfact.getString(11) + "','" + rsetfact.getString(12) + "','" + rsetfact.getString(13) + "','" + rsetfact.getString(14) + "','" + rsetfact.getString(15) + "','" + rsetfact.getString(16) + "','" + rsetfact.getString(17) + "',0) ");
                        }

                    } else {
                        con.insertar("update tb_factura set F_CantSur = '" + (Integer.parseInt(CantSur) - cantDevol) + "', F_Iva='" + dev.devuelveIVA(ClaPro, Integer.parseInt(CantSur) - cantDevol) + "', F_Monto = '" + dev.devuelveImporte(ClaPro, Integer.parseInt(CantSur) - cantDevol) + "' where F_IdFact = '" + idFact + "'");
                        con.insertar("insert into tb_factura values(0,'" + ClaDoc + "','" + ClaCli + "','C',CURDATE(),'" + ClaPro + "','" + cantDevol + "','" + cantDevol + "','" + Costo + "','" + dev.devuelveIVA(ClaPro, cantDevol) + "','" + dev.devuelveImporte(ClaPro, cantDevol) + "','" + FolLote + "','" + FecEnt + "','" + F_Hora + "','" + F_User + "','" + Ubicacion + "','" + Observaciones + "')");

                        ResultSet rsetfact = con.consulta("select * from tb_factura where F_Obs = '" + Observaciones + "' and F_ClaDoc='" + ClaDoc + "' and F_ClaPro='" + ClaPro + "' and F_Lote='" + FolLote + "' ");
                        while (rsetfact.next()) {
                            con.insertar("insert into tb_factdevol values ('" + rsetfact.getString(1) + "','" + rsetfact.getString(2) + "','" + rsetfact.getString(3) + "','" + rsetfact.getString(4) + "','" + rsetfact.getString(5) + "','" + rsetfact.getString(6) + "','" + rsetfact.getString(7) + "','" + rsetfact.getString(8) + "','" + rsetfact.getString(9) + "','" + rsetfact.getString(10) + "','" + rsetfact.getString(11) + "','" + rsetfact.getString(12) + "','" + rsetfact.getString(13) + "','" + rsetfact.getString(14) + "','" + rsetfact.getString(15) + "','" + rsetfact.getString(16) + "','" + rsetfact.getString(17) + "',0) ");
                        }
                    }

                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                sesion.setAttribute("F_IndGlobal", null);
                response.sendRedirect("reimp_factura.jsp");
            }
            if (request.getParameter("accion").equals("CancelarFactura")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select * from tb_facttemp where F_ClaCLi = '" + (String) sesion.getAttribute("ClaCliFM") + "'");
                    while (rset.next()) {
                        con.insertar("insert into tb_facttemp_elim values ('" + rset.getString(1) + "','" + rset.getString(2) + "','" + rset.getString(3) + "','" + rset.getString(4) + "','" + rset.getString(5) + "','" + rset.getString(6) + "','" + rset.getString(7) + "', '" + (String) sesion.getAttribute("nombre") + "', NOW())");
                    }
                    con.insertar("delete from tb_facttemp where F_ClaCLi = '" + (String) sesion.getAttribute("ClaCliFM") + "' ");
                    con.cierraConexion();
                    sesion.setAttribute("F_IndGlobal", null);
                    out.println("<script>alert('Factura Eliminada Correctamente')</script>");
                    out.println("<script>window.location='facturacionManual.jsp'</script>");
                } catch (Exception e) {
                }
            }
            if (request.getParameter("accion").equals("remisionCamion")) {

                try {
                    String[] claveschk = request.getParameterValues("chkSeleccciona");
                    String claves = "";
                    if (claves != null && claveschk.length > 0) {
                        for (int i = 0; i < claveschk.length; i++) {
                            if (i == claveschk.length - 1) {
                                claves = claves + claveschk[i];
                            } else {
                                claves = claves + claveschk[i] + ",";
                            }
                        }
                    }
                    con.conectar();
                    //consql.conectar();
                    int FolioFactura = 0;
                    String FechaE = request.getParameter("Fecha");
                    ResultSet FolioFact = con.consulta("SELECT F_IndFact FROM tb_indice");
                    while (FolioFact.next()) {
                        FolioFactura = Integer.parseInt(FolioFact.getString("F_IndFact"));
                    }
                    int FolFact = FolioFactura + 1;
                    con.actualizar("update tb_indice set F_IndFact='" + FolFact + "'");
                    byte[] a = request.getParameter("Obs").getBytes("ISO-8859-1");
                    String Observaciones = (new String(a, "UTF-8")).toUpperCase();
                    String req = request.getParameter("F_Req").toUpperCase();
                    if (req.equals("")) {
                        req = "00000";
                    }
                    String idFact="";
                    String qryFact = "select f.F_ClaCli, l.F_FolLot, l.F_IdLote, l.F_ClaPro, l.F_ClaLot, l.F_FecCad, m.F_TipMed, m.F_Costo, p.F_ClaProve, f.F_Cant, l.F_ExiLot, l.F_Ubica, f.F_IdFact, f.F_Id, f.F_FecEnt, f.F_CantSol  from tb_facttemp f, tb_lote l, tb_medica m, tb_proveedor p where f.F_IdLot = l.F_IdLote AND l.F_ClaPro = m.F_ClaPro AND l.F_ClaOrg = p.F_ClaProve and f.F_IdFact = '" + request.getParameter("Nombre") + "' and f.F_StsFact=4 AND (f.F_Id IN (" + claves + ")) ";
                    ResultSet rset = con.consulta(qryFact);
                    while (rset.next()) {
                        idFact = rset.getString("F_IdFact");
                        String ClaUni = rset.getString("F_ClaCli");
                        String Clave = rset.getString("F_ClaPro");
                        String Caducidad = rset.getString("F_FecCad");
                        String FolioLote = rset.getString("F_FolLot");
                        String IdLote = rset.getString("F_IdLote");
                        String ClaLot = rset.getString("F_ClaLot");
                        String Ubicacion = rset.getString("F_Ubica");
                        String ClaProve = rset.getString("F_ClaProve");
                        String F_Id = rset.getString("F_Id");
                        String F_CantSol = rset.getString("F_CantSol");
                        FechaE = rset.getString("F_FecEnt");
                        int existencia = rset.getInt("F_ExiLot");
                        int cantidad = rset.getInt("F_Cant");
                        int Tipo = rset.getInt("F_TipMed");
                        int FolioMovi = 0, FolMov = 0;
                        double Costo = 0.0, IVA = 0.0, Monto = 0.0, IVAPro = 0.0, MontoIva = 0.0;
                        if (Tipo == 2504) {
                            IVA = 0.0;
                        } else {
                            IVA = 0.16;
                        }

                        Costo = rset.getDouble("F_Costo");

                        int Diferencia = existencia - cantidad;

                        //Actualizacion de TB Lote
                        /*ResultSet rsetLoteSQL = consql.consulta("select F_FolLot as lote from tb_lote where F_ClaPro = '" + Clave + "' and F_ClaLot = '" + ClaLot + "' and F_FecCad = '" + df2.format(df3.parse(Caducidad)) + "'  and F_Origen = '" + fact.dame5car("1") + "' ");
                         String loteSQL = "";
                         while (rsetLoteSQL.next()) {
                         loteSQL = rsetLoteSQL.getString("lote");
                         }*/
                        if (Diferencia == 0) {
                            con.actualizar("UPDATE tb_lote SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");
                            //consql.actualizar("UPDATE TB_lote SET F_ExiLot='0' WHERE F_FolLot='" + loteSQL + "'");
                        } else {
                            con.actualizar("UPDATE tb_lote SET F_ExiLot='" + Diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                            //consql.actualizar("UPDATE TB_lote SET F_ExiLot='" + Diferencia + "' WHERE F_FolLot='" + loteSQL + "'");
                        }
                        IVAPro = (cantidad * Costo) * IVA;
                        Monto = cantidad * Costo;
                        MontoIva = Monto + IVAPro;
                        //Obtencion de indice de movimiento

                        ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                        while (FolioMov.next()) {
                            FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                        }
                        FolMov = FolioMovi + 1;
                        con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");
                        //Inserciones

                        con.insertar("insert into tb_movinv values(0,curdate(),'" + idFact + "','51','" + Clave + "','" + cantidad + "','" + Costo + "','" + MontoIva + "','-1','" + FolioLote + "','" + Ubicacion + "','" + ClaProve + "',curtime(),'" + sesion.getAttribute("nombre") + "')");
                        con.insertar("insert into tb_factura values(0,'" + idFact + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + F_CantSol + "','" + cantidad + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','')");
                        //consql.insertar("insert into TB_MovInv values (CONVERT(date,GETDATE()),'" + FolioFactura + "','','51', '" + Clave + "', '" + cantidad + "', '" + Costo + "','" + IVAPro + "', '" + MontoIva + "' ,'-1', '" + loteSQL + "', '" + FolioMovi + "','A', '0', '','','','" + ClaProve + "','" + sesion.getAttribute("nombre") + "') ");
                        //consql.insertar("insert into TB_Factura values ('F','" + FolioFactura + "','" + fact.dame5car(ClaUni) + "','A','',CONVERT(date,GETDATE()),'','" + Clave + "', '','1','" + cantidad + "','" + cantidad + "', '" + Monto + "','0', '" + Monto + "','" + Monto + "','" + Monto + "','" + IVAPro + "', '" + MontoIva + "','" + Costo + "' ,'" + loteSQL + "','R','" + df2.format(df3.parse(FechaE)) + "','" + sesion.getAttribute("nombre") + "','0','0','','A','" + cantidad + "','" + Ubicacion + "') ");

                        /*ResultSet existSql = consql.consulta("select F_Existen from TB_Medica where F_ClaPro = '" + Clave + "' ");
                         while (existSql.next()) {
                         int difTotal = existSql.getInt("F_Existen") - cantidad;
                         if (difTotal < 0) {
                         difTotal = 0;
                         }
                         consql.actualizar("update TB_Medica set F_Existen = '" + difTotal + "' where F_ClaPro = '" + Clave + "' ");
                         }*/
                        con.actualizar("update tb_facttemp set F_StsFact='5' where F_Id='" + F_Id + "'");
                    }

                    con.insertar("insert into tb_obserfact values ('" + idFact + "','" + Observaciones + "',0,'" + request.getParameter("F_Req").toUpperCase() + "')");
                    //Finaliza
                    //consql.cierraConexion();
                    con.cierraConexion();
                    sesion.setAttribute("ClaCliFM", "");
                    sesion.setAttribute("FechaEntFM", "");
                    sesion.setAttribute("ClaProFM", "");
                    sesion.setAttribute("DesProFM", "");
                    sesion.setAttribute("F_IndGlobal", null);
                    //Aqui tenemos que poner en nulo la variable de folio de dactura
                    out.println("<script>window.open('reimpFactura.jsp?fol_gnkl=" + idFact + "','_blank')</script>");
                    out.println("<script>window.location='remisionarCamion.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (request.getParameter("accion").equals("ConfirmarFactura")) {
                try {
                    con.conectar();
                    RequerimientoModula reqMod = new RequerimientoModula();
                    reqMod.enviaRequerimiento((String) sesion.getAttribute("F_IndGlobal"));
                    con.insertar("update tb_facttemp set F_StsFact = '0' where F_IdFact = '" + (String) sesion.getAttribute("F_IndGlobal") + "' ");
                    con.cierraConexion();
                    sesion.setAttribute("F_IndGlobal", null);
                    sesion.setAttribute("ClaCliFM", "");
                    sesion.setAttribute("FechaEntFM", "");
                    sesion.setAttribute("ClaProFM", "");
                    sesion.setAttribute("DesProFM", "");
                    response.sendRedirect("facturacionManual.jsp");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (request.getParameter("accion").equals("ReenviarFactura")) {
                RequerimientoModula reqMod = new RequerimientoModula();
                reqMod.enviaRequerimiento(request.getParameter("fol_gnkl"));
                response.sendRedirect("reimpConcentrado.jsp");
            }
            if (request.getParameter("accion").equals("AgregarClave")) {
                try {
                    con.conectar();
                    con.insertar("insert into tb_facttemp values('" + (String) sesion.getAttribute("F_IndGlobal") + "','" + (String) sesion.getAttribute("ClaCliFM") + "','" + request.getParameter("IdLot") + "','" + request.getParameter("Cant") + "','" + (String) sesion.getAttribute("FechaEntFM") + "','3','0','','" + request.getParameter("Cant") + "')");
                    con.cierraConexion();
                    response.sendRedirect("facturacionManual.jsp");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (request.getParameter("accion").equals("SeleccionaLote")) {
                System.out.println(request.getParameter("Cantidad"));
                response.setContentType("text/html");
                request.setAttribute("Cantidad", request.getParameter("Cantidad"));
                request.getRequestDispatcher("facturacionManualSelecLote.jsp").forward(request, response);
            }

            if (request.getParameter("accion").equals("btnClave")) {
                try {
                    String F_IndGlobal = (String) sesion.getAttribute("F_IndGlobal");
                    int banInsumo=0;
                    if (F_IndGlobal == null) {
                        sesion.setAttribute("F_IndGlobal", dameIndGlobal() + "");
                        F_IndGlobal = (String) sesion.getAttribute("F_IndGlobal");
                    }
                    con.conectar();
                    ResultSet rset = con.consulta("select m.F_ClaPro, m.F_DesPro, l.F_ClaLot, l.F_FolLot, DATE_FORMAT(l.F_FecCad, '%d/%m/%Y') from tb_medica m, tb_lote l where m.F_ClaPro = l.F_ClaPro and m.F_ClaPro = '" + request.getParameter("ClaPro") + "' group by m.F_ClaPro;");
                    while (rset.next()) {
                        banInsumo=1;
                        sesion.setAttribute("DesProFM", rset.getString(2));
                    }
                    con.cierraConexion();
                    sesion.setAttribute("ClaCliFM", request.getParameter("ClaCli"));
                    sesion.setAttribute("FechaEntFM", request.getParameter("FechaEnt"));
                    sesion.setAttribute("ClaProFM", request.getParameter("ClaPro"));
                    if(banInsumo==0){
                        out.println("<script>alert('Insumo sin Existencias')</script>");
                    }
                    out.println("<script>window.location='facturacionManual.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            String[] quitar = request.getParameter("accion").split(",");
            if (quitar[0].equals("quitarInsumo")) {
                System.out.println(request.getParameter("Nombre") + "*****");
                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                con.conectar();
                con.insertar("update tb_facttemp set F_StsFact = '2' where F_Id = '" + quitar[1] + "' ");
                con.cierraConexion();
                out.println("<script>window.location='remisionarCamion.jsp'</script>");
            }
        } catch (Exception e) {
        }
    }

    public int dameIndGlobal() throws SQLException {
        ConectionDB con = new ConectionDB();
        con.conectar();
        int FolioFactura = 0, FolFact = 0;
        ResultSet FolioFact = con.consulta("SELECT F_IndGlobal FROM tb_indice");
        while (FolioFact.next()) {
            FolioFactura = Integer.parseInt(FolioFact.getString("F_IndGlobal"));
        }
        FolFact = FolioFactura + 1;
        con.actualizar("update tb_indice set F_IndGlobal='" + FolFact + "'");
        con.cierraConexion();
        return FolioFactura;
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
