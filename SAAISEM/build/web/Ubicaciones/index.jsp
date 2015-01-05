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
    <title>Validación Usuarios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Cargar CSS aquí -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="css/flat-ui.css" rel="stylesheet">
    <link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/gnkl_style_default.css" rel="stylesheet">
    
    
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
            	<img src="img/Logo GNK claro2.jpg" class="pull-left" id="logo-savi" height="70" width="170" />
                
                <h3 class=" span6 offset1 text-center">PROYECTO ISEM</h3>	       	
                <h3 class=" span6 offset1 text-center">SISTEMA UBICACIONES Y REDISTRIBUCIÓN</h3>	       	
            	<div class="row-fluid">
                    <nav class="span12">
                        <ul class="breadcrumb">
                            <li>Usted est&aacute; aqu&iacute;:</li>
                            <!--li><a href="/Proyectos/index.html">inicio</a><span class="divider">--><!--/span></li-->
                            <li>inicio ubicaciones isem<span class="divider">--></span></li>
                            
                        </ul>
                    </nav>
                </div>
            </header>
        </div> 
        <div class="row-fluid">
            <div class="login-form span6 offset3">
                <form name="form" id="form" method="post" action="/UbicacionesConsolidado/Ubicaciones">
                    <div class="control-group">
                        <input type="text" class="login-field" value="" name="usuario" placeholder="nombre de usuario" id="usuario" />
                        <label class="login-field-icon icon-user" for="login-name"></label>
                    </div>
                    <div class="control-group">
                        <input type="password" class="login-field" value="" name="password" placeholder="contrase&ntilde;a" id="password" />
                        <label class="login-field-icon icon-lock" for="login-pass"></label>
                    </div>
                    <button class="btn btn-primary btn-large btn-block" name="ban" value="1">Entrar</button>
                    
                </form>
            </div>
       	</div>
        <!-- Se carga un footer para todos los archivos, ya que no varia -->
        <div class="row-fluid">
            <footer class="span12"> 
            </footer>
        </div>
        
   	</div>

    
    <!-- Cargar aquí 'js' para mejorar rendimiento -->
    <script src="js/jquery-1.8.3.min.js"></script>
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>

    <!-- scripts aquí para mejorar rendimiento -->
    <script>
      	$("footer").load("footer.html");
    </script>
		

</body>
</html>


