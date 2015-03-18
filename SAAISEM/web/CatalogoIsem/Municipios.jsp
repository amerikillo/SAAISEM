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
                    <h3 class="panel-title">Carga de Municipios</h3>
                </div>
                <div class="panel-body ">
                    <form method="post" action="../FileUploadMunicipio" enctype="multipart/form-data" name="form1">
                        <div class="form-group">
                            <div class="form-group">
                                <div class="col-lg-4 text-success">
                                    <h4>Seleccione el Excel a Cargar</h4>
                                </div>
                                <label for="Nombre" class="col-xs-2 control-label">Nombre Archivo*</label>
                                <div class="col-sm-5">
                                    <input class="form-control" type="file" name="file1" id="file1" accept=".xlsx"/>                                    
                                </div>
                            </div>
                        </div>
                        <button class="btn btn-block btn-primary" type="submit" name="accion" value="guardar" onclick="return valida_alta();"> Cargar Archivo</button>
                    </form>
                    <div style="display: none;" class="text-center" id="Loader">
                        <img src="../imagenes/ajax-loader-1.gif" height="150" />
                    </div>                    
                </div>
                <div class="row">
                    <div class="col-sm-5">
                        <h6>Los campos marcados con * son obligatorios</h6>                      
                    </div>
                    <div class="text-center">
                        <label class="control-label col-lg-2" for="exportar"><a href="Municipios_gnr.jsp">Exportar<label class="glyphicon glyphicon-export"></label></a></label>
                    </div>
                </div>
                <div class="panel-footer">
                            <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                                <thead>
                                    <tr>
                                        <td>Clave</td>
                                        <td>Descripción</td> 
                                        <td>Jurisdicción</td>                                                           
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                try {
                                    ResultSet rset = null;
                                    
                                    con.conectar();                                    
                                        rset = con.consulta("SELECT * FROM tb_muniis");   
                                    while (rset.next()) {                                       
                            %>
                             <tr>
                                <td><%=rset.getString(1)%></td>
                                <td><%=rset.getString(2)%></td>                                
                                <td><%=rset.getString(3)%></td>                                  
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
         <%@include file="../jspf/piePagina.jspf" %>
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
    function valida_alta() {
                /*var Clave = document.formulario1.Clave.value;*/
                var Nombre = document.getElementById('file1').value;

                if (Nombre === "") {
                    alert("Tiene campos vacíos, verifique.");
                    return false;
                }
                document.getElementById('Loader').style.display = 'block';
            }
</script>

