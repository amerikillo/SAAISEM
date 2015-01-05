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
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    custom.setDecimalSeparator('.');
    custom.setGroupingSeparator(',');
    formatter.setDecimalFormatSymbols(custom);
    HttpSession sesion = request.getSession();
    String usua = "", Clave = "";
    String tipo = "";
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
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Facturación aútomatica</h3>
                </div>
                <div class="panel-body ">
                    <form class="form-horizontal" role="form" name="formulario1" id="formulario1" method="post" action="FacturacionISSEMyM">
                        <div class="form-group">
                            <div class="form-group">
                                <!--label for="Clave" class="col-xs-2 control-label">Clave*</label>
                                <div class="col-xs-2">
                                    <input type="text" class="form-control" id="Clave" name="Clave" placeholder="Clave" onKeyPress="return tabular(event, this)" autofocus >
                                </div-->
                                <label for="Nombre" class="col-xs-1 control-label">Clave Unidad</label>
                                <div class="col-xs-7">
                                    <select id="Nombre" name="Nombre" class="form-control">
                                        <option value="">Unidad</option>
                                        <%
                                            try {
                                                con.conectar();
                                                ResultSet rset = con.consulta("select u.F_ClaCli, u.F_NomCli from tb_uniatn u, tb_unireq r where u.F_ClaCli = r.F_ClaUni and u.F_StsCli = 'A' and r.F_Status=0 group by u.F_ClaCli");
                                                while (rset.next()) {
                                        %>
                                        <option value="<%=rset.getString(1)%>"
                                                <%
                                                    if (Clave.equals(rset.getString(1))) {
                                                        out.println("selected");
                                                    }
                                                %>
                                                ><%=rset.getString(2)%></option>
                                        <%
                                                }
                                                con.cierraConexion();
                                            } catch (Exception e) {

                                            }
                                        %>
                                    </select>
                                </div>

                                <div class="col-lg-1"></div>
                                <div class="col-lg-2"><button class="btn btn-block btn-primary" type="submit" name="accion" value="consultar" onclick="return valida_clave();" >Consultar</button></div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="form-group">
                                <label for="FecFab" class="col-sm-1 control-label">Fec Entrega</label>
                                <div class="col-sm-2">
                                    <input type="date" class="form-control" id="FecFab" name="FecFab" placeholder="FecFab" maxlength="10" />
                                </div>
                            </div>
                        </div>
                        <%
                            if (!Clave.equals("")) {
                        %>
                        <button class="hidden" type="submit" name="accion" value="guardar" onclick="return valida_alta();" id="BtnGuardar">Generar Remisión</button> 
                        <button type="submit" class="btn btn-primary btn-block" data-toggle="modal" data-target="#Observaciones" name="accion" value="remisionCamion" onclick="">Remisionar</button>
                        <div class="hidden">
                            <textarea id="Obs" name="Obs"></textarea>
                            <input id="F_Req" name="F_Req" />
                        </div>
                        <br/><br/>
                        <button class="btn btn-block btn-danger" type="submit" name="accion" value="cancelar" onclick="return confirm('¿Seguro que desea CANCELAR esta orden?');">Cancelar</button> 
                        <%
                            }
                        %>
                    </form>
                    <div>
                        <h6>Los campos marcados con * son obligatorios</h6>
                    </div>
                </div>
                <div class="panel-footer">
                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                        <thead>
                            <tr>
                                <td>Clave</td>
                                <td>Descripción</td>
                                <td>Cajas</td>
                                <td>Piezas</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {

                                    con.conectar();
                                    ResultSet rset = con.consulta("SELECT M.F_ClaPro,M.F_DesPro,REQ.F_CajasReq, REQ.F_PiezasReq FROM tb_unireq REQ INNER JOIN tb_medica M ON REQ.F_ClaPro=M.F_ClaPro WHERE F_ClaUni='" + Clave + "' and F_Status =0");
                                    while (rset.next()) {
                            %>
                            <tr class="odd gradeX">
                                <td><small><%=rset.getString(1)%></small></td>
                                <td><small><%=rset.getString(2)%></small></td>
                                <td><small><%=formatter.format(rset.getInt(3))%></small></td>
                                <td><small><%=formatter.format(rset.getInt(4))%></small></td>
                            </tr>
                            <%
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
        <br><br><br>
        <div class="navbar navbar-fixed-bottom navbar-inverse">
            <div class="text-center text-muted">
                GNK Logística || Desarrollo de Aplicaciones 2009 - 2014 <span class="glyphicon glyphicon-registration-mark"></span><br />
                Todos los Derechos Reservados
            </div>
        </div>

        <!--
                Modal
        -->
        <div class="modal fade" id="Observaciones" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <div class="col-sm-5">
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <h4 class="modal-title" id="myModalLabel">Requerimiento</h4>
                        <div class="row">
                            <div class="col-sm-12">
                                <input name="Requerimiento" id="Requerimiento" class="form-control" />
                            </div>
                        </div>

                        <h4 class="modal-title" id="myModalLabel">Observaciones</h4>
                        <div class="row">
                            <div class="col-sm-12">
                                <textarea name="Obser" id="Obser" class="form-control"></textarea>
                            </div>
                        </div>
                        <div style="display: none;" class="text-center" id="Loader">
                            <img src="imagenes/ajax-loader-1.gif" height="150" />
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" onclick="return validaRemision();" name="accion" value="actualizarCB">Remisionar</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--
            /Modal
            -->
    </body>
</html>


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
                                    var seg = confirm('Desea Remisionar este Insumo?');
                                    if (seg == false) {
                                        return false;
                                    } else {
                                        if ($('#FecFab').val() === "") {
                                            alert("Debe seleccionar una fecha de entrega");
                                            return false;
                                        } else {
                                            document.getElementById('Loader').style.display = 'block';
                                            var observaciones = document.getElementById('Obser').value;
                                            document.getElementById('Obs').value = observaciones;
                                            var req = document.getElementById('Requerimiento').value;
                                            document.getElementById('F_Req').value = req;
                                            document.getElementById('BtnGuardar').click();
                                        }
                                    }

                                }

</script> 
