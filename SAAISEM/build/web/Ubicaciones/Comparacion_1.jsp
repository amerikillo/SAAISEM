<%-- 
    Document   : tabla
    Created on : 28/11/2013, 09:35:40 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession();
    String usua = "";
    String Usuario = "", Valida = "", Nombre = "", Contador = "";
    int Tipo = 0;

    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("Usuario");
        Nombre = (String) sesion.getAttribute("nombre");
        Tipo = Integer.parseInt((String) sesion.getAttribute("Tipo"));
        System.out.println(Usuario + Nombre + Tipo);
    } else {
        response.sendRedirect("index.jsp");
    }
    String Folio = (String) sesion.getAttribute("folio");
    String ubicac1 = (String) sesion.getAttribute("ubicacion");
    String id = (String) sesion.getAttribute("id");

%>
<html>
    
    <head>
        <link rel="shortcut icon" type="image/ico" href="img/Logo GNK claro2.jpg">
        <title>COMPARACIÓN</title>
        <link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="http://www.datatables.net/rss.xml">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        
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
               <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4> 
            </div>
            <div class="container">
                <div class="row">
                    
                    <div>                        
                    
                 Global:<select id="selectG">
                     <option>-Seleccione-</option>
                     <option value="CLAVE">CLAVE</option>
                     <option value="LOTE">LOTE</option>                     
                 </select>   
                 <button class="btn btn-sm btn-primary" id="btn-mostrar">MOSTRAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>
                    </div>
                   
                    
                </div>
            </div>
            <div id="loading" class="text-center"></div>
            <div id="container">
                <form name="form" id="form" method="post">
               <div id="demo"></div>
               <div id="dynamic"></div>
                </form>
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
                    $("#btn-mostrar").click(function(){
                       
                    var user = "admin";
                    var global = $("#selectG").val();
                    
                  if(global =="CLAVE"){
                      
                       var dir = 'jsp/consultas.jsp?ban=56&text='+global+'&usuario='+user+''
                      // alert(dir);
                                
                    
                    
                   //alert(dir);
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
                    
                     $('#loading').html('<img src="img/ajax-loader-1.gif" width="10%" height="10%">');
                
                        $.ajax({
                            url: dir,
                                type: 'json',
                                async: false,
                            success: function (d) {
                                setTimeout(function () {                        
                                    $('#loading').html('');
                                }, 2000);
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
                           var cantidadu = json[i].cantidadu;
                           var cantidads = json[i].cantidads;
                           var diferencia = json[i].dife;
                           
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
                           var numero = formatNumber.new(cantidadu);
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
                           var numeros = formatNumber.new(cantidads);
                           
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
                           var diferencias = formatNumber.new(diferencia);
                           
                               aDataSet.push([clave,numero,numeros,diferencias]);                               
                           
                                                    
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
						{ "sTitle": "CLAVE","sClass": "center" },						
						{ "sTitle": "SISTEMA", "sClass": "center" },
                                                { "sTitle": "INVENTARIO", "sClass": "center" },
                                                { "sTitle": "DIFERENCIAS", "sClass": "center" }
					]
				} );	
			} );
                        
                                              
                   }
                   
                  }else if(global =="LOTE"){
                      
                       var dir = 'jsp/consultas.jsp?ban=56&text='+global+'&usuario='+user+''
                      // alert(dir);
                    
                   //alert(dir);
                      $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            limpiarTabla2();
                            MostrarFecha2(data);
                        }, 
                        error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                    
                     $('#loading').html('<img src="img/ajax-loader-1.gif" width="10%" height="10%">');
                
                        $.ajax({
                            url: dir,
                                type: 'json',
                                async: false,
                            success: function (d) {
                                setTimeout(function () {                        
                                    $('#loading').html('');
                                }, 2000);
                            }
                            });
                            
                   function limpiarTabla2() {
                            $(".table tr:not(.cabecera)").remove();
                        }
                   function MostrarFecha2(data){
                       var json = JSON.parse(data);
                       var aDataSet =[];
                       for(var i = 0; i < json.length; i++) {
                           var clave = json[i].clave;
                           var lote = json[i].lote;
                           var fecha = json[i].fecha;
                           var cantidadu = json[i].cantidadu;
                           var cantidads = json[i].cantidads;
                           var diferencia = json[i].dife;
                           
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
                           var numero = formatNumber.new(cantidadu);
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
                           var numeros = formatNumber.new(cantidads);
                           
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
                           var diferencias = formatNumber.new(diferencia);
                           
                               aDataSet.push([clave,lote,fecha,numero,numeros,diferencias]);                               
                           
                                                    
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
						{ "sTitle": "CLAVE","sClass": "center" },
                                                { "sTitle": "LOTE","sClass": "center" },
                                                { "sTitle": "CADUCIDAD","sClass": "center" },
						{ "sTitle": "SISTEMA", "sClass": "center" },
                                                { "sTitle": "INVENTARIO", "sClass": "center" },
                                                { "sTitle": "DIFERENCIAS", "sClass": "center" }
					]
				} );	
			} );
                        
                                              
                   }
                  
                  }
                     
                });
                
                });
        </script>

        </body>
</html>