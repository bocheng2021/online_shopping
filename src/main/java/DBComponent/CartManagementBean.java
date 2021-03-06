package DBComponent;

import myBean.DBConnectorBean;
import myBean.DatabaseBean;

import java.sql.*;
import java.util.List;

public class CartManagementBean extends DatabaseBean {
    private final Connection c;
    private String query;
    private ResultSet rs;
    private List<List> result;

    public CartManagementBean() {
        c = DBConnectorBean.getLocalConnection();
    }

    /**
     * Get SID from table cart using User_Name
     **/

    public List<List> get_all_cart_info_by_user_name(String name){
        try
        {
            query = "Select SID,Amount,Price_Amount from cart where User_Name =?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,name);
            rs = stmt.executeQuery();
            return getResult(rs);
        }
        catch(Exception ex)
        {
            System.out.println("The goods detail research is wrong.");
            return null;
        }
    }


    public String selectMethod_Single(String column, String table,String filter){

        return "Select "+column+" from "+table+" where "+filter+" = ?";
    }

    public Double getPriceOfSID(String photo){
        try
        {
            String query = selectMethod_Single("Price","storage","Photo");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,photo);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            String ps= (String) result.get(0).get(0);
            return Double.valueOf(ps);
        }catch(Exception ex)
        {
            System.err.println("Error in retrieving data.");
            return null;
        }
    }
    /**
     * Create cart record of one good using User_Name and ID of storageg and enter Amount, the Price_Amount of the table cart is automatic form by Storage API
     **/
    public void create_cart_order(String User_Name,String SID,int Amount){
        try
        {
            int number=check_cart_items(User_Name,SID);
            if(number>0)
            {
                Alter_cart_Amount(User_Name,SID,number+Amount);
            }
            else
            {
                query = "insert into cart values (?,?,?,?)";
                PreparedStatement stmt = c.prepareStatement(query);
                stmt.setString(1,User_Name);
                stmt.setString(2,SID);
                stmt.setInt(3,Amount);
                stmt.setDouble(4,Amount*getPriceOfSID(SID));
                stmt.execute();
            }
        }
        catch(Exception ex)
        {
            System.out.println("The goods add is wrong.");
        }
    }
    /*The method to check cart items to ensure if there is a same one.*/
    public int check_cart_items(String User_Name,String SID){
        try {
            query = "Select Amount from cart where User_Name=? and SID = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,User_Name);
            stmt.setString(2,SID);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            if(result.size()==0)
            {
                return 0;
            }
            else
            {
                String amount = (String) result.get(0).get(0);
                return Integer.parseInt(amount);
            }
        }
        catch(Exception ex)
        {
            System.out.println("The cart check is wrong.");
            return 0;
        }
    }
    /**
     * verifyIdentity is for verify whether the user is a seller or buyer, authorize for database change privilege.
     * */
    public String verify_Identity_by_name_in_string_type(String name){
        try
        {
            /*
                O as seller , 1 as buyer presented by String
            */
            query = "Select User_Identity from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,name);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            if (result.size()>0)
            {
                return(String) result.get(0).get(0);
            }
            else
            {
                return "The user doesn't exist.";
            }
        }
        catch (Exception ex)
        {
            System.err.println("Error in retrieving data.");
            return "error";
        }
    }
    /**
     * This method is to get the storage.amount using SID
     **/

    public int getAmountOfSID(String ID){
        try{
            query = selectMethod_Single("Amount","storage","ID");
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            if (result.size()>0)
            {
                return Integer.parseInt((String) result.get(0).get(0));
            }
            else
            {
                return 0;
            }
        }
        catch(Exception ex)
        {
            System.err.println("Error in amount search.");
            return 0;
        }
    }

    /**
     * Alter the amount of cart, meanwhile the price amount will change automatically
     **/
    public void Alter_cart_Amount(String user_name, String SID, int amount){
        try
        {
            query = "UPDATE cart set Amount = ? , Price_Amount = ? where SID = ? and User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1,amount);
            stmt.setDouble(2,amount*getPriceOfSID(SID));
            stmt.setString(3,SID);
            stmt.setString(4,user_name);
            stmt.execute();
            int amountOri = getAmountOfSID(SID);
            String query1 = "UPDATE storage set Amount = ? where ID = ? ";
            PreparedStatement stmt1 = c.prepareStatement(query1);
            stmt1.setInt(1,amountOri-amount);
            stmt1.setString(2,SID);
            stmt1.execute();
        }
        catch(Exception ex)
        {
            System.out.println("The goods update is wrong.");
        }
    }

    /**
     * independent method using storage id to change the storage
     **/

    public void Alter_storage_amount(String SID,int amount){
        try
        {
            int amountOri = getAmountOfSID(SID);
            query = "UPDATE storage set Amount = ? where ID = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1,amountOri-amount);
            stmt.setString(2,SID);
            stmt.execute();
        }
        catch (Exception ex){
            System.out.println("The storage update is wrong");
        }

    }

    public void update_user_cart_after_payment(String user_name){
        try
        {
            query = "DELETE FROM cart WHERE User_Name = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,user_name);
            stmt.execute();
        }
        catch(Exception ex)
        {
            System.out.println("The goods update is wrong.");
        }
    }

    public static void main(String[] args)
    {
        CartManagementBean cart=new CartManagementBean();
        System.out.println(cart.verify_Identity_by_name_in_string_type("YinBocheng"));
    }
}
