package WebComponent;

import DBComponent.DBUtilBean;
import myBean.WebBean;

public class ProfileBean extends WebBean {
    DBUtilBean database=new DBUtilBean();
    String [] goods_content=new String[2];
    String id="";
    String type="";
    String address="";
    String name= "";
    public String core(String username)
    {
        id=database.get_ID_By_Name(username);
        this.name = username;
        String balance= String.valueOf(database.get_money_by_user_name(username));
        if(database.verifyIdentity(id))
        {
            type="Seller";
            goods_content[0]="Your Inventory";
            goods_content[1]="inventory.jsp";
        }
        else
        {
            type="Buyer";
            goods_content[0]="Your Order";
            goods_content[1]="order.jsp";
        }
        address=database.get_address_by_id(id);
        return balance;
    }
}
