<%-- 
    Document   : consultas
    Created on : 26/11/2013, 06:25:43 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page import="conn.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.*" %>

<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%
    String QueryDatos = "", QueryMov = "", QueryUbi="",QueryComp="",QueryCompS="",QueryCompU="";
    String Clave = "", Lote = "", Fecha1 = "", Fecha2 = "", ConMI = "", Provee="",usuario="";
    String cb = "", Folio = "", Folios = "", Ubicacion = "", Ubinew = "", CantM = "", diferenc = "", text = "", Id = "";
    int ban = 0, Cantidad = 0, CantMov = 0, Resultados = 0, diferencia = 0, Folio2 = 0;
    String ClaveU="",ClaveC="",CantidadS="",CantidadUB="",LoteU="",LoteC="",Cadu="",CaduC="",CaduU="",Fecha="";
    int CantidadU=0,conts=0,CantidadSG=0,contu=0,CantidadUBI=0,Diferencia=0;
    double Resultado = 0.0,ResultadoU=0.0;
    ResultSet Consulta = null; 
    ResultSet ConsultaUbi = null;
    ResultSet Movimiento = null;
    ResultSet ConsultaComp = null; 
    ResultSet ConsultaCompS = null;
    ResultSet ConsultaCompU = null;
    ConectionDB ObjMySQL = new ConectionDB();
    conection Obj = new conection();
    ConectionDBInv ObjInv = new ConectionDBInv();
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
        Provee = request.getParameter("provee");        
        diferenc = request.getParameter("diferencia");
        Id = request.getParameter("id");
        usuario = request.getParameter("usuario");
        Obj.conectar();
        ObjInv.conectar();
        ObjMySQL.conectar();
    } catch (Exception ex) {
    }
    JSONObject json = new JSONObject();
    JSONArray jsona = new JSONArray();

    if (ban == 1) {
        QueryDatos = "select year(MIN(F_FecMI)) as a1,MONTH(MIN(F_FecMI)) as m1,DAY(MIN(F_FecMI)) as d1,year(MAX(F_FecMI)) as a2,MONTH(MAX(F_FecMI)) as m2,DAY(MAX(F_FecMI)) as d2 from TB_MovInv";
        Consulta = Obj.consulta(QueryDatos);

        while (Consulta.next()) {
            json.put("a1", Consulta.getString("a1"));
            json.put("m1", Consulta.getString("m1"));
            json.put("d1", Consulta.getString("d1"));
            json.put("a2", Consulta.getString("a2"));
            json.put("m2", Consulta.getString("m2"));
            json.put("d2", Consulta.getString("d2"));
        }
        out.println(json);
    } else if (ban == 2) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and mov.F_ProMI='" + Clave + "' and lt.F_ClaLot='" + Lote + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 3) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and mov.F_ProMI='" + Clave + "' and lt.F_ClaLot='" + Lote + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 4) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and mov.F_ProMI='" + Clave + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {

            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;

            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }

        out.println(jsona);
    } else if (ban == 5) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and lt.F_ClaLot='" + Lote + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 6) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and mov.F_ProMI='" + Clave + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 7) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and lt.F_ClaLot='" + Lote + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 8) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 9) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='" + Clave + "' and lt.F_ClaLot='" + Lote + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 10) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='" + Clave + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 11) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where lt.F_ClaLot='" + Lote + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 12) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_FecMI between '" + Fecha1 + "' and '" + Fecha2 + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 13) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='" + Clave + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 14) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where lt.F_ClaLot='" + Lote + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {

            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();

        }

        out.println(jsona);
    } else if (ban == 15) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 16) {
        QueryDatos = "select CONVERT(VARCHAR(10),mov.F_FecMI, 103) as FecMov,mov.F_ConMI as concepto,mov.F_ProMI as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad, mov.F_CanMI as cantidad from TB_MovInv mov inner join TB_Lote lt on mov.F_LotMI=lt.F_FolLot where mov.F_ProMI='" + Clave + "' and lt.F_ClaLot='" + Lote + "' and mov.F_ConMI='" + ConMI + "' order by mov.F_FecMI,mov.F_ProMI,lt.F_ClaLot,lt.F_FecCad asc";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("fecha", Consulta.getString("FecMov"));
            json.put("concepto", Consulta.getString("concepto"));
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 17) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  U.F_Cb='" + cb + "' AND L.F_ClaPro='" + Clave + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0 ";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cant"));
            Cantidad = (int) Resultado;
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Cantidad);
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 18) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ClaPro='" + Clave + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 19) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  U.F_Cb='" + cb + "' AND L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 20) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  U.F_Cb='" + cb + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 21) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 22) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 23) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where U.F_Cb='" + cb + "' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 24) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_Ubica='NUEVA' AND L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 25) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, M.F_DesPro AS descri, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ExiLot>0 AND L.F_IdLote='" + Id + "' AND L.F_FolLot='" + Folio + "' AND L.F_Ubica='" + Ubicacion + "'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("descripcion", Consulta.getString("descri"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
   // json.put("piezas",Consulta.getString("pz"));

        }
        out.println(json);
    } else if (ban == 26) {
        QueryDatos = "select F_ClaUbi,F_DesUbi from tb_ubica order by F_Cb+0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("claubi", Consulta.getString("F_ClaUbi"));
            json.put("desubi", Consulta.getString("F_DesUbi"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 27) {
        CantMov = Integer.parseInt(CantM);
        Folio2 = Integer.parseInt(Folio);
        diferencia = Integer.parseInt(diferenc);
        QueryDatos = "select F_Can as EXI from TB_UbiExi where F_FolLot='" + Folio + "' AND F_ClaUbi='" + Ubinew + "'";
        Consulta = Obj.consulta(QueryDatos);
        if (Consulta.next()) {
            Cantidad = Integer.parseInt(Consulta.getString("EXI"));
        }
        if (Cantidad > 0) {
            Resultados = CantMov + Cantidad;
            Obj.actualizar("update TB_UbiExi set F_Can='" + Resultados + "' from TB_UbiExi UBI  where UBI.F_FolLot='" + Folio + "' and UBI.F_ClaUbi='" + Ubinew + "'");
        } else {
            Obj.actualizar("insert into TB_UbiExi values('" + Folio2 + "','" + Ubinew + "','" + CantMov + "')");
        }
        Obj.actualizar("insert into TB_MovUbi values('" + Folio2 + "','" + Ubicacion + "','" + CantMov + "',getdate(),'-','sistemas','101')");

        Obj.actualizar("insert into TB_MovUbi values('" + Folio2 + "','" + Ubinew + "','" + CantMov + "',getdate(),'-','sistemas','100')");

        if (diferencia == 0) {
            Obj.actualizar("delete TB_UbiExi from TB_UbiExi UBI inner join TB_Ubica U on UBI.F_ClaUbi=U.F_ClaUbi where UBI.F_FolLot='" + Folio + "' and U.F_DesUbi='" + Ubicacion + "'");
            response.sendRedirect("Consultas.jsp");
        } else {
            Obj.actualizar("update TB_UbiExi set F_Can='" + diferencia + "' from TB_UbiExi UBI inner join TB_Ubica U on UBI.F_ClaUbi=U.F_ClaUbi where UBI.F_FolLot='" + Folio + "' and U.F_DesUbi='" + Ubicacion + "'");
            QueryMov = "select LT.F_ClaPro as clave,MED.F_DesPro as descri,LT.F_ClaLot as lote,CONVERT(VARCHAR(10),LT.F_FecCad, 103) as Cadu,UE.F_Can AS cant,UBI.F_DesUbi as ubi,UBI.F_ClaUbi as Claubi,UBI.F_Cb as cb,UE.F_FolLot as folio,LT.F_PzCajas as pz from TB_UbiExi UE inner join TB_Lote LT on UE.F_FolLot=LT.F_FolLot inner join TB_Medica MED on LT.F_ClaPro=MED.F_ClaPro inner join TB_Ubica UBI on UE.F_ClaUbi=UBI.F_ClaUbi where UBI.F_DesUbi='" + Ubicacion + "' and LT.F_FolLot='" + Folio + "'";
            Movimiento = Obj.consulta(QueryMov);
            while (Movimiento.next()) {
                json.put("clave", Movimiento.getString("clave"));
                json.put("descripcion", Movimiento.getString("descri"));
                json.put("lote", Movimiento.getString("lote"));
                json.put("caducidad", Movimiento.getString("cadu"));
                json.put("cantidad", Movimiento.getString("cant"));
                json.put("ubicacion", Movimiento.getString("ubi"));
                json.put("folio", Movimiento.getString("folio"));
                json.put("piezas", Movimiento.getString("pz"));
                json.put("claubi", Movimiento.getString("Claubi"));

            }
            out.println(json);
        }
    } else if (ban == 28) {
        QueryDatos = "select f_nomcli from tb_uniatn where F_NomCli like '%" + text + "%' order by f_clacli asc LIMIT 0,10";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("unidad", Consulta.getString("F_NomCli"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 29) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  L.F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 30) {
        QueryDatos = "SELECT M.F_DocMI,L.F_ClaPro AS CLAVE,L.F_ClaLot AS LOTE,CONVERT(VARCHAR(10),L.F_FecCad, 103) AS CADUCIDAD,SUM(M.F_CanMI) AS CANTIDAD FROM TB_MovInv M INNER JOIN TB_Lote L ON M.F_LotMI=L.F_FolLot WHERE M.F_ConMI BETWEEN '2' AND '50' AND M.F_DocMI BETWEEN '" + Folio + "' and '" + Folios + "' AND M.F_FecMI='" + Fecha1 + "' GROUP BY L.F_ClaPro,L.F_ClaLot,L.F_FecCad,M.F_DocMI ORDER BY M.F_DocMI ASC";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("CANTIDAD"));
            Cantidad = (int) Resultado;
            json.put("clave", Consulta.getString("CLAVE"));
            json.put("lote", Consulta.getString("LOTE"));
            json.put("caducidad", Consulta.getString("CADUCIDAD"));
            json.put("cantidad", Cantidad);

            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 31) {
        QueryDatos = "select comp.F_Produc as clave,lt.F_ClaLot as lote,CONVERT(VARCHAR(10),lt.F_FecCad, 103) as caducidad,SUM(comp.F_Unidad) as cantidad from TB_Compra comp inner join tb_medica med on comp.F_Produc=med.F_ClaPro inner join TB_Lote lt on comp.F_Lote=lt.F_FolLot where comp.F_ClaDoc between '" + Folio + "' and '" + Folios + "' and comp.F_StsCom='A' GROUP BY comp.F_Produc,lt.F_ClaLot,lt.F_FecCad";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cantidad"));
            Cantidad = (int) Resultado;
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("caducidad"));
            json.put("cantidad", Cantidad);
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 32) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant, U.F_ClaUbi AS Claubi,U.F_DesUbi AS ubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi  INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro WHERE L.F_Cb='"+cb+"' and L.F_ExiLot>'0'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 33) {
        QueryDatos = "SELECT sum(f_exilot) as cant  FROM tb_lote ";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("existencia", Consulta.getString("cant"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 34) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi where  U.F_Cb='" + cb + "' AND L.F_ClaPro='" + Clave + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            Resultado = Double.parseDouble(Consulta.getString("cant"));
            Cantidad = (int) Resultado;
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Cantidad);
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 35) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ClaPro='" + Clave + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 36) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  U.F_Cb='" + cb + "' AND L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 37) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  U.F_Cb='" + cb + "' AND L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 38) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  L.F_ClaPro='" + Clave + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 39) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where L.F_ClaLot='" + Lote + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    } else if (ban == 40) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where U.F_Cb='" + cb + "' AND L.F_ExiLot>0 OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 41) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant, U.F_ClaUbi AS Claubi,U.F_DesUbi AS ubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro WHERE L.F_Cb='"+cb+"' and L.F_ExiLot>'0' OR L.F_Ubica LIKE '%CH%' AND L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 42) {
        QueryDatos = "SELECT L.F_IdLote,L.F_ClaPro AS clave, L.F_ClaLot AS lote,DATE_FORMAT(L.F_FecCad,'%d/%m/%Y') AS Cadu,L.F_ExiLot AS cant,U.F_DesUbi AS ubi, L.F_Ubica AS Claubi, L.F_FolLot AS folio,M.F_DesPro FROM tb_lote L INNER JOIN tb_ubica U ON L.F_Ubica=U.F_ClaUbi INNER JOIN tb_medica M ON L.F_ClaPro=M.F_ClaPro where  L.F_ExiLot>0 AND L.F_Ubica LIKE '%CH%' OR L.F_Ubica LIKE'%CJ%'";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("clave"));
            json.put("lote", Consulta.getString("lote"));
            json.put("caducidad", Consulta.getString("cadu"));
            json.put("cantidad", Consulta.getString("cant"));
            json.put("ubicacion", Consulta.getString("ubi"));
            json.put("folio", Consulta.getString("folio"));
            json.put("id", Consulta.getString("L.F_IdLote"));
            json.put("claubi", Consulta.getString("Claubi"));
            json.put("descrip", Consulta.getString("M.F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 43) {
        QueryDatos = "select F_ClaUbi,F_DesUbi from tb_ubica WHERE F_DesUbi LIKE '%CH%' OR F_DesUbi LIKE '%CJ%' order by F_Cb+0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("claubi", Consulta.getString("F_ClaUbi"));
            json.put("desubi", Consulta.getString("F_DesUbi"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 44) {
        QueryDatos = "SELECT COUNT(F_ClaPro) as cantidad FROM tb_lote WHERE F_ExiLot>0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("cantidad", Consulta.getString("cantidad"));
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 45) {
        QueryDatos = "select F_ClaUbi from tb_ubica where F_ClaUbi like '%" + text + "%' order by F_Cb+0 LIMIT 0,10";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("ubicac", Consulta.getString("F_ClaUbi"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 46) {
        QueryDatos = "select F_ClaUbi from tb_ubica where F_ClaUbi LIKE '%CH%' OR F_ClaUbi LIKE '%CJ%' order by F_Cb+0 LIMIT 0,10";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("ubicac", Consulta.getString("F_ClaUbi"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 47) {
        QueryDatos = "SELECT p.F_NomPro,c.F_ClaPro,l.F_ClaLot,SUM(F_CanCom) as cantidad,DATE_FORMAT(F_FecApl,'%d/%m/%Y') as fecha,c.F_OrdCom,c.F_ClaDoc,c.F_FolRemi,c.F_User,m.F_Costo,(m.F_Costo * SUM(F_CanCom)) as monto FROM tb_compra c INNER JOIN tb_proveedor p on c.F_ClaOrg=p.F_ClaProve INNER JOIN (SELECT F_FolLot,F_ClaLot FROM tb_lote GROUP BY F_FolLot) l on c.F_Lote=l.F_FolLot INNER JOIN tb_medica m on c.F_ClaPro=m.F_ClaPro where p.F_NomPro='"+text+"' GROUP BY p.F_NomPro,c.F_ClaPro,l.F_ClaLot,c.F_FecApl,c.F_OrdCom,c.F_ClaDoc,c.F_FolRemi,c.F_User";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("proveedor", Consulta.getString("p.F_NomPro"));
            json.put("clave", Consulta.getString("c.F_ClaPro"));
            json.put("lote", Consulta.getString("l.F_ClaLot"));
            json.put("cantidad", Consulta.getString("cantidad"));
            json.put("fecha", Consulta.getString("fecha"));
            json.put("oc", Consulta.getString("c.F_OrdCom"));
            json.put("documento", Consulta.getString("c.F_ClaDoc"));
            json.put("remision", Consulta.getString("c.F_FolRemi"));
            json.put("user", Consulta.getString("c.F_User"));
            json.put("costo", Consulta.getString("m.F_Costo"));
            json.put("monto", Consulta.getString("monto"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 48) {
        QueryDatos = "SELECT F_NomPro FROM tb_proveedor ORDER BY F_ClaProve+0";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("proveed", Consulta.getString("F_NomPro"));
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 49) {
        QueryDatos = "SELECT p.F_NomPro,c.F_ClaPro,l.F_ClaLot,SUM(F_CanCom) as cantidad,DATE_FORMAT(F_FecApl,'%d/%m/%Y') as fecha,c.F_OrdCom,c.F_ClaDoc,c.F_FolRemi,c.F_User,m.F_Costo,(m.F_Costo * SUM(F_CanCom)) as monto FROM tb_compra c INNER JOIN tb_proveedor p on c.F_ClaOrg=p.F_ClaProve INNER JOIN (SELECT F_FolLot,F_ClaLot FROM tb_lote GROUP BY F_FolLot) l on c.F_Lote=l.F_FolLot INNER JOIN tb_medica m on c.F_ClaPro=m.F_ClaPro where c.F_FecApl='"+text+"' GROUP BY p.F_NomPro,c.F_ClaPro,l.F_ClaLot,c.F_FecApl,c.F_OrdCom,c.F_ClaDoc,c.F_FolRemi,c.F_User";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("proveedor", Consulta.getString("p.F_NomPro"));
            json.put("clave", Consulta.getString("c.F_ClaPro"));
            json.put("lote", Consulta.getString("l.F_ClaLot"));
            json.put("cantidad", Consulta.getString("cantidad"));
            json.put("fecha", Consulta.getString("fecha"));
            json.put("oc", Consulta.getString("c.F_OrdCom"));
            json.put("documento", Consulta.getString("c.F_ClaDoc"));
            json.put("remision", Consulta.getString("c.F_FolRemi"));
            json.put("user", Consulta.getString("c.F_User"));
            json.put("costo", Consulta.getString("m.F_Costo"));
            json.put("monto", Consulta.getString("monto"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 50) {
        QueryDatos = "select u.F_ClaCli, u.F_NomCli from tb_uniatn u, tb_facttemp f where u.F_StsCli = 'A' and f.F_ClaCli = u.F_ClaCli group by u.F_ClaCli";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clavepro", Consulta.getString("u.F_ClaCli"));
            json.put("nombrepro", Consulta.getString("u.F_NomCli"));
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 51) {
        QueryDatos = "SELECT l.F_ClaPro FROM	tb_facttemp f,	tb_lote l,	tb_uniatn u,	tb_pzxcaja p WHERE	f.F_IdLot = l.F_IdLote AND f.F_ClaCli = u.F_ClaCli AND p.F_ClaPro = l.F_ClaPro AND f.F_ClaCli = '" + text + "' GROUP BY l.F_ClaPro";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("clave", Consulta.getString("l.F_ClaPro"));            
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 52) {
        QueryDatos = "SELECT	l.F_ClaLot FROM	tb_facttemp f,	tb_lote l,	tb_uniatn u,	tb_pzxcaja p WHERE	f.F_IdLot = l.F_IdLote AND f.F_ClaCli = u.F_ClaCli AND p.F_ClaPro = l.F_ClaPro AND f.F_ClaCli = '"+text+"' GROUP BY	l.F_ClaLot";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("lote", Consulta.getString("l.F_ClaLot"));            
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 53) {
        QueryDatos = "SELECT DATE_FORMAT(l.F_FecCad, '%d/%m/%Y') as fecha FROM	tb_facttemp f,	tb_lote l,	tb_uniatn u,	tb_pzxcaja p WHERE	f.F_IdLot = l.F_IdLote AND f.F_ClaCli = u.F_ClaCli AND p.F_ClaPro = l.F_ClaPro AND f.F_ClaCli = '"+text+"' GROUP BY l.F_FecCad";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("fecha", Consulta.getString("fecha"));            
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 54) {
        QueryDatos = "SELECT	l.F_ClaLot FROM	tb_facttemp f,	tb_lote l,	tb_uniatn u,	tb_pzxcaja p WHERE	f.F_IdLot = l.F_IdLote AND f.F_ClaCli = u.F_ClaCli AND p.F_ClaPro = l.F_ClaPro AND f.F_ClaCli = '"+Provee+"' and  l.F_ClaPro = '"+text+"' GROUP BY	l.F_ClaLot";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("fecha", Consulta.getString("fecha"));            
            
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 55) {
        QueryDatos = "select F_DesPro FROM tb_medica WHERE F_DesPro like '%" + text + "%' order by F_DesPro ASC LIMIT 0,10";
        Consulta = Obj.consulta(QueryDatos);
        while (Consulta.next()) {
            json.put("ubicac", Consulta.getString("F_DesPro"));
            jsona.add(json);
            json = new JSONObject();
        }
        out.println(jsona);
    }else if (ban == 56) {
            ObjMySQL.actualizar("DELETE FROM tb_comparacion WHERE F_Tipo='"+text+"' and F_Usuario='"+usuario+"'");

        if (text.equals("CLAVE")){
            QueryDatos = "SELECT F_ClaPro AS clave,SUM(F_ExiLot) AS cantidad FROM tb_lote  WHERE F_ExiLot>0 GROUP BY F_ClaPro ORDER BY F_ClaPro ASC";    
            Consulta = ObjMySQL.consulta(QueryDatos);
            while(Consulta.next()){
                Resultado = Double.parseDouble(Consulta.getString("cantidad"));
                Cantidad = (int) Resultado;
                Clave = Consulta.getString("clave");                
            ObjMySQL.actualizar("insert into TB_Comparacion values('"+Clave+"','-',curdate(),'"+Cantidad+"','sistemas','CLAVE','"+usuario+"',0)");        
            }
            QueryUbi="SELECT F_ClaPro AS clave,SUM(F_ExiLot) AS cantidad FROM tb_lote  WHERE F_ExiLot>0 GROUP BY F_ClaPro ORDER BY F_ClaPro ASC";
            ConsultaUbi = ObjInv.consulta(QueryUbi);
            while(ConsultaUbi.next()){
                ClaveU = ConsultaUbi.getString("clave");
                ResultadoU = Double.parseDouble(ConsultaUbi.getString("cantidad"));
                CantidadU = (int) ResultadoU;
                ObjMySQL.actualizar("insert into TB_Comparacion values('"+ClaveU+"','-',curdate(),'"+CantidadU+"','inventario','CLAVE','"+usuario+"',0)");
            }
            QueryComp="SELECT F_ClaPro from tb_comparacion where F_Tipo='CLAVE' and F_Usuario='"+usuario+"' GROUP BY F_ClaPro";
            ConsultaComp = ObjMySQL.consulta(QueryComp);
            while(ConsultaComp.next()){
                ClaveC = ConsultaComp.getString("F_ClaPro");
                QueryCompS="select F_ClaPro,SUM(F_Cantidad) as cantidad from tb_comparacion where F_ClaPro='"+ClaveC+"' AND F_Tipo='CLAVE' AND F_Sistemas='sistemas' and F_Usuario='"+usuario+"' group by F_ClaPro";
                ConsultaCompS = ObjMySQL.consulta(QueryCompS);
                while(ConsultaCompS.next()){
                    CantidadS=ConsultaCompS.getString("cantidad");
                    conts++;
                }
                if(conts>0){
                    CantidadSG=Integer.parseInt(CantidadS);
                }else{
                    CantidadSG=0;
                }
                QueryCompU="select F_ClaPro,SUM(F_Cantidad) as cantidad from tb_comparacion where F_ClaPro='"+ClaveC+"' AND F_Tipo='CLAVE' AND F_Sistemas='inventario' and F_Usuario='"+usuario+"' group by F_ClaPro";
                ConsultaCompU = ObjMySQL.consulta(QueryCompU);
                while(ConsultaCompU.next()){
                    CantidadUB=ConsultaCompU.getString("cantidad");
                    contu++;
                }
                if (contu>0){
                    CantidadUBI = Integer.parseInt(CantidadUB);
                }else{
                    CantidadUBI = 0;
                }
                Diferencia = CantidadUBI - CantidadSG;
                conts = 0;
                contu = 0;
                json.put("clave",ClaveC);                
                json.put("cantidads",CantidadUBI);
                json.put("cantidadu",CantidadSG);
                json.put("dife",Diferencia);
                jsona.add(json);
                json = new JSONObject();
               
            }
            out.println(jsona);
        }else{
            QueryDatos = "SELECT F_ClaPro as clave,F_ClaLot as lote,F_FecCad,SUM(F_ExiLot) as cantidad FROM TB_Lote WHERE F_ExiLot>0 GROUP BY F_ClaPro,F_ClaLot order by F_ClaPro,F_ClaLot,F_FecCad asc";    
            Consulta = ObjMySQL.consulta(QueryDatos);
            while(Consulta.next()){
                Resultado = Double.parseDouble(Consulta.getString("cantidad"));
                Cantidad = (int) Resultado;
                Clave = Consulta.getString("clave");
                Lote= Consulta.getString("lote");
                Cadu = Consulta.getString("F_FecCad");
            ObjMySQL.actualizar("insert into TB_Comparacion values('"+Clave+"','"+Lote+"','"+Cadu+"','"+Cantidad+"','sistemas','LOTE','"+usuario+"',0)");        
            }
            QueryUbi="SELECT F_ClaPro as clave,F_ClaLot as lote,F_FecCad,SUM(F_ExiLot) as cantidad FROM TB_Lote WHERE F_ExiLot>0 GROUP BY F_ClaPro,F_ClaLot order by F_ClaPro,F_ClaLot,F_FecCad asc";
            ConsultaUbi = ObjInv.consulta(QueryUbi);
            while(ConsultaUbi.next()){
                ClaveU = ConsultaUbi.getString("clave");
                LoteU = ConsultaUbi.getString("Lote");
                CaduU = ConsultaUbi.getString("F_FecCad");
                ResultadoU = Double.parseDouble(ConsultaUbi.getString("cantidad"));
                CantidadU = (int) ResultadoU;
                ObjMySQL.actualizar("insert into TB_Comparacion values('"+ClaveU+"','"+LoteU+"','"+CaduU+"','"+CantidadU+"','inventario','LOTE','"+usuario+"',0)");
            }
            QueryComp="SELECT F_ClaPro,F_Lote,F_FecCad,DATE_FORMAT(F_FecCad,'%d/%m/%Y') as fecha from tb_comparacion where F_Tipo='LOTE' and F_Usuario='"+usuario+"' GROUP BY F_ClaPro,F_Lote order by F_ClaPro,F_Lote,F_FecCad asc";
            ConsultaComp = ObjMySQL.consulta(QueryComp);
            while(ConsultaComp.next()){
                ClaveC = ConsultaComp.getString("F_ClaPro");                
                LoteC = ConsultaComp.getString("F_Lote");
                CaduC = ConsultaComp.getString("F_FecCad");
                Fecha = ConsultaComp.getString("fecha");
                QueryCompS="select F_ClaPro,SUM(F_Cantidad) as cantidad from tb_comparacion where F_ClaPro='"+ClaveC+"' and F_Lote='"+LoteC+"' and F_FecCad='"+CaduC+"' AND F_Tipo='LOTE' AND F_Sistemas='sistemas' and F_Usuario='"+usuario+"' group by F_ClaPro";
                ConsultaCompS = ObjMySQL.consulta(QueryCompS);
                while(ConsultaCompS.next()){
                    CantidadS=ConsultaCompS.getString("cantidad");
                    conts++;
                }
                if(conts>0){
                    CantidadSG=Integer.parseInt(CantidadS);
                }else{
                    CantidadSG=0;
                }
                QueryCompU="select F_ClaPro,SUM(F_Cantidad) as cantidad from tb_comparacion where F_ClaPro='"+ClaveC+"' and F_Lote='"+LoteC+"' and F_FecCad='"+CaduC+"' AND F_Tipo='LOTE' AND F_Sistemas='inventario' and F_Usuario='"+usuario+"' group by F_ClaPro";
                ConsultaCompU = ObjMySQL.consulta(QueryCompU);
                while(ConsultaCompU.next()){
                    CantidadUB=ConsultaCompU.getString("cantidad");
                    contu++;
                }
                if (contu>0){
                    CantidadUBI = Integer.parseInt(CantidadUB);
                }else{
                    CantidadUBI = 0;
                }
                Diferencia = CantidadUBI - CantidadSG;
                conts = 0;
                contu = 0;
                json.put("clave",ClaveC);
                json.put("lote",LoteC);
                json.put("fecha",Fecha);
                json.put("cantidads",CantidadUBI);
                json.put("cantidadu",CantidadSG);
                json.put("dife",Diferencia);
                jsona.add(json);
                json = new JSONObject();
               
            }
            out.println(jsona);
        }
    
    }

    Obj.CierreConn();
    ObjInv.cierraConexion();
    ObjMySQL.cierraConexion();
%>
