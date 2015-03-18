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
    int Tarimas = 0, TTarimas = 0, TarimasI = 0, Piezas = 0, TPiezas = 0, Cajas = 0, TCajas = 0, CajasI = 0, Resto = 0, PiezasT = 0, PiezasC = 0, PiezasTI = 0, TotalP = 0;
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
        ResultSet rset = con.consulta("SELECT C.F_ClaPro,M.F_DesPro,L.F_ClaLot,L.F_FecCad,L.F_Cb,C.F_ClaDoc,C.F_OrdCom,C.F_CanCom,COM.F_Pz,COM.F_Tarimas,COM.F_TarimasI,COM.F_Cajas,COM.F_CajasI,COM.F_Resto FROM tb_compra C INNER JOIN tb_compraregistro COM ON C.F_OrdCom=COM.F_OrdCom AND C.F_ClaPro=COM.F_ClaPro AND C.F_CanCom=COM.F_Pz INNER JOIN tb_lote L ON C.F_Lote=L.F_FolLot INNER JOIN tb_medica M ON C.F_ClaPro=M.F_ClaPro WHERE C.F_ClaDoc='" + folio_gnk + "' GROUP BY C.F_IdCom");
        while (rset.next()) {
            TTarimas = Integer.parseInt(rset.getString("COM.F_Tarimas"));
            TarimasI = Integer.parseInt(rset.getString("COM.F_TarimasI"));
            TPiezas = Integer.parseInt(rset.getString("C.F_CanCom"));
            TCajas = Integer.parseInt(rset.getString("COM.F_Cajas"));
            CajasI = Integer.parseInt(rset.getString("COM.F_CajasI"));
            Resto = Integer.parseInt(rset.getString("COM.F_Resto"));
            Clave = rset.getString("C.F_ClaPro");
            Lote = rset.getString("L.F_ClaLot");
            Cb = rset.getString("L.F_Cb");
            Cadu = rset.getString("L.F_FecCad");
            Descrip = rset.getString("M.F_DesPro");
            Orden = rset.getString("C.F_OrdCom");

            Tarimas = TTarimas - TarimasI;
                Piezas = TPiezas - Resto;
                if(Resto > 0){
                    if (TCajas > 1){
                    PiezasC = Piezas / (TCajas - 1);
                    }
                    Cajas = TCajas - ( CajasI + 1 );  
                }else{
                PiezasC = Piezas / TCajas;    
                Cajas = TCajas - CajasI;  
                }
                
                //Cajas = TCajas - CajasI;                 
                PiezasT = Cajas * PiezasC;
                
                if (Cajas > 0 && Tarimas != 0){
                    TotalP = PiezasT / Tarimas;
                for (int i = 0; i < Tarimas; i++) {
                    con.insertar("insert into tb_marbetes values ('" + folio_gnk + "','" + Cb + "','" + Clave + "','" + Descrip + "','" + Lote + "','" + Cadu + "', '"+ Orden +"', '"+ TotalP +"','0')");
            }
                }
                
                PiezasTI = (CajasI * PiezasC) + Resto;                
                con.insertar("insert into tb_marbetes values ('" + folio_gnk + "','" + Cb + "','" + Clave + "','" + Descrip + "','" + Lote + "','" + Cadu + "', '"+ Orden +"', '"+ PiezasTI +"','0')");
                
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
    /*Enviamos la ruta del reporte, los parámetros y la conexión(objeto Connection)*/
    byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conexion);
    /*Indicamos que la respuesta va a ser en formato PDF*/ response.setContentType("application/pdf");
    response.setContentLength(bytes.length);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(bytes, 0, bytes.length); /*Limpiamos y cerramos flujos de salida*/ ouputStream.flush();
    ouputStream.close();
%>
