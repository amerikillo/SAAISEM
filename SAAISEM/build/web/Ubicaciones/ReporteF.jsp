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
    String Usuario = "", Valida = "", Nombre = "";
    int Tipo = 0;
    
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("Usuario");
        Nombre = (String) sesion.getAttribute("nombre");
        Tipo = Integer.parseInt((String) sesion.getAttribute("Tipo"));
        System.out.println(Usuario + Nombre + Tipo);
    } else {
        response.sendRedirect("../index.jsp");
    }

%>
<html>

    <head>
        <title>Reporte proveedor por Fecha</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="ckeditor/ckeditor.js"></script>
        <link href=bootstrap/css/bootstrap.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap-combined.min.css" rel="stylesheet">
        <!--link href="css/flat-ui.css" rel="stylesheet"-->
        <!--link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet"-->
        <!--link href="css/gnkl_style_default.css" rel="stylesheet"-->
        <style type="text/css" title="currentStyle">
            @import "table_js/demo_page.css";
            @import "table_js/demo_table.css";
            @import "table_js/TableTools.css";
        </style>
        <style type="text/css">
            .container2 {
                margin-top: 30px;
                width: 400px;
                
            }
        </style>
        <script type="text/javascript" language="javascript" src="table_js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="table_js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/TableTools.js"></script>
        <script type="text/javascript" src="table_js/TableTools.min.js"></script>
        
        
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <!--div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="main_menu.jsp">Inicio</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Entradas<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../captura.jsp">Entrada Manual</a></li>
                                    <li><a href="../compraAuto2.jsp">Entrada Automática OC ISEM</a></li>
                                    <li><a href="../reimpresion.jsp">Reimpresión de Compras</a></li>
                                    <li><a href="../ordenesCompra.jsp">Órdenes de Compras</a></li>
                                    <li><a href="../kardexClave.jsp">Kardex Claves</a></li>
                                    <li><a href="Consultas.jsp">Ubicaciones</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturación<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../requerimiento.jsp">Carga de Requerimiento</a></li>
                                    <li><a href="../factura.jsp">Facturación Automática</a></li>
                                    <li><a href="../reimp_factura.jsp">Reimpresión de Facturas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../medicamento.jsp">Catálogo de Insumo para la Salud</a></li>
                                    <li><a href="../catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="../marcas.jsp">Catálogo de Marcas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Fecha Recibo<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="../Entrega.jsp">Fecha de Recibo en CEDIS</a></li>     
                                    <li><a href="../historialOC.jsp">Historial OC</a></li>                                    
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href=""><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="../index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse>
                </div>
            </div-->
            <hr/>
            <div class="container">
                <h3>Reporte por Fecha Proveedor</h3>
                <div class="row">
                    
                    <div class="row">
                        
                        <div class="col-sm-1">
                            Proveedor:
                        </div>
                        <div class="col-sm-5">
                            <select id="select" class="form-control"><option id="op">--Proveedor--</option></select>
                        </div>
                        <div class="col-sm-2">
                            Fecha de Recibo:
                        </div>
                        <div class="col-sm-2">
                            
                            <input type="text" class="form-control" data-date-format="yyyy-mm-dd" id="Fecha" name="Fecha" />
                        </div>
                    </div>
                    <br/>
                 </div>                       
            </div>
              
 
            <div id="container">                
                    <div id="demo"></div>
                    <div id="dynamic"></div>                                    
                </div>
            </div>
                    <br />
                    <h3>Total Piezas:<input type="text" id="txtf_exis" readonly="true" size="10"></h3>
            <div class="row-fluid">
                <footer class="span12">
                </footer>
            </div>

        </div>
    </body>
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script src="js/flatui-checkbox.js"></script>
    <script src="js/flatui-radio.js"></script>
    <script src="js/jquery-1.9.1"></script>
    <script src="../js/bootstrap-datepicker.js"></script>

    <script>
        $("footer").load("footer.html");
    </script>
    <script>
    $(function() {
        $("#Fecha").datepicker();
        $("#Fecha").datepicker('option', {dateFormat: 'yy/mm/dd'});
    });
</script>
    <script type="text/javascript" charset="utf-8">
        

        $(document).ready(function() {
       $("#select").click(function() {
                $("#select").click(function() {
                var Provee = $("#select").val();                
                var dir = 'jsp/consultas.jsp?ban=47&text=' + Provee + ''
                
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
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
                function MostrarFecha(data) {
                    var json = JSON.parse(data);
                    var aDataSet = [];
                    var exist = 0;
                    for (var i = 0; i < json.length; i++) {
                        var proveedor = json[i].proveedor;
                        var clave = json[i].clave;
                        var lote = json[i].lote;                        
                        var cantidad = json[i].cantidad;
                        var fecha = json[i].fecha;
                        var oc = json[i].oc;
                        var documento = json[i].documento;
                        var remision = json[i].remision;
                        var user = json[i].user;
                        var costo = json[i].costo;
                        var monto = json[i].monto;
                        exist =parseInt(cantidad)+parseInt(exist);
                        
                        var formatNumber = {
                            separador: ",", // separador para los miles
                            sepDecimal: '.', // separador para los decimales
                            formatear: function(num) {
                                num += '';
                                var splitStr = num.split('.');
                                var splitLeft = splitStr[0];
                                var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
                                var regx = /(\d+)(\d{3})/;
                                while (regx.test(splitLeft)) {
                                    splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
                                }
                                return this.simbol + splitLeft + splitRight;
                            },
                            new : function(num, simbol) {
                                this.simbol = simbol || '';
                                return this.formatear(num);
                            }
                        }
                        var numero = formatNumber.new(cantidad);
                        var numero1 = formatNumber.new(exist);
                        
                        aDataSet.push([proveedor, clave, lote, numero, fecha, oc, documento, remision, user, costo, monto]);
                    }
                    
                    
                        
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet, "button": 'aceptar',
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Proveedor", "sClass": "center"},
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Piezas", "sClass": "center"},
                                {"sTitle": "Fecha", "sClass": "center"},                                
                                {"sTitle": "O.C.", "sClass": "center"},
                                {"sTitle": "No. Ingreso", "sClass": "center"},
                                {"sTitle": "Remisión", "sClass": "center"},
                                {"sTitle": "Usuario", "sClass": "center"}
                            ]
                        });
                    });
                    
                    $("#txtf_exis").val(numero1);

                }
                });
            });
            
            $("#Fecha").click(function() {
                
                var fecha = $("#Fecha").val();                
                var dir = 'jsp/consultas.jsp?ban=49&text=' + fecha + ''
                
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
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
                function MostrarFecha(data) {
                    var json = JSON.parse(data);
                    var aDataSet = [];
                    var exist = 0;
                    for (var i = 0; i < json.length; i++) {
                        var proveedor = json[i].proveedor;
                        var clave = json[i].clave;
                        var lote = json[i].lote;                        
                        var cantidad = json[i].cantidad;
                        var fecha = json[i].fecha;
                        var oc = json[i].oc;
                        var documento = json[i].documento;
                        var remision = json[i].remision;
                        var user = json[i].user;
                        var costo = json[i].costo;
                        var monto = json[i].monto;
                        exist =parseInt(cantidad)+parseInt(exist);
                        
                        var formatNumber = {
                            separador: ",", // separador para los miles
                            sepDecimal: '.', // separador para los decimales
                            formatear: function(num) {
                                num += '';
                                var splitStr = num.split('.');
                                var splitLeft = splitStr[0];
                                var splitRight = splitStr.length > 1 ? this.sepDecimal + splitStr[1] : '';
                                var regx = /(\d+)(\d{3})/;
                                while (regx.test(splitLeft)) {
                                    splitLeft = splitLeft.replace(regx, '$1' + this.separador + '$2');
                                }
                                return this.simbol + splitLeft + splitRight;
                            },
                            new : function(num, simbol) {
                                this.simbol = simbol || '';
                                return this.formatear(num);
                            }
                        }
                        var numero = formatNumber.new(cantidad);
                        var numero1 = formatNumber.new(exist);
                        
                        aDataSet.push([proveedor, clave, lote, numero, fecha, oc, documento, remision, user, costo, monto]);
                    }
                    
                    
                        
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet, "button": 'aceptar',
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Proveedor", "sClass": "center"},
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Piezas", "sClass": "center"},
                                {"sTitle": "Fecha", "sClass": "center"},                                
                                {"sTitle": "O.C.", "sClass": "center"},
                                {"sTitle": "No. Ingreso", "sClass": "center"},
                                {"sTitle": "Remisión", "sClass": "center"},
                                {"sTitle": "Usuario", "sClass": "center"}
                            ]
                        });
                    });
                    
                    $("#txtf_exis").val(numero1);

                }
                
            });

             var dir = 'jsp/consultas.jsp?ban=48'
            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarUbi2(data);
                },
                error: function() {
                    alert("Ha ocurrido un error a");

                }

            });
            function MostrarUbi2(data) {

                var json = JSON.parse(data);
                for (var x = 0; x < json.length; x++) {
                    var proveed = json[x].proveed;                    
                    $("#select").append($("<option></option>").text(proveed).val(proveed));

                }

            }
 
            
          });
               
    </script>
    
</html>