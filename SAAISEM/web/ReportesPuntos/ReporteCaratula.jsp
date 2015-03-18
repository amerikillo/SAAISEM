<%-- 
    Document   : ReporteVertical
    Created on : 6/01/2015, 03:09:40 PM
    Author     : Sistemas
--%>
<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.*"%> 
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.Map"%> 
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

String factura="",Reportes="",Punto="",fecha1="",fecha2="",FoliosFact="",Mes="",Dia="",AA="",Fechas="",FecEntrega="";
String path = getServletContext().getRealPath("/");
out.println(path+"imagenes\\na.png");
String C1=path+"imagenes\\na.png";
String C2=path+"imagenes\\na.png";
String C3=path+"imagenes\\na.png";
String C4=path+"imagenes\\na.png";
String C5=path+"imagenes\\na.png";
String C6=path+"imagenes\\na.png";
String C7=path+"imagenes\\na.png";
String C8=path+"imagenes\\na.png";
int ban=0,puntos=0,Fecha=0;
Statement smtfolio=null;
Statement smtfacturas=null;
ResultSet folio = null;
ResultSet facturas = null;

try{
    factura = request.getParameter("factura");
    ban = Integer.parseInt(request.getParameter("ban"));
    fecha1 = request.getParameter("Fecha1");
    fecha2 = request.getParameter("Fecha2");
}catch(Exception e){}
System.out.println(factura+"//"+ban);
String F_Imagen = path+"imagenes\\check2.png"; 
%>
<html>
    <%
if(ban == 1){
    Connection conn; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gnklmex_isem","root","eve9397");
    //conn = DriverManager.getConnection("jdbc:mysql://189.194.249.165:3306/gnklmex_isem","root","eve9397");    
    smtfolio = conn.createStatement();    
       
        folio = smtfolio.executeQuery("SELECT F_FacGNKLAgr,F_Folios,F_DesUniIS,F_DesJurIS,F_DesCooIS,DATE_FORMAT(F_Fecsur,'%d/%m/%Y') AS F_Fecsur,F_Puntos FROM tb_caratula WHERE F_FacGNKLAgr='"+factura+"'");
        while(folio.next()){    
            puntos = folio.getInt(7);
            Fechas = folio.getString(6);
            Reportes = Reportes + puntos;            
        }
        Dia = Fechas.substring(0,2);
        AA = Fechas.substring(6,10);
        Fecha = Integer.parseInt(Fechas.substring(3,5));
        System.out.println("fecha"+Fecha);
        if (Fecha == 1){
            Mes = "ENERO";
        }else if (Fecha == 2){
            Mes = "FEBRERO";
        }else if (Fecha == 3){
            Mes = "MARZO";
        }else if (Fecha == 4){
            Mes = "ABRIL";
        }else if (Fecha == 5){
            Mes = "MAYO";
        }else if (Fecha == 6){
            Mes = "JUNIO";
        }else if (Fecha == 7){
            Mes = "JULIO";
        }else if (Fecha == 8){
            Mes = "AGOSTO";
        }else if (Fecha == 9){
            Mes = "SEPTIEMBRE";
        }else if (Fecha == 10){
            Mes = "OCTUBRE";
        }else if (Fecha == 11){
            Mes = "NOVIEMBRE";
        }else{
            Mes = "DICIEMBRE";
        }
        
        FecEntrega = Dia+"/"+Mes+"/"+AA;
        
        
        int y = 1;
        for(int x=0; x<Reportes.length(); x++){
             Punto = Reportes.substring(x,y);
            y = y + 1;
            System.out.println("punto:"+Punto);
            
            if(Punto.equals("1")){
                C1 =path+"imagenes\\check2.png";
            }else if(Punto.equals("2")){
                C2 =path+"imagenes\\check2.png";
            }else if(Punto.equals("3")){
                C3 =path+"imagenes\\check2.png";
            }else if(Punto.equals("4")){
                C4 =path+"imagenes\\check2.png";
            }else if(Punto.equals("5")){
                C5 =path+"imagenes\\check2.png";
            }else if(Punto.equals("6")){
                C6 =path+"imagenes\\check2.png";
            }else if(Punto.equals("7")){
                C7 =path+"imagenes\\check2.png";
            }else{
                C8 =path+"imagenes\\check2.png";
            }            
                      
        }
            File reportfile = new File(application.getRealPath("ReportesPuntos/MarbeteSobre.jasper"));
            Map parameter= new HashMap(); 
            
            parameter.put("C1",C1);
            parameter.put("C2",C2);
            parameter.put("C3",C3);
            parameter.put("C4",C4);
            parameter.put("C5",C5);
            parameter.put("C6",C6);
            parameter.put("C7",C7);
            parameter.put("C8",C8);            
            parameter.put("Factura",factura);
            parameter.put("imagen",F_Imagen);
            parameter.put("fecha",FecEntrega);
           
            JasperPrint jasperPrint= JasperFillManager.fillReport(reportfile.getPath(),parameter,conn);
            JasperPrintManager.printReport(jasperPrint,false);    
            Reportes="";
            conn.close();
}else{
    Connection conn; 
    Class.forName("com.mysql.jdbc.Driver"); 
    
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/gnklmex_isem","root","eve9397");
    //conn = DriverManager.getConnection("jdbc:mysql://189.194.249.165:3306/gnklmex_isem","root","eve9397");    
    smtfacturas = conn.createStatement(); 
    smtfolio = conn.createStatement();    
       
        facturas = smtfacturas.executeQuery("SELECT F_FacGNKLAgr FROM tb_caratula WHERE F_Fecsur between '"+fecha1+"' and '"+fecha2+"' group by F_FacGNKLAgr");
        while(facturas.next()){    
            FoliosFact = facturas.getString(1);
            System.out.println("facturas:"+FoliosFact);
            folio = smtfolio.executeQuery("SELECT F_FacGNKLAgr,F_Folios,F_DesUniIS,F_DesJurIS,F_DesCooIS,DATE_FORMAT(F_Fecsur,'%d/%m/%Y') AS F_Fecsur,F_Puntos FROM tb_caratula WHERE F_FacGNKLAgr='"+FoliosFact+"'");
            while(folio.next()){ 
                puntos = folio.getInt(7);
                Fechas = folio.getString(6);
                Reportes = Reportes + puntos;            
            }
            
            Dia = Fechas.substring(0,2);
        AA = Fechas.substring(6,10);
        Fecha = Integer.parseInt(Fechas.substring(3,5));
        System.out.println("fecha"+Fecha);
        if (Fecha == 1){
            Mes = "ENERO";
        }else if (Fecha == 2){
            Mes = "FEBRERO";
        }else if (Fecha == 3){
            Mes = "MARZO";
        }else if (Fecha == 4){
            Mes = "ABRIL";
        }else if (Fecha == 5){
            Mes = "MAYO";
        }else if (Fecha == 6){
            Mes = "JUNIO";
        }else if (Fecha == 7){
            Mes = "JULIO";
        }else if (Fecha == 8){
            Mes = "AGOSTO";
        }else if (Fecha == 9){
            Mes = "SEPTIEMBRE";
        }else if (Fecha == 10){
            Mes = "OCTUBRE";
        }else if (Fecha == 11){
            Mes = "NOVIEMBRE";
        }else{
            Mes = "DICIEMBRE";
        }
        
        FecEntrega = Dia+"/"+Mes+"/"+AA;
        int y = 1;
        for(int x=0; x<Reportes.length(); x++){
            
            Punto = Reportes.substring(x,y);
            y = y + 1;
            System.out.println("punto:"+Punto);
            
            if(Punto.equals("1")){
                C1 =path+"imagenes\\check2.png";
            }else if(Punto.equals("2")){
                C2 =path+"imagenes\\check2.png";
            }else if(Punto.equals("3")){
                C3 =path+"imagenes\\check2.png";
            }else if(Punto.equals("4")){
                C4 =path+"imagenes\\check2.png";
            }else if(Punto.equals("5")){
                C5 =path+"imagenes\\check2.png";
            }else if(Punto.equals("6")){
                C6 =path+"imagenes\\check2.png";
            }else if(Punto.equals("7")){
                C7 =path+"imagenes\\check2.png";
            }else{
                C8 =path+"imagenes\\check2.png";
            }            
                      
        } 
            File reportfile = new File(application.getRealPath("ReportesPuntos/MarbeteSobre.jasper"));
            Map parameter= new HashMap(); 
            
            parameter.put("C1",C1);
            parameter.put("C2",C2);
            parameter.put("C3",C3);
            parameter.put("C4",C4);
            parameter.put("C5",C5);
            parameter.put("C6",C6);
            parameter.put("C7",C7);
            parameter.put("C8",C8);            
            parameter.put("Factura",FoliosFact);
            parameter.put("imagen",F_Imagen);
            parameter.put("fecha",FecEntrega);
           
            JasperPrint jasperPrint= JasperFillManager.fillReport(reportfile.getPath(),parameter,conn);
            JasperPrintManager.printReport(jasperPrint,false);    
            Reportes="";
        }
        conn.close();
}
    
    %>
    <script type="text/javascript">

     var ventana = window.self; 
     ventana.opener = window.self; 
     setTimeout("window.close()", 5000);

</script>
</html>