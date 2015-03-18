<%-- 
    Document   : tabla
    Created on : 28/11/2013, 09:35:40 AM
    Author     : CEDIS TOLUCA3
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%
    ConectionDB con = new ConectionDB();
    HttpSession sesion = request.getSession();
    String usua = "";
    String Usuario = "", Valida = "", Nombre = "", Contador = "",TipoU="";
    int Tipo = 0;

    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("Usuario");
        Nombre = (String) sesion.getAttribute("nombre");
        Tipo = Integer.parseInt((String) sesion.getAttribute("Tipo"));
        System.out.println(Usuario + Nombre + Tipo);
        TipoU = (String) sesion.getAttribute("UbicaU");
    } else {
        response.sendRedirect("index.jsp");
    }
    String Folio = (String) sesion.getAttribute("folio");
    String ubicac1 = (String) sesion.getAttribute("ubicacion");
    String id = (String) sesion.getAttribute("id");
    
    if (TipoU == null){
        TipoU = "";
    }
    System.out.println("Ubica"+TipoU);
  
%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <!---->
        
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
       <script type="text/javascript" language="javascript" src="table_js/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="table_js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/ZeroClipboard.js"></script>
        <script type="text/javascript" charset="utf-8" src="table_js/TableTools.js"></script>
        
        
        <title>SIE Comparación</title>
        </head>
	<body id="dt_example">
            <div class="container-fluid">
               <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4> 
            </div>
            <div class="container">
                <form id="form" name="form" method="post" action="../ServletK">
                    <div class="row">
                        <div>Global:<select id="Ubica" name="Ubica">
                                <option>-Seleccione-</option>
                                <option value="CLAVE">CLAVE</option>
                                <option value="LOTE">LOTE</option>                     
                            </select>                               
                            <button class="btn btn-sm btn-primary" id="btn-mostrar" name="ban" value="16">MOSTRAR&nbsp;<label class="glyphicon glyphicon-search"></label></button>
                            <div id="loading" class="text-center"></div>
                        </div>
                    </div>
                </form>
            </div>            
           <div class="container">
            <div class="panel panel-primary">
                <div class="panel-body">
                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosProv">
                        <thead>
                            <tr>                                
                                <td class="text-center">CLAVE</td>
                                <%if(TipoU.equals("LOTE")){%>
                                <td class="text-center">LOTE</td>
                                <td class="text-center">CADUCIDAD</td>
                                <%}%>
                                <td class="text-center">SISTEMA</td>
                                <td class="text-center">INVENTARIO</td> 
                                <td class="text-center">DIFERENCIAS</td>                                
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    con.conectar();
                                    ResultSet rset = null;
                                    if(!(TipoU.equals(""))){
                                    rset = con.consulta("SELECT F_ClaPro,F_Lote,F_FecCad,F_CantS,F_CantI,F_Dife FROM tb_comparacion2 WHERE F_Tipo='"+TipoU+"' AND F_Usuario='"+usua+"'");
                                    }
                                    while(rset.next()){
                                    
                            %>
                            <tr>
                                <td><%=rset.getString(1)%></td>
                                <%if(TipoU.equals("LOTE")){%>
                                <td class="text-center"><%=rset.getString(2)%></td>
                                <td class="text-center"><%=rset.getString(3)%></td>
                                <%}%>
                                <td class="text-center"><%=rset.getString(4)%></td>
                                <td class="text-center"><%=rset.getString(5)%></td>
                                <td class="text-center"><%=rset.getString(6)%></td>                                
                            </tr>
                            <%  
                                    }
                                 con.cierraConexion();
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
            <div class="row-fluid">
                <footer class="span12"></footer>
            </div>
            <script src="js/jquery-ui-1.10.3.custom.min.js"></script>
    <script src="js/jquery.ui.touch-punch.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.placeholder.js"></script>
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script src="js/flatui-checkbox.js"></script>
    <script src="js/flatui-radio.js"></script>
    <script src="js/jquery-1.9.1"></script>
            
            
            
            
            <script>
		$("footer").load("footer.html");
                
                $('#datosProv').dataTable({
                            
                            //"bScrollInfinite": true,
                            "bScrollCollapse": true,
                            "sScrollY": "400px",
                            "bProcessing": true,
                            "sPaginationType": "full_numbers",
                            "sDom": 'T<"clear">lfrtip',
                            "oTableTools": {"sSwfPath": "table_js/swf/copy_csv_xls_pdf.swf"}
                            
                        });
            </script>
            <script>
                $(document).ready(function(){
                    $("#btn-mostrar").click(function() {
                        var tipo= $('#Ubica').val();
                        if (tipo =='-Seleccione-'){
                            return false;
                        }else{
                            $('#loading').html('<img src="img/ajax-loader-1.gif" width="10%" height="10%">');
                            $.ajax({
                                type: "GET",
                                dataType: "json",
                                url: "../ServletK",
                                success: function (d) {
                                    setTimeout(function () {
                                        $('#loading').html('');
                                    }, 2000);
                                }
                                });
                      }
                    });
                });
            </script>
           </body>
</html>