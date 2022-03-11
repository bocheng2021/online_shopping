package DBComponent;

import encrypt.MyCryptoTool;

import myBean.DBConnectorBean;
import myBean.DatabaseBean;

import java.sql.*;
import java.util.List;
/**
 * This class is designed for user login and registration
 * */
public class UserSystemBean extends DatabaseBean {

    private final Connection c;
    private final MyCryptoTool cryptoTool=new MyCryptoTool();
    private String query;
    private PreparedStatement stmt;
    private ResultSet rs;
    private List<List> result;
    public UserSystemBean()
    {
        c = DBConnectorBean.getLocalConnection();
    }
    /**
     * verify the password of the related account
     * */
    public boolean verify_User_By_Name(String user_Name) {
        try{
            query = "Select Password from User where User_Name = ?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            String pw = (String) result.get(0).get(0);
            return pw != null;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
    /**
     * verify the password of the related account
     * */
    public boolean verify_Password_By_Name(String user_Name, byte[] Password) {
        try{
            String true_password=cryptoTool.decryptMessage(Password);
            query = "Select Password from User where User_Name = ?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            rs = stmt.executeQuery();
            result = this.getResult(rs);
            String pw = (String) result.get(0).get(0);
            return pw.equals(true_password);
        }catch (Exception ex)
        {
            System.err.println("Error in retrieving data.");
            return false;
        }
    }

/*The method to register the user.*/
    public void registration(String name, byte[] password, String user_identity)
    {
        String true_password=cryptoTool.decryptMessage(password);
        String address="University of Manchester: ";
        String id;
        String user_type="1";
        query = "Select COUNT(ID) from user";
        String insert ="Insert INTO user VALUES (?, ?, ?, ?, ?, ?)";
        if(user_identity.equals("seller")||user_identity.equals("sell")||user_identity.equals("0"))
        {
            user_type="0";
        }
        try {
            PreparedStatement stmt1 = c.prepareStatement(query);
            rs = stmt1.executeQuery();
            result = getResult(rs);
            id= (String) result.get(0).get(0);
            address=address+id;
            PreparedStatement stmt = c.prepareStatement(insert);
            stmt.setString(1,id);
            stmt.setString(2,name);
            stmt.setString(3,true_password);
            stmt.setString(4,user_type);
            stmt.setString(5,address);
            stmt.setDouble(6,2000);
            stmt.executeUpdate();
        }
        catch (Exception throwAble) {
            System.out.println("There are some error in the registration.");
        }

    }
    /*The method to check if there is a user.*/
    public boolean check_user(String name)
    {
        try {
            query = "Select id from user where User_Name=?";
            stmt = c.prepareStatement(query);
            stmt.setString(1,name);
            rs = stmt.executeQuery();
            result = getResult(rs);
            return result.size()>0;
        }
        catch (Exception throwAble) {
            System.out.println("There are some error in the check.");
            return false;
        }
    }

    public static void main(String[] args)
    {
        UserSystemBean db=new UserSystemBean();
        db.check_user("YinBocheng");
    }

}