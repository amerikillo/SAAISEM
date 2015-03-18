<%-- 
    Document   : tabla
    Created on : 28/11/2013, 09:35:40 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
HttpSession Session = request.getSession();
String Usuario="",Valida="",Nombre="";

if (Session.getAttribute("Valida") != null){
Usuario = (String)Session.getAttribute("Usuario");
Nombre = (String)Session.getAttribute("Nombre");
Valida = (String)Session.getAttribute("Valida");
}

if(!Valida.equals("Valido")){
  response.sendRedirect("index.jsp");
}

%>
<html>
    <head>
        <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
        <title>CONSULTA KARDEX ISEM</title>
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
	<body id="dt_example">
            <div class="container-fluid">
                <div class="row-fluid">
                <header class="span12"> 
            	<img src="img/Logo GNK claro2.jpg" class="pull-left" id="logo-savi" height="70" width="170" />
                <h3 class="span6 offset1 text-center">KARDEX SISTEMA SGWGNKL ISEM</h3>	       	
                <div class="row-fluid">
                    <nav class="span12">
                        <ul class="breadcrumb">
                            <li>Usted est&aacute; aqu&iacute;:</li>
                            <li><a href="index.jsp">inicio</a><span class="divider">-></span></li>
                            <li><a href="Consultas.jsp">cONSULTA MEDICAMENTO/MATERIAL DE CURACIÓN</a><span class="divider">-></span></li>
                            <li>Bienvenido Usuario:<b><%=Nombre%></b> a Consulta KARDEX<span class="divider"></span></li>
                        </ul>
                    </nav>
                </div>
                </header>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div>
                        <h5>Rango de fechas del:&nbsp;&nbsp;<input name="txtf_caduc" type="text" id="datepicker" placeholder="Seleccione fecha" size="10" readonly title="dd/mm/aaaa">&nbsp;&nbsp;al&nbsp;&nbsp;<input name="txtf_caduci" type="text" placeholder="Seleccione fecha" id="datepicker1" size="10" readonly title="dd/mm/aaaa">
                            <br />Por Clave:<input name="txtf_clave" type="text" id="txtf_clave" placeholder="Ingrese Clave" size="10">&nbsp;&nbsp;&nbsp;Por Lote<input name="txtf_lote" type="text" id="txtf_lote" placeholder="Ingrese Lote" size="10">&nbsp;&nbsp;&nbsp;Por Concepto<input name="txtf_con" type="text" id="txtf_con" placeholder="Ingrese Concepto" size="10"><br /></h5>   
                    </div>
                    <div class="text-center">
                        <button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>  
                    </div>
                </div>
            </div>
            <div id="container">
               <div id="demo"></div>
               <div id="dynamic"></div>
            </div>
            <div class="row-fluid">
                <footer class="span12">
                </footer>
            </div>
            <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
            <script src="js/jquery.ui.touch-punch.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/jquery.placeholder.js"></script>
            <script src="js/bootstrap-select.js"></script>
            <script src="js/bootstrap-switch.js"></script>
            <script src="js/flatui-checkbox.js"></script>
            <script src="js/flatui-radio.js"></script>
            <script>
		$("footer").load("footer.html");
            </script>
            <script type="text/javascript" charset="utf-8">
                $(document).ready(function() {	
                $("#btn-buscar").click(function(){
                    var fecha = $("#datepicker").val();
                    var fecha1 = $("#datepicker1").val();
                    var clave = $("#txtf_clave").val();
                    var lote = $("#txtf_lote").val();
                    var concepto = $("#txtf_con").val();
                    if((fecha !="") && (fecha1 !="") && (clave !="") && (lote !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=2&fecha1='+fecha+'&fecha2='+fecha1+'&clave='+clave+'&lote='+lote+'&concepto='+concepto+''                      
                    }else if((fecha !="") && (fecha1 !="") && (clave !="") && (lote !="")){
                       var dir = 'jsp/consultas.jsp?ban=3&fecha1='+fecha+'&fecha2='+fecha1+'&clave='+clave+'&lote='+lote+'' 
                    }else if((fecha !="") && (fecha1 !="") && (clave !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=4&fecha1='+fecha+'&fecha2='+fecha1+'&clave='+clave+'&concepto='+concepto+'' 
                    }else if((fecha !="") && (fecha1 !="") && (lote !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=5&fecha1='+fecha+'&fecha2='+fecha1+'&lote='+lote+'&concepto='+concepto+'' 
                    }else if((fecha !="") && (fecha1 !="") && (clave !="")){
                       var dir = 'jsp/consultas.jsp?ban=6&fecha1='+fecha+'&fecha2='+fecha1+'&clave='+clave+'' 
                    }else if((fecha !="") && (fecha1 !="") && (lote !="")){
                       var dir = 'jsp/consultas.jsp?ban=7&fecha1='+fecha+'&fecha2='+fecha1+'&lote='+lote+'' 
                    }else if((fecha !="") && (fecha1 !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=8&fecha1='+fecha+'&fecha2='+fecha1+'&concepto='+concepto+'' 
                    }else if((clave !="") && (lote !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=16&clave='+clave+'&lote='+lote+'&concepto='+concepto+'' 
                    }else if((clave !="") && (lote !="")){
                       var dir = 'jsp/consultas.jsp?ban=9&clave='+clave+'&lote='+lote+'' 
                    }else if((clave !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=10&clave='+clave+'&concepto='+concepto+'' 
                    }else if((lote !="") && (concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=11&lote='+lote+'&concepto='+concepto+'' 
                    }else if((fecha !="") && (fecha1 !="")){
                       var dir = 'jsp/consultas.jsp?ban=12&fecha1='+fecha+'&fecha2='+fecha1+'' 
                    }else if((clave !="")){
                       var dir = 'jsp/consultas.jsp?ban=13&clave='+clave+'' 
                    }else if((lote !="")){
                       var dir = 'jsp/consultas.jsp?ban=14&lote='+lote+'' 
                    }else if((concepto !="")){
                       var dir = 'jsp/consultas.jsp?ban=15&concepto='+concepto+'' 
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
                       var cadena ="";
                       var aDataSet =[];
                       for(var i = 0; i < json.length; i++) {
                           var fecha = json[i].fecha;
                           var concepto = json[i].concepto;
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
                          aDataSet.push([fecha,concepto,clave,lote,caducidad,numero]);                          
                       }
                            $(document).ready(function() {
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
                                        //"bScrollInfinite": true,
                                        "bScrollCollapse": true,
                                        "sScrollY": "400px",
                                        "bProcessing": true,
                                        "sPaginationType": "full_numbers",
                                        "sDom": 'T<"clear">lfrtip',
                                        "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
					"aoColumns": [
						{ "sTitle": "Fecha Mov","sClass": "center" },
						{ "sTitle": "Concepto","sClass": "center" },
						{ "sTitle": "Clave","sClass": "center" },
						{ "sTitle": "Lote", "sClass": "center" },
						{ "sTitle": "Caducidad", "sClass": "center" },
                                                { "sTitle": "Cantidad", "sClass": "center" }
					]
				} );	
			} );
                       
                       $("#datepicker").val(null);
                       $("#datepicker1").val(null);
                       $("#txtf_clave").val(null);
                       $("#txtf_lote").val(null);
                       $("#txtf_con").val(null);
                       
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
	<link rel="stylesheet" href="themes/demos.css">
        <script>
            $(document).ready(function() {	
                var dir = 'jsp/consultas.jsp?ban=1'
               $.ajax({
                      url: dir,
                      type: 'json',
                      async: false,
                      success: function(data){
                          MostrarFolioFecha(data);
                       }, 
                        error: function() {
                                alert("Ha ocurrido un error");	

                        }
                   });
                   
                   function MostrarFolioFecha(data){
                       json = JSON.parse(data);
                       var a1 = json.a1;
                       var d1 = json.d1;
                       var m1 = json.m1;
                       var a2 = json.a2;
                       var d2 = json.d2;
                       var m2 = json.m2;
                       var ft1 = d1+"/"+m1+"/"+a1;
                       $( "#datepicker" ).datepicker({
                           changeMonth: true,
                           changeYear: true,
                           showOn: "button",
                           buttonImage: "img/calendar.gif",
                           buttonImageOnly: true,
                           defaultDate: ft1,
                           minDate:new Date(a1, m1 - 1, d1),
                           maxDate:new Date(a2, m2 - 1, d2),
                       });
                       $( "#datepicker1" ).datepicker({
                           changeMonth: true,
                           changeYear: true,
                           showOn: "button",
                           buttonImage: "img/calendar.gif",
                           buttonImageOnly: true,
                           minDate:new Date(a1, m1 - 1, d1),
                           maxDate:new Date(a2, m2 - 1, d2),
                       }); 
                   }
               });
        </script>
        </body>
</html>