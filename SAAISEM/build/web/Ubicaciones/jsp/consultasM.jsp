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
String Cb="",Folio="",Ubicacion="",Ubinew="",CantM="",diferenc="",Usuario="";
int ban =0,Cantidad=0,CantMov=0,Resultados=0,diferencia=0,Folio2=0;
double Resultado = 0.0;
ResultSet Consulta = null;
ResultSet Movimiento = null;

conection Obj = new conection();
try {
    Fecha1 = request.getParameter("fecha1");
    Fecha2 = request.getParameter("fecha2");
    Lote = request.getParameter("lote");
    Clave = request.getParameter("clave");
    ConMI = request.getParameter("concepto");
    Folio = request.getParameter("folio");
    Ubicacion = request.getParameter("ubicacion");
    Ubinew = request.getParameter("ubinew");
    CantM = request.getParameter("cantidad");
    ban = Integer.parseInt(request.getParameter("ban"));
    Cb = request.getParameter("cb");
    diferenc = request.getParameter("diferencia");
    Usuario = request.getParameter("usuario");
    Obj.conectar();
     } catch (Exception ex){}
JSONObject json = new JSONObject();
JSONArray jsona = new JSONArray();

if (ban == 1){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_ClaPro='"+Clave+"' AND LT.F_Lote='"+Lote+"' AND UBI.F_Cb='"+Cb+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 2){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_ClaPro='"+Clave+"' AND LT.F_Lote='"+Lote+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 3){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_ClaPro='"+Clave+"' AND UBI.F_Cb='"+Cb+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 4){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_Lote='"+Lote+"' AND UBI.F_Cb='"+Cb+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 5){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_ClaPro='"+Clave+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 6){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_Lote='"+Lote+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 7){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE UBI.F_Cb='"+Cb+"'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 8){
QueryDatos = "SELECT LT.F_ClaPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE UBI.F_DesUbi='NUEVO'";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);
}else if (ban == 9){
QueryDatos = "SELECT LT.F_ClaPro,MED.F_DesPro,LT.F_Lote,LT.F_Cadu,LT.F_Fabri,MARC.F_DesMar,MED.F_UM,UBIE.F_FolLot,UBI.F_DesUbi,UBI.F_ClaUbi,UBIE.F_CanUbi,LT.F_PzCj,UBI.F_Cb FROM tb_lote LT INNER JOIN tb_marca MARC ON LT.F_ClaMar=MARC.F_ClaMar INNER JOIN tb_medica MED ON LT.F_ClaPro=MED.F_ClaPro INNER JOIN tb_ubiexi UBIE ON LT.F_FolLot=UBIE.F_FolLot INNER JOIN tb_ubica UBI ON UBIE.F_ClaUbi=UBI.F_ClaUbi WHERE LT.F_FolLot='"+Folio+"' AND UBIE.F_ClaUbi='"+Ubicacion+"'";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    Resultado = Double.parseDouble(Consulta.getString("UBIE.F_CanUbi"));
    Cantidad = (int) Resultado;
    json.put("clave",Consulta.getString("LT.F_ClaPro"));
    json.put("descripcion",Consulta.getString("MED.F_DesPro"));
    json.put("lote",Consulta.getString("LT.F_Lote"));
    json.put("caducidad",Consulta.getString("LT.F_Cadu"));
    json.put("fabricacion",Consulta.getString("LT.F_Fabri"));
    json.put("marca",Consulta.getString("MARC.F_DesMar"));
    json.put("um",Consulta.getString("MED.F_UM"));
    json.put("folio",Consulta.getString("UBIE.F_FolLot"));
    json.put("ubicacion",Consulta.getString("UBI.F_DesUbi"));
    json.put("claubi",Consulta.getString("UBI.F_ClaUbi"));
    json.put("cantidad", Cantidad);    
    json.put("piezas",Consulta.getString("LT.F_PzCj"));
    
   
}
out.println(json);
}else if (ban == 10){
QueryDatos = "select F_ClaUbi,F_DesUbi from tb_ubica order by F_Cb+0";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("claubi",Consulta.getString("F_ClaUbi"));
    json.put("desubi",Consulta.getString("F_DesUbi"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);    
}else if (ban == 11){
QueryDatos = "SELECT F_ClaPro,F_DesPro from tb_medica where F_ClaPro = '"+Clave+"' GROUP BY F_ClaPro";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    json.put("clave",Consulta.getString("F_ClaPro"));
    json.put("descripcion",Consulta.getString("F_DesPro"));
    
}
out.println(json);    
}else if (ban == 12){
QueryDatos = "SELECT med.F_ClaPro,med.F_DesPro,med.F_UM from tb_medica med where med.F_ClaPro='"+Clave+"'";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    json.put("clave",Consulta.getString("med.F_ClaPro"));
    json.put("descripcion",Consulta.getString("med.F_DesPro"));
    json.put("um",Consulta.getString("med.F_UM"));
}
out.println(json);    
}else if (ban == 13){
QueryDatos = "SELECT F_ClaMar,F_DesMar from tb_marca";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    json.put("clamar",Consulta.getString("F_ClaMar"));
    json.put("desmar",Consulta.getString("F_DesMar"));
    jsona.add(json);
    json = new JSONObject();
}
out.println(jsona);    
}else if(ban == 14){
    QueryDatos = "SELECT lt.F_ClaLot from tb_lote lt where lt.F_ClaPro='"+Clave+"' group by lt.F_ClaLot";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("lote",Consulta.getString("lt.F_ClaLot"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 15){
    QueryDatos = "SELECT DATE_FORMAT(lt.F_FecCad,'%d/%m/%Y') as F_FecCad from tb_lote lt where lt.F_ClaPro='"+Clave+"' group by lt.F_FecCad";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cadu",Consulta.getString("F_FecCad"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 16){
    QueryDatos = "SELECT lt.F_Fabri from tb_lote lt where lt.F_ClaPro='"+Clave+"' group by lt.F_Fabri";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("fabricacion",Consulta.getString("lt.F_Fabri"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 17){
    QueryDatos = "SELECT mc.F_DesMar,lt.F_ClaMar from tb_lote lt INNER JOIN tb_marca mc on lt.F_ClaMar=mc.F_ClaMar where lt.F_ClaPro='"+Clave+"' group by mc.F_ClaMar";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("marca",Consulta.getString("mc.F_DesMar"));
        json.put("clamarca",Consulta.getString("lt.F_ClaMar"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 18){
    QueryDatos = "SELECT F_Pz from tb_lotes where F_ClaPro='"+Clave+"' group by F_Pz";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("piezas",Consulta.getString("F_Pz"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 19){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where exi.F_ClaPro='"+Clave+"' and exi.F_Lote='"+Lote+"' and ubi.F_Cb='"+Cb+"' and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 20){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where exi.F_ClaPro='"+Clave+"' and exi.F_Lote='"+Lote+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 21){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where exi.F_ClaPro='"+Clave+"' and ubi.F_Cb='"+Cb+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 22){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where  exi.F_Lote='"+Lote+"' and ubi.F_Cb='"+Cb+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 23){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where exi.F_ClaPro='"+Clave+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 24){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where  exi.F_Lote='"+Lote+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 25){
    QueryDatos = "select exi.F_ClaPro,exi.F_Lote,exi.F_Cadu,exi.F_PzCj,ubi.F_DesUbi,exi.F_ExiUbi,exi.F_Id from tb_ubiexi exi INNER JOIN tb_ubicaciones ubi on exi.F_ClaUbi=ubi.F_ClaUbi where ubi.F_Cb='"+Cb+"'  and exi.F_Usuario='"+Usuario+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("clave",Consulta.getString("exi.F_ClaPro"));
        json.put("lote",Consulta.getString("exi.F_Lote"));
        json.put("caducidad",Consulta.getString("exi.F_Cadu"));
        json.put("piezas",Consulta.getString("exi.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("exi.F_ExiUbi"));
        json.put("id",Consulta.getString("exi.F_Id"));       
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 26){
    QueryDatos = "SELECT ubie.F_ClaPro,med.F_DesPro,ubie.F_Lote,ubie.F_Cadu,ubi.F_DesUbi,ubie.F_PzCj,ubie.F_ExiUbi,ubie.F_id from tb_ubiexi ubie INNER JOIN tb_medica med on ubie.F_ClaPro=med.F_Clapro INNER JOIN tb_ubicaciones ubi on ubie.F_ClaUbi=ubi.F_ClaUbi WHERE ubie.F_Id='"+Folio+"'";
    Consulta = Obj.consulta(QueryDatos);
    if(Consulta.next()){
        json.put("clave",Consulta.getString("ubie.F_ClaPro"));
        json.put("descripcion",Consulta.getString("med.F_DesPro"));
        json.put("lote",Consulta.getString("ubie.F_Lote"));
        json.put("caducidad",Consulta.getString("ubie.F_Cadu"));
        json.put("piezas",Consulta.getString("ubie.F_PzCj"));
        json.put("ubicacion",Consulta.getString("ubi.F_DesUbi"));
        json.put("cantidad",Consulta.getString("ubie.F_ExiUbi"));
        json.put("id",Consulta.getString("ubie.F_id"));
        
        }
    out.println(json);    
}else if(ban == 27){
    QueryDatos = "SELECT L.F_ClaOrg,P.F_NomPro FROM tb_lote L INNER JOIN tb_proveedor P ON L.F_ClaOrg=P.F_ClaProve WHERE L.F_ClaPro='"+Clave+"' GROUP BY L.F_ClaOrg,P.F_NomPro ORDER BY L.F_ClaOrg+0";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("claprov",Consulta.getString("L.F_ClaOrg"));
        json.put("nompro",Consulta.getString("P.F_NomPro"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 28){
    QueryDatos = "SELECT F_Cb FROM tb_lote where F_ClaPro='"+Clave+"' GROUP BY F_Cb";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cb",Consulta.getString("F_Cb"));
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 29){
    QueryDatos = "SELECT COUNT(DISTINCT(F_FolLot)) AS CONTADOR FROM tb_lote WHERE F_ClaPro='"+Clave+"'";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("contador",Consulta.getString("CONTADOR"));        
}
    out.println(json);    
}else if (ban == 30){
QueryDatos = "SELECT L.F_ClaPro,M.F_DesPro FROM tb_lote L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro WHERE L.F_ClaPro='"+Clave+"' and L.F_Cb='"+Cb+"' GROUP BY L.F_ClaPro,M.F_DesPro";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    json.put("clave",Consulta.getString("F_ClaPro"));
    json.put("descripcion",Consulta.getString("F_DesPro"));
    
}
out.println(json);    
}else if (ban == 31){
QueryDatos = "SELECT L.F_ClaPro,M.F_DesPro FROM tb_lote L INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro WHERE L.F_Cb='"+Cb+"' GROUP BY L.F_ClaPro,M.F_DesPro";
Consulta = Obj.consulta(QueryDatos);
if(Consulta.next()){
    json.put("clave",Consulta.getString("F_ClaPro"));
    json.put("descripcion",Consulta.getString("F_DesPro"));
    
}
out.println(json);    
}else if(ban == 32){
    QueryDatos = "SELECT lt.F_ClaLot from tb_lote lt where lt.F_ClaPro='"+Clave+"' and Lt.F_Cb='"+Cb+"' group by lt.F_ClaLot";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("lote",Consulta.getString("lt.F_ClaLot"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 33){
    QueryDatos = "SELECT lt.F_ClaLot from tb_lote lt where Lt.F_Cb='"+Cb+"' group by lt.F_ClaLot";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("lote",Consulta.getString("lt.F_ClaLot"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 34){
    QueryDatos = "SELECT DATE_FORMAT(lt.F_FecCad,'%d/%m/%Y') as F_FecCad from tb_lote lt where lt.F_ClaPro='"+Clave+"' and Lt.F_Cb='"+Cb+"' group by lt.F_FecCad";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cadu",Consulta.getString("F_FecCad"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 35){
    QueryDatos = "SELECT DATE_FORMAT(lt.F_FecCad,'%d/%m/%Y') as F_FecCad from tb_lote lt where Lt.F_Cb='"+Cb+"' group by lt.F_FecCad";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cadu",Consulta.getString("F_FecCad"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 36){
    QueryDatos = "SELECT mc.F_DesMar,lt.F_ClaMar from tb_lote lt INNER JOIN tb_marca mc on lt.F_ClaMar=mc.F_ClaMar where lt.F_ClaPro='"+Clave+"' and Lt.F_Cb='"+Cb+"' group by mc.F_ClaMar";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("marca",Consulta.getString("mc.F_DesMar"));
        json.put("clamarca",Consulta.getString("lt.F_ClaMar"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 37){
    QueryDatos = "SELECT mc.F_DesMar,lt.F_ClaMar from tb_lote lt INNER JOIN tb_marca mc on lt.F_ClaMar=mc.F_ClaMar where Lt.F_Cb='"+Cb+"' group by mc.F_ClaMar";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("marca",Consulta.getString("mc.F_DesMar"));
        json.put("clamarca",Consulta.getString("lt.F_ClaMar"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 38){
    QueryDatos = "SELECT L.F_ClaOrg,P.F_NomPro FROM tb_lote L INNER JOIN tb_proveedor P ON L.F_ClaOrg=P.F_ClaProve WHERE L.F_ClaPro='"+Clave+"' and L.F_Cb='"+Cb+"' GROUP BY L.F_ClaOrg,P.F_NomPro ORDER BY L.F_ClaOrg+0";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("claprov",Consulta.getString("L.F_ClaOrg"));
        json.put("nompro",Consulta.getString("P.F_NomPro"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 39){
    QueryDatos = "SELECT L.F_ClaOrg,P.F_NomPro FROM tb_lote L INNER JOIN tb_proveedor P ON L.F_ClaOrg=P.F_ClaProve WHERE L.F_Cb='"+Cb+"' GROUP BY L.F_ClaOrg,P.F_NomPro ORDER BY L.F_ClaOrg+0";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("claprov",Consulta.getString("L.F_ClaOrg"));
        json.put("nompro",Consulta.getString("P.F_NomPro"));
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 40){
    QueryDatos = "SELECT F_Cb FROM tb_lote where F_ClaPro='"+Clave+"' and F_Cb='"+Cb+"' GROUP BY F_Cb";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cb",Consulta.getString("F_Cb"));
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}else if(ban == 41){
    QueryDatos = "SELECT F_Cb FROM tb_lote where F_Cb='"+Cb+"' GROUP BY F_Cb";
    Consulta = Obj.consulta(QueryDatos);
    while(Consulta.next()){
        json.put("cb",Consulta.getString("F_Cb"));
        
        jsona.add(json);
        json = new JSONObject();
}
    out.println(jsona);    
}

Obj.CierreConn();
%>
