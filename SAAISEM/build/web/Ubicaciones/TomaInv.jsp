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
    <title>INVENTARIO ISEM</title>
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
                
                <h3 class=" span6 offset1 text-center">PROYECTO ISEM</h3>	       	
                <h3 class=" span6 offset1 text-center">SISTEMA DE UBICACIONES Y REDISTRIBUCIÓN</h3>	       	
            	<div class="row-fluid">
                    <nav class="span12">
                        <ul class="breadcrumb">
                            <li>Usted est&aacute; aqu&iacute;:</li>
                            <li><a href="index.jsp">inicio</a><span class="divider">--></span></li>
                            <li>Bienvenido Usuario:<b><%=Usuario%></b> a Toma de inventario<span class="divider">--></span></li>
                            
                        </ul>
                    </nav>
                </div>
            </header>
        </div> 
       <div class="container">
           <div class="row">
               <div hidden="true">
                   <input type="text" id="usuario" value="<%=Usuario%>" readonly="" placeholder="" />
               </div>
               <div>
                   <h5>Por Clave:<input type="text" id="txtf_clave" placeholder="Ingrese Clave" size="10">&nbsp;&nbsp;&nbsp;Por Lote<input type="text" id="txtf_lote" placeholder="Ingrese Lote" size="10">&nbsp;&nbsp;&nbsp;Por CB<input type="text" id="txtf_cb" placeholder="Ingrese Concepto" size="10"><br /></h5>   
               </div>
               <div class="text-center">
                   
                   <button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-inv">AGREGAR CLAVE&nbsp;<label class="icon-th-list"></label></button>  
                   
               </div>
           </div>
       </div>
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
                    var usuario = $("#usuario").val();
                    var clave = $("#txtf_clave").val();
                    var lote = $("#txtf_lote").val();
                    var cb = $("#txtf_cb").val();
                    
                    if((clave !="") && (lote !="") && (cb !="")){
                       var dir = 'jsp/consultasM.jsp?ban=19&cb='+cb+'&clave='+clave+'&lote='+lote+'&usuario='+usuario+'' 
                    }else if((clave !="") && (lote !="")){
                       var dir = 'jsp/consultasM.jsp?ban=20&clave='+clave+'&lote='+lote+'&usuario='+usuario+'' 
                    }else if((clave !="") && (cb !="")){
                       var dir = 'jsp/consultasM.jsp?ban=21&clave='+clave+'&cb='+cb+'&usuario='+usuario+'' 
                    }else if((lote !="") && (cb !="")){
                       var dir = 'jsp/consultasM.jsp?ban=22&lote='+lote+'&cb='+cb+'&usuario='+usuario+'' 
                    }else if((clave !="")){
                       var dir = 'jsp/consultasM.jsp?ban=23&clave='+clave+'&usuario='+usuario+'' 
                    }else if((lote !="")){
                       var dir = 'jsp/consultasM.jsp?ban=24&lote='+lote+'&usuario='+usuario+'' 
                    }else if((cb !="")){
                       var dir = 'jsp/consultasM.jsp?ban=25&cb='+cb+'&usuario='+usuario+'' 
                    }
                    
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            limpiarTabla();
                            MostrarFecha(data);
                        }, 
                        error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function limpiarTabla() {
                            $(".table tr:not(.cabecera)").remove();
                        }
                   function MostrarFecha(data){
                       var json = JSON.parse(data);
                       var aDataSet =[];
                       for(var i = 0; i < json.length; i++) {
                           var clave = json[i].clave;
                           var lote = json[i].lote;
                           var caducidad = json[i].caducidad;
                           var cantidad = json[i].cantidad;
                           var ubicacion = json[i].ubicacion;
                           var id = json[i].id;
                           var piezas = json[i].piezas;
                           var ubicacion = json[i].ubicacion;
                           var cajas=parseInt(cantidad/piezas);
                           var modificar ='<button id="folio" name="folio" value='+id+"/2"+'>Eliminar<input type=hidden value=5 id=ban name=ban /></button>';
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
                          aDataSet.push([clave,lote,caducidad,cajas,numero,ubicacion,modificar]);                          
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
                                                { "sTitle": "Cajas", "sClass": "center" },
                                                { "sTitle": "Total Piezas", "sClass": "center" },
                                                { "sTitle": "Ubicación", "sClass": "center" },
                                                { "sTitle": "ReUbicar", "sClass": "center" },
                                                
					]
				} );	
			} );
                       
                      
                       $("#txtf_clave").val(null);
                       $("#txtf_lote").val(null);
                       $("#txtf_cb").val(null);
                       
                   }
                             
                     
                });
                
                
                $("#btn-inv").click(function(){
                self.location='Agregar.jsp';
                });
                
            });
        </script>
         
</body>
</html>


