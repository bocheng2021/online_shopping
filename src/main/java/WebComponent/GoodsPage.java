package WebComponent;
import database.CartManagementBean;
import myBean.BaseBean;

public class GoodsPage extends BaseBean {
    String name ="";
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    CartManagementBean cart=new CartManagementBean();

    public String core(String param, String cart_param, String hasUser)
    {
        /*the below two variables are used for the cart addition.*/
        String confirm="false";
        /* record the user name.*/
        String user_name;
        name="images/category/"+param+".png";
        /*---The method to check if the user login or not.---*/
        if(hasUser!=null)
        {
            user_name= hasUser;
            user_content="Log out";
            user_address="logout.jsp";
            if(cart_param!=null)
            {
                /*The condition that the user is a seller.*/
                if (cart.verify_Identity_by_name_in_string_type(user_name).equals("0"))
                {
                    confirm="seller";
                }
                else
                {
                    cart.create_cart_order(user_name,name,1);
                    confirm="true";
                }
            }
        }
        else
        {
            if(cart_param!=null)
            {
                /*the condition for there is no user log in.*/
                confirm="no_user";
            }

            user_content="Sign up/ in";
            user_address="login.jsp";
        }
        return confirm;
    }
}
