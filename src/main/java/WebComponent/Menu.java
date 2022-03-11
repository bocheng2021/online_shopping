package WebComponent;

import database.CartManagementBean;
import myBean.WebBean;

public class Menu extends WebBean {
    String[] names =new String[5];
    /*variable to get the parameter of the cart*/
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    CartManagementBean cart=new CartManagementBean();

    public String core(String username, String cart_param, String param)
    {
        /*confirm is used to set the flag for the cart alert.*/
        String confirm="false";
        /*---The method to check if the user login or not.---*/
        if(username!=null)
        {
            if(cart_param!=null)
            {
                /*The condition that the user is a seller.*/
                if (cart.verify_Identity_by_name_in_string_type(username).equals("0"))
                {
                    confirm="seller";
                }
                else
                {
                    cart_param="images/category/"+cart_param+".png";
                    cart.create_cart_order(username,cart_param,1);
                    confirm="true";
                }
            }
            else
            {
                cart_param="";
            }
            user_content="Log out";
            user_address="logout.jsp";
        }
        else
        {
            if(cart_param!=null)
            {
                /*change the confirm flag to true.*/
                confirm="no_user";
            }
            user_content="Sign up/ in";
            user_address="login.jsp";
        }

        for(int i=0;i<5;i++)
        {
            names[i]=param+ (i+1);
        }
        return confirm;
    }
}
