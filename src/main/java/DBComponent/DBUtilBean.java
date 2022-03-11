package DBComponent;

import myBean.DBConnectorBean;
import myBean.DatabaseBean;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtilBean extends DatabaseBean {
    private final Connection c;
    private String query;
    private PreparedStatement stmt;
    private ResultSet rs;
    private List<List> result;

    public DBUtilBean()
    {
        c = DBConnectorBean.getLocalConnection();
    }


    public List<List> Search(String Keyword){
        try{
            query = "Select Photo from storage where Title like ?";
            stmt = c.prepareStatement(query);
            String likeStmt = '%'+Keyword+'%';
            stmt.setString(1,likeStmt);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            if(result.size()==0)
            {
                return null;
            }
            else
            {
                return result;
            }
        }
        catch (Exception ex) {
            return null;
        }
    }

    public String selectMethod_Single(String column, String table,String filter){
        return "Select "+column+" from "+table+" where "+filter+" = ?";
    }

    public String updateMethodOfOID(String colum,String table,String filter1,String filter2){
        return "Update "+table+" set "+colum+" = ? where "+filter1+" = ? and "+filter2+" = ?";
    }

    private String ProcessQuery(String entry) throws SQLException {
        stmt = c.prepareStatement(query);
        stmt.setString(1,entry);
        rs = stmt.executeQuery();
        result = this.getResult(rs);
        if (result.size()>0)
        {
            return (String) result.get(0).get(0);
        }
        else return null;
    }

    /**
     * verify the password of the related account
     * */
    public String get_ID_By_Name(String user_Name) {
        try{
            query = "Select ID from User where User_Name = ?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    /**
     * verifyIdentity is for verify whether the user is a seller or buyer, authorize for database change privilege.
     * */
    public boolean verifyIdentity(String ID){
        try{
            /*
                O as seller , 1 as buyer presented by String
            */
            query = "Select User_Identity from User where ID = ?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            String identity = (String) result.get(0).get(0);
            return identity.equals("0");
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Double get_money_by_user_name(String user_name){
        try{
            query = "Select Money from User where User_Name = ?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,user_name);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            if(result.size()>0)
            {
                return Double.parseDouble((String) result.get(0).get(0));
            }
            else return 0.0;
        }
        catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /**
     * get the User_Address by enter the User_Name (String)
     * */
    public String get_address_by_name(String name){
        try{
            query = "Select Default_Address from User where User_Name = ?";
            return ProcessQuery(name);
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     * get the User_Address by enter the User_ID (String)
     * */
    public String get_address_by_id(String id){
        try{
            query = "Select Default_Address from user where ID = ?";
            return ProcessQuery(id);
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get goods name by the photo address of the item*/
    public String getAmountByPhoto(String photo){
        try{
            query = selectMethod_Single("Amount","storage","Photo");
            stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get goods name by the photo address of the item*/
    public String getSingleNameByPhoto(String photo){
        try{
            query = selectMethod_Single("Title","storage","Photo");
            stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get price by the photo address of the item*/
    public String getSinglePriceByPhoto(String photo){
        try{
            query = selectMethod_Single("Price","storage","Photo");
            stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get description by the photo address of the item*/
    public String getDetailsByPhoto(String photo){
        try{
            query = selectMethod_Single("Description","storage","Photo");
            stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     *  get the price using Storage_ID (String)
     * */
    public Double getPriceOfSID(String ID){
        try{
            query = selectMethod_Single("Price","storage","ID");
            stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            String ps= (String) result.get(0).get(0);
            return Double.valueOf(ps);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     *  as name
     * */
    public String getSellerOfOID(String ID){
        try{
            query = selectMethod_Single("Seller_ID","orders","ID");
            stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            rs = stmt.executeQuery();
            result = getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /**
     *  as name
     * */
    public void updateAddressOfOID_and_SID(String ID,String newAddress,String StorageID){
        try{
            query = updateMethodOfOID("Address","orders","ID","Storage_ID");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,newAddress);
            stmt.setString(2,ID);
            stmt.setString(3,StorageID);
            stmt.executeUpdate();
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     *  as name
     * */
    public void updateAddressOfOID(String ID,String newAddress){
        try{
            query = "update orders set Address = ? where ID = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,newAddress);
            stmt.setString(2,ID);
            stmt.executeUpdate();
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(DBUtilBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *  update user money
     * */
    public void updateUserMoney(String user_name,Double money){
        try{
            DecimalFormat df = new DecimalFormat( "0.00");
            query = "update user set Money = ? where user_name = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setDouble(1, Double.parseDouble(df.format(money)));
            stmt.setString(2,user_name);
            stmt.executeUpdate();
        }catch(Exception ex)
        {
            System.err.println("Error in change user money.");
        }
    }

    /**
     * The code downward is the select method build from 0
     ***/
    public void CreateOrder(String Storage_ID, int Amount, Date Order_Time, double
            Price_Amount, String Buyer, String Seller, String Address){
        try{
            String id="0";
            /* the method to count id from user. */
            query = "Select COUNT(ID) from orders";
            stmt = c.prepareStatement(query);
            rs = stmt.executeQuery();
            result = getResult(rs);
            if (result.size()>0)
            {
                id= (String) result.get(0).get(0);
            }
            /*the method to insert order into database.*/
            query = "Insert into orders values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,id);
            stmt.setString(2,Storage_ID);
            stmt.setInt(3,Amount);
            stmt.setDate(4,Order_Time);
            stmt.setDate(5,Order_Time);
            stmt.setString(6,"U");
            stmt.setDouble(7,Price_Amount);
            stmt.setString(8,Buyer);
            stmt.setString(9,Seller);
            stmt.setString(10,Address);
            stmt.executeUpdate();
        }
        catch (Exception ex){
            System.err.println("Error in creating order.");
        }
    }
}