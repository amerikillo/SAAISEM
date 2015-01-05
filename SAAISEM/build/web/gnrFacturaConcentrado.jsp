<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
    DecimalFormat formatter = new DecimalFormat("#,###,###");
    DecimalFormat formatterDecimal = new DecimalFormat("#,###,##0.00");
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    custom.setDecimalSeparator('.');
    custom.setGroupingSeparator(',');
    formatter.setDecimalFormatSymbols(custom);
    formatterDecimal.setDecimalFormatSymbols(custom);
    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
    } else {
        //response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();

    String fol_gnkl = "", fol_remi = "", orden_compra = "", fecha = "";
    try {
        if (request.getParameter("accion").equals("buscar")) {
            fol_gnkl = request.getParameter("fol_gnkl");
            fol_remi = request.getParameter("fol_remi");
            orden_compra = request.getParameter("orden_compra");
            fecha = request.getParameter("fecha");
        }
    } catch (Exception e) {

    }
    if (fol_gnkl == null) {
        fol_gnkl = "";
        fol_remi = "";
        orden_compra = "";
        fecha = "";
    }
    
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=\"RemisionGlobal.xls\"");
%>
<div>
    <h4>Global de Remisiones</h4>
    
    <br />
    <div class="panel panel-primary">
        <div class="panel-body">
            <table class="table table-bordered table-striped" id="datosCompras" border="1">
                <thead>
                    <tr>
                        <td>Cliente</td>
                        <td>FechaEnt</td>
                        <td>Remision</td>
                        <td>CLAVE</td>
                        <td>SAP</td>
                        <td>Descripción</td>
                        <td>Lote</td>
                        <td>Caducidad</td>
                        <td>Marca</td>
                        <td>FecFab</td>
                        <td>Req.</td>
                        <td>Ubicación</td>
                        <td>Ent.</td>
                        <td>Costo U</td>
                        <td>Importe</td>
                        <td>Status</td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            con.conectar();
                            try {
                                ResultSet rset = con.consulta("SELECT U.F_NomCli,DATE_FORMAT(F.F_FecEnt,'%d/%m/%Y') AS F_FecEnt,F.F_ClaDoc,F.F_ClaPro,M.F_DesPro,L.F_ClaLot,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS F_FecCad,F.F_CantReq,F.F_CantSur,F.F_Costo,F.F_Monto, F.F_Ubicacion, F_StsFact, Mar.F_DesMar, DATE_FORMAT(L.F_FecFab,'%d/%m/%Y') AS F_FecFab, M.F_ClaSap FROM tb_factura F INNER JOIN tb_medica M ON F.F_ClaPro=M.F_ClaPro INNER JOIN tb_lote L ON F.F_Lote=L.F_FolLot INNER JOIN tb_uniatn U ON F.F_ClaCli=U.F_ClaCli INNER JOIN tb_marca Mar ON L.F_ClaMar = Mar.F_ClaMar GROUP BY F.F_IdFact");
                                while (rset.next()) {
                    %>
                    <tr>
                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                        <td><%=rset.getString(4)%></td>
                        <td><%=rset.getString("F_ClaSap")%></td>
                        <td><%=rset.getString(5)%></td>
                        <td><%=rset.getString(6)%></td>
                        <td><%=rset.getString(7)%></td>
                        
                        <td><%=rset.getString("F_DesMar")%></td>
                        <td><%=rset.getString("F_FecFab")%></td>
                        
                        <td><%=rset.getString(8)%></td>
                        <td><%=rset.getString(12)%></td>
                        <td><%=rset.getString(9)%></td>
                        <td><%=rset.getString(10)%></td>
                        <td><%=rset.getString(11)%></td>
                        <td><%=rset.getString("F_StsFact")%></td>
                    </tr>
                    <%
                                }
                            } catch (Exception e) {

                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>