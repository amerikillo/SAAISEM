/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modula;

import conn.ConectionDB;
import conn.ConectionDB_SQLServer;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 *
 * @author amerikillo
 */
public class AbastoModula {

    public void AbastoModula(String F_OrdCom, String F_FolRemi) {

        DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        DateFormat df4 = new SimpleDateFormat("yyyyMMddhhmmss");
        ConectionDB con = new ConectionDB();
        ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();

        try {
            con.conectar();
            conModula.conectar();
            try {
                conModula.ejecutar("delete from IMP_ORDINI_RIGHE where RIG_ORDINE='" + F_OrdCom + "-" + F_FolRemi + "'");
                conModula.ejecutar("delete from IMP_ORDINI where ORD_ORDINE='" + F_OrdCom + "-" + F_FolRemi + "'");
                ResultSet rset = con.consulta("select F_FecApl from tb_compratemp where F_OrdCom = '" + F_OrdCom + "' and F_FolRemi = '" + F_FolRemi + "' group by F_OrdCom, F_FolRemi");
                while (rset.next()) {
                    conModula.ejecutar("insert into IMP_ORDINI values ('" + F_OrdCom + "-" + F_FolRemi + "','A','','" + df4.format(df3.parse(rset.getString("F_FecApl"))) + "','V','','1')");
                }
                rset = con.consulta("select F_FecApl, F_FolRemi, F_OrdCom, F_ClaPro, F_Lote, F_FecCad, F_Cb, F_Pz from tb_compratemp where F_OrdCom = '" + F_OrdCom + "' and F_FolRemi = '" + F_FolRemi + "'");
                while (rset.next()) {
                    /*
                     * La 'A' es de inserción
                     */
                    conModula.ejecutar("insert into IMP_ORDINI_RIGHE values('" + F_OrdCom + "-" + F_FolRemi + "','','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_Lote") + "','1','" + rset.getString("F_Pz") + "','" + rset.getString("F_Cb") + "','" + df.format(df3.parse(rset.getString("F_FecCad"))) + "','')");
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

    public void enviaRuta(String F_FecEnt) {

        DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        DateFormat df4 = new SimpleDateFormat("yyyyMMddhhmmss");
        ConectionDB con = new ConectionDB();
        ConectionDB_SQLServer conModula = new ConectionDB_SQLServer();

        try {
            con.conectar();
            conModula.conectar();
            try {
                conModula.ejecutar("delete from IMP_ORDINI_RIGHE where RIG_ORDINE='R" + F_FecEnt + "'");
                conModula.ejecutar("delete from IMP_ORDINI where ORD_ORDINE='R" + F_FecEnt + "'");
                ResultSet rset = con.consulta("select F_FecEnt from tb_facttemp where F_FecEnt = '" + F_FecEnt + "' group by F_FecEnt");
                while (rset.next()) {
                    conModula.ejecutar("insert into IMP_ORDINI values ('R" + F_FecEnt + "','A','','" + df4.format(df3.parse(rset.getString("F_FecEnt"))) + "','V','','1')");
                }
                rset = con.consulta("select F_FecEnt, F_ClaPro, F_ClaLot, F_FecCad, F_Cb, SUM(F_Cant) as F_Cant, F_Id from v_folioremisiones where F_FecEnt = '" + F_FecEnt + "' group by F_ClaPro, F_ClaLot, F_FecCad");
                while (rset.next()) {
                    /*
                     * La 'A' es de inserción
                     */
                    conModula.ejecutar("insert into IMP_ORDINI_RIGHE values('R" + F_FecEnt + "','','" + rset.getString("F_ClaPro") + "','" + rset.getString("F_ClaLot") + "','1','" + rset.getString("F_Cant") + "','" + rset.getString("F_Cb") + "','" + df.format(df3.parse(rset.getString("F_FecCad"))) + "','')");
                    con.insertar("update tb_facttemp set F_StsMod='1' where F_Id='" + rset.getString("F_Id") + "'");
                }

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            conModula.cierraConexion();
            con.cierraConexion();
        } catch (Exception e) {
        }

    }
}
