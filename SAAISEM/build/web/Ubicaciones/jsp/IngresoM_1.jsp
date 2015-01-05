<%-- 
    Document   : consultas
    Created on : 26/11/2013, 06:25:43 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="conn.*" %>
<%@page import="org.json.simple.*" %>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" session="true"%>
<%
HttpSession Session = request.getSession();
String Clave="",Lote="",Cajas="",Resto="",Caducidad="",Pzcj="",Ubica="",ban2="",Folio="";
String Usuario="",Valida="";
int ban=0;

if (Session.getAttribute("Valida") != null){
    Usuario = (String)Session.getAttribute("Usuario");
    Valida = (String)Session.getAttribute("Valida");
    Clave = (String)Session.getAttribute("clave");
    Lote = (String)Session.getAttribute("lote");    
    Caducidad = (String)Session.getAttribute("caducidad");
    Ubica  = (String)Session.getAttribute("ubicacion");
    Pzcj = (String)Session.getAttribute("piezas");
    Cajas = (String)Session.getAttribute("cajas");
    Resto = (String)Session.getAttribute("resto");
    Folio = (String)Session.getAttribute("folio");
    ban = Integer.parseInt((String)Session.getAttribute("ban"));
}

if(!Valida.equals("Valido")){
  response.sendRedirect("/UbicacionesIsem/index.jsp");
}

%>
<%
String QueryDatos="";
int ContL=0,Tcajas=0,Tpiezas=0,Tresto=0,Resultado=0;
ResultSet Consulta = null;

conection Obj = new conection();
try {
    Obj.conectar();
     } catch (Exception ex){}

if (ban == 1){
QueryDatos = "SELECT F_ClaPro from tb_lotes where F_ClaPro='"+Clave+"' and F_Lote='"+Lote+"' and F_Cadu='"+Caducidad+"' and F_Pz='"+Pzcj+"' GROUP BY F_ClaPro";
Consulta = Obj.consulta(QueryDatos);
while(Consulta.next()){
    ContL++;
    }
if (ContL == 0){
    Obj.actualizar("insert into tb_lotes values('"+Clave+"','"+Lote+"','"+Caducidad+"','    2','"+Pzcj+"',0)");
}
if (Cajas !="" && Pzcj !="" && Pzcj !=""){
Tcajas = Integer.parseInt(Cajas);
Tresto = Integer.parseInt(Resto);
Tpiezas = Integer.parseInt(Pzcj);
Resultado = (Tcajas * Tpiezas) + Tresto;
}
Obj.actualizar("insert into tb_ubiexi values('"+Clave+"','"+Lote+"','"+Caducidad+"','"+Ubica+"','"+Pzcj+"','"+Resultado+"','    2','"+Usuario+"',0)");
response.sendRedirect("/UbicacionesIsem/Agregar.jsp");
}else if (ban == 2){
 Obj.actualizar("delete from tb_ubiexi where F_Id='"+Folio+"'");
 response.sendRedirect("/UbicacionesIsem/TomaInv.jsp");
}
Obj.CierreConn();
%>
