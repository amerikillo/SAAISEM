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
        response.sendRedirect("index.jsp");
    }
    ConRequerimiento con = new ConRequerimiento();

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
        <link href="css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="css/topPadding.css" rel="stylesheet">
        <link href="css/datepicker3.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>SIALSS</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>Módulo - Sistema de Administración de Almacenes (SAA)</h4>

            <%@include file="jspf/menuPrincipal.jspf" %>

            
                <div class="col-sm-12">
                    <h4>Generación Secuencial</h4>
                </div>
            <br />
            <hr/>
            <form action="ExportarReque.jsp" method="get">
                <div class="row">
                    
                    
                    <div class="panel-footer">
                        <div class="row">
                            <label class="control-label col-lg-2" for="jurisdiccion">Jurisdicción</label>
                            <div class="col-lg-5">
                                    <select class="form-control" name="Juris" id="Juris" >
                                            <option id="op">--Jurisdicción--</option>
                                            <%
                                            try {
                                                con.conectar();
                                                try {
                                                            ResultSet RsetJur = con.consulta("SELECT J.F_ClaJur,J.F_DesJur FROM tb_requerimientos R INNER JOIN tb_uniatn U ON R.F_ClaCli=U.F_ClaCli INNER JOIN tb_jurisdiccion J ON U.F_Juris=J.F_ClaJur WHERE R.F_StsReq='4' GROUP BY J.F_ClaJur,J.F_DesJur");
                                                            while (RsetJur.next()) {
                                                            %>
                                                            <option value="<%=RsetJur.getString(1)%>"><%=RsetJur.getString(2)%></option>
                                                            <%
                                                               
                                                            }
                                                            

                                                        } catch (Exception e) {
                                                            e.getMessage();
                                                        } 

                                                 con.cierraConexion();
                                                    } catch (Exception e) {
                                                    }
                                            %>
                                    </select>
                                </div>
                            <label class="control-label col-lg-2" for="mess">Mes</label>
                            <div class="col-lg-3">
                                    <select class="form-control" name="Mes" id="Mes" >
                                            <option id="op">--Mes--</option>
                                            <%
                                            try {
                                                con.conectar();
                                                try {
                                                            String mes="";
                                                            int dm=0;
                                                            ResultSet RsetMes = con.consulta("SELECT MONTH(F_FecEnt) FROM tb_requerimientos GROUP BY MONTH(F_FecEnt)");
                                                            while (RsetMes.next()) {
                                                            dm = RsetMes.getInt(1);
                                                            if(dm == 1){
                                                                mes = "ENERO";
                                                            }else if(dm == 2){
                                                                mes = "FEBRERO";
                                                            }else if(dm == 3){
                                                                mes = "MARZO";
                                                            }else if(dm == 4){
                                                                mes = "ABRIL";
                                                            }else if(dm == 5){
                                                                mes = "MAYO";
                                                            }else if(dm == 6){
                                                                mes = "JUNIO";
                                                            }else if(dm == 7){
                                                                mes = "JULIO";
                                                            }else if(dm == 8){
                                                                mes = "AGOSTO";
                                                            }else if(dm == 9){
                                                                mes = "SEPTIEMBRE";
                                                            }else if(dm == 10){
                                                                mes = "OCTUBRE";
                                                            }else if(dm == 11){
                                                                mes = "NOVIEMBRE";
                                                            }else if(dm == 12){
                                                                mes = "DICIEMBRE";
                                                            }

                                                            %>
                                                            <option value="<%=dm%>"><%=mes%></option>
                                                            <%
                                                               
                                                            }
                                                            

                                                        } catch (Exception e) {
                                                            e.getMessage();
                                                        } 

                                                 con.cierraConexion();
                                                    } catch (Exception e) {
                                                    }
                                            %>
                                    </select>
                                </div>
                            
                            
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <button class="btn btn-block btn-primary" type="submit" id="btn_capturar" name="btn_capturar" onclick="return valida_alta()">Mostrar</button>
                                    </div>
                                </div>
                            </div>   
                        </div> 
                    </div>
                    <div class="panel panel-primary">
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered table-striped" id="datosCompras">
                            <thead>
                                <tr>
                                    <td>Clave Cliente</td>
                                    <td>Nombre Cliente</td>
                                    <td>No. Requerimiento</td>
                                    <td>Excel</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        con.conectar();
                                        try {
                                            String Mess = request.getParameter("Mes");
                                            String Juris = request.getParameter("Juris");
                                            String Fecha1="" , Fecha2="";
                                            Fecha1 = "2015-"+Mess+"-01";
                                            if (Mess.equals("1")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("2")){
                                            Fecha2 = "2015-"+Mess+"-28";
                                            }else if (Mess.equals("3")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("4")){
                                            Fecha2 = "2015-"+Mess+"-30";
                                            }else if (Mess.equals("5")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("6")){
                                            Fecha2 = "2015-"+Mess+"-30";
                                            }else if (Mess.equals("7")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("8")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("9")){
                                            Fecha2 = "2015-"+Mess+"-30";
                                            }else if (Mess.equals("10")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            }else if (Mess.equals("11")){
                                            Fecha2 = "2015-"+Mess+"-30";
                                            }else if (Mess.equals("12")){
                                            Fecha2 = "2015-"+Mess+"-31";
                                            } 
                                            ResultSet rset = con.consulta("SELECT R.F_ClaCli,U.F_NomCli,R.F_IdReq FROM tb_requerimientos R INNER JOIN tb_uniatn U ON R.F_ClaCli=U.F_ClaCli WHERE R.F_StsReq='4' AND U.F_Juris='"+Juris+"' AND R.F_FecEnt BETWEEN '"+Fecha1+"' AND '"+Fecha2+"' GROUP BY R.F_ClaCli,U.F_NomCli,R.F_IdReq;");
                                            while (rset.next()) {

                                %>
                                <tr>

                                    <td><%=rset.getString(1)%></td>
                                    <td><%=rset.getString(2)%></td>
                                    <td><%=rset.getString(3)%></td>
                                    <td>
                                        <a class="btn btn-block btn-success" href="gnrReq.jsp?fol_gnkl=<%=rset.getString(3)%>"><span class="glyphicon glyphicon-save"></span></a>
                                    </td>
                                </tr>
                                <%
                                            }
                                        } catch (Exception e) {

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
                                    
            </form>
            <div style="display: none;" class="text-center" id="Loader">
                <img src="imagenes/ajax-loader-1.gif" height="150" />
            </div>  
        <%@include file="../jspf/piePagina.jspf" %>
        <!-- 
    ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="js/jquery-1.9.1.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/jquery-ui-1.10.3.custom.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        
        <script>
       // $("#fecha_ini").datepicker({});
       // $("#fecha_fin").datepicker({});
        </script>
        <script>
       /* $(document).ready(function() {
            $("#btn_capturar").click(function() {
                var FI = $("#fecha_ini").val();
                var FF = $("#fecha_ini").val();

                if(FI =="" && FF ==""){
                    alert("Favor de Seleccionar Fechas");
                }
            });
        });*/
        function valida_alta() {
                /*var Clave = document.formulario1.Clave.value;*/
                var FI = $("#fecha_ini").val();
                var FF = $("#fecha_ini").val();

                if(FI =="" && FF ==""){
                    alert("Favor de Seleccionar Fechas");
                    return false;
                }/*else{
                    return confirm('¿Esta Ud. Seguro de Iniciar proceso de Generación?')
                }   */             
                document.getElementById('Loader').style.display = 'block';
            }
    </script>
    </body>

</html>

