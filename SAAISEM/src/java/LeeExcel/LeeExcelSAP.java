package LeeExcel;

import conn.ConectionDB;
import java.io.FileInputStream;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Iterator;
import java.util.Vector;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Indra Hidayatulloh
 */
public class LeeExcelSAP {

    private Vector vectorDataExcelXLSX = new Vector();
    ConectionDB con = new ConectionDB();

    public boolean obtieneArchivo(String path, String file, String usua) {
        String excelXLSXFileName = path + "/exceles/" + file;
        vectorDataExcelXLSX = readDataExcelXLSX(excelXLSXFileName);
        displayDataExcelXLSX(vectorDataExcelXLSX, usua);
        return true;
    }

    public Vector readDataExcelXLSX(String fileName) {
        Vector vectorData = new Vector();

        try {
            FileInputStream fileInputStream = new FileInputStream(fileName);

            XSSFWorkbook xssfWorkBook = new XSSFWorkbook(fileInputStream);

            // Read data at sheet 0
            XSSFSheet xssfSheet = xssfWorkBook.getSheetAt(0);

            Iterator rowIteration = xssfSheet.rowIterator();

            // Looping every row at sheet 0
            while (rowIteration.hasNext()) {
                XSSFRow xssfRow = (XSSFRow) rowIteration.next();
                Iterator cellIteration = xssfRow.cellIterator();

                Vector vectorCellEachRowData = new Vector();

                // Looping every cell in each row at sheet 0
                while (cellIteration.hasNext()) {
                    XSSFCell xssfCell = (XSSFCell) cellIteration.next();
                    vectorCellEachRowData.addElement(xssfCell);
                }

                vectorData.addElement(vectorCellEachRowData);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return vectorData;
    }

    public void displayDataExcelXLSX(Vector vectorData, String usua) {
        // Looping every row data in vector

        for (int i = 1; i < vectorData.size(); i++) {
            Vector vectorCellEachRowData = (Vector) vectorData.get(i);
            String qry = "insert into tb_pedidoisem values ('0', ";
            // looping every cell in each row
            for (int j = 0; j < 10; j++) {
                if (j == 2) {
                    //String Clave = (vectorCellEachRowData.get(j).toString() + "");
                    //qry = qry + "'" + Clave + "' , ";
                } else if (j == 0) {
                    try {
                        String NoCompra = (vectorCellEachRowData.get(2).toString() + "");
                        qry = qry + "'" + NoCompra + "' , ";
                        String[] Clave = (vectorCellEachRowData.get(j).toString() + "").split("    ");
                        String idProvee = "";
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select F_ClaProve from tb_proveedor where F_NomPro = '" + Clave[1] + "' ");
                            while (rset.next()) {
                                idProvee = rset.getString("F_ClaProve");
                            }
                            if (idProvee.equals("")) {
                                con.insertar("insert into tb_proveedor values(0,'" + Clave[1] + "','','','','','','','','')");
                                rset = con.consulta("select F_ClaProve from tb_proveedor where F_NomPro = '" + Clave[1] + "' ");
                                while (rset.next()) {
                                    idProvee = rset.getString("F_ClaProve");
                                }
                            }
                            con.cierraConexion();
                        } catch (Exception e) {

                        }
                        qry = qry + "'" + idProvee + "' , ";
                    } catch (Exception e) {
                    }
                } else if (j == 4) {
                    String Clave = (vectorCellEachRowData.get(j).toString() + "");
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select F_ClaPro from tb_medica where F_ClaSap = '" + Clave + "' ");
                        while (rset.next()) {
                            Clave = rset.getString("F_ClaPro");
                        }
                        con.cierraConexion();
                    } catch (Exception e) {

                    }
                    qry = qry + "'" + Clave + "' , '','1','-','1800-00-00',";
                } else if (j == 9) {
                    String Clave = ((int) Double.parseDouble(vectorCellEachRowData.get(j).toString()) + "");
                    qry = qry + "'" + Clave + "' , 'SAP',NOW(),CURDATE(),CURTIME(),'" + usua + "','1','0' ) ";
                }
                /*else if (j == 1) {
                 System.out.println("algo");
                 try {
                 String ClaPro = ((vectorCellEachRowData.get(j).toString()) + "");
                 DecimalFormat formatter = new DecimalFormat("0000.00");
                 DecimalFormatSymbols custom = new DecimalFormatSymbols();
                 custom.setDecimalSeparator('.');
                 custom.setGroupingSeparator(',');
                 formatter.setDecimalFormatSymbols(custom);
                 ClaPro = formatter.format(Double.parseDouble(ClaPro));
                 String[] punto = ClaPro.split("\\.");
                 System.out.println(punto.length);
                 if (punto.length > 1) {
                 System.out.println(ClaPro + "***" + punto[0] + "////" + punto[1]);
                 if (punto[1].equals("01")) {
                 ClaPro = agrega(punto[0]) + ".01";
                 } else if (punto[1].equals("02")) {
                 ClaPro = agrega(punto[0]) + ".02";
                 } else if (punto[1].equals("00")) {
                 ClaPro = agrega(punto[0]);
                 } else {
                 ClaPro = agrega(punto[0]);
                 }
                 System.out.println(ClaPro);
                 }
                 qry = qry + "'" + agrega(ClaPro) + "' , ";

                 } catch (Exception e) {
                 System.out.println(e.getMessage());
                 }
                 } else {
                 try {
                 String Clave = ((int) Double.parseDouble(vectorCellEachRowData.get(j).toString()) + "");
                 qry = qry + "'" + Clave + "' , ";
                 } catch (Exception e) {
                 }
                 }*/

            }
            //qry = qry + "curdate(), 0, '0')"; // agregar campos fuera del excel
            //System.out.println(qry);
            try {
                con.conectar();
                try {
                    con.insertar(qry);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                con.cierraConexion();
            } catch (Exception e) {
            }
        }
    }

    public String agrega(String clave) {
        String clave2 = "";
        if (clave.length() < 4) {

            if (!clave.substring(0, 1).equals("0")) {
                //System.out.println(clave);
                if (clave.length() == 1) {
                    clave2 = ("000" + clave);
                }
                if (clave.length() == 2) {
                    clave2 = ("00" + clave);
                }
                if (clave.length() >= 3) {
                    clave2 = ("0" + clave);
                }

            }
        } else {
            clave2 = clave;
        }
        return clave2;
    }

}
