<%-- 
    Document   : consultas
    Created on : 26/11/2013, 06:25:43 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="conn.*" %>
<%@page import="org.json.simple.*" %>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%
String QueryDatos="",QueryMov="";
String Clave="",Lote="",Fecha1="",Fecha2="",ConMI="";
String cb="",Folio="",Folios="",Ubicacion="",Ubinew="",CantM="",diferenc="",text="",Id="";
int ban =0,Cantidad=0,CantMov=0,Resultados=0,diferencia=0,Folio2=0;
double Resultado = 0.0;
ResultSet Consulta = null;
ResultSet Movimiento = null;

conection Obj = new conection() ;
try {
    Fecha1 = request.getParameter("fecha1");
    Fecha2 = request.getParameter("fecha2");
    Lote = request.getParameter("lote");
    Clave = request.getParameter("clave");
    ConMI = request.getParameter("concepto");
    Folio = request.getParameter("folio");
    Folios = request.getParameter("folio2");    
    Ubicacion = request.getParameter("ubicacion");
    Ubinew = request.getParameter("ubinew");
    CantM = request.getParameter("cantidad");
    ban = Integer.parseInt(request.getParameter("ban"));
    cb = request.getParameter("cb");
    text = request.getParameter("text");
    diferenc = request.getParameter("diferencia");
    Id = request.getParameter("id");
    Obj.conectar();
     } catch (Exception ex){}
JSONObject json = new JSONObject();
JSONArray jsona = new JSONArray();

if (ban == 1){
    QueryDatos = "select year(MIN(F_FecMI)) as a1,MONTH(MIN(F_FecMI)) as m1,DAY(MIN(F_FecMI)) as d1,year(MAX(F_FecMI)) as a2,MONTH(MAX(F_FecMI)) as m2,DAY(MAX(F_FecMI)) as d2 from TB_MovInv";
     Consulta = Obj.consulta(QueryDatos);
     
     while(Consulta.next()){
     json.put("a1", Consulta.getString("a1"));
     json.put("m1", Consulta.getString("m1"));
     json.put("d1", Consulta.getString("d1"));
     json.put("a2", Consulta.getString("a2"));
     json.put("m2", Consulta.getString("m2"));
     json.put("d2", Consulta.getString("d2"));
     }
     out.println(json);
}else if (ban == 2){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and mov.F_ProMI='"+Clave+"' and lt.F_ClaLot='"+Lote+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 3){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and mov.F_ProMI='"+Clave+"' and lt.F_ClaLot='"+Lote+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 4){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and mov.F_ProMI='"+Clave+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){

    
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}

out.println(jsona);
}else if (ban == 5){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and lt.F_ClaLot='"+Lote+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 6){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and mov.F_ProMI='"+Clave+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 7){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and lt.F_ClaLot='"+Lote+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 8){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 9){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='"+Clave+"' and lt.F_ClaLot='"+Lote+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 10){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='"+Clave+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 11){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where lt.F_ClaLot='"+Lote+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 12){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '"+Fecha1+"' and '"+Fecha2+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 13){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='"+Clave+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 14){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where lt.F_ClaLot='"+Lote+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
  
}

out.println(jsona);
}else if (ban == 15){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 16){
QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='"+Clave+"' and lt.F_ClaLot='"+Lote+"' and mov.F_ConMI='"+ConMI+"' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("fecha",Consulta.getString("FecMov"));
    json.put("concepto",Consulta.getString("concepto"));
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 17){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  L.F_Ubica='"+cb+"' AND L.F_ClaPro='"+Clave+"' AND L.F_ClaLot='"+Lote+"' AND L.F_ExiLot>0 ";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cant"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Cantidad);
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 18){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where L.F_ClaPro='"+Clave+"' AND L.F_ClaLot='"+Lote+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 19){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  L.F_Ubica='"+cb+"' AND L.F_ClaPro='"+Clave+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 20){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  L.F_Ubica='"+cb+"' AND L.F_ClaLot='"+Lote+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 21){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  L.F_ClaPro='"+Clave+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 22){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where L.F_ClaLot='"+Lote+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 23){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where L.F_Ubica='"+cb+"' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 24){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where L.F_Ubica='NUEVA' AND L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 25){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, M.F_DesPro AS descri, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ExiLot>0 AND L.F_IdLote='"+Id+"' AND L.F_FolLot='"+Folio+"' AND L.F_Ubica='"+Ubicacion+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("descripcion",Consulta.getString("descri"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
   // json.put("piezas",Consulta.getString("pz"));
    
    
    
}
out.println(json);
}else if (ban == 26){
QueryDatos = "select F_ClaUbi,F_DesUbi from tb_ubica order by F_DesUbi asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("claubi",Consulta.getString("F_ClaUbi"));
    json.put("desubi",Consulta.getString("F_DesUbi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);    
}else if (ban == 27){
    CantMov = Integer.parseInt(CantM);
    Folio2 = Integer.parseInt(Folio);
    diferencia = Integer.parseInt(diferenc);
QueryDatos = "select F_Can as EXI from TB_UbiExi where F_FolLot='"+Folio+"' AND F_ClaUbi='"+Ubinew+"'";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    Cantidad = Integer.parseInt(Consulta.getString("EXI"));
}
if (Cantidad > 0){
    Resultados = CantMov + Cantidad;   
    Obj.actualizar("update TB_UbiExi set F_Can='"+Resultados+"' from TB_UbiExi UBI  where UBI.F_FolLot='"+Folio+"' and UBI.F_ClaUbi='"+Ubinew+"'");
}else{
    Obj.actualizar("insert into TB_UbiExi values('"+Folio2+"','"+Ubinew+"','"+CantMov+"')");
}
Obj.actualizar("insert into TB_MovUbi values('"+Folio2+"','"+Ubicacion+"','"+CantMov+"',getdate(),'-','sistemas','101')");				

Obj.actualizar("insert into TB_MovUbi values('"+Folio2+"','"+Ubinew+"','"+CantMov+"',getdate(),'-','sistemas','100')");
 
if(diferencia == 0){
    Obj.actualizar("delete TB_UbiExi from TB_UbiExi UBI inner join TB_Ubica U on UBI.F_ClaUbi=U.F_ClaUbi where UBI.F_FolLot='"+Folio+"' and U.F_DesUbi='"+Ubicacion+"'"); 
    response.sendRedirect("Consultas.jsp");
}else{
    Obj.actualizar("update TB_UbiExi set F_Can='"+diferencia+"' from TB_UbiExi UBI inner join TB_Ubica U on UBI.F_ClaUbi=U.F_ClaUbi where UBI.F_FolLot='"+Folio+"' and U.F_DesUbi='"+Ubicacion+"'"); 
    QueryMov="select LT.F_ClaPro as clave,MED.F_DesPro as descri,LT.F_ClaLot as lote,CONVERT(VARCHAR(10),LT.F_FecCad, 103) as Cadu,UE.F_Can AS cant,UBI.F_DesUbi as ubi,UBI.F_ClaUbi as Claubi,UBI.F_Cb as cb,UE.F_FolLot as folio,LT.F_PzCajas as pz from TB_UbiExi UE inner join TB_Lote LT on UE.F_FolLot=LT.F_FolLot inner join TB_Medica MED on LT.F_ClaPro=MED.F_ClaPro inner join TB_Ubica UBI on UE.F_ClaUbi=UBI.F_ClaUbi where UBI.F_DesUbi='"+Ubicacion+"' and LT.F_FolLot='"+Folio+"'";
    Movimiento = Obj.consulta(QueryMov);
    while(Movimiento.next()){
    json.put("clave",Movimiento.getString("clave"));
    json.put("descripcion",Movimiento.getString("descri"));
    json.put("lote",Movimiento.getString("lote"));
    json.put("caducidad",Movimiento.getString("cadu"));
    json.put("cantidad", Movimiento.getString("cant"));
    json.put("ubicacion",Movimiento.getString("ubi"));
    json.put("folio",Movimiento.getString("folio"));
    json.put("piezas",Movimiento.getString("pz"));
    json.put("claubi",Movimiento.getString("Claubi"));
     
    
}
out.println(json);
}
}else if (ban == 28){
QueryDatos = "select top 10  f_nomcli from tb_uniant where F_NomCli like '%"+text+"%' order by f_clacli asc";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("unidad",Consulta.getString("F_NomCli"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);    
}else if (ban == 29){
QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  L.F_ExiLot>0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("cadu"));
    json.put("cantidad", Consulta.getString("cant"));
    json.put("ubicacion",Consulta.getString("ubi"));
    json.put("folio",Consulta.getString("folio"));
    json.put("id",Consulta.getString("L.F_IdLote"));
    json.put("claubi",Consulta.getString("Claubi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 30){
QueryDatos = "SELECT M.F_DocMI,L.F_ClaPro AS CLAVE,L.F_ClaLot AS LOTE,CONVERT(VARCHAR(10),L.F_FecCad, 103) AS CADUCIDAD,SUM(M.F_CanMI) AS CANTIDAD FROM TB_MovInv M INNER JOIN TB_Lote L ON M.F_LotMI=L.F_FolLot WHERE M.F_ConMI BETWEEN '2' AND '50' AND M.F_DocMI BETWEEN '"+Folio+"' and '"+Folios+"' AND M.F_FecMI='"+Fecha1+"' GROUP BY L.F_ClaPro,L.F_ClaLot,L.F_FecCad,M.F_DocMI ORDER BY M.F_DocMI ASC";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("CANTIDAD"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("CLAVE"));
    json.put("lote",Consulta.getString("LOTE"));
    json.put("caducidad",Consulta.getString("CADUCIDAD"));
    json.put("cantidad", Cantidad);
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 31){
QueryDatos = "select comp.F_Produc as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad,SUM(comp.F_Unidad) as cantidad from TB_Compra comp inner join tb_medica med on comp.F_Produc=med.F_ClaPro inner join TB_Lote lt on comp.F_Lote=lt.F_FolLot where comp.F_ClaDoc between '"+Folio+"' and '"+Folios+"' and comp.F_StsCom='A' GROUP BY comp.F_Produc,lt.F_ClaLot,lt.F_FecCad";    
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("cantidad"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("clave"));
    json.put("lote",Consulta.getString("lote"));
    json.put("caducidad",Consulta.getString("caducidad"));
    json.put("cantidad", Cantidad);    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}

Obj.CierreConn();
%>
