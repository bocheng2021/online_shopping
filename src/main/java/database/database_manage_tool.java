package database;//package {Add package name}
import java.sql.*; //Importing Java package that deals with database.
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class database_manage_tool {
    private Connection c;
    public database_manage_tool()
    {
        c = database_connector.getLocalConnection();
    }
    /**
     * @param rset JDBC ResultSet.
     * @return List of Lists containing the elements of a table
     */
    public List<List> getResult(ResultSet rset) {

        List<List> result = new ArrayList<>();
        List<String> row;

        try {
            int colNum = rset.getMetaData().getColumnCount();
            while (rset.next()) {
                row = new ArrayList<>();

                for (int i = 1; i <= colNum; i++) {
                    row.add(rset.getString(i));
                }

                result.add(row);
            }
            return result;
        } catch (SQLException e) {
            System.err.println("Error in retrieving data.");
            e.printStackTrace();
        }
        return null;
    }

    public List<List> Search(String Keyword){
        try{
            String query = "Select Photo from storage where Title like ?";
            PreparedStatement stmt = c.prepareStatement(query);
            String likeStmt = '%'+Keyword+'%';
            stmt.setString(1,likeStmt);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
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
    /**
     * verify the password of the related account
     * */
    public String get_ID_By_Name(String user_Name) {
        try{
            String query = "Select ID from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
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
            String query = "Select User_Identity from User where ID = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            String identity = (String) result.get(0).get(0);
            return identity.equals("0");
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Double get_money_by_user_name(String user_name){
        try{
            String query = "Select Money from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,user_name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
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
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /**
     * get the User_Address by enter the User_Name (String)
     * */
    public String get_address_by_name(String name){
        try{
            String query = "Select Default_Address from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            if (result.size()>0)
            {
                return (String) result.get(0).get(0);
            }
            else return null;
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /**
     * get the User_Address by enter the User_ID (String)
     * */
    public String get_address_by_id(String id){
        try{
            String query = "Select Default_Address from user where ID = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,id);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            if (result.size()>0)
            {
                return (String) result.get(0).get(0);
            }
            else return null;
        }catch (SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get goods name by the photo address of the item*/
    public String getAmountByPhoto(String photo){
        try{
            String query = selectMethod_Single("Amount","storage","Photo");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get goods name by the photo address of the item*/
    public String getSingleNameByPhoto(String photo){
        try{
            String query = selectMethod_Single("Title","storage","Photo");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get price by the photo address of the item*/
    public String getSinglePriceByPhoto(String photo){
        try{
            String query = selectMethod_Single("Price","storage","Photo");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /*The method to get description by the photo address of the item*/
    public String getDetailsByPhoto(String photo){
        try{
            String query = selectMethod_Single("Description","storage","Photo");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     *  get the price using Storage_ID (String)
     * */
    public Double getPriceOfSID(String ID){
        try{
            String query = selectMethod_Single("Price","storage","ID");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            String ps= (String) result.get(0).get(0);
            return Double.valueOf(ps);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    /**
     *  as name
     * */
    public String getSellerOfOID(String ID){
        try{
            String query = selectMethod_Single("Seller_ID","orders","ID");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            ResultSet rs = stmt.executeQuery();
            List<List> result = getResult(rs);
            return (String) result.get(0).get(0);
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    /**
     *  as name
     * */
    public void updateAddressOfOID_and_SID(String ID,String newAddress,String StorageID){
        try{
            String query = updateMethodOfOID("Address","orders","ID","Storage_ID");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,newAddress);
            stmt.setString(2,ID);
            stmt.setString(3,StorageID);
            stmt.executeUpdate();
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     *  as name
     * */
    public void updateAddressOfOID(String ID,String newAddress){
        try{
            String query = "update orders set Address = ? where ID = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,newAddress);
            stmt.setString(2,ID);
            stmt.executeUpdate();
        }catch(SQLException ex)
        {
            System.err.println("Error in retrieving data.");
            ex.printStackTrace();
            Logger.getLogger(database_manage_tool.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *  update user money
     * */
    public void updateUserMoney(String user_name,Double money){
        try{
            DecimalFormat df = new DecimalFormat( "0.00");
            String query = "update user set Money = ? where user_name = ? ";
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
    public void CreateOrder(String Storage_ID,int Amount,java.sql.Date Order_Time,double
            Price_Amount, String Buyer, String Seller, String Address){
        try{
            String id="0";
            /* the method to count id from user. */
            String code = "Select COUNT(ID) from orders";
            PreparedStatement stmt = c.prepareStatement(code);
            ResultSet rs = stmt.executeQuery();
            List<List> result = getResult(rs);
            if (result.size()>0)
            {
                id= (String) result.get(0).get(0);
            }
            /*the method to insert order into database.*/
            String query = "Insert into orders values(?,?,?,?,?,?,?,?,?,?)";
            stmt = c.prepareStatement(query);
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

    public static void main(String[] args) {
        database_manage_tool database=new database_manage_tool();
        String[] result_names;
        String search_input = "cookie";
        List<List> result=database.Search(search_input);
        if (result!=null)
        {
            result_names=new String[result.size()];
            for (int i=0;i<result.size();i++)
            {
                result_names[i]=((result.get(i).toString()).replace("images/category/", "").
                        replace(".png", ""));
            }
        }
    }
}