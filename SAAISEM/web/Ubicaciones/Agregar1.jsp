<%-- 
    Document   : Redistribucion
    Created on : 21/11/2013, 08:50:58 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
HttpSession Session = request.getSession();
String Usuario="",Valida="";

if (Session.getAttribute("Valida") != null){
Usuario = (String)Session.getAttribute("Usuario");
Valida = (String)Session.getAttribute("Valida");


}

if(!Valida.equals("Valido")){
  response.sendRedirect("index.jsp");
}

%>

<html>
    <head>
        <meta charset="utf-8">
        
        <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
        <title>AGREGAR ISEM</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="ckeditor/ckeditor.js"></script>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
        <link href="css/flat-ui.css" rel="stylesheet">
        <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="css/gnkl_style_default.css" rel="stylesheet">
    </head>
    <body>
        <div class="container-fluid">
            <div class="row-fluid">
                <header class="span12"> 
                    <img src="img/Logo GNK claro2.jpg" class="pull-left" id="logo-savi" height="70" width="140" />
                    <h3 class=" span6 offset1 text-center">PROYECTO ISEM</h3>	       	
                    <h3 class=" span6 offset1 text-center">SISTEMA UBICACIONES Y REDISTRIBUCIÓN</h3>	       	
                    <div class="row-fluid">
                        <nav class="span12">
                            <ul class="breadcrumb">
                                <li>Usted est&aacute; aqu&iacute;:</li>
                                <li><a href="index.jsp">inicio</a><span class="divider">-></span></li>
                                <li><a href="TomaInv.jsp">Consultas toma de inventario</a><span class="divider">-></span></li>
                                <li>Agregar clave al inventario<span class="divider"></span></li>
                            </ul>
                        </nav>
                    </div>
                </header>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div><h5>Ingresa Clave:<input type="text" id="txtf_clave" placeholder="Ingrese Clave" size="10" class="text-center">&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button></h5></div>
            </div>
        </div>
        <div class="container">
            <form id="form" name="form" method="post" action="/UbicacionesConsolidado/Ubicaciones">
            <table class="table">
                <tbody>
                    <tr>
                        <th>Clave:</th><td><input type="text" id="clave" name="clave" placeholder="" readonly="" class="text-center" /></td>
                    </tr>
                    <tr>
                        <th>Descripción:</th><td id="descripcion"></td>
                    </tr>
                    <tr>
                        <th>Lote</th><td><input type="text" id="lote" name="lote" placeholder="" class="text-center"/></td><td><select id="selectl">
                                    <option id="op">--Lote--</option>
                              </select></td>
                    </tr>
                    <tr>
                        <th>Caducidad</th><td><input type="text" id="caducidad" name="caducidad" placeholder="" readonly="" class="text-center"/>&nbsp;<label class="icon-calendar icon-2x"></label></td><td><select id="selectCadu">
                                    <option id="op">--Caducidad--</option>
                              </select></td>
                    </tr>
                    
                    
                    <tr>
                        <th>Ubicación</th><td><input type="text" id="actual" name="ubin" value="" placeholder="" readonly="" class="text-center"/></td><td><select id="select">
                                    <option id="op">--Ubicación--</option>
                              </select></td>
                    </tr>
                    <tr>
                        <th>Piezas x Cajas</th><td><input type="text" id="piezas" name="piezas" placeholder="" class="text-center"  value="0"/></td><td><select id="selectPiezas">
                                    <option id="op">--Piezas--</option>
                              </select></td>
                    </tr>
                    <tr>
                        <th>Cajas</th><td><input type="text" id="cajas" name="cajasm" placeholder=""  value="0" class="text-center" /></td>
                    </tr>
                    <tr>
                        <th>Resto</th><td><input type="text" id="resto" name="restom" placeholder="" value="0" class="text-center" /></td>
                    </tr>
                    <tr>
                        <th>Existencia PZ</th><td id="exist"></td>
                    </tr>
                        
                </tbody>
                    
                <tr><td colspan="3"><button id="btn-modificar" class="btn btn-primary btn-block" name="ban" value="4">Agregar&nbsp;<label class="icon-refresh"></label></button></td></tr>
                
             </table>
            </form>
        </div>
        <div class="row-fluid">
            <footer class="span12">
            </footer>
        </div>
        <script src="js/jquery-1.8.3.min.js"></script>
        <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
        <script src="js/jquery.ui.touch-punch.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.placeholder.js"></script>
        <script src="js/bootstrap-select.js"></script>
        <script src="js/bootstrap-switch.js"></script>
        <script src="js/flatui-checkbox.js"></script>
        <script src="js/flatui-radio.js"></script>
        <script>
		// cargar header y footer
		$("footer").load("footer.html");
	</script>
        <script>
            $(document).ready(function(){
                $("#btn-buscar").click(function(){
                    var clave = $("#txtf_clave").val();
                    var dir = 'jsp/consultasM.jsp?ban=11&clave='+clave+''
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos(data){
                        json = JSON.parse(data);
                           $("#clave").val(json.clave);
                           $("#descripcion").text(json.descripcion);
                                              
                   } 
                  
                });

                });
        </script>
        <script>
            $(document).ready(function(){
                $("#btn-buscar").click(function(){
                    var clave = $("#txtf_clave").val();
                    var dir = 'jsp/consultasM.jsp?ban=14&clave='+clave+''                   
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos(data){
                       var json = JSON.parse(data);
                       for(var x = 0; x < json.length; x++){
                           $("#selectl").append($("<option></option>").text(json[x].lote).val(json[x].lote));
                       }
                       
                   } 
                });

                });
        </script>
        <script>
            $(document).ready(function(){
                $("#btn-buscar").click(function(){
                    var clave = $("#txtf_clave").val();
                    var dir = 'jsp/consultasM.jsp?ban=15&clave='+clave+''                   
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos(data){
                       var json = JSON.parse(data);
                       for(var x = 0; x < json.length; x++){
                           $("#selectCadu").append($("<option></option>").text(json[x].cadu).val(json[x].cadu));
                       }
                       
                   } 
                });

                });
        </script>
        
         <script>
            $(document).ready(function(){
                $("#btn-buscar").click(function(){
                    var clave = $("#txtf_clave").val();
                    var dir = 'jsp/consultasM.jsp?ban=18&clave='+clave+''                   
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos(data){
                       var json = JSON.parse(data);
                       for(var x = 0; x < json.length; x++){
                           $("#selectPiezas").append($("<option></option>").text(json[x].piezas).val(json[x].piezas));
                       }
                       
                   } 
                });

                });
        </script>
         <script>
            $(document).ready(function(){
               
                   var dir = 'jsp/consultasM.jsp?ban=10'
                   $.ajax({
                      url: dir,
                      type: 'json',
                      async: false,
                      success: function(data){
                          MostrarUbi(data);
                       }, 
                        error: function() {
                                alert("Ha ocurrido un error");	

                        }
                        
                   });
                   function MostrarUbi(data){
                 
                         var json = JSON.parse(data);
                         for(var x = 0; x < json.length; x++){
                             var claubi = json[x].claubi;
                             var desubi = json[x].desubi;
                             $("#select").append($("<option></option>").text(desubi).val(claubi));
                             
                         }
                         
                        }
                 
                 $('#select').change(function(){
                     var valor = $('#select').val();
                     $('#actual').val(valor);
                 });
                 $("#btn-lote").click(function(){
                     self.location='AgregarLote.jsp';
                });
                $('#selectl').change(function(){
                     var valor = $('#selectl').val();
                     $('#lote').val(valor);
                 });
                 $('#selectCadu').change(function(){
                     var valor = $('#selectCadu').val();
                     $('#caducidad').val(valor);
                 });
                 $('#selectFabrica').change(function(){
                     var valor = $('#selectFabrica').val();
                     $('#fabricacion').val(valor);
                 });
                 $('#selectMarca').change(function(){
                     var valor = $('#selectMarca').val();
                     $('#marca').val(valor);
                 });
                 $('#selectPiezas').change(function(){
                     var valor = $('#selectPiezas').val();
                     $('#piezas').val(valor);
                 });
            });         
        </script>
       <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
	<script src="jquery-1.9.0.js"></script>
	<script src="ui/jquery.ui.core.js"></script>
	<script src="ui/jquery.ui.widget.js"></script>
	<script src="ui/i18n/jquery.ui.datepicker-es.js"></script>
	<script src="ui/jquery.ui.datepicker.js"></script>
	
        <script>
            $("#caducidad").datepicker();            
        </script>
    </body>
</html>
