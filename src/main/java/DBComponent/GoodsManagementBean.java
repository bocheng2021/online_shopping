package DBComponent;

import myBean.DBConnectorBean;
import myBean.DatabaseBean;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.List;

public class GoodsManagementBean extends DatabaseBean {
    private final Connection c;
    private String query;
    private PreparedStatement stmt;
    private ResultSet rs;
    private List<List> result;
    public GoodsManagementBean()
    {
        c = DBConnectorBean.getLocalConnection();
    }

    /*The method to get goods name by user id*/
    public String get_goods_name_by_id(String id){
        try
        {
            query = "Select Title from storage where ID =?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,id);
            rs = stmt.executeQuery();
            result = getResult(rs);
            return (String) result.get(0).get(0);
        }
        catch(Exception ex)
        {
            System.out.println("The goods research is wrong.");
            return null;
        }
    }

    /*The method to get goods name by user id*/
    public String get_goods_id_by_name(String name){
        try
        {
            query = "Select ID from storage where Title =?";
            return ProcessQuery(name);
        }
        catch(Exception ex)
        {
            System.out.println("The goods research is wrong.");
            return null;
        }
    }
    /**
     * get the Seller_ID !!! by enter the Storage_ID (String)
     * a further method of getting the name of the seller is suggested to use the combination of this method and getNameofUID(...)
     * */
    public String get_seller_id_by_seller_name(String name){
        try{
            query = "Select ID from user where User_Name =?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = getResult(rs);
            return (String) result.get(0).get(0);
        }catch(Exception ex)
        {
            System.err.println("Error in retrieving data.");
            return null;
        }
    }

    /*The method to get goods detail information by user name*/
    public List<List> get_details_by_user_name(String buyer_name){
        try
        {
            query = "Select Storage_ID, Amount, Address, Price_Amount from orders where User_Buyer =?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,buyer_name);
            rs = stmt.executeQuery();
            return getResult(rs);
        }
        catch(Exception ex)
        {
            System.out.println("The goods detail research is wrong.");
            return null;
        }
    }
    /*The method to get the goods related to specific seller.*/
    public List<List> get_goods_title_by_seller_name(String name){
        try
        {
            query = "Select Title, Description, Amount, Price from storage where Seller_ID =?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,this.get_seller_id_by_seller_name(name));
            rs = stmt.executeQuery();
            return getResult(rs);
        }
        catch(Exception ex)
        {
            System.out.println("The goods title research by seller name is wrong.");
            return null;
        }
    }

    /*The method to get the goods related to specific seller.*/
    public int get_goods_amount_by_id(String ID){
        try
        {
            query = "Select Amount from storage where ID =?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,ID);
            rs = stmt.executeQuery();
            result=getResult(rs);
            if (result.size()>0)
            {
                return Integer.parseInt((String)result.get(0).get(0));
            }
            else return 0;
        }
        catch(Exception ex)
        {
            System.out.println("The goods amount research by id is wrong.");
            return 0;
        }
    }
    /*The method to get the goods seller information .*/
    public String get_goods_seller_by_goods_name(String name){
        try
        {
            query = "Select Seller_ID from storage where Title =?";
            return ProcessQuery(name);
        }
        catch(Exception ex)
        {
            System.out.println("The seller name research is wrong.");
            return null;
        }
    }
    /*The method to get the goods seller information .*/
    public String get_seller_name_by_id(String id){
        try
        {
            query = "Select User_Name from user where ID =?";
            return ProcessQuery(id);
        }
        catch(Exception ex)
        {
            System.out.println("The seller id research is wrong.");
            return null;
        }
    }

    private String ProcessQuery(String id) throws SQLException {
        stmt = c.prepareStatement(query);
        stmt.setString(1,id);
        rs = stmt.executeQuery();
        result = getResult(rs);
        if (result.size()>0)
        {
            return (String) result.get(0).get(0);
        }
        else return null;
    }

    /**
     *  update user money
     * */
    public void updateSellerInventory(String name,int amount, Double price){
        try{
            DecimalFormat df = new DecimalFormat( "0.00");
            query = "update storage set Price = ?, Amount = ? where Title = ? ";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setDouble(1, Double.parseDouble(df.format(price)));
            stmt.setInt(2, amount);
            stmt.setString(3, name);
            stmt.executeUpdate();
        }catch(Exception ex)
        {
            System.err.println("Error in change inventory.");
        }
    }

    public static void main(String[] args)
    {
        GoodsManagementBean tools=new GoodsManagementBean();
    }
}
