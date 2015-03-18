<%-- 
    Document   : insumoNuevoRedist
    Created on : 6/10/2014, 10:49:37 AM
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

    String ClaPro = "", UbiAnt = "", UbiCb = "";
    try {
        ClaPro = request.getParameter("ClaPro");
        UbiAnt = request.getParameter("UbiAnt");
        con.conectar();
        ResultSet rset = con.consulta("select l.F_Cb from tb_lote l, tb_ubica u where l.F_Ubica = u.F_ClaUbi and F_ClaPro= '" + ClaPro + "' and u.F_Cb='" + UbiAnt + "'");
        while (rset.next()) {
            ClaPro = rset.getString("F_Cb");
        }
        con.cierraConexion();
    } catch (Exception e) {
    }

    if (ClaPro == null) {
        ClaPro = "";
    }
    if (UbiAnt == null) {
        UbiAnt = "";
    }

    try {
        con.conectar();
        ResultSet rset = con.consulta("select F_Cb from tb_ubica where F_ClaUbi='" + UbiAnt + "'");
        while (rset.next()) {
            UbiCb = rset.getString("F_Cb");
        }
        if (!UbiCb.equals("")) {
            UbiAnt = UbiCb;
        }
        con.cierraConexion();
    } catch (Exception e) {

    }
%>
<html>
    <head>
        <!-- Estilos CSS -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link href="../css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            
            <%@include file="../jspf/menuPrincipal.jspf" %>

            <h4>Redistribución</h4>
            <form action="leerInsRedist.jsp" method="post">
                <a class="btn btn-default" href="insumoNuevoRedist.jsp">Regresar</a>
                <button class="btn btn-success" type="submit" name="UbiAnt" value="PorUbicar">Por Ubicar</button>
            </form>
            <%
                try {
                    con.conectar();
                    ResultSet rset = con.consulta("select F_DesUbi from tb_ubica where F_Cb= '" + UbiAnt + "' ");
                    while (rset.next()) {
            %>
            <h4>Ubicacion: <%=rset.getString(1)%></h4>
            <%
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            %>
            <form action="leerInsRedist.jsp" method="post">
                <div class="row">
                    <h5 class="col-lg-12">CB del Insumo a Mover</h5>
                    <div class="col-lg-12">
                        <input class="hidden" name="UbiAnt" value="<%=UbiAnt%>" />
                        <input class="form-control" name="ClaPro" value="<%=ClaPro%>" autofocus="" />
                    </div>
                </div>
                <br/>
                <div class="row">
                    <div class="col-lg-12">
                        <button class="btn btn-block btn-primary btn-lg">Leer Insumo</button>
                    </div>
                </div>
            </form>
            <hr/>
            <h4>Insumos Médicos</h4>
            <%
                try {
                    if (!UbiAnt.equals("PorUbicar")) {
                        ResultSet rset = null;
                        con.conectar();
                        if (!ClaPro.equals("")) {
                            System.out.println("1");
                            rset = con.consulta("select u.F_DesUbi, l.F_ClaPro, l.F_ExiLot, m.F_DesPro, l.F_ClaLot, DATE_FORMAT(l.F_FecCad, '%d/%m/%Y') as F_FecCad, l.F_IdLote, l.F_Origen from tb_lote l, tb_medica m, tb_ubica u where l.F_ClaPro = m.F_ClaPro AND l.F_Ubica = u.F_ClaUbi and l.F_ExiLot!=0 and u.F_Cb = '" + UbiAnt + "' and l.F_Cb = '" + ClaPro + "' ");
                        } else if (!UbiAnt.equals("1")) {
                            System.out.println("2");
                            rset = con.consulta("select u.F_DesUbi, l.F_ClaPro, l.F_ExiLot, m.F_DesPro, l.F_ClaLot, DATE_FORMAT(l.F_FecCad, '%d/%m/%Y') as F_FecCad, l.F_IdLote, l.F_Origen from tb_lote l, tb_medica m, tb_ubica u where l.F_ClaPro = m.F_ClaPro AND l.F_Ubica = u.F_ClaUbi and l.F_ExiLot!=0 and u.F_Cb = '" + UbiAnt + "' ");
                        }
                        while (rset.next()) {
            %>
            <h5>
                Ubicación: <%=rset.getString("F_DesUbi")%>
                <br/>
                Clave: <%=rset.getString("F_ClaPro")%>
                <br/>
                Cantidad: <%=formatter.format(rset.getInt("F_ExiLot"))%>
                <br/>
                Descripción: <%=rset.getString("F_DesPro")%>
                <br/>
                Origen: <%=rset.getString("F_Origen")%>
                <br/>
                Lote: <%=rset.getString("F_ClaLot")%>
                <br/>
                Caducidad: <%=rset.getString("F_FecCad")%>
                <br/>
            </h5>
            <form action="ingCantRedist.jsp" method="post">
                <input class="hidden" name="UbiAnt" value="<%=UbiAnt%>" />
                <input class="hidden" name="ClaPro" value="<%=ClaPro%>" />
                <input value="<%=rset.getString("F_IdLote")%>" class="hidden" name="idLote" />
                <button class="btn btn-block btn-success" type="submit">Seleccionar</button>
            </form>
            <hr/>
            <%
                }
            } else {

                System.out.println("3");
                con.conectar();
                ResultSet rset = con.consulta("select u.F_DesUbi, l.F_ClaPro, l.F_ExiLot, m.F_DesPro, l.F_ClaLot, DATE_FORMAT(l.F_FecCad, '%d/%m/%Y') as F_FecCad, l.F_IdLote, l.F_Origen from tb_lote l, tb_medica m, tb_ubica u where l.F_ClaPro = m.F_ClaPro AND l.F_Ubica = u.F_ClaUbi and l.F_ExiLot!=0 and u.F_Cb = '3103'  ");
                while (rset.next()) {
            %>
            <h5>
                Ubicación: <%=rset.getString("F_DesUbi")%>
                <br/>
                Clave: <%=rset.getString("F_ClaPro")%>
                <br/>
                Cantidad: <%=formatter.format(rset.getInt("F_ExiLot"))%>
                <br/>
                Descripción: <%=rset.getString("F_DesPro")%>
                <br/>
                Origen: <%=rset.getString("F_Origen")%>
                <br/>
                Lote: <%=rset.getString("F_ClaLot")%>
                <br/>
                Caducidad: <%=rset.getString("F_FecCad")%>
                <br/>
            </h5>
            <form action="ingCantRedist.jsp" method="post">
                <input class="hidden" name="UbiAnt" value="<%=UbiAnt%>" />
                <input class="hidden" name="ClaPro" value="<%=ClaPro%>" />
                <input value="<%=rset.getString("F_IdLote")%>" class="hidden" name="idLote" />
                <button class="btn btn-block btn-success" type="submit">Seleccionar</button>
            </form>
            <hr/>
            <%

                        }
                        con.cierraConexion();
                    }
                } catch (Exception e) {

                }
            %>
        </div>

        <%@include file="../jspf/piePagina.jspf" %>
    </body>
    <!-- 
================================================== -->
    <!-- Se coloca al final del documento para que cargue mas rapido -->
    <!-- Se debe de seguir ese orden al momento de llamar los JS -->

    <script src="../js/jquery-1.9.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jquery-ui-1.10.3.custom.js"></script>
    <script src="../js/bootstrap-datepicker.js"></script>
</html>
