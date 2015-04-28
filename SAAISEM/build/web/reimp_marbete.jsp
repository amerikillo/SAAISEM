<%-- 
    Document   : Reporte
    Created on : 26/12/2012, 09:05:24 AM
    Author     : Unknown
--%>

<%@page import="conn.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="net.sf.jasperreports.engine.*" %> 
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.sql.*" %> 
<% /*Parametros para realizar la conexión*/

    HttpSession sesion = request.getSession();
    ConectionDB con = new ConectionDB();
    String usua = "";
    int Tarimas = 0, TTarimas = 0, TarimasI = 0, Piezas = 0, TPiezas = 0, Cajas = 0, TCajas = 0, CajasI = 0, Resto = 0, Restop = 0, PiezasT = 0, PiezasC = 0, PiezasTI = 0, TotalP = 0;
    String Clave = "", Cb = "", Lote = "", Cadu = "", Descrip = "", Orden = "";
    if (sesion.getAttribute("nombre") != null) {
        usua = (String) sesion.getAttribute("nombre");
    } else {
        response.sendRedirect("index.jsp");
    }
    String folio_gnk = request.getParameter("fol_gnkl");

    try {
        con.conectar();
        con.insertar("delete from tb_marbetes where F_ClaDoc='" + folio_gnk + "'");
        ResultSet rset = con.consulta("SELECT C.F_ClaPro,M.F_DesPro,L.F_ClaLot,L.F_FecCad,L.F_Cb,C.F_ClaDoc,C.F_OrdCom,C.F_CanCom FROM tb_compra C INNER JOIN tb_lote L ON C.F_Lote=L.F_FolLot INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro WHERE C.F_OrdCom='" + request.getParameter("F_OrdCom") + "' and C.F_FolRemi = '" + request.getParameter("F_FolRemi") + "' GROUP BY C.F_ClaPro,M.F_DesPro,L.F_ClaLot,L.F_FecCad,L.F_Cb,C.F_ClaDoc,C.F_OrdCom,C.F_CanCom");
        while (rset.next()) {
            TPiezas = Integer.parseInt(rset.getString("C.F_CanCom"));
            Clave = rset.getString("C.F_ClaPro");
            Lote = rset.getString("L.F_ClaLot");
            Cb = rset.getString("L.F_Cb");
            Cadu = rset.getString("L.F_FecCad");
            Descrip = rset.getString("M.F_DesPro");
            Orden = rset.getString("C.F_OrdCom");
            TotalP = rset.getInt("C.F_CanCom");

            con.insertar("insert into tb_marbetes values ('" + folio_gnk + "','" + Cb + "','" + Clave + "','" + Descrip + "','" + Lote + "','" + Cadu + "', '"+ Orden +"', '"+ TotalP +"','0')");
                    
            }   
        
        con.cierraConexion();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }

    Connection conexion;
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    conexion = con.getConn();
    /*Establecemos la ruta del reporte*/
    File reportFile = new File(application.getRealPath("reportes/Marbete.jasper"));
    /* No enviamos parámetros porque nuestro reporte no los necesita asi que escriba 
     cualquier cadena de texto ya que solo seguiremos el formato del método runReportToPdf*/
    Map parameters = new HashMap();
    parameters.put("folmar", folio_gnk);
    parameters.put("F_OrdCom", request.getParameter("F_OrdCom"));
    /*Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)*/
    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion);
    /*Indicamos que la respuesta va a ser en formato PDF*/ response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(bytes, 0, bytes.length); /*Limpiamos y cerramos flujos de salida*/ ouputStream.flush();
    ouputStream.close();
%>
