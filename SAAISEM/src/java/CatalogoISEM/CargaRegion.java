/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package CatalogoISEM;

import java.sql.ResultSet;
import conn.*;

/**
 *
 * @author Sistemas
 */
public class CargaRegion {

  ConectionDB con = new ConectionDB();

    public String cargaRegion( String id_usu, String fol_abasto) {
        String mensaje;       
            try {
                con.conectar();
                
                try {
                    ResultSet rset = con.consulta("select * from tb_regiistemp");
                    while (rset.next()) {
                                                      
                               con.actualizar("insert into tb_regiis values('"+rset.getInt(1)+"','"+rset.getString(2)+"')");                                                               
                            }
                       
                   mensaje = "Datos Cargados Correctamente";
                } catch (Exception e) {
                    mensaje = e.getMessage();
                }
                con.cierraConexion();
            } catch (Exception e) {
                mensaje = e.getMessage();
            }       
        return mensaje;
    }
}