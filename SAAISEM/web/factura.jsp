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
<%
    DecimalFormat formatter = new DecimalFormat("#,###,###");
    DecimalFormat formatter2 = new DecimalFormat("000");
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    custom.setDecimalSeparator('.');
    custom.setGroupingSeparator(',');
    formatter.setDecimalFormatSymbols(custom);
    HttpSession sesion = request.getSession();
    String usua = "", Clave = "";
    String tipo = "", F_Ruta = "", F_FecEnt = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        Clave = (String) session.getAttribute("clave");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("index.jsp");
    }
    if (Clave == null) {
        Clave = "";
    }
    ConectionDB con = new ConectionDB();
    String UsuaJuris = "";
    try {
        con.conectar();
        ResultSet rset = con.consulta("select F_Juris from tb_usuario where F_Usu = '" + usua + "'");
        while (rset.next()) {
            UsuaJuris = rset.getString("F_Juris");
        }
        con.cierraConexion();
    } catch (Exception e) {

    }
    String where = " and (";
    String[] temp;
    temp = UsuaJuris.split(",");
    for (int i = 0; i < temp.length; i++) {
        where += "u.F_ClaJurNum = '" + temp[i] + "'";
        if (i != temp.length - 1) {
            where += " or ";
        }
    }
    where += ")";

    try {
        F_Ruta = request.getParameter("F_Ruta");
        F_Ruta = formatter2.format(Integer.parseInt(F_Ruta));

    } catch (Exception e) {
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
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <%@include file="jspf/menuPrincipal.jspf" %>
        </div>
        <div class="container">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Facturación aútomatica</h3>
                </div>
                <div class="panel-body ">
                    <form class="form-horizontal" role="form" name="formulario1" id="formulario1" method="post" action="factura.jsp">

                        <h4 class="col-sm-2">Seleccione Ruta:</h4>
                        <div class="col-sm-2">
                            <select name="F_Ruta" class="form-control" onchange="SelectMuni(this.form);" required>
                                <option>Seleccione</option>
                                <%                            for (int i = 1; i <= 18; i++) {
                                %>
                                <option value="<%=i%>"><%=i%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <h4 class="col-sm-2">Seleccione el Mes:</h4>
                        <div class="col-sm-2">
                            <select name="F_Mes" class="form-control" required>
                                <option>Seleccione</option>
                                <option value="1">Enero</option>
                                <option value="2">Febrero</option>
                                <option value="3">Marzo</option>
                                <option value="4">Abril</option>
                                <option value="5">Mayo</option>
                                <option value="6">Junio</option>
                                <option value="7">Julio</option>
                                <option value="8">Agosto</option>
                                <option value="9">Septiembre</option>
                                <option value="10">Octubre</option>
                                <option value="11">Noviembre</option>
                                <option value="12">Diciembre</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <div class="form-group">
                                <!--label for="FecEnt" class="col-sm-2 control-label">Fecha de Entrega</label>
                                <div class="col-sm-2">
                                    <input type="date" class="form-control" id="FecEnt" name="F_FecEnt" />
                                </div-->
                                <div class="col-lg-2">
                                    <button class="btn btn-block btn-primary" type="submit" name="accion" value="consultar" onclick="return valida_clave();" > Consultar</button>
                                </div>
                            </div>
                        </div>

                    </form>
                    <%
                        int banReq1 = 0, banReq = 0;
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select f.F_ClaUni from tb_fecharuta f, tb_uniatn u where f.F_ClaUni = u.F_ClaCli and f.F_Ruta like '%" + F_Ruta + "%' and MONTH(F_Fecha) = '" + request.getParameter("F_Mes") + "' " + where + " group by f.F_ClaUni");
                            while (rset.next()) {
                                String F_NomCli = "";
                                ResultSet rset2 = con.consulta("select  F_NomCli from tb_uniatn where F_ClaCli = '" + rset.getString("F_ClaUni") + "'");
                                while (rset2.next()) {
                                    F_NomCli = rset2.getString("F_NomCli");
                                }

                                rset2 = con.consulta("select F_ClaUni from tb_unireq where F_Status = '0' and F_ClaUni = '" + rset.getString("F_ClaUni") + "'");
                                while (rset2.next()) {
                                    banReq1 = 1;
                                }
                            }
                            con.cierraConexion();
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    %>
                    <div>
                        <h6>Los campos marcados con * son obligatorios</h6>
                    </div>
                </div>
                <div class="panel-footer">
                    <form action="Facturacion" method="post">
                        <%
                            banReq = 0;
                            try {
                                con.conectar();
                                ResultSet rset = con.consulta("select f.F_ClaUni,f.F_Ruta, f.F_Fecha from tb_fecharuta f, tb_uniatn u, tb_unireq ur where u.F_claCli = ur.F_ClaUni and f.F_ClaUni = u.F_ClaCli and f.F_Ruta like '%" + F_Ruta + "%' and MONTH(f.F_Fecha) = '" + request.getParameter("F_Mes") + "' " + where + " group by f.F_ClaUni");
                                while (rset.next()) {
                                    String F_NomCli = "";
                                    F_FecEnt = rset.getString("F_Fecha");
                                    banReq = 0;
                                    int F_PiezasReq = 0, TotalSur = 0;
                                    ResultSet rset2 = con.consulta("select  F_ClaCli, F_NomCli from tb_uniatn where F_ClaCli = '" + rset.getString(1) + "' group by F_ClaCli");
                                    while (rset2.next()) {

                                        F_NomCli = rset2.getString("F_NomCli");

                                    }
                                    ResultSet rset3 = con.consulta("select F_ClaUni, sum(F_PiezasReq) as F_PiezasReq from tb_unireq where F_Status = '0' and F_ClaUni = '" + rset.getString(1) + "' group by F_ClaUni");
                                    while (rset3.next()) {
                                        banReq = 1;
                                        F_PiezasReq = (rset3.getInt("F_PiezasReq"));
                                    }
                                    if (F_PiezasReq != 0) {
                        %>
                        <div class="panel panel-default">
                            <div class="panel-heading">

                                <%
                                    if (banReq == 1) {
                                %>
                                <input type="checkbox" name="chkUniFact" value="<%=rset.getString("F_ClaUni")%>" checked="">
                                <%
                                    }
                                %>
                                <a data-toggle="collapse" data-parent="#accordion" href="#111<%=rset.getString(1)%>" style="color:black" aria-expanded="true" aria-controls="collapseOne"><%=rset.getString(1)%> |  <%=F_NomCli%></a>
                            </div>
                            <div id="<%=rset.getString(1)%>" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <div class="row">

                                        <!--div class="col-sm-2">
                                        <%
                                            if (banReq == 1) {
                                        %>
                                        <input name="pagina" class="hidden" value="factura.jsp">
                                        <input name="F_ClaUni" value="<%=rset.getString(1)%>" class="hidden" />
                                        <input name="F_FecEnt" value="<%=rset.getString("F_Fecha")%>" class="hidden" />
                                        <a class="btn btn-block btn-sm btn-primary" href="detRequerimiento.jsp?F_ClaUni=<%=rset.getString(1)%>&F_Ruta=<%=F_Ruta%>&F_Mes=<%=request.getParameter("F_Mes")%>&pagina=factura.jsp" ><span class="glyphicon glyphicon-search"></span></a>
                                        <%
                                            }
                                        %>
                                    </div-->
                                        <!--div class="col-sm-2">
                                        <%
                                            if (banReq == 1) {
                                        %>
                                        <input name="F_ClaUni" value="<%=rset.getString(1)%>" class="hidden" />
                                        <input name="F_FecEnt" value="<%=rset.getString("F_Fecha")%>" class="hidden" />
                                        <button class="btn btn-block btn-sm btn-warning" name="accion" value="cancelar"><span class="glyphicon glyphicon-remove"></span></button>
                                        <%
                                            }
                                        %>
                                    </div-->

                                    </div>
                                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-condensed" id="datosProv">
                                        <tr>
                                            <td>Clave</td>
                                            <td>Descripción</td>
                                            <td>Piezas Sol</td>
                                            <td>Piezas Sur</td>
                                            <td>Existencia</td>
                                        </tr>
                                        <%
                                            try {
                                                int ExiLot = 0, ExiSol = 0;
                                                ResultSet rsetR1 = con.consulta("SELECT M.F_ClaPro,M.F_DesPro,REQ.F_CajasReq, REQ.F_PiezasReq FROM tb_unireq REQ INNER JOIN tb_medica M ON REQ.F_ClaPro=M.F_ClaPro WHERE F_ClaUni='" + rset.getString("F_ClaUni") + "' and F_Status =0 and F_PiezasReq != 0");
                                                while (rsetR1.next()) {

                                                    ResultSet rsetR2 = con.consulta("select sum(F_ExiLot) from tb_lote where F_ClaPro='" + rsetR1.getString(1) + "'");
                                                    while (rsetR2.next()) {
                                                        ExiLot = rsetR2.getInt(1);
                                                    }
                                        %>
                                        <tr
                                            <%
                                                if (rsetR1.getInt(4) > ExiLot) {
                                                    out.println("class='danger'");
                                                    ExiSol = ExiLot;
                                                } else {
                                                    ExiSol = rsetR1.getInt(4);
                                                }
                                                TotalSur = TotalSur + ExiSol;

                                            %>
                                            >
                                            <td><%=rsetR1.getString(1)%></td>
                                            <td><%=rsetR1.getString(2)%></td>
                                            <td><%=rsetR1.getInt(4)%></td>
                                            <td ><small><input name="<%=rset.getString(1)%>_<%=rsetR1.getString(1).trim()%>" type="number" class="text-right form-control" value="<%=ExiSol%>" /></small></td>
                                            <td class="text-right"><%=formatter.format(ExiLot)%></td>
                                        </tr>                 
                                        <%
                                            }
                                        %>
                                        <%
                                            } catch (Exception e) {
                                                out.println(e.getMessage());
                                            }
                                        %>

                                    </table> 
                                    <div class="row">

                                        <h4 class="col-sm-2">
                                            Ruta: 
                                            <%=rset.getString(2)%>
                                        </h4>
                                        <h4 class="col-sm-2">
                                            Piezas: <%=formatter.format(F_PiezasReq)%>
                                        </h4>

                                        <h4>Total de Piezas a Facturar: <%=formatter.format(TotalSur)%></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                    }
                                }

                                con.cierraConexion();
                            } catch (Exception e) {
                                out.println(e.getMessage());
                            }
                        %>
                        <%
                            if (banReq1 == 1) {
                        %>
                        <input name="F_FecEnt" class="hidden" value="<%=F_FecEnt%>" />
                        <input name="F_Juris" class="hidden" value="<%=UsuaJuris%>" />
                        <button class="btn btn-block btn-primary" type="submit" name="accion" value="generarRemision" onclick="return validaRemision()">Generar Folio(s)</button> 

                        <%
                            }
                        %>
                    </form>
                </div>
            </div>
        </div>
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística || Desarrollo de Aplicaciones 2009 - 2015 <span class="glyphicon glyphicon-registration-mark"></span><br />
                Todos los Derechos Reservados
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel"></h4>
                    </div>
                    <div class="modal-body">
                        <div class="text-center" id="imagenCarga">
                            <img src="imagenes/ajax-loader-1.gif" alt="" />
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <!-- 
        ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="js/jquery-1.9.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery-ui-1.10.3.custom.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script>
                            $(document).ready(function() {
                                $('#datosProv').dataTable();
                            });
                            function validaRemision() {
                                var confirmacion = confirm('Seguro que desea generar los Folios');
                                if (confirmacion === true) {
                                    $('#myModal').modal();
                                    $('#btnGeneraFolio').prop('disabled', true);
                                    return true;
                                } else {
                                    return false;
                                }
                            }

        </script> 

    </body>
</html>

