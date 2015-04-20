/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import Modula.RequerimientoModula;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import conn.*;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Facturacion extends HttpServlet {

    java.text.DateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy");
    java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

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
        String clave = "", descr = "";
        int ban1 = 0;

        ConectionDB con = new ConectionDB();
        //ConectionDB_SQLServer consql = new ConectionDB_SQLServer();
        try {
            if (request.getParameter("accion").equals("impRemisMultples")) {
                String[] claveschk = request.getParameterValues("checkRemis");
                String remisionesReImp = "";
                for (int i = 0; i < claveschk.length; i++) {

                    //response.sendRedirect("reportes/multiplesRemis.jsp?remis=" + claveschk[i]);
                    out.println("<script>window.open('reportes/multiplesRemis.jsp?remis=" + claveschk[i] + "', '_blank')</script>");
                    if (i == (claveschk.length - 1)) {
                        remisionesReImp = remisionesReImp + "" + claveschk[i] + "";
                    } else {
                        remisionesReImp = remisionesReImp + "" + claveschk[i] + ",";
                    }
                }
                out.println("<script>window.location='facturacion/cambioFechas.jsp'</script>");
                out.println(remisionesReImp);
            }
            if (request.getParameter("accion").equals("recalendarizarRemis")) {
                con.conectar();

                try {
                    String[] claveschk = request.getParameterValues("checkRemis");
                    String remisionesReCal = "";
                    for (int i = 0; i < claveschk.length; i++) {
                        if (i == (claveschk.length - 1)) {
                            remisionesReCal = remisionesReCal + "'" + claveschk[i] + "'";
                        } else {
                            remisionesReCal = remisionesReCal + "'" + claveschk[i] + "',";
                        }
                    }
                    out.println(remisionesReCal);

                    con.insertar("update tb_factura set F_FecEnt = '" + request.getParameter("F_FecEnt") + "' where F_ClaDoc in (" + remisionesReCal + ")");
                    out.println("<script>alert('Actualización correcta')</script>");
                } catch (Exception e) {
                    out.println("<script>alert('Error al actualizar')</script>");
                }
                out.println("<script>window.location='facturacion/cambioFechas.jsp'</script>");
                con.cierraConexion();
            }
            if (request.getParameter("accion").equals("validarVariasAuditor")) {
                con.conectar();
                String[] claveschk = request.getParameterValues("chkId");
                for (int i = 0; i < claveschk.length; i++) {
                    con.insertar("update tb_facttemp set F_StsFact='2' WHERE F_Id= '" + claveschk[i] + "'");
                    con.insertar("insert into tb_regvalida values ('" + claveschk[i] + "','" + sesion.getAttribute("nombre") + "',0)");
                }
                con.cierraConexion();

                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('Claves Validadas Correctamente')</script>");
                out.println("<script>window.location='validacionAuditores.jsp'</script>");
            }
            if (request.getParameter("accion").equals("validarVariasSurtido")) {
                con.conectar();
                String[] claveschk = request.getParameterValues("chkId");
                for (int i = 0; i < claveschk.length; i++) {
                    con.insertar("update tb_facttemp set F_StsFact='4', F_User='" + sesion.getAttribute("nombre") + "' WHERE F_Id= '" + claveschk[i] + "'");
                    con.insertar("insert into tb_regvalida values ('" + claveschk[i] + "','" + sesion.getAttribute("nombre") + "',0)");
                }
                con.cierraConexion();

                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('Claves Validadas Correctamente')</script>");
                out.println("<script>window.location='remisionarCamion.jsp'</script>");
            }
            if (request.getParameter("accion").equals("actualizarCBAuditor")) {
                try {
                    con.conectar();
                    con.insertar("update tb_lote set F_Cb='" + request.getParameter("F_Cb") + "' WHERE F_FolLot= '" + request.getParameter("F_FolLot") + "'");
                    con.insertar("update tb_compra set F_Cb='" + request.getParameter("F_Cb") + "' WHERE F_FolLot= '" + request.getParameter("F_FolLot") + "'");
                    con.cierraConexion();
                } catch (Exception e) {

                }
                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('CB actualizado Correctamente, ingrese el CB')</script>");
                out.println("<script>alert('Reimprima el Marbete Correcto')</script>");
                out.println("<script>window.location='validacionAuditores.jsp'</script>");
            }
            if (request.getParameter("accion").equals("actualizarCB")) {
                try {
                    con.conectar();
                    con.insertar("update tb_lote set F_Cb='" + request.getParameter("F_Cb") + "' WHERE F_FolLot= '" + request.getParameter("F_FolLot") + "'");
                    con.insertar("update tb_compra set F_Cb='" + request.getParameter("F_Cb") + "' WHERE F_FolLot= '" + request.getParameter("F_FolLot") + "'");
                    con.cierraConexion();
                } catch (Exception e) {

                }
                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('CB actualizado Correctamente, ingrese el CB')</script>");
                out.println("<script>alert('Reimprima el Marbete Correcto')</script>");
                out.println("<script>window.location='validacionSurtido.jsp'</script>");
            }
            if (request.getParameter("accion").equals("validaAuditor")) {
                try {
                    con.conectar();
                    con.insertar("update tb_facttemp set F_StsFact='2' WHERE F_Id= '" + request.getParameter("folio") + "'");
                    con.insertar("insert into tb_regvalida values ('" + request.getParameter("folio") + "','" + sesion.getAttribute("nombre") + "',0)");
                    con.cierraConexion();
                } catch (Exception e) {

                }
                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('Clave Validada Correctamente')</script>");
                out.println("<script>window.location='validacionAuditores.jsp'</script>");
            }
            if (request.getParameter("accion").equals("validaRegistro")) {
                try {
                    con.conectar();
                    con.insertar("update tb_facttemp set F_StsFact='4', F_User='" + sesion.getAttribute("nombre") + "' WHERE F_Id= '" + request.getParameter("folio") + "'");
                    con.insertar("insert into tb_regvalida values ('" + request.getParameter("folio") + "','" + sesion.getAttribute("nombre") + "',0)");
                    con.cierraConexion();
                } catch (Exception e) {

                }
                sesion.setAttribute("Nombre", request.getParameter("Nombre"));
                out.println("<script>alert('Clave Validada Correctamente')</script>");
                out.println("<script>window.location='remisionarCamion.jsp'</script>");
            }
            if (request.getParameter("accion").equals("EliminaConcentrado")) {
                try {
                    con.conectar();
                    sesion.setAttribute("F_IndGlobal", null);

                    ResultSet rset = con.consulta("select * from tb_facttemp where F_IdFact = '" + request.getParameter("fol_gnkl") + "'");
                    while (rset.next()) {
                        con.insertar("insert into tb_facttemp_elim values ('" + rset.getString(1) + "','" + rset.getString(2) + "','" + rset.getString(3) + "','" + rset.getString(4) + "','" + rset.getString(5) + "','" + rset.getString(6) + "','" + rset.getString(7) + "', '" + (String) sesion.getAttribute("nombre") + "', NOW())");
                    }
                    con.insertar("delete from tb_facttemp WHERE F_IdFact = '" + request.getParameter("fol_gnkl") + "'");

                    con.cierraConexion();
                } catch (Exception e) {

                }
                response.sendRedirect("reimpConcentrado.jsp");
            }
            if (request.getParameter("accion").equals("consultarAuto")) {
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("SELECT * FROM tb_unireq WHERE F_ClaUni = '" + request.getParameter("Nombre") + "' GROUP BY F_ClaUni");
                    while (rset.next()) {
                        ban1 = 1;
                        clave = rset.getString("F_ClaUni");
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }

                out.println("<script>window.location='facturaAuto.jsp'</script>");
            }

            if (request.getParameter("accion").equals("cancelar")) {
                try {
                    con.conectar();
                    ban1 = 1;
                    con.insertar("update tb_unireq set F_Status = '1' where F_ClaUni = '" + request.getParameter("F_ClaUni") + "' and F_Status=0 ");
                    con.cierraConexion();
                } catch (Exception e) {

                }

                response.setContentType("text/html");
                request.setAttribute("F_FecEnt", request.getParameter("F_FecEnt"));
                request.getRequestDispatcher("factura.jsp").forward(request, response);
            }
            //-------------------------------------------------------------------------------------------------
            if (request.getParameter("accion").equals("guardarGlobalAuto")) {

                //(String) sesion.getAttribute("nombre")
                ban1 = 1;
                String ClaUni = request.getParameter("Nombre");
                String FechaE = request.getParameter("F_FecEnt");
                String Clave = "", FolioLote = "";
                int piezas = 0, existencia = 0, diferencia = 0, X = 0, FolioFactura = 0, FolFact = 0, Tipo = 0, Org = 0, piezasDif = 0;

                try {

                    con.conectar();
                    //consql.conectar();

                    con.insertar("DROP TABLE IF EXISTS tb_lotetemp" + (String) sesion.getAttribute("nombre"));
                    con.insertar("create table tb_lotetemp" + (String) sesion.getAttribute("nombre") + " select * from tb_lote");
                    /*ResultSet Fechaa = con.consulta("SELECT STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     while (Fechaa.next()) {
                     FechaE = Fechaa.getString("STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     }*/
                    ResultSet FolioFact = con.consulta("SELECT F_IndGlobal FROM tb_indice");
                    while (FolioFact.next()) {
                        FolioFactura = Integer.parseInt(FolioFact.getString("F_IndGlobal"));
                    }
                    FolFact = FolioFactura + 1;
                    con.actualizar("update tb_indice set F_IndGlobal='" + FolFact + "'");

                    //ResultSet rset = con.consulta("select f.F_ClaUni from tb_fecharuta f, tb_uniatn u where f.F_ClaUni = u.F_ClaCli and f.F_Fecha = '" + request.getParameter("F_FecEnt") + "' and u.F_ClaJurNum = '" + request.getParameter("F_Juris") + "' ");
                    //while (rset.next()) {
                    //ClaUni = rset.getString("F_ClaUni");
                    //ClaUni = request.getParameter("Nombre");
                    //FechaE = request.getParameter("F_FecEnt");
                    /*
                     *Abre Ciclo ClaUni
                     */
                    ResultSet rset_cantidad = con.consulta("SELECT F_ClaPro,SUM(F_CajasReq) as cajas, SUM(F_PiezasReq) as piezas, F_IdReq FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_Status='0'  GROUP BY F_ClaPro");
                    while (rset_cantidad.next()) {
                        Clave = rset_cantidad.getString("F_ClaPro");
                        int cajasReq = Integer.parseInt(rset_cantidad.getString("cajas"));
                        int piezasReq = Integer.parseInt(rset_cantidad.getString("piezas"));
                        int pzxCaja = 0;
                        ResultSet rsetCP = con.consulta("select F_Pzs from tb_pzxcaja where F_ClaPro = '" + Clave + "' ");
                        while (rsetCP.next()) {
                            pzxCaja = rsetCP.getInt(1);
                        }
                        piezas = (pzxCaja * cajasReq) + piezasReq;
                        //piezas = Integer.parseInt(rset_cantidad.getString("CANTIDAD"));

                        String IdLote = "";
                        //INICIO DE CONSULTA MYSQL
                        ResultSet r_Org = con.consulta("SELECT F_ClaOrg FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " WHERE F_ClaPro='" + Clave + "' GROUP BY F_ClaPro");
                        while (r_Org.next()) {
                            Org = Integer.parseInt(r_Org.getString("F_ClaOrg"));

                            if (Org == 1) {
                                ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' and L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_FecCad,L.F_IdLote ASC");
                                while (FechaLote.next()) {
                                    FolioLote = FechaLote.getString("F_FolLot");
                                    IdLote = FechaLote.getString("F_IdLote");
                                    existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                    ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                    while (rset2.next()) {
                                        existencia = existencia - rset2.getInt(1);
                                    }
                                    Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                    if (existencia > 0) {
                                        if (piezas > existencia) {
                                            diferencia = piezas - existencia;
                                            con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");
                                            con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");

                                            piezasDif = 0;
                                            piezas = diferencia;

                                        } else {
                                            diferencia = existencia - piezas;
                                            if (diferencia > 0) {
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                if (piezas > 0) {
                                                    con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                }
                                            }
                                            piezasDif = diferencia;
                                            piezas = 0;
                                        }
                                    }
                                }
                            } else {
                                ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' AND L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_IdLote,L.F_FecCad ASC");
                                while (FechaLote.next()) {
                                    FolioLote = FechaLote.getString("F_FolLot");
                                    IdLote = FechaLote.getString("F_IdLote");
                                    existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                    ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                    while (rset2.next()) {
                                        existencia = existencia - rset2.getInt(1);
                                    }
                                    Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                    if (existencia > 0) {
                                        if (piezas > existencia) {
                                            diferencia = piezas - existencia;
                                            con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");

                                            con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");
                                            piezasDif = 0;
                                            piezas = diferencia;
                                        } else {
                                            diferencia = existencia - piezas;
                                            if (diferencia > 0) {
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");

                                                if (piezas >= 1) {
                                                    con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                }
                                            }
                                            piezasDif = diferencia;
                                            piezas = 0;
                                        }
                                    }
                                }
                            }
                            /**/
                            if (diferencia > 0 && piezasDif == 0) {
                                con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','0','" + FechaE + "','0','0','','" + diferencia + "','0')");
                                diferencia = 0;
                                piezasDif = 0;
                            }
                        }
                        con.actualizar("update tb_unireq set F_Status='2' where F_IdReq='" + rset_cantidad.getString("F_IdReq") + "'");
                    }
                    RequerimientoModula reqMod = new RequerimientoModula();
                    reqMod.enviaRequerimiento(FolFact + "");
                    response.sendRedirect("reimpConcentrado.jsp");
                    /*
                     * Cierra Ciclo
                     */
                    //}
                    //con.actualizar("delete * FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_FecCarg = CURDATE()");
                    con.cierraConexion();
                    //consql.cierraConexion();

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    System.out.println(e.getLocalizedMessage());
                }
                out.println("<script>window.open('reimpGlobalReq.jsp?fol_gnkl=" + FolFact + "','_blank')</script>");
                out.println("<script>window.open('reimpGlobalMarbetes.jsp?fol_gnkl=" + FolFact + "','_blank')</script>");
            }
            //-------------------------------------------------------------------------------------------------
            if (request.getParameter("accion").equals("guardarGlobal")) {

                ban1 = 1;
                String ClaUni = request.getParameter("Nombre");
                String FechaE = request.getParameter("FecFab");
                String Clave = "", FolioLote = "";
                int piezas = 0, existencia = 0, diferencia = 0, X = 0, FolioFactura = 0, FolFact = 0, Tipo = 0, Org = 0, piezasDif = 0;

                String[] claveschk = request.getParameterValues("chkUniFact");
                String Unidades = "";
                for (int i = 0; i < claveschk.length; i++) {
                    if (i == (claveschk.length - 1)) {
                        Unidades = Unidades + "'" + claveschk[i] + "'";
                    } else {
                        Unidades = Unidades + "'" + claveschk[i] + "',";
                    }
                }
                out.println(Unidades);

                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select F_ClaPro, F_ClaUni from tb_unireq where F_ClaUni in( " + Unidades + ") and F_Status=0 and  F_PiezasReq != 0");
                    while (rset.next()) {
                        String ClaPro = rset.getString("F_ClaPro");
                        String F_NCant = request.getParameter(rset.getString("F_ClaUni") + "_" + ClaPro.trim());
                        con.insertar("update tb_unireq set F_PiezasReq = '" + F_NCant + "' where F_ClaPro = '" + rset.getString("F_ClaPro") + "' and F_ClaUni = '" + rset.getString("F_ClaUni") + "' and F_Status='0'");
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                try {

                    con.conectar();
                    //consql.conectar();

                    con.insertar("DROP TABLE IF EXISTS tb_lotetemp" + (String) sesion.getAttribute("nombre"));
                    con.insertar("create table tb_lotetemp" + (String) sesion.getAttribute("nombre") + " select * from tb_lote");
                    /*ResultSet Fechaa = con.consulta("SELECT STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     while (Fechaa.next()) {
                     FechaE = Fechaa.getString("STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     }*/

                    ResultSet rset = con.consulta("select f.F_ClaUni from tb_fecharuta f, tb_uniatn u where f.F_ClaUni = u.F_ClaCli and f.F_Fecha = '" + request.getParameter("F_FecEnt") + "' and u.F_ClaJurNum in (" + request.getParameter("F_Juris") + ") and f.F_ClaUni in (" + Unidades + ") ");
                    while (rset.next()) {
                        ResultSet FolioFact = con.consulta("SELECT F_IndGlobal FROM tb_indice");
                        while (FolioFact.next()) {
                            FolioFactura = Integer.parseInt(FolioFact.getString("F_IndGlobal"));
                        }
                        FolFact = FolioFactura + 1;
                        con.actualizar("update tb_indice set F_IndGlobal='" + FolFact + "'");
                        ClaUni = rset.getString("F_ClaUni");
                        FechaE = request.getParameter("F_FecEnt");
                        /*
                         *Abre Ciclo ClaUni
                         */
                        ResultSet rset_cantidad = con.consulta("SELECT F_ClaPro,SUM(F_CajasReq) as cajas, SUM(F_PiezasReq) as piezas, F_IdReq FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_Status='0' and F_PiezasReq!=0 GROUP BY F_ClaPro");
                        while (rset_cantidad.next()) {
                            Clave = rset_cantidad.getString("F_ClaPro");
                            int cajasReq = Integer.parseInt(rset_cantidad.getString("cajas"));
                            int piezasReq = Integer.parseInt(rset_cantidad.getString("piezas"));
                            int pzxCaja = 0;
                            ResultSet rsetCP = con.consulta("select F_Pzs from tb_pzxcaja where F_ClaPro = '" + Clave + "' ");
                            while (rsetCP.next()) {
                                pzxCaja = rsetCP.getInt(1);
                            }
                            piezas = (pzxCaja * cajasReq) + piezasReq;
                            //piezas = Integer.parseInt(rset_cantidad.getString("CANTIDAD"));

                            String IdLote = "";
                            //INICIO DE CONSULTA MYSQL
                            ResultSet r_Org = con.consulta("SELECT F_ClaOrg FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " WHERE F_ClaPro='" + Clave + "' GROUP BY F_ClaPro");
                            while (r_Org.next()) {
                                Org = Integer.parseInt(r_Org.getString("F_ClaOrg"));

                                if (Org == 1) {
                                    ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' and L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_FecCad,L.F_IdLote ASC");
                                    while (FechaLote.next()) {
                                        FolioLote = FechaLote.getString("F_FolLot");
                                        IdLote = FechaLote.getString("F_IdLote");
                                        existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                        ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                        while (rset2.next()) {
                                            existencia = existencia - rset2.getInt(1);
                                        }
                                        Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                        if (existencia > 0) {
                                            if (piezas > existencia) {
                                                diferencia = piezas - existencia;
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");
                                                con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");

                                                piezasDif = 0;
                                                piezas = diferencia;

                                            } else {
                                                diferencia = existencia - piezas;

                                                if (diferencia > 0) {
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    if (piezas > 0) {
                                                        con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                        con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    }
                                                }
                                                piezasDif = diferencia;
                                                piezas = 0;
                                            }
                                        }
                                    }
                                } else {
                                    ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' AND L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_IdLote,L.F_FecCad ASC");
                                    while (FechaLote.next()) {
                                        FolioLote = FechaLote.getString("F_FolLot");
                                        IdLote = FechaLote.getString("F_IdLote");
                                        existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                        ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                        while (rset2.next()) {
                                            existencia = existencia - rset2.getInt(1);
                                        }
                                        Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                        if (existencia > 0) {
                                            if (piezas > existencia) {
                                                diferencia = piezas - existencia;
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");

                                                con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");
                                                piezasDif = 0;
                                                piezas = diferencia;
                                            } else {
                                                diferencia = existencia - piezas;
                                                if (diferencia > 0) {
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");

                                                    if (piezas >= 1) {
                                                        con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                        con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    }
                                                }
                                                piezasDif = diferencia;
                                                piezas = 0;
                                            }
                                        }
                                    }
                                }
                                /**/
                                if (diferencia > 0 && piezasDif == 0) {
                                    con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','0','" + FechaE + "','0','0','','" + diferencia + "','0')");
                                    diferencia = 0;
                                    piezasDif = 0;
                                }
                            }
                            con.actualizar("update tb_unireq set F_Status='2' where F_IdReq='" + rset_cantidad.getString("F_IdReq") + "'");

                        }
                        con.actualizar("update tb_unireq set F_Status='2' where F_ClaUni='" + ClaUni + "' and F_Status='0' ");
                        try {
                            /*RequerimientoModula reqMod = new RequerimientoModula();
                             reqMod.enviaRequerimiento(FolFact + "");*/
                        } catch (Exception e) {
                            out.println("<script>alert('Error conexión MODULA')</script>");
                        }
                        //response.sendRedirect("reimpConcentrado.jsp");
                        /*
                         * Cierra Ciclo
                         */
                    }
                    //con.actualizar("delete * FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_FecCarg = CURDATE()");
                    con.cierraConexion();
                    //consql.cierraConexion();

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    System.out.println(e.getLocalizedMessage());
                }
                out.println("<script>window.location='reimpConcentrado.jsp'</script>");
                //out.println("<script>window.open('reimpGlobalReq.jsp?fol_gnkl=" + FolFact + "','_blank')</script>");
                //out.println("<script>window.open('reimpGlobalMarbetes.jsp?fol_gnkl=" + FolFact + "','_blank')</script>");
            }
            //--------------------------------------------------------------------------------------------------------------------------------------
            if (request.getParameter("accion").equals("generarRemision")) {

                ban1 = 1;
                String ClaUni = request.getParameter("Nombre");
                String FechaE = request.getParameter("FecFab");
                String Clave = "", FolioLote = "";
                int piezas = 0, existencia = 0, diferencia = 0, X = 0, FolioFactura = 0, FolFact = 0, Tipo = 0, Org = 0, piezasDif = 0;

                String[] claveschk = request.getParameterValues("chkUniFact");
                String Unidades = "";
                for (int i = 0; i < claveschk.length; i++) {
                    if (i == (claveschk.length - 1)) {
                        Unidades = Unidades + "'" + claveschk[i] + "'";
                    } else {
                        Unidades = Unidades + "'" + claveschk[i] + "',";
                    }
                }
                out.println(Unidades);

                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select F_ClaPro, F_ClaUni from tb_unireq where F_ClaUni in( " + Unidades + ") and F_Status=0 and  F_PiezasReq != 0");
                    while (rset.next()) {
                        String ClaPro = rset.getString("F_ClaPro");
                        String F_NCant = request.getParameter(rset.getString("F_ClaUni") + "_" + ClaPro.trim());
                        con.insertar("update tb_unireq set F_PiezasReq = '" + F_NCant + "' where F_ClaPro = '" + rset.getString("F_ClaPro") + "' and F_ClaUni = '" + rset.getString("F_ClaUni") + "' and F_Status='0'");
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

                try {

                    con.conectar();
                    //consql.conectar();

                    con.insertar("DROP TABLE IF EXISTS tb_lotetemp" + (String) sesion.getAttribute("nombre"));
                    con.insertar("create table tb_lotetemp" + (String) sesion.getAttribute("nombre") + " select * from tb_lote");
                    /*ResultSet Fechaa = con.consulta("SELECT STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     while (Fechaa.next()) {
                     FechaE = Fechaa.getString("STR_TO_DATE(" + FechaE + ", '%d/%m/%Y')");
                     }*/

                    ResultSet rset = con.consulta("select f.F_ClaUni from tb_fecharuta f, tb_uniatn u where f.F_ClaUni = u.F_ClaCli and f.F_Fecha = '" + request.getParameter("F_FecEnt") + "' and u.F_ClaJurNum in (" + request.getParameter("F_Juris") + ") and f.F_ClaUni in (" + Unidades + ") ");
                    while (rset.next()) {
                        ResultSet FolioFact = con.consulta("SELECT F_IndGlobal FROM tb_indice");
                        while (FolioFact.next()) {
                            FolioFactura = Integer.parseInt(FolioFact.getString("F_IndGlobal"));
                        }
                        FolFact = FolioFactura + 1;
                        con.actualizar("update tb_indice set F_IndGlobal='" + FolFact + "'");
                        ClaUni = rset.getString("F_ClaUni");
                        FechaE = request.getParameter("F_FecEnt");
                        /*
                         *Abre Ciclo ClaUni
                         */
                        ResultSet rset_cantidad = con.consulta("SELECT F_ClaPro,SUM(F_CajasReq) as cajas, SUM(F_PiezasReq) as piezas, F_IdReq FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_Status='0' and F_PiezasReq!=0 GROUP BY F_ClaPro");
                        while (rset_cantidad.next()) {
                            Clave = rset_cantidad.getString("F_ClaPro");
                            int cajasReq = Integer.parseInt(rset_cantidad.getString("cajas"));
                            int piezasReq = Integer.parseInt(rset_cantidad.getString("piezas"));
                            int pzxCaja = 0;
                            ResultSet rsetCP = con.consulta("select F_Pzs from tb_pzxcaja where F_ClaPro = '" + Clave + "' ");
                            while (rsetCP.next()) {
                                pzxCaja = rsetCP.getInt(1);
                            }
                            piezas = (pzxCaja * cajasReq) + piezasReq;
                            //piezas = Integer.parseInt(rset_cantidad.getString("CANTIDAD"));

                            String IdLote = "";
                            //INICIO DE CONSULTA MYSQL
                            ResultSet r_Org = con.consulta("SELECT F_ClaOrg FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " WHERE F_ClaPro='" + Clave + "' GROUP BY F_ClaPro");
                            while (r_Org.next()) {
                                Org = Integer.parseInt(r_Org.getString("F_ClaOrg"));

                                if (Org == 1) {
                                    ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' and L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_FecCad,L.F_IdLote ASC");
                                    while (FechaLote.next()) {
                                        FolioLote = FechaLote.getString("F_FolLot");
                                        IdLote = FechaLote.getString("F_IdLote");
                                        existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                        ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                        while (rset2.next()) {
                                            existencia = existencia - rset2.getInt(1);
                                        }
                                        Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                        if (existencia > 0) {
                                            if (piezas > existencia) {
                                                diferencia = piezas - existencia;
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");
                                                con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");

                                                piezasDif = 0;
                                                piezas = diferencia;

                                            } else {
                                                diferencia = existencia - piezas;

                                                if (diferencia > 0) {
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    if (piezas > 0) {
                                                        con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                        con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    }
                                                }
                                                piezasDif = diferencia;
                                                piezas = 0;
                                            }
                                        }
                                    }
                                } else {
                                    ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,(L.F_ExiLot) AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lotetemp" + (String) sesion.getAttribute("nombre") + " L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' AND L.F_Ubica !='REJA_DEVOL'  GROUP BY L.F_IdLote ORDER BY L.F_Origen, L.F_IdLote,L.F_FecCad ASC");
                                    while (FechaLote.next()) {
                                        FolioLote = FechaLote.getString("F_FolLot");
                                        IdLote = FechaLote.getString("F_IdLote");
                                        existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                        ResultSet rset2 = con.consulta("select sum(F_Cant) from tb_facttemp where F_IdLot = '" + IdLote + "' and F_StsFact!=5");
                                        while (rset2.next()) {
                                            existencia = existencia - rset2.getInt(1);
                                        }
                                        Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                        if (existencia > 0) {
                                            if (piezas > existencia) {
                                                diferencia = piezas - existencia;
                                                con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");

                                                con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + existencia + "','" + FechaE + "','0','0','','" + existencia + "','0')");
                                                piezasDif = 0;
                                                piezas = diferencia;
                                            } else {
                                                diferencia = existencia - piezas;
                                                if (diferencia > 0) {
                                                    con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");

                                                    if (piezas >= 1) {
                                                        con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','" + piezas + "','" + FechaE + "','0','0','','" + piezas + "','0')");
                                                        con.actualizar("UPDATE tb_lotetemp" + (String) sesion.getAttribute("nombre") + " SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                                    }
                                                }
                                                piezasDif = diferencia;
                                                piezas = 0;
                                            }
                                        }
                                    }
                                }
                                /**/
                                if (diferencia > 0 && piezasDif == 0) {
                                    con.insertar("insert into tb_facttemp values('" + FolFact + "','" + ClaUni + "','" + IdLote + "','0','" + FechaE + "','0','0','','" + diferencia + "','0')");
                                    diferencia = 0;
                                    piezasDif = 0;
                                }
                            }
                            con.actualizar("update tb_unireq set F_Status='2' where F_IdReq='" + rset_cantidad.getString("F_IdReq") + "'");

                        }
                        con.actualizar("update tb_unireq set F_Status='2' where F_ClaUni='" + ClaUni + "' and F_Status='0' ");
                        try {
                            /*RequerimientoModula reqMod = new RequerimientoModula();
                             reqMod.enviaRequerimiento(FolFact + "");*/
                        } catch (Exception e) {
                            //out.println("<script>alert('Error conexión MODULA')</script>");
                        }
                        //response.sendRedirect("reimpConcentrado.jsp");
                        /*
                         * Cierra Ciclo
                         */
                    }
                    //con.actualizar("delete * FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_FecCarg = CURDATE()");
                    con.cierraConexion();
                    //consql.cierraConexion();

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    System.out.println(e.getLocalizedMessage());
                }
                //out.println("<script>window.location='reimpConcentrado.jsp'</script>");

                ////----------------------------------------------------------------------------------------------------
                ////----------------------------------------------------------------------------------------------------
                try {

                    con.conectar();

                    ResultSet rsetFactTemp = con.consulta("select F_Id, F_IdFact from tb_factemp where F_ClaCli in () and F_StsFact<5 group by F_IdFact");
//consql.conectar();

                    while (rsetFactTemp.next()) {
                        FolioFactura = 0;
                        String idFact = "";
                        FechaE = request.getParameter("Fecha");
                        ResultSet FolioFact = con.consulta("SELECT F_IndFact FROM tb_indice");
                        while (FolioFact.next()) {
                            FolioFactura = Integer.parseInt(FolioFact.getString("F_IndFact"));
                        }
                        FolFact = FolioFactura + 1;
                        con.actualizar("update tb_indice set F_IndFact='" + FolFact + "'");
                        byte[] a = request.getParameter("Obs").getBytes("ISO-8859-1");
                        String Observaciones = (new String(a, "UTF-8")).toUpperCase();
                        String req = request.getParameter("F_Req").toUpperCase();
                        if (req.equals("")) {
                            req = "00000";
                        }
                        String qryFact = "select f.F_ClaCli, l.F_FolLot, l.F_IdLote, l.F_ClaPro, l.F_ClaLot, l.F_FecCad, m.F_TipMed, m.F_Costo, p.F_ClaProve, f.F_Cant, l.F_ExiLot, l.F_Ubica, f.F_IdFact, f.F_Id, f.F_FecEnt, f.F_CantSol  from tb_facttemp f, tb_lote l, tb_medica m, tb_proveedor p where f.F_IdLot = l.F_IdLote AND l.F_ClaPro = m.F_ClaPro AND l.F_ClaOrg = p.F_ClaProve and f.F_IdFact = '" + request.getParameter("Nombre") + "' and f.F_StsFact=4 AND (f.F_ClaCli = (" + rsetFactTemp.getString("F_IdFact") + ")) ";
                        ResultSet rset = con.consulta(qryFact);
                        while (rset.next()) {
                            idFact = rset.getString("F_IdFact");
                            ClaUni = rset.getString("F_ClaCli");
                            Clave = rset.getString("F_ClaPro");
                            String Caducidad = rset.getString("F_FecCad");
                            FolioLote = rset.getString("F_FolLot");
                            String IdLote = rset.getString("F_IdLote");
                            String ClaLot = rset.getString("F_ClaLot");
                            String Ubicacion = rset.getString("F_Ubica");
                            String ClaProve = rset.getString("F_ClaProve");
                            String F_Id = rset.getString("F_Id");
                            String F_CantSol = rset.getString("F_CantSol");
                            FechaE = rset.getString("F_FecEnt");
                            existencia = rset.getInt("F_ExiLot");
                            int cantidad = rset.getInt("F_Cant");
                            Tipo = rset.getInt("F_TipMed");
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
                            if (Diferencia >= 0) {
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
                                con.insertar("insert into tb_factura values(0,'" + idFact + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + F_CantSol + "','" + cantidad + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','',0)");
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
                            } else {
                                out.println("<script>window.open('Error al Generar la remisión, Contacte con el área de Sistemas')</script>");
                                out.println("<script>window.location='remisionarCamion.jsp'</script>");
                            }
                        }

                        con.insertar("insert into tb_obserfact values ('" + idFact + "','" + Observaciones + "',0,'" + request.getParameter("F_Req").toUpperCase() + "', '" + request.getParameter("F_Tipo") + "')");
                        out.println("<script>window.open('reimpFactura.jsp?fol_gnkl=" + idFact + "','_blank')</script>");
                        //Finaliza
                        //consql.cierraConexion();
                    }
                    con.cierraConexion();
                    sesion.setAttribute("ClaCliFM", "");
                    sesion.setAttribute("FechaEntFM", "");
                    sesion.setAttribute("ClaProFM", "");
                    sesion.setAttribute("DesProFM", "");
                    sesion.setAttribute("F_IndGlobal", null);
                    //Aqui tenemos que poner en nulo la variable de folio de dactura
                    //out.println("<script>window.location='remisionarCamion.jsp'</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                ////----------------------------------------------------------------------------------------------------
                ////----------------------------------------------------------------------------------------------------
            }
            //-----------------------------------------------------------------------------------------------------------
            if (request.getParameter("accion").equals("guardar")) {

                ban1 = 1;
                String ClaUni = request.getParameter("Nombre");
                String FechaE = request.getParameter("FecFab");
                String Clave = "", Caducidad = "", FolioLote = "", Lote = "", Ubicacion = "";
                int piezas = 0, existencia = 0, diferencia = 0, ContaLot = 0, X = 0, FolioFactura = 0, FolFact = 0, Tipo = 0, ClaProve = 0, Org = 0, FolMov = 0, FolioMovi = 0;
                double Costo = 0.0, IVA = 0.0, Monto = 0.0, IVAPro = 0.0, MontoIva = 0.0;

                try {

                    con.conectar();
                    //consql.conectar();

                    ResultSet Fechaa = con.consulta("SELECT STR_TO_DATE('" + FechaE + "', '%d/%m/%Y')");
                    while (Fechaa.next()) {
                        FechaE = Fechaa.getString("STR_TO_DATE('" + FechaE + "', '%d/%m/%Y')");
                    }
                    ResultSet FolioFact = con.consulta("SELECT F_IndFact FROM tb_indice");
                    while (FolioFact.next()) {
                        FolioFactura = Integer.parseInt(FolioFact.getString("F_IndFact"));
                    }
                    FolFact = FolioFactura + 1;
                    con.actualizar("update tb_indice set F_IndFact='" + FolFact + "'");

                    ResultSet rset_cantidad = con.consulta("SELECT F_ClaPro,SUM(F_CantReq) AS CANTIDAD, F_IdReq FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_Status='0' and F_FecCarg = CURDATE() GROUP BY F_ClaPro");
                    while (rset_cantidad.next()) {
                        Clave = rset_cantidad.getString("F_ClaPro");
                        piezas = Integer.parseInt(rset_cantidad.getString("CANTIDAD"));
                        String piezasOri = rset_cantidad.getString("CANTIDAD");

                        //INICIO DE CONSULTA MYSQL
                        ResultSet r_Org = con.consulta("SELECT F_ClaOrg FROM tb_lote WHERE F_ClaPro='" + Clave + "' GROUP BY F_ClaOrg ORDER BY F_ClaOrg+0");
                        while (r_Org.next()) {
                            Org = Integer.parseInt(r_Org.getString("F_ClaOrg"));

                            if (Org == 1) {
                                ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,L.F_ExiLot AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot, L.F_IdLote FROM tb_lote L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' AND L.F_ClaOrg='" + Org + "' ORDER BY L.F_Origen, L.F_FecCad ASC");
                                while (FechaLote.next()) {
                                    Caducidad = FechaLote.getString("F_FecCad");
                                    FolioLote = FechaLote.getString("F_FolLot");
                                    String IdLote = FechaLote.getString("F_IdLote");
                                    String ClaLot = FechaLote.getString("F_ClaLot");
                                    existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                    Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                    Costo = Double.parseDouble(FechaLote.getString("F_Costo"));
                                    Ubicacion = FechaLote.getString("F_Ubica");
                                    ClaProve = Integer.parseInt(FechaLote.getString("F_ProVee"));
                                    if (Tipo == 2504) {
                                        IVA = 0.0;
                                    } else {
                                        IVA = 0.16;
                                    }

                                    if (piezas > existencia) {
                                        diferencia = piezas - existencia;
                                        /*ResultSet rsetLoteSQL = consql.consulta("select F_FolLot as lote from tb_lote where F_ClaPro = '" + Clave + "' and F_ClaLot = '" + ClaLot + "' and F_FecCad = '" + df2.format(df3.parse(Caducidad)) + "'  and F_Origen = '" + dame5car("1") + "' ");
                                         String loteSQL = "";
                                         while (rsetLoteSQL.next()) {
                                         loteSQL = rsetLoteSQL.getString("lote");
                                         }
                                         consql.actualizar("UPDATE TB_lote SET F_ExiLot='0' WHERE F_FolLot='" + loteSQL + "'");*/
                                        con.actualizar("UPDATE tb_lote SET F_ExiLot='0' WHERE F_IdLote='" + IdLote + "'");

                                        IVAPro = (existencia * Costo) * IVA;
                                        Monto = existencia * Costo;
                                        MontoIva = Monto + IVAPro;

                                        ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                                        while (FolioMov.next()) {
                                            FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                                        }
                                        FolMov = FolioMovi + 1;
                                        con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");

                                        con.insertar("insert into tb_movinv values(0,curdate(),'" + FolioFactura + "','51','" + Clave + "','" + existencia + "','" + Costo + "','" + MontoIva + "','-1','" + FolioLote + "','" + Ubicacion + "','" + ClaProve + "',curtime(),'" + sesion.getAttribute("nombre") + "')");
                                        con.insertar("insert into tb_factura values(0,'" + FolioFactura + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + piezasOri + "','" + existencia + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','')");
                                        //consql.insertar("insert into TB_MovInv values (CONVERT(date,GETDATE()),'" + FolioFactura + "','','51', '" + Clave + "', '" + existencia + "', '" + Costo + "','" + IVAPro + "', '" + MontoIva + "' ,'-1', '" + FolioLote + "', '" + FolioMovi + "','A', '0', '','','','" + ClaProve + "','" + sesion.getAttribute("nombre") + "') ");
                                        //consql.insertar("insert into TB_Factura values ('F','" + FolioFactura + "','" + dame5car(ClaUni) + "','A','',CONVERT(date,GETDATE()),'','" + Clave + "', '','1','" + piezasOri + "','" + existencia + "', '" + Monto + "','0', '" + Monto + "','" + Monto + "','" + Monto + "','" + IVAPro + "', '" + MontoIva + "','" + Costo + "' ,'" + FolioLote + "','R','" + df2.format(df3.parse(FechaE)) + "','" + sesion.getAttribute("nombre") + "','0','0','','A','" + existencia + "','" + Ubicacion + "') ");
                                        piezas = diferencia;
                                    } else {
                                        diferencia = existencia - piezas;
                                        /*ResultSet rsetLoteSQL = consql.consulta("select F_FolLot as lote from tb_lote where F_ClaPro = '" + Clave + "' and F_ClaLot = '" + ClaLot + "' and F_FecCad = '" + df2.format(df3.parse(Caducidad)) + "'  and F_Origen = '" + dame5car("1") + "' ");
                                         String loteSQL = "";
                                         while (rsetLoteSQL.next()) {
                                         loteSQL = rsetLoteSQL.getString("lote");
                                         }*/
                                        con.actualizar("UPDATE tb_lote SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                        //consql.actualizar("UPDATE TB_lote SET F_ExiLot='" + diferencia + "' WHERE F_FolLot='" + loteSQL + "'");

                                        IVAPro = (piezas * Costo) * IVA;
                                        Monto = piezas * Costo;
                                        MontoIva = Monto + IVAPro;

                                        if (piezas > 0) {
                                            ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                                            while (FolioMov.next()) {
                                                FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                                            }
                                            FolMov = FolioMovi + 1;
                                            con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");

                                            con.insertar("insert into tb_movinv values(0,curdate(),'" + FolioFactura + "','51','" + Clave + "','" + piezas + "','" + Costo + "','" + MontoIva + "','-1','" + FolioLote + "','" + Ubicacion + "','" + ClaProve + "',curtime(),'" + sesion.getAttribute("nombre") + "')");
                                            con.insertar("insert into tb_factura values(0,'" + FolioFactura + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + piezasOri + "','" + piezas + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','')");
                                            con.actualizar("UPDATE tb_lote SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                            //consql.insertar("insert into TB_MovInv values (CONVERT(date,GETDATE()),'" + FolioFactura + "','','51', '" + Clave + "', '" + piezas + "', '" + Costo + "','" + IVAPro + "', '" + MontoIva + "' ,'-1', '" + FolioLote + "', '" + FolioMovi + "','A', '0', '','','','" + ClaProve + "','" + sesion.getAttribute("nombre") + "') ");
                                            //consql.insertar("insert into TB_Factura values ('F','" + FolioFactura + "','" + dame5car(ClaUni) + "','A','',CONVERT(date,GETDATE()),'','" + Clave + "', '','1','" + piezasOri + "','" + piezas + "', '" + Monto + "','0', '" + Monto + "','" + Monto + "','" + Monto + "','" + IVAPro + "', '" + MontoIva + "','" + Costo + "' ,'" + FolioLote + "','R','" + df2.format(df3.parse(FechaE)) + "','" + sesion.getAttribute("nombre") + "','0','0','','A','" + piezas + "','" + Ubicacion + "') ");
                                        }
                                        piezas = 0;
                                    }
                                }
                            } else {
                                ResultSet FechaLote = con.consulta("SELECT L.F_FecCad AS F_FecCad,L.F_FolLot AS F_FolLot,L.F_ExiLot AS F_ExiLot, M.F_TipMed AS F_TipMed, M.F_Costo AS F_Costo, L.F_Ubica AS F_Ubica, C.F_ProVee AS F_ProVee, F_ClaLot,F_IdLote FROM tb_lote L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro INNER JOIN tb_compra C ON L.F_FolLot=C.F_Lote WHERE L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>'0' ORDER BY L.F_Origen, L.F_FecCad ASC");
                                while (FechaLote.next()) {
                                    Caducidad = FechaLote.getString("F_FecCad");
                                    FolioLote = FechaLote.getString("F_FolLot");
                                    String IdLote = FechaLote.getString("F_IdLote");
                                    String ClaLot = FechaLote.getString("F_ClaLot");
                                    existencia = Integer.parseInt(FechaLote.getString("F_ExiLot"));
                                    Tipo = Integer.parseInt(FechaLote.getString("F_TipMed"));
                                    Costo = Double.parseDouble(FechaLote.getString("F_Costo"));
                                    Ubicacion = FechaLote.getString("F_Ubica");
                                    ClaProve = Integer.parseInt(FechaLote.getString("F_ProVee"));
                                    if (Tipo == 2504) {
                                        IVA = 0.0;
                                    } else {
                                        IVA = 0.16;
                                    }
                                    /* ResultSet CantidadLote = con.consulta("SELECT F_ExiLot FROM tb_lote WHERE F_FolLot='"+FolioLote+"'");
                                     while(CantidadLote.next()){
                                     existencia = Integer.parseInt(CantidadLote.getString("F_ExiLot"));
                                     }*/
                                    if (piezas > existencia) {
                                        diferencia = piezas - existencia;
                                        /*ResultSet rsetLoteSQL = consql.consulta("select F_FolLot as lote from tb_lote where F_ClaPro = '" + Clave + "' and F_ClaLot = '" + ClaLot + "' and F_FecCad = '" + df2.format(df3.parse(Caducidad)) + "'  and F_Origen = '" + dame5car("1") + "' ");
                                         String loteSQL = "";
                                         while (rsetLoteSQL.next()) {
                                         loteSQL = rsetLoteSQL.getString("lote");
                                         }
                                         consql.actualizar("UPDATE TB_lote SET F_ExiLot='0' WHERE F_FolLot='" + loteSQL + "'");*/
                                        con.actualizar("UPDATE tb_lote SET F_IdLote='0' WHERE F_FolLot='" + IdLote + "'");

                                        IVAPro = (existencia * Costo) * IVA;
                                        Monto = existencia * Costo;
                                        MontoIva = Monto + IVAPro;

                                        ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                                        while (FolioMov.next()) {
                                            FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                                        }
                                        FolMov = FolioMovi + 1;
                                        con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");

                                        con.insertar("insert into tb_movinv values(0,curdate(),'" + FolioFactura + "','51','" + Clave + "','" + existencia + "','" + Costo + "','" + MontoIva + "','-1','" + FolioLote + "','" + Ubicacion + "','" + ClaProve + "',curtime(),'" + sesion.getAttribute("nombre") + "')");
                                        con.insertar("insert into tb_factura values(0,'" + FolioFactura + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + piezasOri + "','" + existencia + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','')");
                                        //consql.insertar("insert into TB_MovInv values (CONVERT(date,GETDATE()),'" + FolioFactura + "','','51', '" + Clave + "', '" + existencia + "', '" + Costo + "','" + IVAPro + "', '" + MontoIva + "' ,'-1', '" + FolioLote + "', '" + FolioMovi + "','A', '0', '','','','" + ClaProve + "','" + sesion.getAttribute("nombre") + "') ");
                                        //consql.insertar("insert into TB_Factura values ('F','" + FolioFactura + "','" + dame5car(ClaUni) + "','A','',CONVERT(date,GETDATE()),'','" + Clave + "', '','1','" + piezasOri + "','" + existencia + "', '" + Monto + "','0', '" + Monto + "','" + Monto + "','" + Monto + "','" + IVAPro + "', '" + MontoIva + "','" + Costo + "' ,'" + FolioLote + "','R','" + df2.format(df3.parse(FechaE)) + "','" + sesion.getAttribute("nombre") + "','0','0','','A','" + existencia + "','" + Ubicacion + "') ");

                                        piezas = diferencia;
                                    } else {
                                        diferencia = existencia - piezas;
                                        /*ResultSet rsetLoteSQL = consql.consulta("select F_FolLot as lote from tb_lote where F_ClaPro = '" + Clave + "' and F_ClaLot = '" + ClaLot + "' and F_FecCad = '" + df2.format(df3.parse(Caducidad)) + "'  and F_Origen = '" + dame5car("1") + "' ");
                                         String loteSQL = "";
                                         while (rsetLoteSQL.next()) {
                                         loteSQL = rsetLoteSQL.getString("lote");
                                         }*/
                                        con.actualizar("UPDATE tb_lote SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                        //consql.actualizar("UPDATE TB_lote SET F_ExiLot='" + diferencia + "' WHERE F_FolLot='" + loteSQL + "'");

                                        IVAPro = (piezas * Costo) * IVA;
                                        Monto = piezas * Costo;
                                        MontoIva = Monto + IVAPro;

                                        if (piezas >= 1) {
                                            ResultSet FolioMov = con.consulta("SELECT F_IndMov FROM tb_indice");
                                            while (FolioMov.next()) {
                                                FolioMovi = Integer.parseInt(FolioMov.getString("F_IndMov"));
                                            }
                                            FolMov = FolioMovi + 1;
                                            con.actualizar("update tb_indice set F_IndMov='" + FolMov + "'");

                                            con.insertar("insert into tb_movinv values(0,curdate(),'" + FolioFactura + "','51','" + Clave + "','" + piezas + "','" + Costo + "','" + MontoIva + "','-1','" + FolioLote + "','" + Ubicacion + "','" + ClaProve + "',curtime(),'" + sesion.getAttribute("nombre") + "')");
                                            con.insertar("insert into tb_factura values(0,'" + FolioFactura + "','" + ClaUni + "','A',curdate(),'" + Clave + "','" + piezasOri + "','" + piezas + "','" + Costo + "','" + IVAPro + "','" + MontoIva + "','" + FolioLote + "','" + FechaE + "',curtime(),'" + sesion.getAttribute("nombre") + "','" + Ubicacion + "','')");
                                            con.actualizar("UPDATE tb_lote SET F_ExiLot='" + diferencia + "' WHERE F_IdLote='" + IdLote + "'");
                                            //consql.insertar("insert into TB_MovInv values (CONVERT(date,GETDATE()),'" + FolioFactura + "','','51', '" + Clave + "', '" + piezas + "', '" + Costo + "','" + IVAPro + "', '" + MontoIva + "' ,'-1', '" + FolioLote + "', '" + FolioMovi + "','A', '0', '','','','" + ClaProve + "','" + sesion.getAttribute("nombre") + "') ");
                                            //consql.insertar("insert into TB_Factura values ('F','" + FolioFactura + "','" + dame5car(ClaUni) + "','A','',CONVERT(date,GETDATE()),'','" + Clave + "', '','1','" + piezasOri + "','" + piezas + "', '" + Monto + "','0', '" + Monto + "','" + Monto + "','" + Monto + "','" + IVAPro + "', '" + MontoIva + "','" + Costo + "' ,'" + FolioLote + "','R','" + df2.format(df3.parse(FechaE)) + "','" + sesion.getAttribute("nombre") + "','0','0','','A','" + piezas + "','" + Ubicacion + "') ");
                                        }
                                        piezas = 0;
                                    }
                                }
                            }
                        }
                        //FIN CONSULTA MYSQL
                        /*ResultSet existSql = consql.consulta("select F_Existen from TB_Medica where F_ClaPro = '" + Clave + "' ");
                         while (existSql.next()) {
                         int difTotal = existSql.getInt("F_Existen") - rset_cantidad.getInt("CANTIDAD");
                         if (difTotal < 0) {
                         difTotal = 0;
                         }
                         consql.actualizar("update TB_Medica set F_Existen = '" + difTotal + "' where F_ClaPro = '" + Clave + "' ");
                         }*/
                        con.actualizar("update tb_unireq set F_Status='1' where F_IdReq='" + rset_cantidad.getString("F_IdReq") + "'");
                    }
                    con.actualizar("delete * FROM tb_unireq WHERE F_ClaUni='" + ClaUni + "' and F_FecCarg = CURDATE()");
                    con.cierraConexion();
                    //consql.cierraConexion();

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                out.println("<script>window.open('reimpFactura.jsp?fol_gnkl=" + FolioFactura + "','_blank')</script>");
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        request.getSession().setAttribute("folio", request.getParameter("folio"));
        request.getSession().setAttribute("fecha", request.getParameter("fecha"));
        request.getSession().setAttribute("folio_remi", request.getParameter("folio_remi"));
        request.getSession().setAttribute("orden", request.getParameter("orden"));
        request.getSession().setAttribute("provee", request.getParameter("provee"));
        request.getSession().setAttribute("recib", request.getParameter("recib"));
        request.getSession().setAttribute("entrega", request.getParameter("entrega"));
        request.getSession().setAttribute("clave", clave);
        request.getSession().setAttribute("descrip", descr);

        //String original = "hello world";
        //byte[] utf8Bytes = original.getBytes("UTF8");
        //String value = new String(utf8Bytes, "UTF-8"); 
        //out.println(value);
        if (ban1 == 0) {
            out.println("<script>alert('Clave Inexistente')</script>");
            out.println("<script>window.location='factura.jsp'</script>");
        } else {
            out.println("<script>window.location='factura.jsp'</script>");
        }
        //response.sendRedirect("captura.jsp");
    }

    public String dame7car(String clave) {
        try {
            int largoClave = clave.length();
            int espacios = 7 - largoClave;
            for (int i = 1; i <= espacios; i++) {
                clave = " " + clave;
            }
        } catch (Exception e) {
        }
        return clave;
    }

    public String dame5car(String clave) {
        try {
            int largoClave = clave.length();
            int espacios = 5 - largoClave;
            for (int i = 1; i <= espacios; i++) {
                clave = " " + clave;
            }
        } catch (Exception e) {
        }
        return clave;
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
