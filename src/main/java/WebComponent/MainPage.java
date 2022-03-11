package WebComponent;

import DBComponent.CartManagementBean;
import DBComponent.DBUtilBean;
import DBComponent.PageContent;
import myBean.WebBean;

import java.text.DecimalFormat;
import java.util.List;

public class MainPage extends WebBean {
    /*---initial the whole page.---*/
    String [] names=new String[6];
    /*variable for detail information about name and amount of goods in the cart*/
    String[] goodsName;
    String[] goodsAmounts;
    String[] prices;
    /*variable for page change.*/
    String pageNumNext="";
    String pageNumLast="";
    /*variable for cart money*/

    String total_money_for_cart="";

    /*variable for the sign in or sign up.*/
    String proFile="";
    /*local variable of path.*/
    String cart_path="login.jsp?param=noLogin";
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    /*call the interface to get the data from database.*/
    DBUtilBean database=new DBUtilBean();
    List<List> cart_info;
    int num=1;
    PageContent page_tool=new PageContent();
    CartManagementBean cart=new CartManagementBean();

    public String[] core(String user_name, String cart_param, String request_order)
    {
        /*confirm is used to set the flag for the cart alert.*/
        String confirm="false";

        /*variable to get the parameter of the cart*/
        /*----The method to check if the user login or not.----*/
        if(user_name!=null)
        {
            /*the function to add item to the cart.*/
            cart_path="goods_payment.jsp";
            if(cart_param!=null)
            {
                /*The condition that the user is a seller.*/
                if (cart.verify_Identity_by_name_in_string_type(user_name).equals("0"))
                {
                    confirm="seller";
                }
                else
                {
                    String cart_param1="images/category/"+cart_param+".png";
                    cart.create_cart_order(user_name,cart_param1,1);
                    confirm="true";
                }
            }
            /*to initial the price value.*/
            total_money_for_cart="0";
            cart_info =cart.get_all_cart_info_by_user_name(user_name);
            /*----To record the number of the cart.----*/
            num=cart_info.size();
            if(num>0)
            {
                goodsName=new String[num];
                goodsAmounts=new String[num];
                prices=new String[num];
                for (int i=0;i<num;i++)
                {
                    goodsName[i]= database.getSingleNameByPhoto((String) cart_info.get(i).get(0));
                    goodsAmounts[i]= (String) cart_info.get(i).get(1);
                    prices[i]= String.valueOf(cart_info.get(i).get(2));
                }
                /*set the format of the cart total price. */
                DecimalFormat df = new DecimalFormat( "0.00");
                for (String price : prices) {
                    total_money_for_cart = String.valueOf(df.format(Double.parseDouble(total_money_for_cart) +
                            Double.parseDouble(price)));
                }
            }
            /*----the condition that there is no items in the cart.----*/
            else
            {
                num=1;
                goodsName=new String[1];
                goodsAmounts=new String[1];
                goodsName[0]="There is no items in the cart.";
                goodsAmounts[0]="";
                total_money_for_cart="0";
            }
            user_content="Log out";
            proFile="profile.jsp";
            user_address="logout.jsp";
        }
        /*if the user do not log in, the variable will change and turn to the log in page.*/
        else
        {
            /*the condition for there is no user log in.*/
            if(cart_param!=null)
            {
                confirm="no_user";
            }
            /*cart variable initialization.*/
            num=1;
            goodsName=new String[1];
            goodsAmounts=new String[1];
            goodsName[0]="There is no items in the cart.";
            goodsAmounts[0]="";
            total_money_for_cart="0";
            proFile="login.jsp?param=noLogin";
            user_content="Sign up/ in";
            user_address="login.jsp";
        }

        /*---The method to get the page num---*/
        if(request_order != null)
        {
            if(request_order.equals("7"))
            {
                pageNumNext="7";
            }
            else
            {
                pageNumNext=String.valueOf(Integer.parseInt(request_order)+1);
            }
            if(request_order.equals("1"))
            {
                pageNumLast="1";
            }
            else
            {
                pageNumLast=String.valueOf(Integer.parseInt(request_order)-1);
            }
            names=page_tool.getPageName(request_order);
        }
        /*this is used to change the next page and the last page number.*/
        else
        {
            request_order="1";
            pageNumNext="2";
            pageNumLast="1";
            names=page_tool.getPageName("1");
        }
        return new String[]{ confirm, request_order };
    }

    public DBUtilBean getDatabase()
    {
        return database;
    }
}
