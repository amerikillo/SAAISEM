<%-- 
    Document   : ubicacionesConsultas
    Created on : 26/11/2014, 07:39:54 AM
    Author     : Americo
--%>

<%@page import="conn.ConectionDB_SQLServer"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="conn.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DecimalFormat formatter = new DecimalFormat("#,###,###");
    DecimalFormat formatterDecimal = new DecimalFormat("#,###,##0.00");
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    custom.setDecimalSeparator('.');
    custom.setGroupingSeparator(',');
    formatter.setDecimalFormatSymbols(custom);
    formatterDecimal.setDecimalFormatSymbols(custom);
    ConectionDB con = new ConectionDB();
    ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();
    ConectionDB conMysql = new ConectionDB();
    int banConsulta = 0;
    int totalPiezas = 0;
    ResultSet rset = null;
    ResultSet rset2 = null;
    String qry1 = "select sum(F_ExiLot) as totalPiezas from tb_lote";
    String qry2 = "";
    try {
        if (request.getParameter("accion").equals("buscar")) {
            if (!request.getParameter("F_ClaPro").equals("") && request.getParameter("F_ClaPro") != null) {
                qry2 = "select F_ClaPro, F_DesPro, F_ClaLot, DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where F_ClaPro = '" + request.getParameter("F_ClaPro") + "' and F_ExiLot!=0";
                qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias where F_ClaPro = '" + request.getParameter("F_ClaPro") + "'";
            }
            if (!request.getParameter("F_ClaLot").equals("") && request.getParameter("F_ClaLot") != null) {
                qry2 = "select F_ClaPro, F_DesPro, F_ClaLot,  DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where F_ClaLot = '" + request.getParameter("F_ClaLot") + "' and F_ExiLot!=0";
                qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias where F_ClaLot = '" + request.getParameter("F_ClaLot") + "'";
            }
            if (!request.getParameter("F_Ubica").equals("") && request.getParameter("F_Ubica") != null) {
                qry2 = "select F_ClaPro, F_DesPro, F_ClaLot,  DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where F_CBUbica = '" + request.getParameter("F_Ubica") + "' and F_ExiLot!=0";
                qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias where F_CBUbica = '" + request.getParameter("F_Ubica") + "'";
            }
            if (!request.getParameter("F_Cb").equals("") && request.getParameter("F_Cb") != null) {
                qry2 = "select F_ClaPro, F_DesPro, F_ClaLot,  DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where F_Cb = '" + request.getParameter("F_Cb") + "' and F_ExiLot!=0";
                qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias where F_Cb = '" + request.getParameter("F_Cb") + "'";
            }
        }
        if (request.getParameter("accion").equals("porUbicar")) {

            qry2 = "select F_ClaPro, F_DesPro, F_ClaLot,  DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where  F_Ubica='NUEVA' and F_ExiLot!=0";
            qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias where  F_Ubica='NUEVA'";
        }
        if (request.getParameter("accion").equals("mostrarTodas")) {
            qry2 = "select F_ClaPro, F_DesPro, F_ClaLot,  DATE_FORMAT(F_FecCad, '%d/%m/%Y') as F_FecCad, F_DesUbi, F_ExiLot, F_IdLote, F_Ubica, F_FolLot, F_Origen from v_existencias where F_ExiLot!=0";
            qry1 = "select sum(F_ExiLot) as totalPiezas from v_existencias";
        }

    } catch (Exception e) {
        System.out.println(e.getMessage());
    }

    try {
        con.conectar();
        rset = con.consulta(qry1);
        while (rset.next()) {
            totalPiezas = rset.getInt("totalPiezas");
        }
        con.cierraConexion();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <!---->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SIALSS</title>
    </head>
    <body class="container">
        <form action="ubicacionesConsultas.jsp" method="post">
            <h1>SIALSS</h1>
            <hr />
            <div class="row small">
                <h5 class="col-sm-1">Clave</h5>
                <div class="col-sm-2">
                    <input class="form-control input-sm" placeholder="Clave" name="F_ClaPro" />
                </div>
                <h5 class="col-sm-1">Lote</h5>
                <div class="col-sm-2">
                    <input class="form-control input-sm" placeholder="Lote" name="F_ClaLot" />
                </div>
                <h5 class="col-sm-1">CB Ubi</h5>
                <div class="col-sm-2">
                    <input class="form-control input-sm" placeholder="CB Ubicación" name="F_Ubica" />
                </div>
                <h5 class="col-sm-1">CB Med</h5>
                <div class="col-sm-2">
                    <input class="form-control input-sm" placeholder="CB Insumo" name="F_Cb" />
                </div>
            </div>
            <br/>
            <div class="row small">
                <div class="col-sm-2">
                    <button class="btn btn-block btn-primary btn-sm" name="accion" value="buscar">Buscar</button>
                </div>
                <div class="col-sm-2">
                    <button class="btn btn-block btn-primary btn-sm" name="accion" value="porUbicar">Por Ubicar</button>
                </div>
                <div class="col-sm-2">
                    <button class="btn btn-block btn-primary btn-sm" name="accion" value="mostrarTodas">Mostrar Todas</button>
                </div>
                <div class="col-sm-2">
                    <a class="btn btn-block btn-success btn-sm" href="../Procesos/descargaInventario.jsp">Descargar Inventario</a>
                </div>
            </div>
        </form>
        <br/><br/>
        <table class="table table-condensed table-bordered table-striped" id="tablaUbicaciones">
            <thead>
                <tr>
                    <td>CLAVE</td>
                    <td>Origen</td>
                    <td>Lote</td>
                    <td>Caducidad</td>
                    <td>Ubicación</td>
                    <td>Piezas</td>
                    <td></td>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        con.conectar();
                        rset2 = con.consulta(qry2);
                        while (rset2.next()) {
                            ResultSet rset3 = con.consulta("select F_DesOri from tb_origen where F_ClaOri = '"+rset2.getString("F_Origen")+"' ");
                            String F_Origen = "";
                            while(rset3.next()){
                                F_Origen = rset3.getString("F_DesOri");
                            }
                %>
                <tr>
                    <td><a href="#" title="<%=rset2.getString("F_DesPro")%>"><%=rset2.getString("F_ClaPro")%></a></td>
                    <td><%=F_Origen%></td>
                    <td><%=rset2.getString("F_ClaLot")%></td>
                    <td><%=rset2.getString("F_FecCad")%></td>
                    <td><%=rset2.getString("F_DesUbi")%></td>
                    <td><%=formatter.format(rset2.getInt("F_ExiLot"))%></td>
                    <td>
                        <form action="../Ubicaciones/indexValida.jsp" method="post">
                            <input name="folio" value="<%=rset2.getString("F_FolLot")%>" class="hidden" />
                            <input name="ubicacion" value="<%=rset2.getString("F_Ubica")%>" class="hidden" />
                            <input name="id" value="<%=rset2.getString("F_IdLote")%>" class="hidden" />
                            <button class="btn btn-block btn-warning btn-sm" id="folio" name="accion" value="Modificar"><span class="glyphicon glyphicon-edit"></span></button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
            </tbody>
        </table>
        <hr/>
        <h3>Total de Piezas: <%=formatter.format(totalPiezas)%></h3>
        <hr />
        <h3>Modula</h3>
        <table border="1" class="table table-bordered table-condensed table-striped" id="existModula">
            <thead>
                <tr>
                    <td>Clave</td>
                    <td>Descrip</td>
                    <td>Lote</td>
                    <td>Cadu</td>
                    <td>Cajón</td>
                    <td>Posición</td>
                    <td>Cant</td>
                </tr>
            </thead>
            <tbody>
                <% /*
                    try {
                       
                        conModula.conectar();
                        con.conectar();
                        ResultSet rset4 = conModula.consulta("select * from VIEW_MODULA_UBICACION where SCO_GIAC!=0 order by SCO_ARTICOLO");
                        while (rset4.next()) {
                            String Descrip = "";
                            ResultSet rset5 = con.consulta("select F_DesPro from tb_medica where F_ClaPro = '" + rset4.getString("SCO_ARTICOLO") + "'");
                            while (rset5.next()) {
                                Descrip = rset5.getString(1);
                            }*/
                %>
                <tr>
                    <td><%//=rset4.getString("SCO_ARTICOLO")%></td>
                    <td><%//=Descrip%></td>
                    <td><%//=rset4.getString("SCO_SUB1")%></td>
                    <td><%//=rset4.getString("SCO_DSCAD")%></td>
                    <td><%//=rset4.getString("UDC_UDC")%></td>
                    <td><%//=rset4.getString("SCO_POSI")%></td>
                    <td><%//=formatter.format(rset4.getInt("SCO_GIAC"))%></td>
                </tr>
                <%
                      /*  }
                        conModula.cierraConexion();
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                        */
                %>
            </tbody>
        </table>
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
            $('#tablaUbicaciones').dataTable();
            $('#existModula').dataTable();
        });
    </script>
    </body>
</html>
