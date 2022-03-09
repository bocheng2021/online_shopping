package database;//package {Add package name}

import encrypt.MyCryptoTool;
import myBean.DBConnectorBean;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
/**
 * This class is designed for user login and registration
 * */
public class User_Login_and_Registration {

    private Connection c;
    MyCryptoTool cryptoTool=new MyCryptoTool();
    public User_Login_and_Registration()
    {
        String databaseAddress = "jdbc:mysql://localhost:3306/DDBMS?serverTimezone=UTC";
        String databaseUsername = "root";
        String databasePassword = "ybc1234";
        c = DBConnectorBean.getLocalConnection(databaseAddress, databaseUsername, databasePassword);
    }
    /**
     * verify the password of the related account
     * */
    public boolean verify_User_By_Name(String user_Name) {
        try{
            String query = "Select Password from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
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
            String query = "Select Password from User where User_Name = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setString(1,user_Name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = this.getResult(rs);
            String pw = (String) result.get(0).get(0);
            return pw.equals(true_password);
        }catch (Exception ex)
        {
            System.err.println("Error in retrieving data.");
            return false;
        }
    }

    public List<List> getResult(ResultSet rset) {

        List<List> result = new ArrayList<>();
        List<String> row;

        try {
            int colNum = rset.getMetaData().getColumnCount();
            while (rset.next()) {
                row = new ArrayList<String>();

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

/*The method to register the user.*/
    public void registration(String name, byte[] password, String user_identity)
    {
        String true_password=cryptoTool.decryptMessage(password);
        String address="LUC&BJTU";
        String id;
        String user_type="1";
        String code = "Select COUNT(ID) from user";
        String insert ="Insert INTO user VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt;
        if(user_identity.equals("seller")||user_identity.equals("sell")||user_identity.equals("0"))
        {
            user_type="0";
        }
        try {
            stmt = c.prepareStatement(code);
            ResultSet rs = stmt.executeQuery();
            List<List> result = getResult(rs);
            id= (String) result.get(0).get(0);
            address=address+id;
            stmt = c.prepareStatement(insert);
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
            String code = "Select id from user where User_Name=?";
            PreparedStatement stmt = c.prepareStatement(code);
            stmt.setString(1,name);
            ResultSet rs = stmt.executeQuery();
            List<List> result = getResult(rs);
            return result.size()>0;
        }
        catch (Exception throwAble) {
            System.out.println("There are some error in the check.");
            return false;
        }
    }


    public static void main(String[] args)
    {
        User_Login_and_Registration db=new User_Login_and_Registration();
        db.check_user("YinBocheng");
    }

}