<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "", tipo = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <title>SIALSS</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>Módulo - Sistema de Administración de Almacenes (SAA)</h4>

            <%@include file="jspf/menuPrincipal.jspf" %>

            <div class="text-center">
                <br /><br /><br />
                <img src="imagenes/Logo GNK claro2.jpg" width="200" height="100" alt="Logo GNK claro2"/>
                <br/><br/><%
                    if (usua.equals("ingreso")) {
                %>
                <div class="panel panel-danger">
                    <div class="panel-heading">
                        Devoluciones pendientes.
                    </div>

                    <div class="panel-body">
                        <table class="table table-condensed table-bordered table-striped">
                            <tr>
                                <td>Remisión</td>
                                <td>Cliente</td>
                                <td>Fecha</td>
                                <td>Insumo</td>
                                <td>Cant</td>
                                <td>Monto</td>
                                <td>Observaciones</td>
                            </tr>
                            <%
                                try {
                                    con.conectar();
                                    ResultSet rset = con.consulta("select F_ClaDoc, F_ClaCli, DATE_FORMAT(F_FecApl, '%d/%m/%Y') as F_FecApl, F_ClaPro, F_CantSur, F_Monto, F_Obs from tb_factdevol where F_FactSts=0");
                                    while (rset.next()) {
                            %>
                            <tr>
                                <td><%=rset.getString("F_ClaDoc")%></td>
                                <td><%=rset.getString("F_ClaCli")%></td>
                                <td><%=rset.getString("F_FecApl")%></td>
                                <td><%=rset.getString("F_ClaPro")%></td>
                                <td><%=rset.getString("F_CantSur")%></td>
                                <td><%=rset.getString("F_Monto")%></td>
                                <td><%=rset.getString("F_Obs")%></td>
                            </tr>
                            <%
                                    }
                                    con.cierraConexion();
                                } catch (Exception e) {

                                }
                            %>
                        </table>
                    </div>
                </div>
                <%
                    }
                %>

            </div>
        </div>
        <%@include file="jspf/piePagina.jspf" %>
        <!-- 
        ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="js/jquery-1.9.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery-ui-1.10.3.custom.js"></script>
    </body>

</html>

