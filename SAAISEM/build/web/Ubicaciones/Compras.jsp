<%-- 
    Document   : index
    Created on : 15/11/2013, 01:23:26 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%
HttpSession Session = request.getSession();
String Usuario="",Valida="",Tipo="";


if (Session.getAttribute("Valida") != null){
Usuario = (String)Session.getAttribute("Usuario");
Valida = (String)Session.getAttribute("Valida");
Tipo = (String) Session.getAttribute("Tipo");
}

if(!Valida.equals("Valido")){
  response.sendRedirect("index.jsp");
}

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
    <title>MARBETES TARIMAS</title>
    <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://www.datatables.net/rss.xml">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="ckeditor/ckeditor.js"></script>
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
        <link href="css/flat-ui.css" rel="stylesheet">
        <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href="css/gnkl_style_default.css" rel="stylesheet">
        <style type="text/css" title="currentStyle">
            @import "table_js/demo_page.css";
            @import "table_js/demo_table.css";
            @import "table_js/TableTools.css";
        </style>
        <script type="text/javascript" language="javascript" src="table_js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="table_js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/TableTools.js"></script>
        <script type="text/javascript" src="table_js/TableTools.min.js"></script>
</head>
<body>
	<div class="container-fluid">
    	<!-- Se carga un header para todos los archivos, ya que no varia -->
    	<div class="row-fluid">
        	<header class="span12"> 
            	<img src="img/Logo GNK claro2.jpg" class="pull-left" id="logo-savi" height="70" width="130" />
                
                <h3 class=" span6 offset1 text-center">PROYECTO TODOS LOS CEDIS</h3>	       	
                <h3 class=" span6 offset1 text-center">SISTEMA DE GENERACIÓN MARBETES TARIMAS</h3>	       	
            	<div class="row-fluid">
                    <nav class="span12">
                        <ul class="breadcrumb">
                            <li>Usted est&aacute; aqu&iacute;:</li>
                            <li><a href="index.jsp">inicio</a><span class="divider">--></span></li>
                            <li>Bienvenido Usuario:<b><%=Usuario%></b> a GENERACIÓN DE MARBETES<span class="divider">--></span></li>
                            
                        </ul>
                    </nav>
                </div>
            </header>
        </div> 
       
           <form name="form" id="form" method="post" action="/UbicacionesConsolidado/Ubicaciones">
          
               <div>
                   <h5>PROYECTO:<select name="select" id="select">
                           <option id="op">--SELECCIONE PROYECTO--</option>
                           <option id="op" value="DURANGO">DURANGO</option>
                           <option id="op" value="ISEM">ISEM</option>
                           <option id="op" value="ISSEMyM">ISSEMyM</option>
                           <option id="op" value="SEDENA">SEDENA</option>
                           <option id="op" value="TEPIC">TEPIC</option>                           
                       </select>
                       Por Folios:<input type="text" id="txtf_foliof1" name="folio1" placeholder="Ingrese Folio Inicial" size="10" class="text-center">&nbsp;AL&nbsp;<input type="text" id="txtf_foliof2" class="text-center" name="folio2" placeholder="Ingrese Folio Final" size="10">&nbsp;<input type="text" id="fecha" name="fecha" placeholder="Seleccione Fecha" class="text-center"/>&nbsp;<label class="icon-calendar"></label>&nbsp;<label class="btn btn-sm btn-primary" id="btn-buscar">Buscar&nbsp;<label class="glyphicon glyphicon-search"></label></label>&nbsp;<button class="btn btn-sm btn-primary" name="ban" value="8" >Marbete&nbsp;<label class="icon-refresh"></label></button></h5>   
               </div>               
           
        </form>
      
       <div id="container">
           <form name="form" id="form" method="post" action="/UbicacionesConsolidado/Ubicaciones">
               
               <div id="demo"></div>
               <div id="dynamic"></div>
               
           </form>
       </div>                     
        <!-- Se carga un footer para todos los archivos, ya que no varia -->
        <div class="row-fluid">
            <footer class="span12"> 
            </footer>
        </div>
        
   	</div>

    
    <!-- Cargar aquí 'js' para mejorar rendimiento -->
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script src="js/flatui-checkbox.js"></script>
    <script src="js/flatui-radio.js"></script>

    <!-- scripts aquí para mejorar rendimiento -->
    <script>
      	$("footer").load("footer.html");
    </script>
    <script type="text/javascript" charset="utf-8">
                $(document).ready(function() {	
                $("#btn-buscar").click(function(){
                    var folio1 = $("#txtf_foliof1").val();
                    var folio2 = $("#txtf_foliof2").val();
                    var conf1 = folio1.length;
                    var conf2 = folio2.length;
                    if (conf1 == 1){
                        var folios1 = "      "+folio1;
                    }else if (conf1 == 2){
                        var folios1 = "     "+folio1;
                    }else if (conf1 == 3){
                        var folios1 = "    "+folio1;
                    }else if (conf1 == 4){
                        var folios1 = "   "+folio1;
                    }else if (conf1 == 5){
                        var folios1 = "  "+folio1;
                    }else if (conf1 == 6){
                        var folios1 = " "+folio1;
                    }else if (conf1 > 6){
                        var folios1 = folio1;
                    }
                    if (conf2 == 1){
                        var folios2 = "      "+folio2;
                    }else if (conf2 == 2){
                        var folios2 = "     "+folio2;
                    }else if (conf2 == 3){
                        var folios2 = "    "+folio2;
                    }else if (conf2 == 4){
                        var folios2 = "   "+folio2;
                    }else if (conf2 == 5){
                        var folios2 = "  "+folio2;
                    }else if (conf2 == 6){
                        var folios2 = " "+folio2;
                    }else if (conf2 > 6){
                        var folios2 = folio2;
                    }
                    
                    var fecha = $("#fecha").val();
                    if((folio1 !="") && (folio2 !="") && (fecha !="")){
                       var dir = 'jsp/consultas.jsp?ban=30&folio='+folio1+'&folio2='+folio2+'&fecha1='+fecha+'' 
                    }else if((folio1 !="") && (folio2 !="")){
                       var dir = 'jsp/consultas.jsp?ban=31&folio='+folios1+'&folio2='+folios2+'' 
                    }
                    
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarFecha(data);
                        }, 
                        error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarFecha(data){
                       var json = JSON.parse(data);
                       var aDataSet =[];
                       for(var i = 0; i < json.length; i++) {
                           var clave = json[i].clave;
                           var lote = json[i].lote;
                           var caducidad = json[i].caducidad;                           
                           var cantidad = json[i].cantidad;
                          
                           var formatNumber = {
                               separador: ",", // separador para los miles
                               sepDecimal: '.', // separador para los decimales
                               formatear:function (num){
                                   num +='';
                                   var splitStr = num.split('.');
                                   var splitLeft = splitStr[0];
                                   var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
                                   var regx = /(\d+)(\d{3})/;
                                   while (regx.test(splitLeft)) {
                                       splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
                                   }
                                   return this.simbol + splitLeft  +splitRight;
                               },
                                       new:function(num, simbol){
                                   this.simbol = simbol ||'';
                                   return this.formatear(num);
                               }
                           }
                           var numero = formatNumber.new(cantidad);
                          aDataSet.push([clave,lote,caducidad,numero]);                          
                       }
                            $(document).ready(function() {
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,"button":'aceptar',
                                        //"bScrollInfinite": true,
                                        "bScrollCollapse": true,
                                        "sScrollY": "400px",
                                        "bProcessing": true,
                                        "sPaginationType": "full_numbers",
                                        "sDom": 'T<"clear">lfrtip',
                                        "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
					"aoColumns": [
						{ "sTitle": "Clave","sClass": "center" },
                                                { "sTitle": "Lote", "sClass": "center" },
						{ "sTitle": "Caducidad", "sClass": "center" },
                                                { "sTitle": "Total Piezas", "sClass": "center" }
					]
				} );	
			} );
                       
                   }
                             
                     
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
            $("#fecha").datepicker();            
        </script>
</body>
</html>


