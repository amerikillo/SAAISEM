<%-- 
    Document   : catalogoCB
    Created on : 05-dic-2014, 12:42:18
    Author     : amerikillo
--%>

<%@page import="net.sourceforge.jbarcodebean.model.Code128"%>
<%@page import="javax.imageio.*"%>
<%@page import="java.io.*"%>
<%@page import="java.awt.image.*"%>
<%@page import="net.sourceforge.jbarcodebean.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="conn.*" %>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%

    HttpSession sesion = request.getSession();
    String usua = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
    } else {
        response.sendRedirect("index.jsp");
    }
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Estilos CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/cupertino/jquery-ui-1.10.3.custom.css" />
        <link href="../css/navbar-fixed-top.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../css/dataTables.bootstrap.css">
        <!---->
        <title>SIE Sistema de Ingreso de Entradas</title>
    </head>
    <body>
        <div class="container">
            <h1>SIALSS</h1>
            <h4>SISTEMA INTEGRAL DE ADMINISTRACIÓN Y LOGÍSTICA PARA SERVICIOS DE SALUD</h4>
            <hr/>
            <table class="table table-bordered table-condensed table-striped" id="tablaCB">
                <thead>
                    <tr>
                        <td>CLAVE</td>
                        <td>Lote</td>
                        <td>Caducidad</td>
                        <td>SAP</td>
                        <td>CB</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select l.F_ClaPro, m.F_ClaSap, l.F_Cb, m.F_DesPro, l.F_ClaLot, l.F_FecCad from tb_lote l, tb_medica m where l.F_ClaPro = m.F_ClaPro group by l.F_ClaPro, l.F_Cb, l.F_ClaLot, l.F_FecCad");

                            while (rset.next()) {
                                try {
                                    JBarcodeBean barcode = new JBarcodeBean();
                                    barcode.setCodeType(new Code128());
                                    barcode.setCode(rset.getString("F_Cb"));
                                    barcode.setCheckDigit(true);
                                    barcode.setBounds(0, 0, 400, 100);
                                    barcode.setSize(400, 400);
                                    barcode.setSize(10000, 10000);
                                    //barcode.
                                    BufferedImage bufferedImage = barcode.draw(new BufferedImage(200, 100, BufferedImage.TYPE_INT_RGB));
                                    File file = new File(getServletContext().getRealPath("imagenes/cb") + "/" + rset.getString("F_Cb") + ".png");
                                    ImageIO.write(bufferedImage, "png", file);
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                    %>
                    <tr>
                        <td title="<%=rset.getString("F_DesPro")%>"><h3><%=rset.getString("F_ClaPro")%></h3></td>
                        <td><h4><%=rset.getString("F_ClaLot")%></h4></td>
                        <td><h4><%=rset.getString("F_FecCad")%></h4></td>
                        <td><h4><%=rset.getString("F_ClaSap")%></h4></td>
                        <td><h4><%=rset.getString("F_Cb")%></h4></td>
                        <td><img src="../imagenes/cb/<%=rset.getString("F_Cb")%>.png" width="350 px" /></td>
                    </tr>
                    <%   }
                            con.cierraConexion();
                        } catch (Exception e) {
                            out.println(e.getMessage());
                        }
                    %>
                </tbody>
            </table>
        </div>
        <!-- ================================================== -->
        <!-- Se coloca al final del documento para que cargue mas rapido -->
        <!-- Se debe de seguir ese orden al momento de llamar los JS -->
        <script src="../js/jquery-1.9.1.js"></script>
        <script src="../js/bootstrap.js"></script>
        <script src="../js/jquery-ui-1.10.3.custom.js"></script>
        <script src="../js/jquery.dataTables.js"></script>
        <script src="../js/dataTables.bootstrap.js"></script>
        <script>
                $(document).ready(function () {
            $('#tablaCB').dataTable();     });
        </script>
    </body>
</html>
