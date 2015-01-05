<%-- 
    Document   : descargaInventario
    Created on : 28/11/2014, 08:45:23 AM
    Author     : Americo
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="conn.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%
    ConectionDB con = new ConectionDB();
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment;filename=\"Existencias_"+df2.format(new Date())+"_.xls\"");
%>
<!DOCTYPE html>
<table border="1">
    <tr>
        <td>CLAVE</td>
        <td>SAP</td>
        <td>Lote</td>
        <td>Caducidad</td>
        <td>Fec Fab</td>
        <td>Marca</td>
        <td>Proveedor</td>
        <td>Existencia</td>
        <td>Ubicacion</td>
        <td>CB</td>
    </tr>
    <%
        try {
            con.conectar();
            ResultSet rset = con.consulta("select * from v_existencias where F_ExiLot!=0");
            while (rset.next()) {
    %>
    <tr>
        <td><%=rset.getString("F_ClaPro")%></td>
        <td><%=rset.getString("F_ClaSap")%></td>
        <td><%=rset.getString("F_ClaLot")%></td>
        <td><%=rset.getString("F_FecCad")%></td>
        <td><%=rset.getString("F_FecFab")%></td>
        <td><%=rset.getString("F_DesMar")%></td>
        <td><%=rset.getString("F_NomPro")%></td>
        <td><%=rset.getString("F_ExiLot")%></td>
        <td><%=rset.getString("F_DesUbi")%></td>
        <td><%=rset.getString("F_Cb")%></td>
    </tr>
    <%
            }
            con.cierraConexion();
        } catch (Exception e) {

        }
    %>
</table>