<%-- 
    Document   : tabla
    Created on : 28/11/2013, 09:35:40 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession();
    String usua = "", tipo = "";
    String Usuario = "", Valida = "", Nombre = "";
    int Tipo = 0;
    
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("Usuario");
        Nombre = (String) sesion.getAttribute("nombre");
        Tipo = Integer.parseInt((String) sesion.getAttribute("Tipo"));
        tipo = (String) sesion.getAttribute("Tipo");
        System.out.println(Usuario + Nombre + Tipo);
    } else {
        response.sendRedirect("SAA/index.jsp");
    }

%>
<html>

    <head>
        <title>CONSULTAS ISEM</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="ckeditor/ckeditor.js"></script>
        <link href=bootstrap/css/bootstrap.css" rel="stylesheet">
        <!--link href="css/flat-ui.css" rel="stylesheet"-->
        <!--link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet"-->
        <!--link href="css/gnkl_style_default.css" rel="stylesheet"-->
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
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <div class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span clss="icon-bar"></span>
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
                                    <%
                                        if (tipo.equals("2") || tipo.equals("3") || tipo.equals("1")) {
                                    %>

                                    <li><a href="captura.jsp">Entrada Manual</a></li>
                                    <li><a href="compraAuto2.jsp">Entrada Automática OC ISEM</a></li>
                                    <li class="divider"></li>
                                    <li><a href="hh/compraAuto3.jsp">HANDHELD | Entrada Automática OC ISEM</a></li>
                                    <li class="divider"></li>
                                        <%
                                            }
                                            if (tipo.equals("2") || tipo.equals("3") || tipo.equals("5")) {
                                        %>
                                    <li><a href="verificarCompraAuto.jsp">Verificar OC</a></li>
                                        <%
                                            }
                                        %>
                                    <li><a href="#" onclick="window.open('reimpresion.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Reimpresión de Compras</a></li>
                                    <li><a href="#"  onclick="window.open('ordenesCompra.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Órdenes de Compras</a></li>
                                    <li><a href="#"  onclick="window.open('kardexClave.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Kardex Claves</a></li>
                                    <li><a href="#"  onclick="window.open('Ubicaciones/Consultas.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Ubicaciones</a></li>
                                    <li><a href="#"  onclick="window.open('creaMarbetes.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Generar Marbetes</a></li>
                                    
                                        <%
                                            if (tipo.equals("5") || tipo.equals("3")) {
                                        %>
                                    <li class="divider"></li>
                                    <li><a href="hh/insumoNuevoRedist.jsp">Redistribución HH</a></li>
                                    <li class="divider"></li>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (usua.equals("oscar")) {
                                        %>
                                    <li class="divider"></li>
                                    <li><a href="#"  onclick="window.open('devolucionesInsumo.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Cambio Físico</a></li>
                                    <li class="divider"></li>
                                        <%
                                            }
                                        %>
                                    <li><a href="#"  onclick="window.open('Ubicaciones/index_Marbete.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Marbete de Salida</a></li>
                                    <li><a href="#"  onclick="window.open('Ubicaciones/index_Marbete_resto.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Marbete de Resto</a></li>
                                    <!--li><a href="#"  onclick="window.open('verDevolucionesEntrada.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Imprimir Devoluciones</a></li>
                                    <li><a href="#"  onclick="window.open('devolucionesInsumo.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Devolver</a></li-->
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturación<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <%
                                        if (tipo.equals("7") || tipo.equals("3")) {
                                    %>
                                    <li><a href="requerimiento.jsp">Carga de Requerimiento</a></li>
                                    <li><a href="factura.jsp">Facturación Automática</a></li>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (tipo.equals("5") || tipo.equals("3") || tipo.equals("7") || tipo.equals("2")) {
                                        %>
                                    <li><a href="validacionSurtido.jsp">Validación Surtido</a></li>
                                    <li><a href="validacionAuditores.jsp">Validación Auditores</a></li>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (tipo.equals("7")) {
                                        %>
                                    <li><a href="remisionarCamion.jsp">Generar Remisiones</a></li>
                                    <li><a href="facturacionManual.jsp">Facturación Manual</a></li>
                                        <%
                                            }
                                        %>
                                    <li><a href="reimp_factura.jsp">Administrar Remisiones</a></li>
                                    <li><a href="reimpConcentrado.jsp">Reimpresión Concentrados Globales</a></li>
                                    <li><a href="comparativoGlobal.jsp">Comparativo Global</a></li>

                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inventario<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#"  onclick="window.open('Ubicaciones/Inventario.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Inventario</a></li>
                                        <%
                                            if (tipo.equals("5") || tipo.equals("3") || tipo.equals("7") || tipo.equals("2")) {
                                        %>
                                    <li><a href="#"  onclick="window.open('movimientosUsuarioInventario.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Movimientos por Usuario</a></li>
                                    <li><a href="#"  onclick="window.open('semaforo.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Semaforización</a></li>
                                        <%
                                            }
                                        %>
                                    <li><a href="#"  onclick="window.open('invenCiclico/nuevoInventario.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Inventario Ciclico</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="window.open('medicamento.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Catálogo de Medicamento</a></li>
                                    <li><a href="#" onclick="window.open('catalogo.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Catálogo de Proveedores</a></li>
                                    <li><a href="#" onclick="window.open('marcas.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Catálogo de Marcas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reportes<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#" onclick="window.open('Entrega.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Fecha de Recibo en CEDIS</a></li> 
                                    <li><a href="#" onclick="window.open('historialOC.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Historial OC</a></li>
                                    <li><a href="#" onclick="window.open('ReporteF.jsp', '', 'width=1200,height=800,left=50,top=50,toolbar=no')">Reporte por Fecha Proveedor</a></li>

                                </ul>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="row">
                        <div class="col-lg-1">
                            Fecha:
                        </div>
                        <div class="col-lg-2">
                            <input type="text" id="txtf_clave" class="form-control" placeholder="Fecha Inicial" size="10">
                        </div>
                        <div class="col-lg-2">
                            <input type="text" id="txtf_lote" class="form-control" placeholder="Fecha Final" size="10">
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-lg-1">
                            Por Clave:
                        </div>
                        <div class="col-lg-2">
                            <input type="text" id="txtf_clave" class="form-control" placeholder="Ingrese Clave" size="10">
                        </div>
                        <div class="col-lg-1">
                            Por Lote
                        </div>
                        <div class="col-lg-2">
                            <input type="text" id="txtf_lote" class="form-control" placeholder="Ingrese Lote" size="10">
                        </div>                         

                    </div>
                    <br/>
                    <div class="text-center">
                        
                        <button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-ubi">POR UBICAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-mostrar">MOSTRAR TODAS&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-clave">AGREGAR CLAVE&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-kardex">IR KARDEX&nbsp;<label class="icon-th-list"></label></button>  
                           
                    </div>

                </div>
            </div>
            <div id="container">
                <form name="form" id="form" method="post" action="../ServletK">
                    <div id="demo"></div>
                    <div id="dynamic"></div>
                </form>
            </div>
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
    <script>
        $("footer").load("footer.html");
    </script>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function() {
            $("#btn-buscar").click(function() {
                var clave = $("#txtf_clave").val();
                var lote = $("#txtf_lote").val();
                var cb = $("#txtf_cb").val();
                if ((clave != "") && (lote != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=17&cb=' + cb + '&clave=' + clave + '&lote=' + lote + ''
                } else if ((clave != "") && (lote != "")) {
                    var dir = 'jsp/consultas.jsp?ban=18&clave=' + clave + '&lote=' + lote + ''
                } else if ((clave != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=19&clave=' + clave + '&cb=' + cb + ''
                } else if ((lote != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=20&lote=' + lote + '&cb=' + cb + ''
                } else if ((clave != "")) {
                    var dir = 'jsp/consultas.jsp?ban=21&clave=' + clave + ''
                } else if ((lote != "")) {
                    var dir = 'jsp/consultas.jsp?ban=22&lote=' + lote + ''
                } else if ((cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=23&cb=' + cb + ''
                }
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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        var id = json[i].id;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value="' + folio + ":" + claubi + ";" + id + '">ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
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
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"},
                                {"sTitle": "ReUbicar", "sClass": "center"}
                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }


            });

            $("#btn-ubi").click(function() {
                var dir = 'jsp/consultas.jsp?ban=24'

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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        var id = json[i].id;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value="' + folio + ":" + claubi + ";" + id + '"  >ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
                    }
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet,
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"},
                                {"sTitle": "ReUbicar", "sClass": "center"}
                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }


            });
            $("#btn-kardex").click(function() {
                self.location = 'kardex.jsp';
            });

            $("#btn-mostrar").click(function() {
                var dir = 'jsp/consultas.jsp?ban=29'
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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        var id = json[i].id;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value=' + folio + ":" + claubi + ";" + id + '>ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
                    }
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet,
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"},
                                {"sTitle": "ReUbicar", "sClass": "center"}
                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }


            });

            /////BOTONES PARA LOS USUARIOS DE CONSULTAS (2)///////
            $("#btn-buscar2").click(function() {
                var clave = $("#txtf_clave").val();
                var lote = $("#txtf_lote").val();
                var cb = $("#txtf_cb").val();
                if ((clave != "") && (lote != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=17&cb=' + cb + '&clave=' + clave + '&lote=' + lote + ''
                } else if ((clave != "") && (lote != "")) {
                    var dir = 'jsp/consultas.jsp?ban=18&clave=' + clave + '&lote=' + lote + ''
                } else if ((clave != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=19&clave=' + clave + '&cb=' + cb + ''
                } else if ((lote != "") && (cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=20&lote=' + lote + '&cb=' + cb + ''
                } else if ((clave != "")) {
                    var dir = 'jsp/consultas.jsp?ban=21&clave=' + clave + ''
                } else if ((lote != "")) {
                    var dir = 'jsp/consultas.jsp?ban=22&lote=' + lote + ''
                } else if ((cb != "")) {
                    var dir = 'jsp/consultas.jsp?ban=23&cb=' + cb + ''
                }
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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        // var piezas = json[i].piezas;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value=' + folio + ":" + claubi + '>ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
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
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"}
                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }


            });

            $("#btn-ubi2").click(function() {
                var dir = 'jsp/consultas.jsp?ban=24'
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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        //var piezas = json[i].piezas;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value=' + folio + ":" + claubi + '>ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
                    }
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet,
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"}

                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }

            });

            $("#btn-mostrar2").click(function() {
                var dir = 'jsp/consultas.jsp?ban=29'
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
                    for (var i = 0; i < json.length; i++) {
                        var clave = json[i].clave;
                        var lote = json[i].lote;
                        var caducidad = json[i].caducidad;
                        var cantidad = json[i].cantidad;
                        var ubicacion = json[i].ubicacion;
                        var folio = json[i].folio;
                        //var piezas = json[i].piezas;
                        var claubi = json[i].claubi;
                        //var cajas=parseInt(cantidad/piezas);
                        var cadena = '<button id="folio" name="folio" value=' + folio + ":" + claubi + '>ReDistribuir<input type=hidden value=2 id=ban name=ban /></button>';
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
                        aDataSet.push([clave, lote, caducidad, numero, ubicacion, cadena]);
                    }
                    $(document).ready(function() {
                        $('#dynamic').html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>');
                        $('#example').dataTable({
                            "aaData": aDataSet,
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"},
                            "aoColumns": [
                                {"sTitle": "Clave", "sClass": "center"},
                                {"sTitle": "Lote", "sClass": "center"},
                                {"sTitle": "Caducidad", "sClass": "center"},
                                {"sTitle": "Total Piezas", "sClass": "center"},
                                {"sTitle": "Ubicación", "sClass": "center"}

                            ]
                        });
                    });


                    $("#txtf_clave").val(null);
                    $("#txtf_lote").val(null);
                    $("#txtf_cb").val(null);

                }


            });

            ////FIN BOTONES USUARIOS CONSULTAS/////

        });
        $("#btn-clave").click(function(){
          self.location='Agregar.jsp';
        });
    </script>
</html>