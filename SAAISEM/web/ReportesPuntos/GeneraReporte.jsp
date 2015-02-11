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
    String usua = "";
    String tipo = "";
    String fecha_ini="", fecha_fin="",radio="",F_FolCon="";
    int F_Idsur=0,F_IdePro=0,F_Cvesum=0,F_Punto=0,F_Con=0;
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("../index.jsp");
    }
    
    try {
        fecha_ini = request.getParameter("fecha_ini");        
        fecha_fin = request.getParameter("fecha_fin");    
        radio = request.getParameter("radio");        
    } catch (Exception e) {

    }
    if(fecha_ini==null){
        fecha_ini="";
    }
    if(fecha_fin==null){
        fecha_fin="";
    }
    
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <%@include file="../jspf/menuPrincipal.jspf" %>
        </div>
        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Generar Reportes Automáticos</h3>
                </div>
                
                <form action="GeneraReporte.jsp" method="post">
                        <div class="panel-footer">
                            <div class="row">                                    
                                <label class="control-label col-lg-2" for="fecha_ini">Fecha Inicio</label>
                                <div class="col-lg-2">
                                    <!--input class="form-control" id="fecha_ini" name="fecha_ini" data-date-format="DD/MM/YYYY"  value="" /-->
                                    <input class="form-control" id="fecha_ini" name="fecha_ini" type="date" />
                                </div>
                                <label class="control-label col-lg-2" for="fecha_fin">Fecha Fin</label>
                                <div class="col-lg-2">
                                    <!--input class="form-control" id="fecha_fin" name="fecha_fin" data-date-format="dd/mm/yyyy"  value="" /-->
                                    <input class="form-control" id="fecha_fin" name="fecha_fin" type="date" />
                                </div>
                                
                            </div>                            
                        </div>     
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-10 text-center">
                                    <button class="btn btn-sm btn-success" id="btn_capturar">MOSTRAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>
                                </div>
                                
                            </div>
                        </div>                        
                    </form>
                    <div>
                        <form class="form-horizontal" role="form" name="formulario_receta" id="formulario_receta" method="get" action="../ReporteImprimeAuto">   
                            <input class="form-control" id="fecha_ini1" name="fecha_ini1" type="hidden" value="<%=fecha_ini%>" />
                            <input class="form-control" id="fecha_fin1" name="fecha_fin1" type="hidden" value="<%=fecha_fin%>" />
                            <button class="btn btn-block btn-primary" id="btn_capturar" name="btn_capturar" value="<%//=rset.getString(1)%>" onclick="return confirm('¿Esta Ud. Seguro de Iniciar proceso de Generación?')">Generar</button>
                        </form>
                    </div>
                <div class="panel-footer">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                                <thead>
                                    <tr>
                                        <td>No. Folio</td>
                                        <td>Clave Cliente</td>
                                        <td>Nombre Cliente</td>
                                        <td>Fecha de Entrega</td>                                    
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                try {
                                    ResultSet rset = null;
                                    
                                    con.conectar();
                                    if (fecha_ini == "" && fecha_fin == ""){
                                        rset = con.consulta("SELECT F.F_ClaDoc,F.F_ClaCli,U.F_NomCli,DATE_FORMAT(F.F_FecEnt,'%d/%m/%Y') AS F_FecEnt FROM tb_factura F INNER JOIN tb_uniatn U ON F.F_ClaCli=U.F_ClaCli where F.F_ClaDoc='0' GROUP BY F.F_ClaDoc ORDER BY F.F_ClaDoc+0");                                   
                                    }else{                                       
                                        rset = con.consulta("SELECT F.F_ClaDoc,F.F_ClaCli,U.F_NomCli,DATE_FORMAT(F.F_FecEnt,'%d/%m/%Y') AS F_FecEnt FROM tb_factura F INNER JOIN tb_uniatn U ON F.F_ClaCli=U.F_ClaCli where F.F_FecEnt between '"+fecha_ini+"' and '"+fecha_fin+"' GROUP BY F.F_ClaDoc ORDER BY F.F_ClaDoc+0");                                                                                                                       
                                    }
                                   
                                    while (rset.next()) {
                                        
                            %>
 
                         


                            <tr>
                                <td><%=rset.getString(1)%></td>
                                <td><%=rset.getString(2)%></td>                                
                                <td><%=rset.getString(3)%></td>                        
                                <td><%=rset.getString(4)%></td>
                                                                 
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
    </body>
</html>


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
    //$("#fecha_ini").datepicker();
    //$("#fecha_fin").datepicker();
    
    </script>
    <script>
    $(document).ready(function() {
        $('#datosProv').dataTable();
    });
</script>

