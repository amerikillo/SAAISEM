<%-- 
    Document   : Redistribucion
    Created on : 21/11/2013, 08:50:58 AM
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
        <title>CONSULTAS ISEM</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
        <script src="ckeditor/ckeditor.js"></script>
        <link href=bootstrap/css/bootstrap.css" rel="stylesheet">
        <!--link href="css/flat-ui.css" rel="stylesheet"-->
        <!--link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet"-->
        <!--link href="css/gnkl_style_default.css" rel="stylesheet"-->
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
                                    <li><a href="captura.jsp">Entrada Manual</a></li>
                                    <li><a href="compraAuto2.jsp">Entrada Automática OC ISEM</a></li>
                                    <li><a href="reimpresion.jsp" target="blank_">Reimpresión de Compras</a></li>
                                    <li><a href="ordenesCompra.jsp" target="blank_">Órdenes de Compras</a></li>
                                    <li><a href="kardexClave.jsp" target="blank_">Kardex Claves</a></li>
                                    <li><a href="Ubicaciones/Consultas.jsp" target="blank_">Ubicaciones</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Facturación<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="requerimiento.jsp">Carga de Requerimiento</a></li>
                                    <li><a href="factura.jsp">Facturación Automática</a></li>
                                    <li><a href="reimp_factura.jsp">Reimpresión de Facturas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Catálogos<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="medicamento.jsp" target="blank_">Catálogo de Medicamento</a></li>
                                    <li><a href="catalogo.jsp" target="blank_">Catálogo de Proveedores</a></li>
                                    <li><a href="marcas.jsp" target="blank_">Catálogo de Marcas</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Fecha Recibo<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="Entrega.jsp" target="blank_">Fecha de Recibo en CEDIS</a></li> 
                                    <li><a href="historialOC.jsp" target="blank_">Historial OC</a></li>                                      
                                </ul>
                            </li>
                            <!--li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADASU<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="captura.jsp">Captura de Insumos</a></li>
                                    <li class="divider"></li>
                                    <li><a href="catalogo.jsp">Catálogo de Proveedores</a></li>
                                    <li><a href="reimpresion.jsp">Reimpresión de Docs</a></li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%=usua%></a></li>
                            <li class="active"><a href="index.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                        </ul>
                    </div><!--/.nav-collapse>
                </div>
            </div-->
                            <hr/>
            <div class="container">
                <div class="row">
                    <div><h5>Seleccione Proveedor:<select id="selectProvee">
                                        <option id="op">--Proveedor--</option>
                                    </select>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button></h5></div>
                </div>
            </div>                
            <div class="container">
                <form id="form" name="form" method="post" action="../ServletK">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Proveedor:</th><td><input type="text" id="provee" name="provee" placeholder="" readonly="" class="text-center" /></td>
                            </tr>
                            <tr>
                                <th>Clave:</th><td><input type="text" id="clave" name="clave" placeholder="" readonly="" class="text-center" /><select id="selectClave">
                                        <option id="op">--Clave--</option>
                                    </select></td>
                            </tr>
                            
                            <tr>
                                <th>Lote</th><td><input type="text" id="lote" name="lote" placeholder="" readonly="" class="text-center"/>&nbsp;&nbsp;      

                                    <select id="selectl">
                                        <option id="op">--Lote--</option>
                                    </select></td>
                            </tr>
                            <tr>
                                <th>Caducidad</th><td><input type="text" id="caducidad" name="caducidad" readonly="" placeholder="" class="text-center"/>&nbsp;<label class="icon-calendar icon-2x"></label>&nbsp;&nbsp;<select id="selectCadu">
                                        <option id="op">--Caducidad--</option>
                                    </select></td>
                            </tr>                            
                                                          
                            <tr>
                                <th>Cantidad</th><td><input type="text" id="restom" name="restom" placeholder="" class="text-center" /></td>
                            </tr>                            
                        </tbody>
                        <tr><td colspan="3"><button id="btn-agregar" class="btn btn-primary btn-block" name="ban" value="15">Marbete&nbsp;<label class="icon-refresh"></label></button></td></tr>
                    </table>
                </form>
            </div>
            <div class="row-fluid">
                <footer class="span12">
                </footer>
            </div>

        </div>
    </body>
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
        function justNumbers(e)
        {
            var keynum = window.event ? window.event.keyCode : e.which;
            if ((keynum == 8) || (keynum == 46))
                return true;

            return /\d/.test(String.fromCharCode(keynum));
        }
        $(document).ready(function() {
            
            var dir = 'jsp/consultas.jsp?ban=50'
            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarUbi(data);
                },
                error: function() {
                    alert("Ha ocurrido un error");

                }

            });
            function MostrarUbi(data) {

                var json = JSON.parse(data);
                for (var x = 0; x < json.length; x++) {
                    var clavepro = json[x].clavepro;
                    var nombrepro = json[x].nombrepro;
                    $("#selectProvee").append($("<option></option>").text(nombrepro).val(clavepro));

                }

            }
            
            $("#btn-buscar").click(function() {
                var clave = $("#selectProvee").val();
                var dir = 'jsp/consultas.jsp?ban=51&text=' + clave + ''
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarDatos(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");
                    }
                });
                function MostrarDatos(data) {
                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        $("#selectClave").append($("<option></option>").text(json[x].clave).val(json[x].clave));
                        $("#clave").val(json[x].clave);
                    }

                }
                $("#provee").val(clave);
            });
            
            
            var clave = $("#clave").val();
            var provee = $("#provee").val();
            
            var dir = 'jsp/consultas.jsp?ban=54&text=' + clave + '&provee='+ provee +''
                

                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarDatos(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");
                    }
                });
                function MostrarDatos(data) {
                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        $("#selectl").append($("<option></option>").text(json[x].lote).val(json[x].lote));
                        $("#lote").val(json[x].lote);
                    }
                $("#selectl").val("");
                }
            
            
            
        });
    </script>
    <!--script>
        $(document).ready(function() {
            $("#btn-buscar").click(function() {               
                var clave = $("#selectProvee").val();
                 var dir = 'jsp/consultas.jsp?ban=52&text=' + clave + ''
                

                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarDatos(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");
                    }
                });
                function MostrarDatos(data) {
                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        $("#selectl").append($("<option></option>").text(json[x].lote).val(json[x].lote));
                        $("#lote").val(json[x].lote);
                    }
$("#selectl").val("");
                }
                
            });

        });
    </script-->
    
    
    
    <script>
        $(document).ready(function() {
            $("#btn-buscar").click(function() {
                var clave = $("#selectProvee").val();
               
                    var dir = 'jsp/consultas.jsp?ban=53&text=' + clave + ''
                

                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarDatos(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");
                    }
                });
                function MostrarDatos(data) {
                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        $("#selectCadu").append($("<option></option>").text(json[x].fecha).val(json[x].fecha));
                        $("#caducidad").val(json[x].fecha);
                    }

                }
            });

        });
    </script>
    
   
    
    <script>
        $(document).ready(function() {

           $('#selectClave').change(function() {
                var valor = $('#selectClave').val();
                $('#clave').val(valor);
            });
            $('#selectl').change(function() {
                var valor = $('#selectl').val();
                $('#lote').val(valor);
            });
            $('#selectCadu').change(function() {
                var valor = $('#selectCadu').val();
                $('#caducidad').val(valor);
            });
            
            
            
            

            $("#form").submit(function() {

                var missinginfo = "";
                var clave = $("#clave").val();
                var lote = $("#lote").val();
                var cadu = $("#caducidad").val();
                var cb = $("#cb").val();
                var provee = $("#proveedor").val();
                var marca = $("#marca").val();
                var ubi = $("#actual").val();
                var resto = $("#restom").val();
                if (resto != "") {
                    var resultado = parseInt(resto);
                } else {
                    var resultado = 0;
                }

                if (clave == "") {
                    missinginfo += "\n El campo Clave no debe estar Vacío.";
                }
                if (lote == "") {
                    missinginfo += "\n El campo Lote no debe estar Vacío.";
                }
                if (cadu == "") {
                    missinginfo += "\n El campo Caducidad no debe estar Vacío.";
                }
                if (provee == "") {
                    missinginfo += "\n El campo Proveedor no debe estar Vacío.";
                }
                if (cb == "") {
                    missinginfo += "\n El campo CB Producto no debe estar Vacío.";
                }
                if (marca == "") {
                    missinginfo += "\n El campo Marca no debe estar Vacío.";
                }
                if (ubi == "") {
                    missinginfo += "\n El campo Ubicación no debe estar Vacío.";
                }
                if (resultado == 0) {
                    missinginfo += "\n La cantidad no se puede Ingresar porque es 0.";
                    $("#restom").val(null);
                }
                if (missinginfo != "") {
                    missinginfo = "\n TE HA FALTADO INTRODUCIR LOS SIGUIENTES DATOS:\n" + missinginfo + "\n\n ¡INGRESA LOS DATOS FALTANTES Y TRATA OTRA VEZ!\n";
                    alert(missinginfo);
                    return false;
                } else {
                    return true;
                }

            });
            $("#btn-regresar").click(function(){
                self.location='Consultas.jsp';
            });
        });
    </script>
    <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
    <script src="jquery-1.9.0.js"></script>
    <script src="ui/jquery.ui.core.js"></script>
    <script src="ui/jquery.ui.widget.js"></script>
    <script src="ui/i18n/jquery.ui.datepicker-es.js"></script>
    <script src="ui/jquery.ui.datepicker.js"></script>

    
</html>
