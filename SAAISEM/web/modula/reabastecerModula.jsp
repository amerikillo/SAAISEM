<%-- 
    Document   : reabastecerModula
    Created on : 26/03/2015, 12:54:16 PM
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="conn.ConectionDB_SQLServer"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="conn.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMdd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); %>
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
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>SIALSS</title>
    </head>
    <body class="container">
        <h1>SIALSS</h1>
        <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
        <hr/>
        <h4>Reabastecer Modula</h4>

        <button class="btn btn-block btn-primary">Reabastecer</button>
        <hr/>
        <table class="table table-bordered table-condensed table-striped" id="tablaMovMod">
            <thead>
                <tr>
                    <td>Clave</td>
                    <td>Descrip</td>
                    <td>Min</td>
                    <td>Max</td>
                    <td>Exist Modula</td>
                    <td>Reabastecer</td>
                </tr>
            </thead>
            <tdoby>
                <%
                    con.conectar();
                    conModula.conectar();
                    ResultSet rset = con.consulta("select med.F_ClaPro, F_DesPro, F_Max, F_Min from tb_medica med, tb_maxmodula modu where med.F_ClaPro = modu.F_ClaPro and F_StsPro='A' and F_Min!=0 and F_Max!=0 ");
                    while (rset.next()) {
                        int F_CantMax = 0, F_CantMin = 0;
                        int F_Cant = 0, F_Ingreso = 0, F_Salidas = 0, F_Total = 0;

                        F_CantMax = rset.getInt("F_Max");
                        F_CantMin = rset.getInt("F_Min");

                        ResultSet rset3 = conModula.consulta("select ART_EXISTENCIAS, ART_INGRESO, ART_SALIDAS from VIEW_MODULA_EXISTENCIA_MIN where ART_ARTICOLO = '" + rset.getString("F_ClaPro") + "'");
                        while (rset3.next()) {
                            F_Cant = rset3.getInt("ART_EXISTENCIAS");
                            F_Ingreso = rset3.getInt("ART_INGRESO");
                            F_Salidas = rset3.getInt("ART_SALIDAS");
                        }

                        F_Total = F_Cant + F_Ingreso - F_Salidas;
                        if (F_Total < F_CantMin) {
                %>
                <tr>
                    <td><%=rset.getString("F_ClaPro")%></td>
                    <td><%=rset.getString("F_DesPro")%></td>
                    <td><%=F_CantMin%></td>
                    <td><%=F_CantMax%></td>
                    <td><%=F_Total%></td>
                    <td><%=(F_CantMax - F_Total)%></td>
                </tr>
                <%
                        }
                    }
                    conModula.cierraConexion();
                    con.cierraConexion();
                %>
            </tdoby>
        </table>
        <!-- ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="../js/jquery-1.9.1.js"></script>
        <script src="../js/bootstrap.js"></script>
        <script src="../js/jquery-ui-1.10.3.custom.js"></script>
        <script src="../js/jquery.dataTables.js"></script>
        <script src="../js/dataTables.bootstrap.js"></script>
        <script>
            $(document).ready(function() {
                $('#tablaMovMod').dataTable();
            });
        </script>
    </body>
</html>
