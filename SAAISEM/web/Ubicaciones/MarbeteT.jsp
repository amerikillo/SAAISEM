<%-- 
    Document   : Reporte1
    Created on : 19/12/2013, 10:11:35 AM
    Author     : CEDIS TOLUCA3
--%>
<%@page import="java.io.*"%> 
<%@page import="java.sql.Connection"%> 
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.Map"%> 
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<%
int Fol1=0, Fol2=0,Ban=0;
HttpSession Session = request.getSession();
String Folio1="",Folio2="",Folios1="",Folios2="",Fecha="";
Folio1 = (String)Session.getAttribute("folio1");
Folio2 = (String)Session.getAttribute("folio2");
Ban = Integer.parseInt((String)Session.getAttribute("ban"));
Fecha = (String)Session.getAttribute("fecha");

Fol1 = Folio1.length();
Fol2 = Folio2.length();

if (Fol1 == 1){
    Folios1="      "+Folio1;
}else if (Fol1 == 2){
    Folios1="     "+Folio1;
}else if (Fol1 == 3){
    Folios1="    "+Folio1;
}else if (Fol1 == 4){
    Folios1="   "+Folio1;
}else if (Fol1 == 5){
    Folios1="  "+Folio1;
}else if (Fol1 == 6){
    Folios1=" "+Folio1;
}else if (Fol1 >= 7){
    Folios1=Folio1;
}

if (Fol2 == 1){
    Folios2="      "+Folio2;
}else if (Fol2 == 2){
    Folios2="     "+Folio2;
}else if (Fol2 == 3){
    Folios2="    "+Folio2;
}else if (Fol2 == 4){
    Folios2="   "+Folio2;
}else if (Fol2 == 5){
    Folios2="  "+Folio2;
}else if (Fol2 == 6){
    Folios2=" "+Folio2;
}else if (Fol2 >= 7){
    Folios2=Folio2;
}
%>

<!DOCTYPE html>
<html>
    <%

    Connection conn; 
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); 
    conn = DriverManager.getConnection("jdbc:sqlserver://192.168.2.170:1433;databaseName=gnklmex6","sa","gnklmex");
    if (Ban == 1){
    /*Establecemos la ruta del reporte*/ 
    File reportfile = new File(application.getRealPath("MarbeteTarimaT.jasper")); 
    /* No enviamos parámetros porque nuestro reporte no los necesita */ 
    Map parameter= new HashMap(); 
    //parameter.put("unidad", "1");
    parameter.put("folio1", Folio1);
    parameter.put("folio2", Folio2);
    parameter.put("fecha", Fecha);
    //System.out.println("Uni:"+Unidad+" Fol:"+Folio+" Caj:"+Cajas);
    /*Enviamos la ruta del reporte, los parámetros y la conexión*/ 
    byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter,conn);
    
    /*Indicamos que la respuesta va a ser en formato PDF*/ 
    response.setContentType("application/pdf"); response.setContentLength(bytes.length); ServletOutputStream outputStream= response.getOutputStream(); outputStream.write(bytes,0,bytes.length); 
    /*Limpiamos y cerramos flujos de salida*/ 
    outputStream.flush(); outputStream.close();
        
    }else{
    /*Establecemos la ruta del reporte*/ 
    File reportfile = new File(application.getRealPath("MarbeteTarima.jasper")); 
    /* No enviamos parámetros porque nuestro reporte no los necesita */ 
    Map parameter= new HashMap(); 
    //parameter.put("unidad", "1");
    parameter.put("folio1", Folios1);
    parameter.put("folio2", Folios2);
    
    //System.out.println("Uni:"+Unidad+" Fol:"+Folio+" Caj:"+Cajas);
    /*Enviamos la ruta del reporte, los parámetros y la conexión*/ 
    byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter,conn);
    
    /*Indicamos que la respuesta va a ser en formato PDF*/ 
    response.setContentType("application/pdf"); response.setContentLength(bytes.length); ServletOutputStream outputStream= response.getOutputStream(); outputStream.write(bytes,0,bytes.length); 
    /*Limpiamos y cerramos flujos de salida*/ 
    outputStream.flush(); outputStream.close();
    }
    conn.close();
%>
</html>
