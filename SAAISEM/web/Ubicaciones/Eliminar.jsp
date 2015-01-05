<%-- 
    Document   : Redistribucion
    Created on : 21/11/2013, 08:50:58 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%
HttpSession Session = request.getSession();
String Usuario="",Valida="",Folio="";

if (Session.getAttribute("Valida") != null){
Usuario = (String)Session.getAttribute("Usuario");
Valida = (String)Session.getAttribute("Valida");
Folio = (String)Session.getAttribute("folio");


}

if(!Valida.equals("Valido")){
  response.sendRedirect("index.jsp");
}
out.println(Folio);
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
                                <li>Eliminar clave al inventario<span class="divider"></span></li>
                            </ul>
                        </nav>
                    </div>
                </header>
            </div>
        </div>
        <div class="container">
            <form id="form" name="form" method="post" action="/UbicacionesConsolidado/Ubicaciones">
            <table class="table">
                <tbody>
                    <tr>
                        <th>Folio:</th><td><input type="text" id="folio" name="folio" placeholder="" readonly="" class="text-center" /></td>
                    </tr>
                    <tr>
                        <th>Clave:</th><td><input type="text" id="clave" placeholder="" readonly="" class="text-center" /></td>
                    </tr>
                    <tr>
                        <th>Descripción:</th><td id="descripcion"></td>
                    </tr>
                    <tr>
                        <th>Lote</th><td><input type="text" id="lote" placeholder="" readonly="" class="text-center"/></td>
                    </tr>
                    <tr>
                        <th>Caducidad</th><td><input type="text" id="caducidad" placeholder="" readonly="" class="text-center"/>&nbsp;<label class="icon-calendar icon-2x"></label></td>
                    </tr>
                    
                    
                    <tr>
                        <th>Ubicación</th><td><input type="text" id="ubicacion" value="" placeholder="" readonly="" class="text-center"/></td>
                    </tr>
                    <tr>
                        <th>Piezas x Cajas</th><td><input type="text" id="piezas" placeholder="" class="text-center" readonly=""/></td>
                    </tr>
                    
                    <tr>
                        <th>Existencia PZ</th><td id="exist"></td>
                    </tr>
                        
                </tbody>
                    
                <tr><td colspan="3"><button id="btn-modificar" class="btn btn-primary btn-block" name="ban" value="6">Eliminar&nbsp;<label class="icon-trash"></label></button></td></tr>
                
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
                var folio = <%=Folio%>;
                   var dir = 'jsp/consultasM.jsp?ban=26&folio='+folio+''
                   
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
                         json = JSON.parse(data);
                         $("#clave").val(json.clave);
                         $("#descripcion").text(json.descripcion);
                         $("#lote").val(json.lote);
                         $("#caducidad").val(json.caducidad);
                         $("#ubicacion").val(json.ubicacion);
                         $("#piezas").val(json.piezas);
                         $("#exist").text(json.cantidad);
                         $("#folio").val(json.id);
                        }
                                 
            });         
        </script>
      
    </body>
</html>
