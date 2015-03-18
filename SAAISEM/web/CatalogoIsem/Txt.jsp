<%-- 
    Document   : index
    Created on : 17/02/2014, 03:34:46 PM
    Author     : Sistemas
--%>

<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "", tipo = "";
    String Secuencial="", FechaSe="", Factura="";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
        tipo = (String) sesion.getAttribute("Tipo");
    } else {
        response.sendRedirect("../index.jsp");
    }
    ConectionDB con = new ConectionDB();

    String ClaCli = "", FechaEnt = "", ClaPro = "", DesPro = "";

    try {
        ClaCli = (String) sesion.getAttribute("ClaCliFM");
        FechaEnt = (String) sesion.getAttribute("FechaEntFM");
        ClaPro = (String) sesion.getAttribute("ClaProFM");
        DesPro = (String) sesion.getAttribute("DesProFM");
    } catch (Exception e) {

    }

    if (ClaCli == null) {
        ClaCli = "";
    }
    if (FechaEnt == null) {
        FechaEnt = "";
    }
    if (ClaPro == null) {
        ClaPro = "";
    }
    if (DesPro == null) {
        DesPro = "";
    }

 

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../css/topPadding.css" rel="stylesheet">
        <link href="../css/datepicker3.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>SIALSS</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>Módulo - Sistema de Administración de Almacenes (SAA)</h4>

            <%@include file="../jspf/menuPrincipal.jspf" %>

            
                <div class="col-sm-12">
                    <h4>Generación de Archivos TXT y Médicos</h4>
                </div>
            <br />
            <hr/>
            <form action="../ExporTxtIs" method="post">
                <div class="row">
                    <div class="panel-footer">
                        <div class="row">
                            <label class="control-label col-lg-2" for="fecha_ini">Fecha Inicio</label>
                            <div class="col-lg-2">
                                    <!--input class="form-control" id="fecha_ini" name="fecha_ini" data-date-format="dd/mm/yyyy"  value="" readonly /-->
                                    <input class="form-control" id="fecha_ini" name="fecha_ini" type="date" />
                                </div>
                            <label class="control-label col-lg-2" for="fecha_fin">Fecha Fin</label>
                            <div class="col-lg-2">
                                    <!--input class="form-control" id="fecha_fin" name="fecha_fin" data-date-format="dd/mm/yyyy"  value="" readonly /-->
                                    <input class="form-control" id="fecha_fin" name="fecha_fin" type="date" />
                                </div>
                            <label class="control-label col-lg-2" for="fecha_fin">Generar</label>
                            <div class="col-lg-4">
                                <input type="radio" id="radio" name="radio" checked="true" value="txt" > TXT
                                <input type="radio" id="radio" name="radio" value="medico"> Médicos
                            </div>
                            
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <button class="btn btn-block btn-primary" id="btn_capturar" name="btn_capturar" onclick="return confirm('¿Esta Ud. Seguro de Iniciar proceso de Generación?')">Generar</button>
                                    </div>
                                </div>
                            </div>   
                        </div> 
                    </div>
                </div>
            </form>
            <div style="display: none;" class="text-center" id="Loader">
                <img src="../imagenes/ajax-loader-1.gif" height="150" />
            </div>
        <%@include file="../jspf/piePagina.jspf" %>
        <!-- 
    ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="../js/jquery-1.9.1.js"></script>
        <script src="../js/bootstrap.js"></script>
        <script src="../js/jquery-ui-1.10.3.custom.js"></script>
        <script src="../js/bootstrap-datepicker.js"></script>  
        <script>
            function valida_alta() {
                var fecha_fin = $("#fecha_fin").val();
                var fecha_ini = $("#fecha_ini").val();
                

                if (fecha_ini === "" && fecha_fin==="") {
                    alert("Seleccione Rango de Fechas Fechas");
                    return false;
                }
                    document.getElementById('Loader').style.display = 'block';
                
            }
      </script>
    </body>

</html>

