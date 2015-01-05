<%-- 
    Document   : index
    Created on : 15/11/2013, 01:23:26 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
    <title>Marbetes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta content="Plugin Gratis para autocompletar un input con jQuery y Ajax" name="description" />
    <!-- Cargar CSS aquí -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/gnkl_style_default.css" rel="stylesheet">
    
    <link rel="stylesheet" href="js_auto/jquery-ui.css">
    <script src="js_auto/jquery-1.9.1.js"></script>
    <script src="js_auto/jquery-ui.js"></script>
    <link rel="stylesheet" href="js_auto/style.css">
    
    <!-- Este script se encarga de lidiar con versiones anteriores de IE -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	<div class="container-fluid">
    	<!-- Se carga un header para todos los archivos, ya que no varia -->
    	<div class="row-fluid">
        	<header class="span12"> 
            	<img src="img/Logo GNK claro2.jpg" class="pull-left" id="logo-savi" height="70" width="130" />
                
                <h3 class=" span6 offset1 text-center">PROYECTO COMPRA CONSOLIDADA</h3>	       	
                <h3 class=" span6 offset1 text-center">SISTEMA DE MARBETES PUNTO DE ENTREGA</h3>	       	
            	<div class="row-fluid">
                    <nav class="span12">
                        <ul class="breadcrumb">
                            <li>Usted est&aacute; aqu&iacute;:</li>
                           
                            <li>inicio gENERACIÓN DE MARBETES<span class="divider">--></span></li>
                            
                        </ul>
                    </nav>
                </div>
            </header>
        </div> 
        
        
        <!-- Se carga un footer para todos los archivos, ya que no varia -->
        <div class="row-fluid">
            <footer class="span12"> 
            </footer>
        </div>
        
   	</div>
    <div class="container">
        <div class="row-fluid">
            <div class="text-center">
                <h3>Introduzca los siguientes datos</h3>
            </div>
            <form id="form" name="form" method="post" action="../ServletK">
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <th>Nombre Unidad</th><td><input type="text" name="nombre" id="nombre" onKeyUp="Unidad()" placeholder="Ingrese Nombre Unidad"/><datalist id="Unidades"></datalist></td>
                    </tr>
                     <tr>
                         <th>Folio</th><td><input type="text" name="folio" id="folio" placeholder="Ingrese Folio Documento"/></td>
                    </tr>
                     <tr>
                         <th>Número de Tarimas</th><td><input type="text" name="cajasm" id="cajasm" placeholder="Ingrese Número de Marbetes"/></td>
                    </tr>
                </tbody>                
                     <tr>
                         <td colspan="2"><button class="btn btn-block btn-primary" name="ban" value="7">Generar</button></td>
                    </tr>
            </table>
            </form>
       	</div>
    </div>

    
    <!-- Cargar aquí 'js' para mejorar rendimiento -->
    
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>

    <!-- scripts aquí para mejorar rendimiento -->
    <script>
      	$("footer").load("footer.html");
    </script>
           
    <script>
        function Unidad(){
           var text = $("#nombre").val();
            var dir = 'jsp/consultas.jsp?ban=28&text='+text+''
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
                       var x = 0;
                       
                       var json = JSON.parse(data);
                       for(var i = 0; i < json.length; i++) {
                           x++;
                           var uni = json[i].unidad;
                       
                           if (x < json.length){
                               if (x == 1){
                                   var unid1 = uni;
                               }else if (x == 2){
                               var unid2 = uni;
                               }else if (x == 3){
                               var unid3 = uni;
                               }else if (x == 4){
                               var unid4 = uni;
                               }else if (x == 5){
                               var unid5 = uni;
                               }else if (x == 6){
                               var unid6 = uni;
                               }else if (x == 7){
                               var unid7 = uni;
                               }else if (x == 8){
                               var unid8 = uni;
                               }else if (x == 9){
                               var unid9 = uni;
                               }
                           }else{
                              var unid10 = uni;
                           }
                           if (json.length == 1){
                               var availableTags = [unid10];
                           }else if (json.length == 2){
                               var availableTags = [unid1,unid10];
                           }else if (json.length == 3){
                               var availableTags = [unid1,unid2,unid10];
                           }else if (json.length == 4){
                               var availableTags = [unid1,unid2,unid3,unid10];
                           }else if (json.length == 5){
                               var availableTags = [unid1,unid2,unid3,unid4,unid10];
                           }else if (json.length == 6){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid10];
                           }else if (json.length == 7){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid10];
                           }else if (json.length == 8){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid10];
                           }else if (json.length == 9){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid8,unid10];
                           }else if (json.length == 10){
                               var availableTags = [unid1,unid2,unid3,unid4,unid5,unid6,unid7,unid8,unid9,unid10];
                           } 
                               
                           
                           
                           $( "#nombre" ).autocomplete({
                               source: availableTags
                           }); 

                       }  
        }
        
        };
    
    </script>
    
    <script>
            $("#form").submit(function (){
                 
                 var missinginfo = "";
                 if ($("#nombre").val()==""){missinginfo += "\n El campo Nombre Unidad no debe de estar vacío.";}
                 if ($("#folio").val()==""){missinginfo += "\n El campo Folio no debe de estar vacío.";}
                 if ($("#cajasm").val()==""){missinginfo += "\n El campo Marbetes no debe de estar vacío.";}
                 if (missinginfo != ""){
                     missinginfo = "\n TE HA FALTADO INTRODUCIR LOS SIGUIENTES DATOS PARA ENVIAR PETICIÓN DE SOPORTE:\n" + missinginfo + "\n\n ¡INGRESA LOS DATOS FALTANTES Y TRATA OTRA VEZ!\n";
                     alert(missinginfo);
                     return false;
                 }else{
                     return true;
                 }
                 
             });
        </script>
		

</body>
</html>


