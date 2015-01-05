<%-- 
    Document   : Redistribucion
    Created on : 21/11/2013, 08:50:58 AM
    Author     : CEDIS TOLUCA3
--%>
<%@page import="groovy.lang.Script"%>
<%@page import="conn.*" %>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<%

    ConectionDBInv con = new ConectionDBInv();
    ResultSet Rset_Clave;
    ResultSet Rset_Cb;
    ResultSet Rset_Consul;
    ResultSet Rset_fecha;
    String CB = "", btn = "", btne = "", clave = "", lote = "", caducidad = "", proveedor = "", cbm = "", marca = "", ubica = "", pzas = "", cantidad = "", exis = "", Id = "", Id2 = "";
    String CBM = "", descrip = "", claveL = "", DescripM = "";
    int cont = 0, existencia = 0, cantinv = 0, total = 0;

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

    con.conectar();

    try {

        //= request.getParameter("selectc");
        descrip = request.getParameter("descrip");
        claveL = request.getParameter("selectc");
        btne = request.getParameter("eliminar");
        CBM = request.getParameter("txtf_cdm");
        CB = request.getParameter("txtf_cb");
        btn = request.getParameter("btn-agregar");
        clave = request.getParameter("clave");
        lote = request.getParameter("lote");
        caducidad = request.getParameter("caducidad");
        proveedor = request.getParameter("proveedor");
        cbm = request.getParameter("cb");
        marca = request.getParameter("marca");
        ubica = request.getParameter("ubin");
        pzas = request.getParameter("pzc");
        cantidad = request.getParameter("restom");

        if (descrip == null) {
            descrip = "";
        }
        if (btne == null) {
            btne = "";
        }
        if (CBM == null) {
            CBM = "";
        }
        if (CB == null) {
            CB = "";
        }
        if (btn == null) {
            btn = "";
        }
        if (clave == null) {
            clave = "";
        }
        if (lote == null) {
            lote = "";
        }
        if (caducidad == null) {
            caducidad = "";
        }
        if (proveedor == null) {
            proveedor = "";
        }
        if (cbm == null) {
            cbm = "";
        }
        if (marca == null) {
            marca = "";
        }
        if (ubica == null) {
            ubica = "";
        }
        if (pzas == null) {
            pzas = "";
        }
        if (cantidad == null) {
            cantidad = "";
        }

        //out.println(btn);
    } catch (Exception e) {
        System.out.println(e);
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

        <script type="text/javascript" language="javascript" src="table_js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="table_js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/TableTools.js"></script>
        <script type="text/javascript" src="table_js/TableTools.min.js"></script>

        <link rel="stylesheet" href="js_auto/jquery-ui.css">
        <script src="js_auto/jquery-1.9.1.js"></script>
        <script src="js_auto/jquery-ui.js"></script>

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

            <form action="Inventario.jsp" method="post">
                <div class="container">
                    <div class="row">
                        <div><h5>Ingresa CB Ubica:<input type="text" id="txtf_cb" name="txtf_cb" placeholder="Ingrese CB" size="20" class="text-center" onchange="this.form.submit();" >&nbsp;&nbsp;Ingresa CB Med:<input type="text" id="txtf_cdm" name="txtf_cdm" placeholder="Ingrese CB" size="15" class="text-center" onchange="this.form.submit();" >&nbsp;&nbsp;<input type="text" name="descrip" id="descrip" onKeyUp="Descripcion()" placeholder="Ingrese Descripción" /><datalist id="Descripciones"></datalist>&nbsp;&nbsp;<button class="btn btn-sm btn-primary" id="btn-buscar">BUSCAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>&nbsp;<button class="btn btn-sm btn-success" id="btn-regresar">REGRESAR&nbsp;<label class="glyphicon glyphicon-hand-left"></label></button></h5></div>
                    </div>

                </div>                
                <div class="container">               
                    <table class="table">
                        <tbody>                            
                            <tr>
                                <%
                                    if (CBM != "") {
                                        Rset_Cb = con.consulta("SELECT L.F_ClaPro,F_ClaLot,DATE_FORMAT(F_FecCad,'%d/%m/%Y') as fecha,M.F_DesPro FROM tb_lote L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro WHERE F_Cb='" + CBM + "' GROUP BY F_Cb");
                                        while (Rset_Cb.next()) {
                                            clave = Rset_Cb.getString("L.F_ClaPro");
                                            lote = Rset_Cb.getString("F_ClaLot");
                                            caducidad = Rset_Cb.getString("fecha");
                                            DescripM = Rset_Cb.getString("M.F_DesPro");
                                        }
                                    }

                                    if (descrip != "") {
                                        Rset_Cb = con.consulta("select M.F_DesPro,M.F_ClaPro FROM tb_medica M WHERE M.F_DesPro='" + descrip + "' GROUP BY M.F_DesPro");
                                        while (Rset_Cb.next()) {
                                            DescripM = Rset_Cb.getString("M.F_DesPro");
                                            clave = Rset_Cb.getString("M.F_ClaPro");
                                        }
                                    }

                                    if (CB != "") {
                                        Rset_Clave = con.consulta("SELECT L.F_ClaPro FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_Cb='" + CB + "' GROUP BY L.F_ClaPro");
                                    } else if (CBM != "") {
                                        Rset_Clave = con.consulta("SELECT L.F_ClaPro FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE L.F_Cb='" + CBM + "' GROUP BY L.F_ClaPro");
                                    } else if (ubica != "" && descrip != "") {
                                        Rset_Clave = con.consulta("select M.F_ClaPro FROM tb_medica M WHERE M.F_DesPro='" + descrip + "' GROUP BY M.F_ClaPro");
                                    } else if (descrip != "") {
                                        Rset_Clave = con.consulta("select M.F_ClaPro FROM tb_medica M WHERE M.F_DesPro='" + descrip + "' GROUP BY M.F_ClaPro");
                                    } else if (btne != "") {
                                        Rset_Cb = con.consulta("SELECT F_Ubica FROM tb_lote WHERE F_IdLote='" + btne + "'");
                                        while (Rset_Cb.next()) {
                                            ubica = Rset_Cb.getString("F_Ubica");
                                        }
                                        Rset_Clave = con.consulta("SELECT L.F_ClaPro FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_ClaUbi='" + ubica + "' GROUP BY L.F_ClaPro");
                                    } else {
                                        Rset_Clave = con.consulta("SELECT L.F_ClaPro FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_ClaUbi='" + ubica + "' GROUP BY L.F_ClaPro");
                                    }
                                %>
                                <th>Clave:</th><td>
                                    <%if (CBM != "" || descrip != "") {%>
                                    <input type="text" id="clave" name="clave" placeholder="Clave" readonly="" value="<%=clave%>" class="text-center" onkeypress="return tabular(event, this)" />
                                    <%} else {%>
                                    <input type="text" id="clave" name="clave" placeholder="Clave" readonly="" value="<%//=clave%>" class="text-center" onkeypress="return tabular(event, this)" />
                                    <%}%>
                                    &nbsp;&nbsp;

                                    <select id="selectc" name="selectc">                                       
                                        <option>--Clave--</option>
                                        <%
                                            while (Rset_Clave.next()) {
                                        %>
                                        <option value="<%=Rset_Clave.getString(1)%>"><%=Rset_Clave.getString(1)%></option>
                                        <%}%>
                                    </select>

                                </td>

                            </tr>
                            <tr>
                                <th>Decripción:</th>
                                <td id="obs"><%=DescripM%></td>
                            </tr>
                            <tr>
                                <th>Lote</th><td>
                                    <%if (CBM != "") {%>
                                    <input type="text" id="lote" name="lote" placeholder="" class="text-center" value="<%=lote%>" onkeypress="return tabular(event, this)"/>
                                    <%} else {%>
                                    <input type="text" id="lote" name="lote" placeholder="" class="text-center" value="<%//=lote%>" onkeypress="return tabular(event, this)"/>
                                    <%}%>
                                    &nbsp;&nbsp;      

                                    <select id="selectl">
                                        <option id="op">--Lote--</option>                                        
                                    </select></td>

                            </tr>
                            <tr>
                                <th>Caducidad</th><td>
                                    <%if (CBM !=""){%>
                                    <input type="text" id="caducidad" name="caducidad" data-date-format="dd/mm/yyyy" placeholder="" class="text-center" value="<%=caducidad%>" onKeyPress="
                                            return LP_data(event, this);
                                            anade(this, event);
                                            return tabular(event, this);
                                           " maxlength="10" onblur="validaCadu();"/>&nbsp;<label class="icon-calendar icon-2x"></label>
                                    <%}else{%>
                                    <input type="text" id="caducidad" name="caducidad" data-date-format="dd/mm/yyyy" placeholder="" class="text-center" value="<%//=caducidad%>" onKeyPress="
                                            return LP_data(event, this);
                                            anade(this, event);
                                            return tabular(event, this);
                                           " maxlength="10" onblur="validaCadu();"/>&nbsp;<label class="icon-calendar icon-2x"></label>
                                    <%}%>
                                    &nbsp;&nbsp;

                                    <select id="selectCadu">
                                        <option id="op">--Caducidad--</option>

                                    </select>

                                </td>
                            </tr>                         


                            <tr>
                                <%
                                        if (CB !="" || ubica !="" || btne !=""){
                                           
                                            if (btne !=""){
                                                Rset_Clave = con.consulta("SELECT U.F_Cb FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi WHERE F_IdLote='"+btne+"'");
                                                while(Rset_Clave.next()){
                                                    CB = Rset_Clave.getString("U.F_Cb");
                                                }
                                            }
                                            Rset_Clave = con.consulta("SELECT U.F_ClaUbi FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_Cb='"+CB+"' GROUP BY U.F_ClaUbi"); 
                                            while(Rset_Clave.next()){
                                               ubica = Rset_Clave.getString("U.F_ClaUbi");
                                            }
                                        
                                %>
                                <th>Ubicación</th><td><input type="text" id="actual" name="ubin" value="<%=ubica%>" placeholder="" class="text-center" onKeyUp="Ubicacionc()" onkeypress="return tabular(event, this)"/> <datalist id="Ubicaciones"></datalist>&nbsp;&nbsp;<!--select id="select"-->
                                    <%}else{%>
                                <th>Ubicación</th><td><input type="text" id="actual" name="ubin" value="<%//=ubica%>" placeholder="" class="text-center" onKeyUp="Ubicacionc()" onkeypress="return tabular(event, this)"/><datalist id="Ubicaciones"></datalist>&nbsp;&nbsp;<!--select id="select"-->
                                    <%}%>
                                    <!--option id="op">--Ubicación--</option>                                        
                                </select--></td>
                            </tr>  
                            <tr>
                                <th>Presentación</th><td><input type="text" id="pzc" name="pzc" value="<%//=pzas%>" placeholder="" class="text-center" onkeypress="return justNumbers(event);"/>
                                    <select id="selectR">
                                        <option id="op">--Resto--</option>                                        
                                    </select>
                                </td>
                            </tr>  
                            <tr>
                                <th>Total Existencias</th><td><input type="text" id="restom" name="restom" placeholder="" class="text-center" value="<%//=cantidad%>" onkeypress="return justNumbers(event);" /></td>
                            </tr>                            
                        </tbody>
                        <div id="loading" class="text-center"></div>
                        <tr><td colspan="3"><button id="btn-agregar" class="btn btn-primary btn-block" name="btn-agregar" value="Agregar">Agregar&nbsp;<label class="icon-refresh"></label></button></td></tr>

                    </table>

                </div>
            </form>




            <%
            if (btn.equals("Agregar")){
               
                Rset_fecha = con.consulta("SELECT STR_TO_DATE('"+caducidad+"', '%d/%m/%Y')");                   
                     if (Rset_fecha.next()) { 
                         caducidad= Rset_fecha.getString("STR_TO_DATE('"+caducidad+"', '%d/%m/%Y')");
                     }
               
                Rset_Consul = con.consulta("SELECT F_ExiLot,F_Idlote FROM tb_lote WHERE F_ClaPro='"+clave+"' AND F_ClaLot='"+lote+"' AND F_FecCad='"+caducidad+"' AND F_Ubica='"+ubica+"'");
                while(Rset_Consul.next()){
                    cont ++;
                    exis = Rset_Consul.getString("F_ExiLot");
                    Id = Rset_Consul.getString("F_Idlote");
                }
                if (cont > 0){
                    existencia = Integer.parseInt(exis);
                    cantinv = Integer.parseInt(cantidad);
                    total = existencia + cantinv;
                    con.actualizar("UPDATE tb_lote SET F_ExiLot='"+total+"',F_FolLot='"+pzas+"' WHERE F_Idlote='"+Id+"'");
                   
                }else{
                    con.actualizar("INSERT INTO tb_lote VALUES(0,'"+clave+"','"+lote+"','"+caducidad+"','"+cantidad+"','"+pzas+"','1','"+ubica+"',CURDATE(),'1','1')");
                }
                con.actualizar("insert into tb_movinv values(0,curdate(),'4','"+clave+"','"+cantidad+"','1','"+lote+"','"+caducidad+"','"+ubica+"',curtime(),'"+usua+"')");
               
              
            }
            %>
            <table class="table">
                <tr>
                    <td>CLAVE</td>
                    <td>LOTE</td>
                    <td>CADUCIDAD</td>
                    <td>UBICACIÓN</td>
                    <td>CANTIDAD</td>
                    <td></td>
                </tr>
                <%
                 if (btne !=""){
                        Rset_Clave = con.consulta("SELECT F_ClaPro,F_ClaLot,F_FecCad,F_ExiLot,F_Ubica FROM tb_lote WHERE F_IdLote='"+btne+"'");
                        while(Rset_Clave.next()){
                            clave = Rset_Clave.getString("F_ClaPro");
                            lote = Rset_Clave.getString("F_ClaLot");
                            caducidad = Rset_Clave.getString("F_FecCad");
                            cantidad = Rset_Clave.getString("F_ExiLot");
                            ubica = Rset_Clave.getString("F_Ubica");
                        }
                        con.actualizar("insert into tb_movinv values(0,curdate(),'53','"+clave+"','"+cantidad+"','-1','"+lote+"','"+caducidad+"','"+ubica+"',curtime(),'"+usua+"')");
                        con.actualizar("UPDATE tb_lote SET F_ExiLot='0' where F_IdLote ='"+btne+"'");
                        
                    }
           
                if (CB !=""){
                    Rset_Clave = con.consulta("SELECT L.F_ClaPro,L.F_ClaLot,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y'),U.F_DesUbi,L.F_ExiLot,L.F_IdLote FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_Cb='"+CB+"' AND F_ExiLot>0");
                }else if(ubica !=""){
                    Rset_Clave = con.consulta("SELECT L.F_ClaPro,L.F_ClaLot,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y'),U.F_DesUbi,L.F_ExiLot,L.F_IdLote FROM tb_lote L INNER JOIN tb_ubica U on L.F_Ubica=U.F_ClaUbi WHERE U.F_ClaUbi='"+ubica+"' AND F_ExiLot>0");
                }
                    while(Rset_Clave.next()){
                        
                    Id2 = Rset_Clave.getString(6);                                         
                %>
                <tr>
                    <td><%=Rset_Clave.getString(1)%></td>
                    <td><%=Rset_Clave.getString(2)%></td>
                    <td><%=Rset_Clave.getString(3)%></td>
                    <td><%=Rset_Clave.getString(4)%></td>
                    <td><%=Rset_Clave.getString(5)%></td>
                <form action="Inventario.jsp" method="post">
                    <td><button class="btn btn-danger" onclick="return confirm('¿Seguro de que desea eliminar?');" name="eliminar" value="<%=Rset_Clave.getString(6)%>" id="eliminar"><span class="glyphicon glyphicon-remove"></span></td>
                </form>
                </tr>
                <%
                    }
                
                %>
            </table>
            <div class="row-fluid">
                <footer class="span12">
                </footer>
            </div>



        </div>
        <%
        con.cierraConexion();
        %>
    </body>
    <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>
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

    </script>

    <script>

        function Descripcion() {
            var text = $("#descrip").val();
            var dir = 'jsp/consultas.jsp?ban=55&text=' + text + ''

            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarDatos2(data);
                },
                error: function() {
                    alert("Ha ocurrido un error");
                }
            });
            function MostrarDatos2(data) {
                var x = 0;

                var json = JSON.parse(data);
                for (var i = 0; i < json.length; i++) {
                    x++;
                    var uni = json[i].ubicac;

                    if (x < json.length) {

                        if (x == 1) {
                            var unid1 = uni;
                        } else if (x == 2) {
                            var unid2 = uni;
                        } else if (x == 3) {
                            var unid3 = uni;
                        } else if (x == 4) {
                            var unid4 = uni;
                        } else if (x == 5) {
                            var unid5 = uni;
                        } else if (x == 6) {
                            var unid6 = uni;
                        } else if (x == 7) {
                            var unid7 = uni;
                        } else if (x == 8) {
                            var unid8 = uni;
                        } else if (x == 9) {
                            var unid9 = uni;
                        }
                    } else {
                        var unid10 = uni;

                    }
                    if (json.length == 1) {
                        var availableTags = [unid10];
                    } else if (json.length == 2) {
                        var availableTags = [unid1, unid10];
                    } else if (json.length == 3) {
                        var availableTags = [unid1, unid2, unid10];
                    } else if (json.length == 4) {
                        var availableTags = [unid1, unid2, unid3, unid10];
                    } else if (json.length == 5) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid10];
                    } else if (json.length == 6) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid10];
                    } else if (json.length == 7) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid10];
                    } else if (json.length == 8) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid10];
                    } else if (json.length == 9) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid8, unid10];
                    } else if (json.length == 10) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid8, unid9, unid10];
                    }



                    $("#descrip").autocomplete({
                        source: availableTags
                    });

                }
            }

        }
        ;



        function Ubicacionc() {
            var text = $("#actual").val();
            var dir = 'jsp/consultas.jsp?ban=45&text=' + text + ''
            // alert(dir);
            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarDatosUbi(data);
                },
                error: function() {
                    alert("Ha ocurrido un error");
                }
            });
            function MostrarDatosUbi(data) {
                var x = 0;

                var json = JSON.parse(data);
                for (var i = 0; i < json.length; i++) {
                    x++;
                    var uni = json[i].ubicac;

                    if (x < json.length) {

                        if (x == 1) {
                            var unid1 = uni;
                        } else if (x == 2) {
                            var unid2 = uni;
                        } else if (x == 3) {
                            var unid3 = uni;
                        } else if (x == 4) {
                            var unid4 = uni;
                        } else if (x == 5) {
                            var unid5 = uni;
                        } else if (x == 6) {
                            var unid6 = uni;
                        } else if (x == 7) {
                            var unid7 = uni;
                        } else if (x == 8) {
                            var unid8 = uni;
                        } else if (x == 9) {
                            var unid9 = uni;
                        }
                    } else {
                        var unid10 = uni;

                    }
                    if (json.length == 1) {
                        var availableTags = [unid10];
                    } else if (json.length == 2) {
                        var availableTags = [unid1, unid10];
                    } else if (json.length == 3) {
                        var availableTags = [unid1, unid2, unid10];
                    } else if (json.length == 4) {
                        var availableTags = [unid1, unid2, unid3, unid10];
                    } else if (json.length == 5) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid10];
                    } else if (json.length == 6) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid10];
                    } else if (json.length == 7) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid10];
                    } else if (json.length == 8) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid10];
                    } else if (json.length == 9) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid8, unid10];
                    } else if (json.length == 10) {
                        var availableTags = [unid1, unid2, unid3, unid4, unid5, unid6, unid7, unid8, unid9, unid10];
                    }



                    $("#actual").autocomplete({
                        source: availableTags
                    });

                }
            }

        }
        ;

        function validaCadu() {
            var cad = document.getElementById('caducidad').value;
            if (cad === "") {


            } else if (cad.length < 10) {
                alert("Caducidad Incorrecta");
                document.getElementById('caducidad').focus();
                return false;
            } else {
                var dtFechaActual = new Date();
                var sumarDias = parseInt(365);
                dtFechaActual.setDate(dtFechaActual.getDate() + sumarDias);
                var fechaSpl = cad.split("/");
                var Caducidad = fechaSpl[2] + "-" + fechaSpl[1] + "-" + fechaSpl[0];
                /*alert(Caducidad);*/
                if (Date.parse(dtFechaActual) > Date.parse(Caducidad)) {
                    alert("La fecha de caducidad no puede ser menor a 12 meses próximos");
                    document.getElementById('caducidad').focus();
                    return false;
                }
            }
        }

        otro = 0;
        function LP_data(e, esto) {
            var key = (document.all) ? e.keyCode : e.which; //codigo de tecla. 
            if (key < 48 || key > 57)//si no es numero 
                return false; //anula la entrada de texto.
            else
                anade(esto);
        }
        function tabular(e, obj) {
            tecla = (document.all) ? e.keyCode : e.which;
            if (tecla != 13)
                return;
            frm = obj.form;
            for (i = 0; i < frm.elements.length; i++)
                if (frm.elements[i] == obj)
                {
                    if (i == frm.elements.length - 1)
                        i = -1;
                    break
                }
            /*ACA ESTA EL CAMBIO*/
            if (frm.elements[i + 1].disabled == true)
                tabular(e, frm.elements[i + 1]);
            else
                frm.elements[i + 1].focus();
            return false;
        }
        function anade(esto) {
            if (esto.value.length > otro) {
                if (esto.value.length === 2) {
                    esto.value += "/";
                }
            }
            if (esto.value.length > otro) {
                if (esto.value.length === 5) {
                    esto.value += "/";
                }
            }
            if (esto.value.length < otro) {
                if (esto.value.length === 2 || esto.value.length === 5) {
                    esto.value = esto.value.substring(0, esto.value.length - 1);
                }
            }
            otro = esto.value.length;
        }

    </script>
    <script>
        $(document).ready(function() {
            $("#selectc").click(function() {
                $("#selectl").empty();
                $("#selectl").append($("<option></option>").text("--Lote--").val("--Lote--"));
                var clavel = $("#selectc").val();
                var dir = 'jsp/consultasInv.jsp?ban=1&clave=' + clavel + ''
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarLote(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");

                    }


                });
                function MostrarLote(data) {

                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        var lote = json[x].lote;
                        $("#selectl").append($("<option></option>").text(lote).val(lote));

                    }
                }
                $("#selectCadu").empty();
                $("#selectCadu").append($("<option></option>").text("--Caducidad--").val("--Caducidad--"));

                var Claves = $("#clave").val();
                var dir = 'jsp/consultasInv.jsp?ban=4&clave=' + Claves + ''
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarDescr(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");

                    }

                });
                function MostrarDescr(data) {

                    var json = JSON.parse(data);
                    $("#obs").text(json.descripc);
                }

            });

            $("#selectl").click(function() {
                $("#selectCadu").empty();
                $("#selectCadu").append($("<option></option>").text("--Caducidad--").val("--Caducidad--"));
                var clavel = $("#selectc").val();
                var clavels = $("#clave").val();
                var lotel = $("#selectl").val();
                if (clavel != "--Clave--") {
                    var dir = 'jsp/consultasInv.jsp?ban=2&clave=' + clavel + '&lote=' + lotel + ''
                } else {
                    var dir = 'jsp/consultasInv.jsp?ban=2&clave=' + clavels + '&lote=' + lotel + ''
                }
                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(data) {
                        MostrarCadu(data);
                    },
                    error: function() {
                        alert("Ha ocurrido un error");

                    }

                });
                function MostrarCadu(data) {

                    var json = JSON.parse(data);
                    for (var x = 0; x < json.length; x++) {
                        var fecha = json[x].fecha;
                        $("#selectCadu").append($("<option></option>").text(fecha).val(fecha));

                    }

                }


            });


        });
    </script>

    <script>
        $(document).ready(function() {

            var dir = 'jsp/consultasInv.jsp?ban=10'
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
                    var claubi = json[x].claubi;
                    var desubi = json[x].desubi;
                    $("#select").append($("<option></option>").text(desubi).val(claubi));

                }

            }

            $('#selectc').change(function() {
                var valor = $('#selectc').val();
                $('#clave').val(valor);
            });

            $('#select').change(function() {
                var valor = $('#select').val();
                $('#actual').val(valor);
            });
            $('#selectl').change(function() {
                var valor = $('#selectl').val();
                $('#lote').val(valor);
            });
            $('#selectCadu').change(function() {
                var valor = $('#selectCadu').val();
                $('#caducidad').val(valor);
            });
            $('#selectProv').change(function() {
                var valor = $('#selectProv').val();
                $('#proveedor').val(valor);
            });
            $('#selectCb').change(function() {
                var valor = $('#selectCb').val();
                $('#cb').val(valor);
            });
            $('#selectMarca').change(function() {
                var valor = $('#selectMarca').val();
                $('#marca').val(valor);
            });
            $('#selectPiezas').change(function() {
                var valor = $('#selectPiezas').val();
                $('#piezas').val(valor);
            });

            $("#btn-agregar").click(function() {

                $('#loading').html('<img src="img/ajax-loader-1.gif" width="10%" height="10%">');

                $.ajax({
                    url: dir,
                    type: 'json',
                    async: false,
                    success: function(d) {
                        setTimeout(function() {
                            $('#loading').html('');
                        }, 2000);
                    }
                });

                var missinginfo = "";
                var clave = $("#clave").val();
                var pzs = $("#pzc").val();
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
                if (pzs == "") {
                    missinginfo += "\n El campo Presentación no debe estar Vacío.";
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
            $("#btn-regresar").click(function() {
                self.location = 'Consultas.jsp';
            });



            $("#selectl").empty();
            $("#selectl").append($("<option></option>").text("--Lote--").val("--Lote--"));
            var clavel = $("#clave").val();
            var dir = 'jsp/consultasInv.jsp?ban=1&clave=' + clavel + ''
            $.ajax({
                url: dir,
                type: 'json',
                async: false,
                success: function(data) {
                    MostrarLotes(data);
                },
                error: function() {
                    alert("Ha ocurrido un error");

                }


            });
            function MostrarLotes(data) {

                var json = JSON.parse(data);
                for (var x = 0; x < json.length; x++) {
                    var lote = json[x].lote;
                    $("#selectl").append($("<option></option>").text(lote).val(lote));

                }
            }
            $("#selectCadu").empty();
            $("#selectCadu").append($("<option></option>").text("--Caducidad--").val("--Caducidad--"));

        });
    </script>
    <link rel="stylesheet" href="themes/base/jquery.ui.all.css">
    <script src="jquery-1.9.0.js"></script>
    <script src="ui/jquery.ui.core.js"></script>
    <script src="ui/jquery.ui.widget.js"></script>
    <script src="ui/i18n/jquery.ui.datepicker-es.js"></script>
    <script src="ui/jquery.ui.datepicker.js"></script>

    <script>
        //$("#caducidad").datepicker();
    </script>
</html>
