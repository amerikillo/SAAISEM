<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="conn.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.lang.*" import="java.util.*" import= "javax.swing.*" import="java.io.*" import="java.text.DateFormat" import="java.text.ParseException" import="java.text.SimpleDateFormat" import="java.util.Calendar" import="java.util.Date"  import="java.text.NumberFormat" import="java.util.Locale" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 

ConectionDB con = new ConectionDB();
NumberFormat nf1 = NumberFormat.getInstance(Locale.US); 
DecimalFormat formatter2 = new DecimalFormat("#,###,###.##");

ResultSet rset2 = null;
ResultSet rset = null;
String fecha1="",fecha2="",radio="",F_Idsur="",F_DesSur="",F_Descob="",F_DesSum="";
int F_IdePro=0,F_Cvesum=0;
double costo=0.0,iva=0.0,total=0.0;
String only="";

	try {
		fecha1 = request.getParameter("f1");       			   
                fecha2 = request.getParameter("f2");       			   
                radio = request.getParameter("ra");       			   
		       			   
        } catch (Exception e) { }
        
        System.out.println("f1"+fecha1+" f2:"+fecha2+" ra:"+radio);
String but="r";
	  

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename=Facturacion TXT.xls");


//ingresar un try y realizar una sola conexión
   
				  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 12">
<link id=Main-File rel=Main-File href="../Libro1.htm">
<link rel=File-List href=filelist.xml>
<!--link rel=Stylesheet href=stylesheet.css-->
<style> 
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.style1 {color: #FF0000}
-->
</style>
<![if !supportTabStrip]><script language="JavaScript"> 
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}
 
if (window.name!="frSheet")
 window.location.replace("../Libro1.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]>
</head>
 
<body link=blue vlink=purple>
 
<table border=0 cellpadding=0 cellspacing=0 width=439 style='border-collapse:
 collapse;table-layout:fixed;width:330pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=101 span=2 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%
         try{
       con.conectar();
       if ((fecha1.equals("")) && (fecha2.equals(""))){
          // out.println("<script>alert('Favor de Introducir Fechas')</script>");
          // out.println("<script>window.history.back()</script>");
       }else{
           if (radio.equals("no")){
               System.out.println("No relacionado");
               rset2   = con.consulta("SELECT F_CooUniIS,F_DesCooIS,F_CveJur,F_DesJurIS,F_Cvemun,F_DesMunIS,F_CveLoc,F_DesLocIS,"
                       + "F_Cveuni,F_DesUniIS,F_Fecsur,F_FacGNKLAgr,F_Puntos,F_Secuencial,F_FacSAVI,F_Canreq,F_Cansur,F_Diferencia,"
                       + "ROUND(F_CostMed,2) AS F_CostMed,F_CosServ,F_Status,F_Idsur,F_IdePro,F_Cvesum "
                       + "FROM tb_txtfacturas "
                       + "WHERE F_Fecsur BETWEEN '"+fecha1+"' AND '"+fecha2+"' AND (F_Status <> 'C' OR F_Status='')  "
                       + "AND F_FacSAVI = ''  AND F_FacGNKLAgr LIKE 'AG-0%'");
           }else{
               System.out.println("Si relacionado");
               rset2 = con.consulta("SELECT F_CooUniIS,F_DesCooIS,F_CveJur,F_DesJurIS,F_Cvemun,F_DesMunIS,F_CveLoc,F_DesLocIS,"
                       + "F_Cveuni,F_DesUniIS,F_Fecsur,F_FacGNKLAgr,F_Puntos,F_Secuencial,F_FacSAVI,F_Canreq,F_Cansur,F_Diferencia,"
                       + "ROUND(F_CostMed,2) AS F_CostMed,F_CosServ,F_Status,F_Idsur,F_IdePro,F_Cvesum "
                       + "FROM tb_txtfacturas "
                       + "WHERE F_Fecsur BETWEEN '"+fecha1+"' AND '"+fecha2+"' AND (F_Status <> 'C' OR F_Status='')  "
                       + "AND F_FacSAVI != ''  AND F_FacGNKLAgr LIKE 'AG-0%'");
           }
  %>
   <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt;mso-ignore:colspan'>F_CooUniIS</td>
  <td class=xl66>F_DesCooIS</td>
  <td class=xl66>F_JurUniIS</td>
  <td class=xl66>F_DesJurIS</td>
  <td class=xl66>F_MunUniIS</td>
  <td class=xl66>F_DesMunIS</td>
  <td class=xl66>F_LocUniIS</td>
  <td class=xl66>F_DesLocIS</td>
  <td class=xl66>F_CveUniT</td>
  <td class=xl66>F_DesUni</td>
  <td class=xl66>F_FecsurT</td>
  <td class=xl66>F_FacGNKLT</td>
  <td class=xl66>F_FolConT</td>
  <td class=xl66>F_Surtido</td>
  <td class=xl66>F_Cobertura</td>
  <td class=xl66>F_Suministro</td>
  <td class=xl66>F_Secuencial</td>
  <td class=xl66>F_FacSAVIT</td>
  <td class=xl66>F_canreq</td>
  <td class=xl66>F_CanSur</td>
  <td class=xl66>F_Diferencia</td>
  <td class=xl66>F_CostMed</td>
  <td class=xl66>F_CostServ</td>
  <td class=xl66>F_IVA</td>
  <td class=xl66>F_Total</td>
  </tr>
  <tr height=20 style='height:15.0pt'>
 
 <%
   while (rset2.next()) {
       F_Idsur=rset2.getString(22);
       F_IdePro=rset2.getInt(23);
       F_Cvesum=rset2.getInt(24);
       costo = rset2.getDouble(19);
       if (F_Idsur.equals(" 1")){
           F_DesSur="ADM";
       }else{
           F_DesSur="VTA";
       }
       if(F_IdePro == 0){
           F_Descob="PA";
       }else{
           F_Descob="SP";
       }
       if(F_Cvesum == 1){
           F_DesSum="MED";
       }else{
           F_DesSum="CUR";
       }
       if (F_DesSum.equals("CUR")){
           iva = costo * 0.16;
           total = costo + iva;
       }
       
 %>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(1)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(2)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(3)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(4)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(5)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(6)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(7)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(8)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(9)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(10)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(11)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(12)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(13)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=F_DesSur%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=F_Descob%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=F_DesSum%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(14)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(15)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(16)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(17)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(18)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(19)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=rset2.getString(20)%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=iva%></td>
  <td height=20 class=xl75 style='height:15.0pt;mso-number-format:"@"'><%=total%></td>    
 
 </tr>
  <%
       iva = 0.0;
       total = 0.0;
   }
       }
       
 %>

 


 
  
  
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=120 style='width:90pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=101 style='width:76pt'></td>
 </tr>
 <![endif]>
</table>
 
</body>
 
</html>
<%
 con.cierraConexion();
 } catch (Exception e) {
     System.out.println(e.getMessage());
 }
                                
%>