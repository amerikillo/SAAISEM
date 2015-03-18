<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%java.text.DateFormat df1 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
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
    String tipo = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
    ConectionDB_Nube conNube = new ConectionDB_Nube();
    try {
        if (request.getParameter("accion").equals("Buscar")) {
            sesion.setAttribute("posClave", "0");
            sesion.setAttribute("folioRemi", "");
            sesion.setAttribute("CodBar", "");
        }
    } catch (Exception er) {

    }

    int totalClaves = 0, clavesCapturadas = 0;
    String fecha = "", noCompra = "", Proveedor = "", Fecha = "";
    String nomProvee = "";
    try {
        fecha = request.getParameter("Fecha");
    } catch (Exception e) {
    }
    try {
        noCompra = request.getParameter("NoCompra");
        //System.out.println(noCompra);
    } catch (Exception e) {
    }
    try {
        Proveedor = request.getParameter("Proveedor");
    } catch (Exception e) {
    }
    if (fecha == null) {
        fecha = "";
    }
    if (noCompra == null) {
        try {
            noCompra = (String) sesion.getAttribute("NoCompra");
        } catch (Exception e) {
        }
        if (noCompra == null) {
            noCompra = "";
        }
    }
    System.out.println(noCompra);
    if (Proveedor == null) {
        Proveedor = "";
    }

    String posClave = "0";
    try {
        posClave = sesion.getAttribute("posClave").toString();
    } catch (Exception e) {

    }
    if (posClave == null || posClave.equals("")) {
        posClave = "0";
    }

    try {
        if (request.getParameter("accion").equals("buscaCompra")) {
            posClave = "0";
        }
    } catch (Exception e) {

    }

    int numRenglones = 0;

    String folioRemi = "";

    if (folioRemi.equals("")) {
        try {
            folioRemi = (String) sesion.getAttribute("folioRemi");
        } catch (Exception e) {
        }
    }

    if (folioRemi == null) {
        folioRemi = "";
    }
    try {
        Fecha = request.getParameter("Fecha");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    if (Fecha == null) {
        Fecha = "";
    }

    String CodBar = "", Lote = "", Cadu = "";
    try {
        CodBar = (String) sesion.getAttribute("CodBar");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    if (CodBar == null) {
        CodBar = "";
    }

    System.out.println(CodBar);
    try {
        Lote = (String) sesion.getAttribute("Lote");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    if (Lote == null) {
        Lote = "";
    }
    try {
        Cadu = (String) sesion.getAttribute("Cadu");
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
    if (Cadu == null) {
        Cadu = "";
    }


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <!---->
        <title>SIALSS</title>

        <script>
        </script>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>Módulo - Sistema de Administración de Almacenes (SAA)</h4>

            <%@include file="jspf/menuPrincipal.jspf" %>
            <form action="compraAuto2.jsp" method="post">
                <div class="row">
                    <label class="col-sm-2 text-right">
                        <h4>Proveedor</h4>
                    </label>
                    <div class="col-sm-5">
                        <select class="form-control" name="Proveedor" id="Proveedor" onchange="SelectProve(this.form);
                                document.getElementById('Fecha').focus()">
                            <option value="">--Proveedor--</option>
                            <%                                try {
                                    con.conectar();
                                    ResultSet rset = con.consulta("select F_ClaProve, F_NomPro from tb_proveedor order by F_NomPro");
                                    while (rset.next()) {
                            %>
                            <option value="<%=rset.getString(1)%>" ><%=rset.getString(2)%></option>
                            <%
                                    }
                                    con.cierraConexion();
                                } catch (Exception e) {
                                }
                            %>

                        </select>
                    </div>
                    <label class="col-sm-2 text-right">
                        <h4>Fecha</h4>
                    </label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control" data-date-format="dd/mm/yyyy" id="Fecha" name="Fecha" value="<%=Fecha%>" onkeypress="return tabular(event, this)" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <button class="btn btn-primary btn-block" name="accion" value="Buscar">Buscar</button>
                    </div>
                </div>
                <br/>
                <div class="row">
                    <label class="col-sm-2">
                        <h4>&Oacute;rdenes de Compra: </h4>
                    </label>
                    <div class="col-sm-9">
                        <select class="form-control" name="NoCompra" onchange="this.form.submit();">
                            <option value="">-- Proveedor -- Orden de Compra --</option>
                            <%
                                String fecha1 = "";
                                try {
                                    fecha = df1.format(df3.parse(Fecha));
                                } catch (Exception e) {

                                }
                                try {
                                    con.conectar();
                                    ResultSet rset = con.consulta("select o.F_NoCompra, p.F_NomPro, F_StsPed from tb_pedidoisem o, tb_proveedor p where o.F_Provee = p.F_ClaProve and o.F_FecSur like  '%" + fecha + "%'  and o.F_Provee like '%" + request.getParameter("Proveedor") + "'  and F_StsPed !='2' and F_Recibido=0  group by o.F_NoCompra");
                                    while (rset.next()) {
                                        String banConfirmada = "";
                                        if (rset.getString("F_StsPed").equals("0")) {
                                            banConfirmada = " | Sin Confirmar";
                                        }
                            %>
                            <option value="<%=rset.getString(1)%>"><%=rset.getString(2)%> - <%=rset.getString(1)%> <%=banConfirmada%></option>
                            <%
                                    }
                                    con.cierraConexion();
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            %>
                        </select>
                    </div>
                </div>
                <br/>
            </form>
            <form action="CompraAutomatica" method="get" name="formulario1" id="FormInsumo">
                <br/>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select i.F_NoCompra, i.F_FecSur, i.F_HorSur, p.F_NomPro, p.F_ClaProve from tb_pedidoisem i, tb_proveedor p where i.F_Provee = p.F_ClaProve and F_StsPed = '1' and F_NoCompra = '" + noCompra + "' and F_recibido='0' group by F_NoCompra");
                        while (rset.next()) {
                            nomProvee = rset.getString("p.F_NomPro");
                %>
                <div class="row">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <h4 class="col-sm-3">Folio Orden de Compra:</h4>
                                <div class="col-sm-2"><input class="form-control" value="<%=rset.getString(1)%>" readonly="" name="folio" id="folio" onkeypress="return tabular(event, this)" /></div>
                                <h4 class="col-sm-2 text-right">Remisión:</h4>
                                <div class="col-sm-2"><input class="form-control" value="<%=folioRemi%>" name="folioRemi" id="folioRemi" onkeypress="return tabular(event, this)" /></div>
                                <div class="col-sm-2">
                                    <%
                                        if (tipo.equals("2") || tipo.equals("3") || tipo.equals("5")) {
                                    %>
                                    <a class="btn btn-default" href="verificarCompraAuto.jsp">Verificar Remisión</a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="row">
                                <h4 class="col-sm-12">Proveedor: <%=rset.getString(4)%></h4>
                            </div>
                            <div class="row">
                                <h4 class="col-sm-12">Fecha y Hora de Entrega: <%=df3.format(df2.parse(rset.getString(2)))%> <%=rset.getString(3)%></h4>
                            </div>
                            <div class="row">
                                <h4 class="col-sm-1">CLAVE</h4>
                                <div class="col-sm-2">
                                    <input  class="form-control" name="selectClave" id="selectClave"/>
                                    <!--select class="form-control" name="selectClave" id="selectClave">
                                        <option>-Seleccione-</option>
                                    <%
                                        try {
                                            con.conectar();
                                            ResultSet rset2 = con.consulta("select F_Clave from tb_pedidoisem where F_NoCompra = '" + noCompra + "' and F_Recibido = '0' ");
                                            while (rset2.next()) {
                                                out.print("<option>" + rset2.getString(1) + "</option>");
                                                totalClaves++;
                                            }
                                            con.cierraConexion();
                                        } catch (Exception e) {

                                        }
                                    %>
                                </select-->
                                </div>
                                <div class="col-sm-1">
                                    <button class="btn btn-primary btn-block" name="accion" value="seleccionaClave">CLAVE</button>
                                </div>
                                <div class="col-sm-6">
                                    <%
                                        try {
                                            con.conectar();
                                            ResultSet rset5 = con.consulta("SELECT C.F_Cb,C.F_ClaPro,M.F_DesPro,C.F_Lote,C.F_FecCad,C.F_Pz,F_IdCom, C.F_Costo, C.F_ImpTo, C.F_ComTot, C.F_FolRemi FROM tb_compratemp C INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro WHERE F_OrdCom='" + noCompra + "'");
                                            while (rset5.next()) {
                                                clavesCapturadas++;
                                            }
                                            con.cierraConexion();
                                        } catch (Exception e) {

                                        }
                                    %>

                                    <h4>Insumos Ingresados <%=clavesCapturadas%>/<%=totalClaves%></h4>
                                </div>
                                <div class="col-sm-2">
                                    <a href="#" class="btn btn-danger btn-block" data-toggle="modal" data-target="#Rechazar">Rechazar</a>
                                </div>

                            </div>
                        </div>
                        <div class="panel-body">
                            <%
                                try {
                                    System.out.println("*****" + (String) sesion.getAttribute("claveSeleccionada"));
                                    con.conectar();
                                    ResultSet rset2 = con.consulta("select s.F_Clave, m.F_DesPro, s.F_Lote, DATE_FORMAT(F_Cadu, '%d/%m/%Y'), s.F_Cant, F_IdIsem, F_Obser from tb_pedidoisem s, tb_medica m where s.F_Clave = m.F_ClaPro and F_NoCompra = '" + rset.getString(1) + "' and F_StsPed = '1'");
                                    while (rset2.next()) {
                                        rset2.last();
                                        numRenglones = rset2.getRow() - 1;
                                    }
                                    rset2 = con.consulta("select s.F_Clave, m.F_DesPro, s.F_Lote, DATE_FORMAT(F_Cadu, '%d/%m/%Y'), s.F_Cant, F_IdIsem, F_Obser from tb_pedidoisem s, tb_medica m where s.F_Clave = m.F_ClaPro and F_NoCompra = '" + rset.getString(1) + "' and F_Clave = '" + sesion.getAttribute("claveSeleccionada") + "' ");
                                    while (rset2.next()) {

                            %>
                            <h4 class="bg-primary" style="padding: 5px">CLAVE | <%=rset2.getString(1)%> <%=rset2.getString(2)%></h4>
                            <div class="">
                                <table class="table table-bordered table-condensed table-striped">
                                    <tr>
                                        <td><strong>CLAVE</strong></td>
                                        <td><strong>Descripción</strong></td>
                                        <td><strong>Cod Bar</strong></td>
                                        <td><strong>Lote</strong></td>
                                        <td><strong>Caducidad</strong></td>
                                        <td>
                                            <strong>Cantidad a Recibir</strong>
                                            <input type="text" value="<%=formatter.format(rset2.getInt(5))%>" class="form-control" name="cantRecibir" id="cantRecibir" onclick="" readonly=""  onkeypress="return tabular(event, this)"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type="text" value="<%=rset2.getString(1)%>" class="form-control" name="ClaPro" id="ClaPro" onclick="" readonly=""  onkeypress="return tabular(event, this)"/>
                                        </td>
                                        <td><%=rset2.getString(2)%></td>
                                        <td>
                                            <input type="text" value="<%=CodBar%>" class="form-control" name="codbar" id="codbar" onclick="" onkeypress="return checkKey(event, this);" />
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <button class="btn btn-primary btn-block btn-sm" type="submit" name="accion" id="CodigoBarras" value="CodigoBarras" onclick="">CB</button>
                                                </div>
                                                <div class="col-sm-6">
                                                    <button class="btn btn-primary btn-block btn-sm" type="submit" name="accion" id="GeneraCodigo" value="GeneraCodigo" onclick=""><span class="glyphicon glyphicon-barcode"></span></button>
                                                </div>
                                            </div>

                                        </td>
                                        <%
                                            int contadorLotes = 0;
                                            String idMarca = "";
                                            if (!CodBar.equals("")) {
                                                try {
                                                    con.conectar();
                                                    ResultSet rset3 = con.consulta("select F_Cb, F_ClaPro, F_ClaLot, F_FecCad, F_FecFab, F_ClaMar from tb_cb where F_Cb='" + CodBar + "' group by F_ClaPro, F_ClaLot, F_FecCad");
                                                    while (rset3.next()) {
                                                        contadorLotes++;
                                                    }
                                                    con.cierraConexion();
                                                } catch (Exception e) {

                                                }
                                            }
                                            if (contadorLotes > 1) {
                                                //Mas de 1 lote
                                        %>
                                        <td>
                                            <input type="text" value="<%=Lote%>" class="form-control" name="lot" id="lot" onkeypress="return tabular(event, this)"/>
                                            <select class="form-control" name="list_lote" id="list_lote"  onchange="cambiaLoteCadu(this);" onkeypress="return tabular(event, this)">
                                                <option>--Lote--</option>
                                                <%
                                                    if (!CodBar.equals("")) {
                                                        try {
                                                            con.conectar();
                                                            ResultSet rset3 = con.consulta("select F_Cb, F_ClaPro, F_ClaLot, F_FecCad, F_FecFab, F_ClaMar from tb_cb where F_Cb='" + CodBar + "' group by F_ClaLot, F_FecCad");
                                                            while (rset3.next()) {
                                                                idMarca = rset3.getString(6);
                                                %>
                                                <option><%=rset3.getString(3)%></option>
                                                <%
                                                            }
                                                            con.cierraConexion();
                                                        } catch (Exception e) {

                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="text" value="<%=Cadu%>" data-date-format="dd/mm/yyyy" class="form-control" name="cad" id="cad" onclick="" onKeyPress="
                                                    return LP_data(event, this);
                                                    anade(this, event);
                                                    return tabular(event, this);
                                                   " maxlength="10" onblur="validaCadu();"/>
                                            <select class="form-control" name="list_cadu" id="list_cadu">
                                                <option>--Caducidad--</option>
                                                <%
                                                    if (!CodBar.equals("")) {
                                                        try {
                                                            con.conectar();
                                                            ResultSet rset3 = con.consulta("select F_Cb, F_ClaPro, F_ClaLot, DATE_FORMAT(F_FecCad,'%d/%m/%Y'), F_FecFab, F_ClaMar from tb_cb where F_Cb='" + CodBar + "' group by F_ClaLot, F_FecCad");
                                                            while (rset3.next()) {
                                                %>
                                                <option><%=rset3.getString(4)%></option>
                                                <%
                                                            }
                                                            con.cierraConexion();
                                                        } catch (Exception e) {

                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <%
                                        } else {
                                            //1 Lote o menos
                                        %>
                                        <td><%
                                            if (!CodBar.equals("")) {
                                                try {
                                                    con.conectar();
                                                    ResultSet rset3 = con.consulta("select F_Cb, F_ClaPro, F_ClaLot, F_FecCad, F_FecFab, F_ClaMar from tb_cb where F_Cb='" + CodBar + "' group by F_ClaLot, F_FecCad");
                                                    while (rset3.next()) {
                                                        idMarca = rset3.getString(6);
                                                        Lote = rset3.getString(3);
                                                    }
                                                    con.cierraConexion();
                                                } catch (Exception e) {

                                                }
                                            }
                                            %>
                                            <input type="text" value="<%=Lote%>" class="form-control" name="lot" id="lot" onkeypress="return tabular(event, this)"/>
                                        </td>
                                        <td>
                                            <%
                                                if (!CodBar.equals("")) {
                                                    try {
                                                        con.conectar();
                                                        ResultSet rset3 = con.consulta("select F_Cb, F_ClaPro, F_ClaLot, DATE_FORMAT(F_FecCad,'%d/%m/%Y'), F_FecFab, F_ClaMar from tb_cb where F_Cb='" + CodBar + "' group by F_ClaLot, F_FecCad");
                                                        while (rset3.next()) {
                                                            Cadu = rset3.getString(4);
                                                        }
                                                        con.cierraConexion();
                                                    } catch (Exception e) {

                                                    }
                                                }
                                            %>
                                            <input type="text" value="<%=Cadu%>" data-date-format="dd/mm/yyyy" class="form-control" name="cad" id="cad" onclick="" onKeyPress="
                                                    return LP_data(event, this);
                                                    anade(this, event);
                                                    return tabular(event, this);
                                                   " maxlength="10" onblur="validaCadu();"/>
                                        </td>
                                        <%
                                            }
                                        %>

                                        <td>
                                            <strong>Cantidad Recibida</strong>
                                            <%
                                                int cantRecibida = 0;
                                                try {
                                                    con.conectar();
                                                    ResultSet rset3 = con.consulta("select sum(F_CanCom) from tb_compra where F_OrdCom = '" + rset.getString(1) + "' and F_ClaPro = '" + rset2.getString(1) + "'  ");
                                                    while (rset3.next()) {
                                                        cantRecibida = cantRecibida + rset3.getInt(1);
                                                    }
                                                    rset3 = con.consulta("select sum(F_Pz) from tb_compratemp where F_OrdCom = '" + rset.getString(1) + "' and F_ClaPro = '" + rset2.getString(1) + "'  ");
                                                    while (rset3.next()) {
                                                        cantRecibida = cantRecibida + rset3.getInt(1);
                                                    }
                                                    con.cierraConexion();
                                                } catch (Exception e) {

                                                }
                                            %>
                                            <input type="text" value="<%=formatter.format(cantRecibida)%>" class="form-control" name="cantRecibida" id="cantRecibida" onkeypress="return tabular(event, this)" onclick="" readonly=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <strong>Marca</strong>
                                                    <select class="form-control" name="list_marca" onKeyPress="return tabular(event, this)" id="list_marca">
                                                        <option value="">Marca</option>
                                                        <%
                                                            try {
                                                                con.conectar();
                                                                ResultSet rset3 = con.consulta("SELECT F_ClaMar,F_DesMar FROM v_marcaprovee where F_NomPro = '" + nomProvee + "'");
                                                                while (rset3.next()) {
                                                        %>
                                                        <option value="<%=rset3.getString("F_ClaMar")%>"
                                                                <%
                                                                    if (rset3.getString("F_ClaMar").equals(idMarca)) {
                                                                        out.println("selected");
                                                                    }
                                                                %>
                                                                ><%=rset3.getString("F_DesMar")%></option>
                                                        <%

                                                                }
                                                                con.cierraConexion();
                                                            } catch (Exception e) {
                                                            }
                                                        %>
                                                        <option disabled="">---------------</option>

                                                        <%
                                                            try {
                                                                con.conectar();
                                                                ResultSet rset3 = con.consulta("SELECT F_ClaMar,F_DesMar FROM tb_marca");
                                                                while (rset3.next()) {
                                                        %>
                                                        <option value="<%=rset3.getString("F_ClaMar")%>"
                                                                <%
                                                                    if (rset3.getString("F_ClaMar").equals(idMarca)) {
                                                                        out.println("selected");
                                                                    }
                                                                %>
                                                                ><%=rset3.getString("F_DesMar")%></option>
                                                        <%

                                                                }
                                                                con.cierraConexion();
                                                            } catch (Exception e) {
                                                            }
                                                        %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <button class="btn btn-block btn-primary glyphicon glyphicon-refresh" type = "submit" value = "refresh" name = "accion" ></button>
                                            </div>
                                            <div class="col-sm-6">
                                                <a href="marcas.jsp" target="_blank"><h4>Alta</h4></a>
                                            </div>
                                            <input value="<%=rset.getString("p.F_ClaProve")%>" name="claPro" id="claPro" class="hidden" onkeypress="return tabular(event, this)" />
                                        </td>
                                        <td>
                                            Origen:
                                            <select class="form-control" name="F_Origen" id="F_Origen">
                                                <%
                                                    try {
                                                        con.conectar();
                                                        ResultSet rset3 = con.consulta("select F_ClaOri, F_DesOri from tb_origen");
                                                        while (rset3.next()) {
                                                            ResultSet rset4 = con.consulta("select F_Origen from tb_medica where F_ClaPro = '" + rset2.getString(1) + "' ");
                                                %>
                                                <option value="<%=rset3.getString("F_ClaOri")%>"
                                                        <%
                                                            while (rset4.next()) {
                                                                if (rset3.getString("F_ClaOri").equals(rset4.getString("F_Origen"))) {
                                                                    out.println("selected");
                                                                }
                                                            }
                                                        %>
                                                        ><%=rset3.getString("F_DesOri")%></option>
                                                <%
                                                        }
                                                        con.cierraConexion();
                                                    } catch (Exception e) {
                                                        System.out.println(e.getMessage());
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td colspan="4">
                                            <strong>Observaciones</strong>
                                            <textarea class="form-control" readonly><%=rset2.getString(7)%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <h5><strong>Tarimas Completas</strong></h5>
                                            <div class="row">

                                                <label for="Cajas" class="col-sm-2 control-label">Tarimas</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="TarimasC" name="TarimasC" placeholder="0" onKeyPress="return justNumbers(event);
                                                            return handleEnter(even);" onkeyup="totalPiezas()" onclick="" />
                                                </div>
                                                <label for="pzsxcaja" class="col-sm-2 control-label">Cajas x Tarima</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="CajasxTC" name="CajasxTC" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas()" onclick="" />
                                                </div>
                                                <label for="Resto" class="col-sm-2 control-label">Piezas x Caja</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="PzsxCC" name="PzsxCC" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas()" onclick="" />
                                                </div>
                                            </div>
                                            <br/>
                                            <h5><strong>Tarimas Incompletas</strong></h5>
                                            <div class="row">

                                                <label for="Cajas" class="hidden">Tarimas</label>
                                                <div class="hidden">
                                                    <input type="text" class="form-control" id="TarimasI" name="TarimasI" placeholder="0" onKeyPress="return justNumbers(event);
                                                            return handleEnter(even);" onkeyup="totalPiezas();" onclick="" />
                                                </div>
                                                <label for="pzsxcaja" class="col-sm-2 control-label">Cajas x Tarima</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="CajasxTI" name="CajasxTI" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                                </div>
                                                <label for="pzsxcaja" class="col-sm-2 control-label">Resto</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="Resto" name="Resto" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <h5><strong>Totales</strong></h5>
                                            <div class="row">

                                                <label for="Cajas" class="col-sm-1 control-label">Tarimas</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="Tarimas" name="Tarimas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);
                                                            return handleEnter(even);" onkeyup="totalPiezas();" onclick="" />
                                                </div>
                                                <label for="pzsxcaja" class="col-sm-1 control-label">Cajas Completas</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="Cajas" name="Cajas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                                </div>
                                                <label for="CajasIn" class="col-sm-1 control-label">Cajas Incompletas</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="CajasIn" name="CajasIn" placeholder="0" readonly="" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                                </div>
                                                <label for="TCajas" class="col-sm-1 control-label">Total Cajas</label>
                                                <div class="col-sm-1">
                                                    <input type="text" class="form-control" id="TCajas" name="TCajas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                                </div>
                                                <label for="Resto" class="col-sm-1 control-label">Piezas</label>
                                                <div class="col-sm-2">
                                                    <input type="text" class="form-control" id="Piezas" name="Piezas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick="" />
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="6">
                                            <textarea class="form-control" id="Obser" name="Obser"></textarea>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <%if (!posClave.equals("0")) {%>
                                    <!--button class="btn btn-block btn-danger" name="accion" id="accion" value="anterior" >Clave Anterior</button-->
                                    <%}%>
                                </div>
                                <%
                                    if (tipo.equals("2") || tipo.equals("3") || tipo.equals("1")) {
                                %>
                                <div class="col-sm-4">
                                    <div id="imgCarga" style="display: none">
                                        <img src="imagenes/ajax-loader-1.gif" />
                                    </div>
                                    <button class="btn btn-block btn-primary" name="accion" id="accion" value="guardarLote" onclick="return validaCompra();" >Guardar Lote</button>
                                </div>
                                <%
                                    }
                                %>
                                <div class="col-sm-4">
                                    <%if (!posClave.equals(numRenglones + "")) {%>
                                    <!--button class="btn btn-block btn-danger" name="accion" id="accion" value="siguiente" >Siguiente Clave</button-->
                                    <%}%>

                                </div>
                            </div>


                            <hr/>
                            <%
                                    }
                                    con.cierraConexion();
                                } catch (Exception e) {
                                    out.println(e.getMessage());
                                }
                            %>
                        </div>
                        <!--div class="panel-footer">
                            <button class="btn btn-block btn-success btn-lg" name="accion" id="accion" value="confirmar" onclick="return validaCompra();">Confirmar Compra</button>
                        </div-->
                    </div>

                </div>
                <%
                        }
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
            </form>
            <div class="table-responsive">
                <table class="table table-bordered table-striped" style="width: 100%">
                    <tr>
                        <td>Remisión</td>
                        <td><a name="ancla"></a>Código de Barras</td>
                        <td>CLAVE</td>
                        <td>Descripción</td>
                        <td>Ori</td>
                        <td>Lote</td>
                        <td>Caducidad</td>                        
                        <td>Cantidad</td>                      
                        <td>Costo U</td>                     
                        <td>IVA</td>                       
                        <td>Importe</td>
                        <td></td>
                    </tr>
                    <%
                        int banCompra = 0;
                        String obser = "";
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("SELECT C.F_Cb,C.F_ClaPro,M.F_DesPro,C.F_Lote,C.F_FecCad,C.F_Pz,F_IdCom, C.F_Costo, C.F_ImpTo, C.F_ComTot, C.F_FolRemi, C.F_Origen FROM tb_compratemp C INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro WHERE F_OrdCom='" + noCompra + "' and F_Estado = '1'");
                            while (rset.next()) {
                                banCompra = 1;
                    %>
                    <tr>
                        <td><%=rset.getString("C.F_FolRemi")%></td>
                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                        <td><%=rset.getString("F_Origen")%></td>
                        <td><%=rset.getString(4)%></td>
                        <td><%=df3.format(df2.parse(rset.getString(5)))%></td>
                        <td class="text-right"><%=formatter.format(rset.getDouble(6))%></td>           
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_Costo"))%></td>
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_ImpTo"))%></td>          
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_ComTot"))%></td>              
                        <td>

                            <form method="get" action="Modificaciones">
                                <input name="id" type="text" style="" class="hidden" value="<%=rset.getString(7)%>" />
                                <button class="btn btn-warning" name="accion" value="modificarCompraAuto"><span class="glyphicon glyphicon-pencil" ></span></button>
                                <button class="btn btn-danger" onclick="return confirm('¿Seguro de que desea eliminar?');" name="accion" value="eliminarCompraAuto"><span class="glyphicon glyphicon-remove"></span>
                                </button>
                                <!--button class="btn btn-success" onclick="return confirm('¿Seguro de Verificar?');" name="accion" value="verificarCompraAuto"><span class="glyphicon glyphicon-ok"></span>
                                </button-->
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                        if (banCompra == 1) {
                    %>
                    <tr>

                        <td colspan="12">
                            <div class="col-lg-3 col-lg-offset-6">
                                <form action="nuevoAutomaticaLotes" method="post" id="TablaScroll">
                                    <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=noCompra%>" />
                                    <button  value="Eliminar" name="accion" class="btn btn-danger btn-block" onclick="return confirm('¿Seguro que desea eliminar la compra?');">Cancelar Compra</button>
                                </form>
                            </div>
                            <div class="col-lg-3">
                                <form action="Modificaciones" method="post">
                                    <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=noCompra%>" />
                                    <button  value="verificarCompraAuto" name="accion" class="btn btn-success btn-block" onclick="return confirm('¿Seguro que desea verificar la compra?');">Ingresar OC</button>
                                </form>
                            </div>
                            <%
                                if (tipo.equals("2") || tipo.equals("3") || tipo.equals("5")) {
                            %>
                            <!--div class="col-lg-3">
                                <form action="nuevoAutomaticaLotes" method="post">
                                    <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=noCompra%>" />
                                    <button  value="GuardarAbierta" name="accion" class="btn btn-warning  btn-block" onclick="return confirm('Seguro que desea realizar la compra?');
                                            return validaCompra();">Compra Abierta</button>
                                </form>
                            </div>
                            <div class="col-lg-3">
                                <form action="nuevoAutomaticaLotes" method="post">
                                    <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=noCompra%>" />
                                    <button  value="Guardar" name="accion" class="btn btn-success  btn-block" onclick="return confirm('Seguro que desea realizar la compra?');
                                            return validaCompra();">Confirmar Compra</button>
                                </form>
                            </div-->
                            <%
                                }
                            %>

                            <!--div class="col-lg-3">
                                <form action="reimpReporte.jsp" target="_blank">
                                    <input class="hidden" name="fol_gnkl" value="<%=noCompra%>">
                                    <button class="btn btn-success btn-block">Imprimir Compra</button>
                                </form>
                            </div>
                            <div class="col-lg-3">
                                <form action="reimp_marbete.jsp" target="_blank">
                                    <input class="hidden" name="fol_gnkl" value="<%=noCompra%>">
                                    <button class="btn btn-primary btn-block">Imprimir Marbete</button>
                                </form>
                            </div-->
                        </td>
                        <!--td colspan="2"><a href="Reporte.jsp" target="_blank" class="btn btn-success btn-block">Imprimir</a></td-->
                    </tr>
                    <%
                        }
                    %>

                </table>

            </div>


        </div>


        <br>
        <%@include file="jspf/piePagina.jspf" %>


        <!--
        Modal
        -->
        <div class="modal fade" id="Rechazar" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form action="Rechazos" method="get">
                        <div class="modal-header">
                            <div class="row">
                                <div class="col-sm-5">
                                    <h4 class="modal-title" id="myModalLabel">Rechazar Orden de Compra</h4>
                                </div>
                                <div class="col-sm-2">
                                    <input name="NoCompraRechazo" id="NoCompraRechazo" value="<%=noCompra%>" class="form-control" readonly="" />
                                </div>
                            </div>
                            <div class="row">
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select i.F_NoCompra, i.F_FecSur, i.F_HorSur, p.F_NomPro, p.F_ClaProve from tb_pedidoisem i, tb_proveedor p where i.F_Provee = p.F_ClaProve and F_StsPed = '1' and F_NoCompra = '" + noCompra + "' and F_recibido='0' group by F_NoCompra");
                                        while (rset.next()) {
                                %>
                                <div class="col-sm-12">
                                    Proveedor:<%=rset.getString("p.F_NomPro")%>
                                </div>
                                <div class="col-sm-12">
                                    Fecha y Hora <%=rset.getString("i.F_FecSur")%> - <%=rset.getString("i.F_HorSur")%>
                                </div>
                                <%
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {

                                    }
                                %>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <h4>Observaciones de Rechazo</h4>
                                </div>
                                <div class="col-sm-12">
                                    <textarea class="form-control" placeholder="Observaciones" name="rechazoObser" id="rechazoObser" rows="5"></textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <h4>Fecha de nueva recepción</h4>
                                </div>
                                <div class="col-sm-6">
                                    <input type="date" min="<%=df2.format(new Date())%>" class="form-control" id="FechaOrden" name="FechaOrden" />
                                </div>
                                <div class="col-sm-6">
                                    <select class="form-control" id="HoraOrden" name="HoraOrden">
                                        <%
                                            for (int i = 0; i < 24; i++) {
                                                if (i != 24) {
                                        %>
                                        <option value="<%=i%>:00"><%=i%>:00</option>
                                        <option value="<%=i%>:30"><%=i%>:30</option>
                                        <%
                                        } else {
                                        %>
                                        <option value="<%=i%>:00"><%=i%>:00</option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <h4>Correo del proveedor</h4>
                                    <input type="email" class="form-control" id="correoProvee" name="correoProvee" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <h4>Claves a Cancelar</h4>
                                    <h6>*Deseleccione las claves que no va a cancelar</h6>
                                </div>
                                <div class="col-sm-6">
                                    <div class="checkbox">
                                        <label>
                                            <h4><input type="checkbox" checked name="todosChk" id="todosChk" onclick="checkea(this)">Seleccionar todas</h4>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <table class="table table-bordered">
                                        <%
                                            try {
                                                con.conectar();
                                                ResultSet rset = con.consulta("select F_Clave from tb_pedidoisem where F_NoCompra = '" + noCompra + "' ");
                                                int columna = 1;
                                                while (rset.next()) {

                                                    if (columna == 1) {
                                        %>
                                        <tr>
                                            <%
                                                }
                                            %>
                                            <td>
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" checked="" name="chkCancela" value="<%=rset.getString(1)%>"><%=rset.getString(1)%>
                                                    </label>
                                                </div>
                                            </td>
                                            <%
                                                if (columna % 5 == 0) {
                                            %>
                                        </tr>
                                        <%
                                                        columna = 0;
                                                    }
                                                    columna++;

                                                }
                                                con.cierraConexion();
                                            } catch (Exception e) {
                                                System.out.println(e.getMessage());
                                            }
                                        %>
                                    </table>
                                </div>
                            </div>
                            <div class="text-center" id="imagenCarga" style="display: none;" > 
                                <img src="imagenes/ajax-loader-1.gif">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" onclick="return validaRechazo();
                                    " name="accion" value="Rechazar">Rechazar OC</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--
        /Modal
        --><!-- 
    ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="js/jquery-1.9.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery-ui-1.10.3.custom.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/funcIngresos.js"></script>

        <script type="text/javascript">

                                $(window).scrollTop(400);

                                $('#FormInsumo').submit(function () {

                                    document.getElementById('imgCarga').style.display = "block";
                                    $('#accion').css('display', 'none');
                                });

                                function checkea(obj) {
                                    var cbs = document.getElementsByName('chkCancela');
                                    if (obj.checked) {
                                        for (var i = 0; i < cbs.length; i++)
                                        {
                                            cbs[i].checked = true;
                                        }
                                    } else {
                                        for (var i = 0; i < cbs.length; i++)
                                        {
                                            cbs[i].checked = false;
                                        }
                                    }
                                }
                                function validaRechazo() {
                                    var obser = document.getElementById('rechazoObser').value;
                                    var fechaN = document.getElementById('FechaOrden').value;
                                    var horaN = document.getElementById('HoraOrden').value;
                                    var correoProvee = document.getElementById('correoProvee').value;
                                    if (obser === "") {
                                        alert('Ingrese las observaciones del rechazo.');
                                        return false;
                                    }
                                    if (fechaN === "") {
                                        alert('Ingrese nueva fecha de recepción.');
                                        return false;
                                    }
                                    if (horaN === "0:00") {
                                        alert('Ingrese nueva hora de recepción.');
                                        return false;
                                    }
                                    if (correoProvee === "0:00") {
                                        alert('Ingrese correo de proveedor.');
                                        return false;
                                    }
                                    var con = confirm('¿Seguro que desea rechazar la OC?');
                                    if (con === false) {
                                        return false;
                                    }
                                    document.getElementById('imagenCarga').style.display = 'block';
                                    //return false;
                                }

                                $(function () {
                                    $("#Fecha").datepicker();
                                    $("#Fecha").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                });
                                function justNumbers(e)
                                {
                                    var keynum = window.event ? window.event.keyCode : e.which;
                                    if ((keynum === 8) || (keynum === 46))
                                        return true;
                                    return /\d/.test(String.fromCharCode(keynum));
                                }

                                otro = 0;
                                function LP_data(e, esto) {
                                    var key = (document.all) ? e.keyCode : e.which; //codigo de tecla. 
                                    if (key < 48 || key > 57)//si no es numero 
                                        return false; //anula la entrada de texto.
                                    else
                                        anade(esto);
                                }
                                function anade(esto) {

                                    if (esto.value.length > otro) {
                                        if (esto.value.length === 2) {
                                            esto.value += "/";
                                        }
                                    }
                                    if (esto.value.length > otro) {
                                        if (esto.value.length === 5) {
                                            esto.value += "/";
                                        }
                                    }
                                    if (esto.value.length < otro) {
                                        if (esto.value.length === 2 || esto.value.length === 5) {
                                            esto.value = esto.value.substring(0, esto.value.length - 1);
                                        }
                                    }
                                    otro = esto.value.length;
                                }


                                function AvisaID(id) {
                                    //alert(id);
                                }
                                var formatNumber = {
                                    separador: ",", // separador para los miles
                                    sepDecimal: '.', // separador para los decimales
                                    formatear: function (num) {
                                        num += '';
                                        var splitStr = num.split('.');
                                        var splitLeft = splitStr[0];
                                        var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
                                        var regx = /(\d+)(\d{3})/;
                                        while (regx.test(splitLeft)) {
                                            splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
                                        }
                                        return this.simbol + splitLeft + splitRight;
                                    },
                                    new : function (num, simbol) {
                                        this.simbol = simbol || '';
                                        return this.formatear(num);
                                    }
                                };
                                /*$(function() {
                                 $("#cad").datepicker();
                                 $("#cad").datepicker('option', {dateFormat: 'dd/mm/yy'});
                                 });*/
                                function totalPiezas() {
                                    var TarimasC = document.getElementById('TarimasC').value;
                                    var CajasxTC = document.getElementById('CajasxTC').value;
                                    var PzsxCC = document.getElementById('PzsxCC').value;
                                    var TarimasI = document.getElementById('TarimasI').value;
                                    var CajasxTI = document.getElementById('CajasxTI').value;
                                    var Resto = document.getElementById('Resto').value;
                                    if (TarimasC === "") {
                                        TarimasC = 0;
                                    }
                                    if (CajasxTC === "") {
                                        CajasxTC = 0;
                                    }
                                    if (PzsxCC === "") {
                                        PzsxCC = 0;
                                    }
                                    if (TarimasI === "") {
                                        TarimasI = 0;
                                    }
                                    if (CajasxTI === "") {
                                        CajasxTI = 0;
                                    }
                                    if (Resto === "") {
                                        Resto = 0;
                                        var totalCajas = parseInt(CajasxTC) * parseInt(TarimasC) + parseInt(CajasxTI);
                                        document.getElementById('TCajas').value = formatNumber.new(totalCajas);
                                    } else {
                                        var totalCajas = parseInt(CajasxTC) * parseInt(TarimasC) + parseInt(CajasxTI);
                                        document.getElementById('TCajas').value = formatNumber.new(totalCajas + 1);
                                        document.getElementById('CajasIn').value = formatNumber.new(1);
                                        if (parseInt(CajasxTI) !== parseInt(0)) {
                                            TarimasI = parseInt(TarimasI) + parseInt(1);
                                        }
                                    }
                                    var totalTarimas = parseInt(TarimasC) + parseInt(TarimasI);
                                    if (totalTarimas === 0 && Resto !== 0) {
                                        totalTarimas = totalTarimas + 1;
                                    }
                                    document.getElementById('Tarimas').value = formatNumber.new(totalTarimas);
                                    var totalCajas = parseInt(CajasxTC) * parseInt(TarimasC) + parseInt(CajasxTI);
                                    document.getElementById('Cajas').value = formatNumber.new(totalCajas);
                                    var totalPiezas = parseInt(PzsxCC) * parseInt(totalCajas);
                                    document.getElementById('Piezas').value = formatNumber.new(totalPiezas + parseInt(Resto));
                                }

                                function validaCadu() {
                                    var cad = document.getElementById('cad').value;
                                    if (cad === "") {
                                        alert("Falta Caducidad");
                                        document.getElementById('cad').focus();
                                        return false;
                                    } else {
                                        if (cad.length < 10) {
                                            alert("Caducidad Incorrecta");
                                            document.getElementById('cad').focus();
                                            return false;
                                        } else {
                                            var dtFechaActual = new Date();
                                            var sumarDias = parseInt(180);
                                            dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
                                            var fechaSpl = cad.split("/");
                                            var Caducidad = fechaSpl[2] + "-" + fechaSpl[1] + "-" + fechaSpl[0];
                                            /*alert(Caducidad);*/

                                            if (Date.parse(dtFechaActual) > Date.parse(Caducidad)) {
                                                alert("La fecha de caducidad no puede ser menor a 6 meses próximos");
                                                document.getElementById('cad').focus();
                                                return false;
                                            }
                                        }
                                    }
                                }

                                function validaCompra() {
                                    var folioRemi = document.getElementById('folioRemi').value;
                                    if (folioRemi === "") {
                                        alert("Falta Folio de Remisión");
                                        document.getElementById('folioRemi').focus();
                                        return false;
                                    }

                                    var codBar = document.getElementById('codbar').value;
                                    if (codBar === "") {
                                        alert("Falta Código de Barras");
                                        document.getElementById('codbar').focus();
                                        return false;
                                    }

                                    var lot = document.getElementById('lot').value;
                                    if (lot === "" || lot === "-") {
                                        alert("Falta Lote");
                                        document.getElementById('lot').focus();
                                        return false;
                                    }

                                    var marca = document.getElementById('list_marca').value;
                                    if (marca === "" || marca === "-") {
                                        alert("Falta Marca");
                                        document.getElementById('list_marca').focus();
                                        return false;
                                    }

                                    var cad = document.getElementById('cad').value;
                                    if (cad === "") {
                                        alert("Falta Caducidad");
                                        document.getElementById('cad').focus();
                                        return false;
                                    } else {
                                        var dtFechaActual = new Date();
                                        var sumarDias = parseInt(180);
                                        dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
                                        var fechaSpl = cad.split("/");
                                        var Caducidad = fechaSpl[2] + "-" + fechaSpl[1] + "-" + fechaSpl[0];
                                        /*alert(Caducidad);*/

                                        if (Date.parse(dtFechaActual) > Date.parse(Caducidad)) {
                                            alert("La fecha de caducidad no puede ser menor a 6 meses próximos");
                                            document.getElementById('cad').focus();
                                            return false;
                                        }

                                    }

                                    var Piezas = document.getElementById('Piezas').value;
                                    if (Piezas === "" || Piezas === "0") {
                                        document.getElementById('Piezas').focus();
                                        alert("Favor de llenar todos los datos");
                                        return false;
                                    }

                                    var cantRecibida = document.getElementById('cantRecibida').value;
                                    var cantTotal = document.getElementById('cantRecibir').value;
                                    cantRecibida = cantRecibida.replace(/,/gi, "");
                                    cantTotal = cantTotal.replace(/,/gi, "");
                                    Piezas = Piezas.replace(/,/gi, "");
                                    var nCantidad = parseInt(Piezas) + parseInt(cantRecibida);
                                    if (nCantidad > parseInt(cantTotal)) {
                                        alert("Excede la cantidad a recibir, favor de verificar");
                                        return false;
                                    }

                                }


                                function tabular(e, obj)
                                {
                                    tecla = (document.all) ? e.keyCode : e.which;
                                    if (tecla != 13)
                                        return;
                                    frm = obj.form;
                                    for (i = 0; i < frm.elements.length; i++)
                                        if (frm.elements[i] == obj)
                                        {
                                            if (i == frm.elements.length - 1)
                                                i = -1;
                                            break
                                        }
                                    /*ACA ESTA EL CAMBIO*/
                                    if (frm.elements[i + 1].disabled == true)
                                        tabular(e, frm.elements[i + 1]);
                                    else
                                        frm.elements[i + 1].focus();
                                    return false;
                                }

                                function cambiaLoteCadu(elemento) {
                                    var indice = elemento.selectedIndex;
                                    document.getElementById('list_cadu').selectedIndex = indice;
                                    document.getElementById('lot').value = document.getElementById('list_lote').value;
                                    document.getElementById('cad').value = document.getElementById('list_cadu').value;
                                }


                                function checkKey(e, obj) {
                                    tecla = (document.all) ? e.keyCode : e.which;
                                    if (tecla != 13)
                                        return;
                                    frm = obj.form;
                                    for (i = 0; i < frm.elements.length; i++)
                                        if (frm.elements[i] == obj)
                                        {
                                            if (i == frm.elements.length - 1)
                                                i = -1;
                                            break
                                        }
                                    /*ACA ESTA EL CAMBIO*/
                                    if (frm.elements[i + 1].disabled == true)
                                        tabular(e, frm.elements[i + 1]);
                                    else
                                        frm.elements[i + 1].focus();
                                    document.getElementById('CodigoBarras').click();
                                    return false;
                                }

        </script>

    </body>



</html>
