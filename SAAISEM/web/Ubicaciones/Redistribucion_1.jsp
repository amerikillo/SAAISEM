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
    String Usuario = "", Valida = "", Nombre = "";
    int Tipo = 0;

    if (sesion.getAttribute("nombre") != null) {
        Usuario = (String) sesion.getAttribute("Usuario");
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
        <link href="bootstrap/css/bootstrap-combined.min.css" rel="stylesheet">
        
        <link rel="stylesheet" href="js_auto/jquery-ui.css">
        <script src="js_auto/jquery-1.9.1.js"></script>
        <script src="js_auto/jquery-ui.js"></script>
        <link rel="stylesheet" href="js_auto/style.css">
        <!--link href="css/flat-ui.css" rel="stylesheet"-->
        <!--link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet"-->
        <!--link href="css/gnkl_style_default.css" rel="stylesheet"-->
        <!--script type="text/javascript" language="javascript" src="table_js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="table_js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/TableTools.js"></script>
        <script type="text/javascript" src="table_js/TableTools.min.js"></script-->
        <style type="text/css">
            .container2 {
                margin-top: 30px;
                width: 400px;
                
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS - MODULO DE REUBICAR</h1>
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
            <div class="container2">
                <div class="progress progress-striped active">
                    <div class="bar" style="width: 0%;"></div>
                </div>
            </div>  
            <div class="container">
                <form id="form" name="form" method="post" action="../ServletK">
                    <table class="table table-bordered">

                        <tr>
                            <td>Clave:</td>
                            <td id="clave"></td>
                            <td>Descripción:</td>
                            <td colspan="3" id="descripcion"></td>
                        </tr>
                        <tr>
                            <td>Lote</td>
                            <td>Caducidad</td>
                            <td>Existencia</td>


                        </tr>
                        <tr>
                            <td id="lote"></td>
                            <td id="caducidad"></td>
                            <td id="exist"></td>

                        </tr>
                        <tr>

                            <td>Existencia a Mover</td>
                            <td>Ubicación</td>
                            <td>Ubicación Seleccionada</td>
                            <td colspan="2">Ubicación Actual</td>

                        </tr>
                        <tr>                           
                            <td><input type="text" name="restom" id="restom" placeholder="" class="form-control" required="true" onKeyPress="return justNumbers(event);" /></td>
                            <% if(Usuario.equals("Ana")){ %>
                            <td><select id="selectq" class="form-control">
                                    <option id="op">--Ubicación--</option>
                                </select></td>
                            <%}else{%>
                            <td><select id="select" class="form-control">
                                    <option id="op">--Ubicación--</option>
                                </select></td>
                           <%}%>
                           <td><input type="text" name="ubin" id="ubin" placeholder="" onKeyUp="Ubicacionc()" class="form-control" /><datalist id="Ubicaciones"></datalist></td>
                            <td colspan="2"><input type="text" id="actual" value="<%=ubicac1%>" placeholder="" readonly="" class="form-control" onKeyPress="return justNumbers(event);" /></td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <div class="col-lg-6">
                                <button id="btn-distribuir" class="btn btn-lg btn-primary btn-block" name="ban" value="3">Re Distribuir</button>
                                </div>
                                <br />
                                <br />
                                <div class="col-lg-6">
                                <button class="btn btn-lg btn-success btn-block" id="btn-regresar">REGRESAR&nbsp;<label class="glyphicon glyphicon-hand-left"></label></button>
                                </div>
                            </td>
                        </tr>

                    </table>
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
    <!--script src="js/jquery-1.8.3.min.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script src="js/flatui-checkbox.js"></script>
    <script src="js/flatui-radio.js"></script>
    <script src="js/jquery-1.9.1"></script-->
    <script>
        
        function Ubicacionc(){
           var text = $("#ubin").val();
            var dir = 'jsp/consultas.jsp?ban=45&text='+text+''
            
                    $.ajax({
                        url: dir,
                        type: 'json',
                        async: false,
                        success: function(data){
                            MostrarDatos2(data);
                        }, 
                                error: function() {
                            alert("Ha ocurrido un error");	
                        }
                    });
                   function MostrarDatos2(data){
                       var x = 0;
                      
                       var json = JSON.parse(data);
                       for(var i = 0; i < json.length; i++) {
                           x++;
                           var uni = json[i].ubicac;
                       
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
                               
                           
                           
                           $( "#ubin" ).autocomplete({
                               source: availableTags
                           }); 

                       }  
        }
        
        };
        
    </script>
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
            var fol = <%=Folio%>;
            var id = <%=id%>;
            var ubica = $("#actual").val();
            
            var dir = 'jsp/consultas.jsp?ban=25&folio=' + fol + '&ubicacion=' + ubica + '&id=' + id + ''
            
            var progress = setInterval(function() {
                  var $bar = $('.bar');
                  if ($bar.width()==400) {
                      clearInterval(progress);
                      $('.progress').removeClass('active');
                  } else {
                      $bar.width($bar.width()+200);
                  }
                  $bar.text($bar.width()/4 + "%");
                  }, 800);

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
                json = JSON.parse(data);
                var cantidad = json.cantidad;

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
                $("#clave").text(json.clave);
                $("#descripcion").text(json.descripcion);
                $("#lote").text(json.lote);
                $("#caducidad").text(json.caducidad);
                $("#exist").text(numero);

            }
        });
        $(document).ready(function() {   
        var dir = 'jsp/consultas.jsp?ban=26'
            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarUbi(data);
                },
                error: function() {
                    alert("Ha ocurrido un error a");

                }

            });
            function MostrarUbi(data) {

                var json = JSON.parse(data);
                for (var x = 0; x < json.length; x++) {
                    var claubi = json[x].claubi;
                    var desubi = json[x].desubi;
                    $("#select").append($("<option></option>").text(desubi).val(claubi));

                }

            }
            
            var dir = 'jsp/consultas.jsp?ban=43'
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
                    var claubi = json[x].claubi;
                    var desubi = json[x].desubi;
                    $("#selectq").append($("<option></option>").text(desubi).val(claubi));

                }

            }
            

            $('#select').change(function() {
                var valor = $('#select').val();
                $('#ubin').val(valor);
            });
            
            $('#selectq').change(function() {
                var valor = $('#selectq').val();
                $('#ubin').val(valor);
            });
                 

            $("#form").submit(function() {
                var missinginfo = "";
                var restom = $("#restom").val();
                var ubica = $("#ubin").val();
                var actual = $("#actual").val();
                var existencia = $("#exist").text();
                var resultado = parseInt(restom);
                if (resultado > existencia) {
                    missinginfo += "\n La cantidad a mover es mayor al existente.";
                }
                if ($("#ubin").val() == "") {
                    missinginfo += "\n El campo Ubicación Seleccionada no debe estar Vacio.";
                }
                if (ubica == actual ){
                    missinginfo += "\n No se puede mover por ser misma Ubicación";
                }
                if (missinginfo != "") {

                    missinginfo = "\n TE HA FALTADO INTRODUCIR LOS SIGUIENTES DATOS PARA ENVIAR PETICIÓN:\n" + missinginfo + "\n\n";
                    alert(missinginfo);
                    $("#restom").val(null);
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
    
        
            
</html>
