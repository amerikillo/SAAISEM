<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Americo
--%>

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
            /*try {
                con.conectar();
                conNube.conectar();
                ResultSet rsetOrdenes = conNube.consulta("select * from tb_pedidoisem where F_StsPed !=0 ");
                try {
                    while (rsetOrdenes.next()) {
                        try {
                            con.insertar("insert into tb_pedidoisem values('" + rsetOrdenes.getString(1) + "','" + rsetOrdenes.getString(2) + "','" + rsetOrdenes.getString(3) + "','" + rsetOrdenes.getString(4) + "','" + rsetOrdenes.getString(5) + "','" + rsetOrdenes.getString(6) + "','" + rsetOrdenes.getString(7) + "','" + rsetOrdenes.getString(8) + "','" + rsetOrdenes.getString(9) + "','" + rsetOrdenes.getString(10) + "','" + rsetOrdenes.getString(11) + "','" + rsetOrdenes.getString(12) + "','" + rsetOrdenes.getString(13) + "','" + rsetOrdenes.getString(14) + "','" + rsetOrdenes.getString(15) + "','" + rsetOrdenes.getString(16) + "')");
                        } catch (Exception e) {
                            try {
                                con.insertar("update tb_pedidoisem set F_StsPed = '" + rsetOrdenes.getString(15) + "' where F_IdIsem='" + rsetOrdenes.getString(1) + "'");
                            } catch (Exception ex) {

                            }
                        }

                    }
                } catch (Exception e) {

                }
                con.cierraConexion();
                con.cierraConexion();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }*/
        }
    } catch (Exception er) {

    }

    String fecha = "", noCompra = "", Proveedor = "", Fecha = "";
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
    try {
        con.conectar();
        ResultSet rset = con.consulta("select F_FolRemi from tb_compra where F_OrdCom  = '" + noCompra + "' group by F_FolRemi");
        while (rset.next()) {
            folioRemi = rset.getString(1);
        }
        if (folioRemi.equals("")) {
            rset = con.consulta("select F_FolRemi from tb_compratemp where F_OrdCom  = '" + noCompra + "' group by F_FolRemi");
            while (rset.next()) {
                folioRemi = rset.getString(1);
            }
        }
        con.cierraConexion();
    } catch (Exception e) {

    }
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
        <!-- Estilos CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <link rel="stylesheet" href="css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="css/navbar-fixed-top.css" rel="stylesheet">
        <!---->
        <!---->
        <title>SIALSS</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>Módulo - Sistema de Administración de Almacenes (SAA)</h4>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="main_menu.jsp">Inicio</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entradas<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Entrada Manual</a></li>
                                    <li><a href="compraAuto2.jsp">Entrada Automática OC ISEM</a></li>
                                    <li><a href="reimpresion.jsp" target="blank_">Reimpresión de Compras</a></li>
                                    <li><a href="ordenesCompra.jsp" target="blank_">Órdenes de Compras</a></li>
                                    <li><a href="kardexClave.jsp" target="blank_">Kardex Claves</a></li>
                                    <li><a href="Ubicaciones/Consultas.jsp" target="blank_">Ubicaciones</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturación<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="requerimiento.jsp">Carga de Requerimiento</a></li>
                                    <li><a href="factura.jsp">Facturación Automática</a></li>
                                     <li><a href="reimp_factura.jsp">Administrar Remisiones</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="medicamento.jsp" target="blank_">Catálogo de Medicamento</a></li>
                                    <li><a href="catalogo.jsp" target="blank_">Catálogo de Proveedores</a></li>
                                    <li><a href="marcas.jsp" target="blank_">Catálogo de Marcas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Fecha Recibo<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="Entrega.jsp" target="blank_">Fecha de Recibo en CEDIS</a></li> 
                                    <li><a href="historialOC.jsp" target="blank_">Historial OC</a></li>                                      
                                </ul>
                            </li>
                            <!--li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADASU<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                                </ul>
                            </li-->
                            <%
                                if (usua.equals("root")) {
                            %>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Usuario<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="usuarios/usuario_nuevo.jsp">Nuevo Usuario</a></li>
                                    <li><a href="usuarios/edita_usuario.jsp">Edicion de Usuarios</a></li>
                                </ul>
                            </li>
                            <%                                }
                            %>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <form action="compraAuto2.jsp" method="post">
                <div class="row">
                    <label class="col-sm-2 text-right">
                        <h4>Proveedor</h4>
                    </label>
                    <div class="col-sm-5">
                        <select class="form-control" name="Proveedor" id="Proveedor" onchange="SelectProve(this.form);
                                document.getElementById('Fecha').focus()">
                            <option value="">--Proveedor--</option>
                            <%
                                try {
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
                                    ResultSet rset = con.consulta("select o.F_NoCompra, p.F_NomPro from tb_pedidoisem o, tb_proveedor p where o.F_Provee = p.F_ClaProve and o.F_FecSur like  '%" + fecha + "%'  and o.F_Provee like '%" + request.getParameter("Proveedor") + "'  and F_StsPed !='2' and F_Recibido=0  group by o.F_NoCompra");
                                    while (rset.next()) {
                            %>
                            <option value="<%=rset.getString(1)%>"><%=rset.getString(2)%> - <%=rset.getString(1)%></option>
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
            <form action="CompraAutomatica" method="get" name="formulario1">
                <br/>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select i.F_NoCompra, i.F_FecSur, i.F_HorSur, p.F_NomPro, p.F_ClaProve from tb_pedidoisem i, tb_proveedor p where i.F_Provee = p.F_ClaProve and F_StsPed = '1' and F_NoCompra = '" + noCompra + "' and F_recibido='0' group by F_NoCompra");
                        while (rset.next()) {
                %>
                <div class="row">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <h4 class="col-sm-3">Folio Orden de Compra:</h4>
                                <div class="col-sm-2"><input class="form-control" value="<%=rset.getString(1)%>" readonly="" name="folio" id="folio" onkeypress="return tabular(event, this)" /></div>
                                <h4 class="col-sm-2 text-right">Folio de Remisión:</h4>
                                <div class="col-sm-2"><input class="form-control" value="<%=folioRemi%>" name="folioRemi" id="folioRemi" onkeypress="return tabular(event, this)" /></div>
                            </div>
                            <div class="row">
                                <h4 class="col-sm-12">Proveedor: <%=rset.getString(4)%></h4>
                            </div>
                            <div class="row">
                                <h4 class="col-sm-12">Fecha y Hora de Entrega: <%=df3.format(df2.parse(rset.getString(2)))%> <%=rset.getString(3)%></h4>
                            </div>
                        </div>
                        <div class="panel-body">

                            <%
                                try {
                                    con.conectar();
                                    ResultSet rset2 = con.consulta("select s.F_Clave, m.F_DesPro, s.F_Lote, DATE_FORMAT(F_Cadu, '%d/%m/%Y'), s.F_Cant, F_IdIsem, F_Obser from tb_pedidoisem s, tb_medica m where s.F_Clave = m.F_ClaPro and F_NoCompra = '" + rset.getString(1) + "' and F_StsPed = '1'");
                                    while (rset2.next()) {
                                        rset2.last();
                                        numRenglones = rset2.getRow() - 1;
                                    }
                                    rset2 = con.consulta("select s.F_Clave, m.F_DesPro, s.F_Lote, DATE_FORMAT(F_Cadu, '%d/%m/%Y'), s.F_Cant, F_IdIsem, F_Obser from tb_pedidoisem s, tb_medica m where s.F_Clave = m.F_ClaPro and F_NoCompra = '" + rset.getString(1) + "' and F_StsPed = '1' limit " + posClave + ",1 ");
                                    while (rset2.next()) {

                            %>
                            <h4 class="bg-primary" style="padding: 5px">CLAVE <%=Integer.parseInt(posClave) + 1%> / <%=numRenglones + 1%> | <%=rset2.getString(1)%> <%=rset2.getString(2)%></h4>
                            <table class="table table-bordered table-condensed table-striped">
                                <tr>
                                    <td><strong>Clave</strong></td>
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
                                    <td><input type="text" value="<%=rset2.getString(1)%>" class="form-control" name="ClaPro" id="ClaPro" onclick="" readonly=""  onkeypress="return tabular(event, this)"/></td>
                                    <td><%=rset2.getString(2)%></td>
                                    <td>
                                        <input type="text" value="<%=CodBar%>" class="form-control" name="codbar" id="codbar" onclick="" onkeypress="checkKey(event);" />
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
                                                            ResultSet rset3 = con.consulta("SELECT m.F_ClaMar, m.F_DesMar FROM tb_marca m, tb_marcaclave mc where m.F_ClaMar = mc.F_ClaMar and mc.F_ClaPro = '"+rset2.getString(1)+"' ");
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
                                    <td colspan="5">
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
                                                <input type="Cajas" class="form-control" id="TarimasC" name="TarimasC" placeholder="0" onKeyPress="return justNumbers(event);
                                                        return handleEnter(even);" onkeyup="totalPiezas()" onclick="" />
                                            </div>
                                            <label for="pzsxcaja" class="col-sm-2 control-label">Cajas x Tarima</label>
                                            <div class="col-sm-1">
                                                <input type="pzsxcaja" class="form-control" id="CajasxTC" name="CajasxTC" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas()" onclick="" />
                                            </div>
                                            <label for="Resto" class="col-sm-2 control-label">Piezas x Caja</label>
                                            <div class="col-sm-1">
                                                <input type="Resto" class="form-control" id="PzsxCC" name="PzsxCC%>" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas()" onclick="" />
                                            </div>
                                        </div>
                                        <br/>
                                        <h5><strong>Tarimas Incompletas</strong></h5>
                                        <div class="row">

                                            <label for="Cajas" class="col-sm-2 control-label">Tarimas</label>
                                            <div class="col-sm-1">
                                                <input type="Cajas" class="form-control" id="TarimasI" name="TarimasI" placeholder="0" onKeyPress="return justNumbers(event);
                                                        return handleEnter(even);" onkeyup="totalPiezas();" onclick="" />
                                            </div>
                                            <label for="pzsxcaja" class="col-sm-2 control-label">Cajas x Tarima</label>
                                            <div class="col-sm-1">
                                                <input type="pzsxcaja" class="form-control" id="CajasxTI" name="CajasxTI" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                            </div>
                                            <label for="pzsxcaja" class="col-sm-2 control-label">Resto</label>
                                            <div class="col-sm-1">
                                                <input type="pzsxcaja" class="form-control" id="Resto" name="Resto" placeholder="0" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6">
                                        <h5><strong>Totales</strong></h5>
                                        <div class="row">

                                            <label for="Cajas" class="col-sm-2 control-label">Tarimas</label>
                                            <div class="col-sm-1">
                                                <input type="text" class="form-control" id="Tarimas" name="Tarimas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);
                                                        return handleEnter(even);" onkeyup="totalPiezas();" onclick="" />
                                            </div>
                                            <label for="pzsxcaja" class="col-sm-2 control-label">Cajas</label>
                                            <div class="col-sm-1">
                                                <input type="text" class="form-control" id="Cajas" name="Cajas" placeholder="0" readonly="" onKeyPress="return justNumbers(event);" onkeyup="totalPiezas();" onclick=""/>
                                            </div>
                                            <label for="Resto" class="col-sm-2 control-label">Piezas</label>
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
                            <div class="row">
                                <div class="col-sm-4">
                                    <%if (!posClave.equals("0")) {%>
                                    <button class="btn btn-block btn-danger" name="accion" id="accion" value="anterior" >Clave Anterior</button>
                                    <%}%>
                                </div>
                                <div class="col-sm-4">
                                    <button class="btn btn-block btn-primary" name="accion" id="accion" value="guardarLote" onclick="return validaCompra();" >Guardar Lote</button>
                                </div>
                                <div class="col-sm-4">
                                    <%if (!posClave.equals(numRenglones + "")) {%>
                                    <button class="btn btn-block btn-danger" name="accion" id="accion" value="siguiente" >Siguiente Clave</button>
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

            <div class="panel-body panel-default">
                <table class="table table-bordered table-striped">
                    <tr>
                        <td><a name="ancla"></a>Código de Barras</td>
                        <td>Clave</td>
                        <td>Descripción</td>                       
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
                            ResultSet rset = con.consulta("SELECT C.F_Cb,C.F_ClaPro,M.F_DesPro,C.F_Lote,C.F_FecCad,C.F_Pz,F_IdCom, C.F_Costo, C.F_ImpTo, C.F_ComTot FROM tb_compratemp C INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro WHERE F_FecApl=CURDATE() AND F_OrdCom='" + noCompra + "'");
                            while (rset.next()) {
                                banCompra = 1;

                    %>
                    <tr>
                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                        <td><%=rset.getString(4)%></td>
                        <td><%=df3.format(df2.parse(rset.getString(5)))%></td>
                        <td><%=formatter.format(rset.getDouble(6))%></td>           
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_Costo"))%></td>
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_ImpTo"))%></td>          
                        <td><%=formatterDecimal.format(rset.getDouble("C.F_ComTot"))%></td>              
                        <td>

                            <form method="get" action="Modificaciones">
                                <input name="id" type="text" style="" class="hidden" value="<%=rset.getString(7)%>" />
                                <button class="btn btn-warning" name="accion" value="modificarCompraAuto"><span class="glyphicon glyphicon-pencil" ></span></button>
                                <button class="btn btn-danger" onclick="return confirm('¿Seguro de que desea eliminar?');" name="accion" value="eliminarCompraAuto"><span class="glyphicon glyphicon-remove"></span>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                    %>
                    <%
                        if (banCompra == 1) {
                    %>
                    <tr>

                        <td colspan="10">
                            <div class="col-lg-3 col-lg-offset-3">
                                <form action="nuevoAutomaticaLotes" method="post">
                                    <input name="fol_gnkl" type="text" style="" class="hidden" value="<%=noCompra%>" />
                                    <button  value="Eliminar" name="accion" class="btn btn-danger btn-block" onclick="return confirm('Seguro que desea eliminar la compra?');">Cancelar Compra</button>
                                </form>
                            </div>
                            <%
                                if (tipo.equals("2") || tipo.equals("3") || tipo.equals("5")) {
                            %>
                            <div class="col-lg-3">
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
                            </div>
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


        <br><br><br>
        <div class="navbar navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística || Desarrollo de Aplicaciones 2009 - 2015 <span class="glyphicon glyphicon-registration-mark"></span><br />
                Todos los Derechos Reservados
            </div>
        </div>
    </body>


    <!-- 
    ================================================== -->
    <!-- Se coloca al final del documento para que cargue mas rapido -->
    <!-- Se debe de seguir ese orden al momento de llamar los JS -->
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/jquery-ui-1.10.3.custom.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">

                                        $(function() {
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
                                            formatear: function(num) {
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
                                            new : function(num, simbol) {
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
                                            }
                                            var totalTarimas = parseInt(TarimasC) + parseInt(TarimasI);
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
                                                    var sumarDias = parseInt(276);
                                                    dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
                                                    var fechaSpl = cad.split("/");
                                                    var Caducidad = fechaSpl[2] + "-" + fechaSpl[1] + "-" + fechaSpl[0];
                                                    /*alert(Caducidad);*/

                                                    if (Date.parse(dtFechaActual) > Date.parse(Caducidad)) {
                                                        alert("La fecha de caducidad no puede ser menor a 9 meses próximos");
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
                                                document.getElementById('codbar').focus();
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
                                                var sumarDias = parseInt(276);
                                                dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
                                                var fechaSpl = cad.split("/");
                                                var Caducidad = fechaSpl[2] + "-" + fechaSpl[1] + "-" + fechaSpl[0];
                                                /*alert(Caducidad);*/

                                                if (Date.parse(dtFechaActual) > Date.parse(Caducidad)) {
                                                    alert("La fecha de caducidad no puede ser menor a 9 meses próximos");
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


                                        function checkKey(key) {
                                            var unicode;
                                            if (key.charCode)
                                            {
                                                unicode = key.charCode;
                                            }
                                            else
                                            {
                                                unicode = key.keyCode;
                                            }
                                            //alert(unicode); // Para saber que codigo de tecla presiono , descomentar

                                            if (unicode == 13) {
                                                document.getElementById('CodigoBarras').click();
                                            }
                                        }
    </script>

</html>
