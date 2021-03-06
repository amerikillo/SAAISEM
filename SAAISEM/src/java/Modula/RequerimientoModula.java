/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modula;

import conn.ConectionDB;
import conn.ConectionDB_SQLServer;
import java.sql.ResultSet;

/**
 *
 * @author Americo
 */
public class RequerimientoModula {

    public void enviaRequerimiento(String F_IdFact) {
        /*
         * Metodo para mandar requerimientos (Facturas o folios)
         */
        java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.text.DateFormat df4 = new java.text.SimpleDateFormat("yyyyMMdd");
        ConectionDB con = new ConectionDB();
        ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();
        try {
            con.conectar();
            conModula.conectar();
            try {
                conModula.ejecutar("delete from IMP_ORDINI_RIGHE where RIG_ORDINE='" + F_IdFact + "'");
                conModula.ejecutar("delete from IMP_ORDINI where ORD_ORDINE='" + F_IdFact + "'");
                ResultSet rset = con.consulta("select F_ClaCli, F_FecEnt, F_IdFact from v_folioremisiones where F_IdFact = '" + F_IdFact + "' group by F_IdFact");
                while (rset.next()) {
                    conModula.ejecutar("insert into IMP_ORDINI values ('" + rset.getString("F_IdFact") + "','A','','" + df4.format(df3.parse(rset.getString("F_FecEnt"))) + "','P','" + rset.getString("F_ClaCli") + "','1')");
                }
                rset = con.consulta("select F_ClaCli, F_FecEnt, F_IdFact, F_ClaPro, F_ClaLot, F_FecCad, F_Cb, F_Cant, F_Id from v_folioremisiones where F_IdFact = '" + F_IdFact + "'");
                while (rset.next()) {
                    /*
                     * La 'A' es de inserción
                     */
                    conModula.ejecutar("insert into IMP_ORDINI_RIGHE values('" + rset.getString("F_IdFact") + "','','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_ClaLot") + "','1','" + rset.getString("F_Cant") + "','" + rset.getString("F_Cb") + "','" + df4.format(df3.parse(rset.getString("F_FecCad"))) + "','')");
                    //con.insertar("update tb_factttemp set F_StsFact='0' where F_Id='" + rset.getString("F_Id") + "'");
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            conModula.cierraConexion();
            con.cierraConexion();
        } catch (Exception e) {
        }

    }
    /*
     *Este metodo de abajo no es
     */

    public void enviaRuta(String F_FecEnt) {
        java.text.DateFormat df3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.text.DateFormat df4 = new java.text.SimpleDateFormat("yyyyMMdd");
        ConectionDB con = new ConectionDB();
        ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();
        try {
            con.conectar();
            conModula.conectar();
            try {
                ResultSet rset = con.consulta("select F_IdFact from v_folioremisiones where F_FecEnt = '" + F_FecEnt + "' group by F_IdFact");
                while (rset.next()) {
                    conModula.ejecutar("delete from IMP_ORDINI_RIGHE where RIG_ORDINE='" + rset.getString("F_IdFact") + "'");
                    conModula.ejecutar("delete from IMP_ORDINI where ORD_ORDINE='" + rset.getString("F_IdFact") + "'");
                }
                rset = con.consulta("select F_ClaCli, F_FecEnt, F_IdFact from v_folioremisiones where F_FecEnt = '" + F_FecEnt + "' group by F_IdFact");
                while (rset.next()) {
                    conModula.ejecutar("insert into IMP_ORDINI values ('" + rset.getString("F_IdFact") + "','A','','" + df4.format(df3.parse(rset.getString("F_FecEnt"))) + "','P','" + rset.getString("F_ClaCli") + "','1')");
                }
                rset = con.consulta("select F_ClaCli, F_FecEnt, F_IdFact, F_ClaPro, F_ClaLot, F_FecCad, F_Cb, F_Cant, F_Id from v_folioremisiones where F_FecEnt = '" + F_FecEnt + "'");
                while (rset.next()) {
                    /*
                     * La 'A' es de inserción
                     */
                    conModula.ejecutar("insert into IMP_ORDINI_RIGHE values('" + rset.getString("F_IdFact") + "','','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_ClaLot") + "','1','" + rset.getString("F_Cant") + "','" + rset.getString("F_Cb") + "','" + df4.format(df3.parse(rset.getString("F_FecCad"))) + "','')");
                    //con.insertar("update tb_factttemp set F_StsFact='0' where F_Id='" + rset.getString("F_Id") + "'");
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            conModula.cierraConexion();
            con.cierraConexion();
        } catch (Exception e) {
        }

        /*
         try {

         ResultSet rset = con.consulta("select F_ClaCli, F_FecEnt, F_FolRemi from tb_reqmodula where F_Sts=0 group by F_FolRemi");
         while (rset.next()) {
         conModula.ejecutar("insert into IMP_ORDINI values ('" + rset.getString("F_FolRemi") + "','A','','" + df4.format(df3.parse(rset.getString("F_FecEnt"))) + "','P','" + rset.getString("F_ClaCli") + "','1')");
         }
         rset = con.consulta("select F_ClaCli, F_FecEnt, F_FolRemi, F_ClaPro, F_ClaLot, F_FecCad, F_CB, F_Ori, F_Cant, F_Id from tb_reqmodula where F_Sts=0");
         while (rset.next()) {
         *
         * La 'A' es de inserción
         *
         conModula.ejecutar("insert into IMP_ORDINI_RIGHE values('" + rset.getString("F_FolRemi") + "','','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_ClaLot") + "','" + rset.getString("F_Ori") + "','" + rset.getString("F_Cant") + "','" + rset.getString("F_CB") + "','" + df4.format(df3.parse(rset.getString("F_FecCad"))) + "','')");
         con.insertar("update tb_reqmodula set F_Sts='1' where F_Id='" + rset.getString("F_Id") + "'");
         }

         } catch (Exception e) {
         System.out.println(e.getMessage());
         }
         */
    }
}
