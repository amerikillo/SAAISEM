/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ExportarTxt;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ExportarTxt.*;
import javax.servlet.http.HttpSession;
/**
 *
 * @author Sistemas
 */
public class ExporTxtIs extends HttpServlet {
    ExporTxt TxT = new ExporTxt();
    ExportMedico Med = new ExportMedico();
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        String mensaje ="";
        String fecha1=request.getParameter("fecha_ini");
        String fecha2=request.getParameter("fecha_fin");
        String radio=request.getParameter("radio");
        
        if((radio.equals("txt") && (fecha1 !="") && (fecha2 !=""))){
        mensaje = TxT.Exportar((String) sesion.getAttribute("cla_uni"), (String) sesion.getAttribute("id_usu"), (String)fecha1,(String)fecha2);
        }else{
            mensaje = "Favor de Seleccionar Fechas";
        }
        if(radio.equals("medico")){
            mensaje = Med.ExporMed((String) sesion.getAttribute("cla_uni"), (String) sesion.getAttribute("id_usu"));
        }
        out.println("<script>alert('"+mensaje+"')</script>");
        out.println("<script>window.location='CatalogoIsem/Txt.jsp'</script>");
    }

   

    
}
