<%-- 
    Document   : index
    Created on : 01-oct-2013, 12:05:12
    Author     : wence
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<%
    HttpSession sesion = request.getSession();
    String usua = "";
    String Usuario = "", Valida = "", Nombre = "", Folio = "", ubicac1 = "", id = "";
    int Tipo = 0;

    if (sesion.getAttribute("nombre") != null) {
        Usuario = (String) sesion.getAttribute("Usuario");
        Nombre = (String) sesion.getAttribute("nombre");
        Tipo = Integer.parseInt((String) sesion.getAttribute("Tipo"));
        System.out.println(Usuario + Nombre + Tipo);
        //  out.println("Usuario"+Usuario +"<nombre>"+ Nombre +"<tipo>"+ Tipo);
    } else {
        response.sendRedirect("Consultas.jsp");
    }
    String info = null;

    Folio = request.getParameter("folio");
    ubicac1 = request.getParameter("ubicacion");
    id = request.getParameter("id");

    //out.println("folio"+Folio+"<ubi>"+ubicac1+"<id>"+id);

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Ingreso SAA</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap -->
        <link href="css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="css/login.css" rel="stylesheet" media="screen">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="../../assets/js/html5shiv.js"></script>
          <script src="../../assets/js/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container">
            <!--div class="row marco" >
                <div class="col-md-4">.col-md-4</div>
                <div class="col-md-4">.col-md-4</div>
                <div class="col-md-4">.col-md-4</div>
            </div-->

            <form name ="form" id="forma-login" class="marco" action="../ServletK" method="post" >
                <!--label for="username" class="uname" data-icon="u" > Your email or username </label-->
                <div class="row">
                    <div class="col-md-4"><img src="../imagenes/GNKL_Small.JPG" ></div>
                    <div class="col-md-8"><h2>Validar Usuario</h2></div>

                </div>


                <div class="input-group">
                    <span class="input-group-addon"><label class="glyphicon glyphicon-user"></label>
                    </span>
                    <input type="text" name="nombre2" id="nombre2" class="form-control" autofocus="" placeholder="Introduzca Nombre de Usuario">
                </div>
                <div class="input-group">
                    <span class="input-group-addon"><label class="glyphicon glyphicon-hand-right"></label>
                    </span>

                    <input type="password" name="pass" id="pass" class="form-control"  placeholder="Introduzca Contrase&ntilde;a V&aacute;lida">
                </div>
                <div>
                    <%         info = (String) sesion.getAttribute("mensaje");
                        //out.print(info);
                        if (!(info == null || info.equals(null))) {
                    %>
                    <div>Datos inv&aacute;lidos, intente otra vez...</div>
                    <%
                        }
                        sesion.invalidate();
                    %>

                </div>
                <br><button id="btn-distribuir" class="btn btn-lg btn-primary btn-block" name="ban" value="13">Entrar</button>

                <button id="btn-distribuir" class="btn btn-lg btn-success btn-block" name="ban" value="12">Regresar</button>                 
                <br>
                <input type="hidden" name="Usuariou" id="Usuariou" class="form-control" value="<%=Usuario%>" readonly="" hidden="true">
                <input type="hidden" name="Nombreu" id="nombreu" class="form-control" value="<%=Nombre%>" readonly="">
                <input type="hidden" name="Tipou" id="Tipou" class="form-control" value="<%=Tipo%>" readonly="">
                <input type="hidden" name="Foliou" id="Foliou" class="form-control" value="<%=Folio%>" readonly="">
                <input type="hidden" name="Ubica" id="Ubica" class="form-control" value="<%=ubicac1%>" readonly="">
                <input type="hidden" name="Id" id="Id" class="form-control" value="<%=id%>" readonly="">                
            </form>
            <br>



        </div>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="//code.jquery.com/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>

