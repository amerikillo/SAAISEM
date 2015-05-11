<%-- 
    Document   : concentradoxRuta
    Created on : 27/03/2015, 09:19:56 AM
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
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    custom.setDecimalSeparator('.');
    custom.setGroupingSeparator(',');
    formatter.setDecimalFormatSymbols(custom);
    HttpSession sesion = request.getSession();
    String usua = "";
    String tipo = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("../index.jsp");
    }
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <!-- Estilos CSS -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link href="../css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <!---->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body class="container">
        <h1>SIALSS</h1>
        <%@include file="../jspf/menuPrincipal.jspf" %>

        <h4>Concentrados por Ruta</h4>
        <hr/>

        <table class="table table-condensed table-striped table-bordered" id="tbConcentrados">
            <thead>
                <tr>
                    <td>Fecha</td>
                    <td>Imprimir</td>
                    <td>Enviar Módula</td>
                </tr>
            </thead>
            <tbody>
                <%                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select F_FecEnt, DATE_FORMAT(F_FecEnt, '%d/%m/%Y') as F_Fecha from tb_factura group by F_Fecent, F_StsFact");
                        while (rset.next()) {
                %>
                <tr>
                    <td><h5>Concentrado del <%=rset.getString("F_Fecha")%></h5></td>
                    <td><a class="btn btn-block btn-success btn-sm" target="_blank" href="../reimpRutaConcentrado.jsp?F_FecSur=<%=rset.getString("F_FecEnt")%>"><span class="glyphicon glyphicon-print"></span></a></td>
                    <!--td><button class="btn btn-block btn-info btn-sm"><span class="glyphicon glyphicon-upload"></span></button></td-->
                    <td>
                        <form action="../FacturacionManual" method="post">
                            <input class="hidden" name="F_FecEnt" value="<%=rset.getString("F_FecEnt")%>">
                            <button class="btn btn-block btn-info btn-sm" name="accion" value="ReenviarConcentradoRuta" onclick="return confirm('Seguro de Reenviar este concentrado?')"><span class="glyphicon glyphicon-upload"></span></button>

                        </form>
                    </td>
                </tr>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        out.println(e.getMessage());
                    }
                %>
            </tbody>
        </table>

        <%@include file="../jspf/piePagina.jspf" %>
        <!-- 
================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->

        <script src="../js/jquery-1.9.1.js"></script>
        <script src="../js/bootstrap.js"></script>
        <script src="../js/jquery-ui-1.10.3.custom.js"></script>
        <script src="../js/jquery.dataTables.js"></script>
        <script src="../js/dataTables.bootstrap.js"></script>
        <script>
                                $(document).ready(function () {
                                    $('#tbConcentrados').dataTable();
                                });
        </script>
    </body>
</html>
