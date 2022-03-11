package WebComponent;

import database.CartManagementBean;
import database.DBUtilBean;
import database.GoodsManagementBean;
import myBean.WebBean;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Payment extends WebBean {
    DBUtilBean database=new DBUtilBean();
    CartManagementBean cart=new CartManagementBean();
    GoodsManagementBean tools=new GoodsManagementBean();
    /*variable for detail information about name and amount of goods in the cart*/
    String[] goodsName;
    String[] goodsAmounts;
    String[] picture;
    String[] prices;
    String total_money_for_cart="0";
    List<List> cart_info;
    int num=1;

    public String core(String user_name, String param, ServletRequest request, ServletResponse response) throws ServletException, IOException {
        /*the variable to make sure if it is confirm or not.*/
        String confirm="false";
        /*The method to create an order and give a result to the user.*/
        java.sql.Date sqlDate = new java.sql.Date(new Date().getTime());
        /*to initial the price value.*/
        total_money_for_cart="0";
        /*use this variable to make sure if there is enough amount*/
        ArrayList<Boolean> enough_amount=new ArrayList<Boolean>();
        cart_info =cart.get_all_cart_info_by_user_name(user_name);
        num=cart_info.size();
        if(num>0)
        {
            goodsName=new String[num];
            goodsAmounts=new String[num];
            prices=new String[num];
            picture=new String[num];
            for (int i=0;i<num;i++)
            {
                picture[i]= (String) cart_info.get(i).get(0);
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
            /*the method to create order*/
            if(param!=null)
            {
                /*the condition that the user buy the goods in the cart*/
                if(param.equals("buy"))
                {
                    /*get the buyer money.*/
                    Double money=database.get_money_by_user_name(user_name);
                    /*detect if the money is enough for the payment.*/
                    if(money>Double.parseDouble(total_money_for_cart))
                    {
                        for(int i=0;i<num;i++)
                        {
                            /*create order and finish the payment..*/
                            String id=tools.get_goods_id_by_name(goodsName[i]);
                            /*make sure the amounts in the storage is more than the cart needs*/
                            if (Integer.parseInt(goodsAmounts[i])>tools.get_goods_amount_by_id(id))
                            {
                                /*change the key of amount*/
                                enough_amount.add(false);
                            }
                            else
                            {
                                enough_amount.add(true);
                            }
                        }
                        /*use the key of amount to show that if the user has enough amount.*/
                        boolean flag=true;
                        for (Boolean aBoolean : enough_amount) {
                            if (!aBoolean) {
                                flag = false;
                                break;
                            }
                        }
                        enough_amount.clear();
                        if (flag)
                        {
                            for(int i=0;i<num;i++)
                            {
                                /*create order and finish the payment..*/
                                String id=tools.get_goods_id_by_name(goodsName[i]);
                                /*make sure the amounts in the storage is more than the cart needs*/
                                if (Integer.parseInt(goodsAmounts[i])>tools.get_goods_amount_by_id(id))
                                {
                                    /*change the key of amount*/
                                    enough_amount.add(false);
                                }
                                else
                                {
                                    String seller_name=tools.get_seller_name_by_id(tools.get_goods_seller_by_goods_name
                                            (goodsName[i]));
                                    enough_amount.add(true);
                                    database.CreateOrder(id,Integer.parseInt(goodsAmounts[i]), sqlDate, Double.parseDouble
                                            (prices[i]),user_name,seller_name,database.get_address_by_name(user_name));
                                    /*update the amount in the storage.*/
                                    cart.Alter_storage_amount(id,Integer.parseInt(goodsAmounts[i]));
                                    database.updateUserMoney(seller_name,database.get_money_by_user_name(seller_name)
                                            +Double.parseDouble(prices[i]));
                                }
                            }
                            /* if success, change the user money.*/
                            database.updateUserMoney(user_name,money-Double.parseDouble(total_money_for_cart));
                            /*after change the user money, clear the cart.*/
                            cart.update_user_cart_after_payment(user_name);
                            request.getRequestDispatcher("goods_payment.jsp?param=success").forward(request,response);
                        }
                        else
                        {
                            confirm="noAmount";
                        }
                    }
                    else
                    {
                        confirm="no_money";
                    }
                }
            }
        }
        else
        {
            if (param!=null)
            {
                if (cart.verify_Identity_by_name_in_string_type(user_name).equals("0"))
                {
                    /*the seller flag.*/
                    confirm="seller";
                }
                else
                {
                    /*the no item flag.*/
                    confirm="no_item";
                }
            }
            num=1;
            goodsName=new String[1];
            goodsAmounts=new String[1];
            prices=new String[1];
            picture=new String[1];
            goodsName[0]="There is no items in the cart.";
            goodsAmounts[0]="0";
            prices[0]="0";
            picture[0]="images/cart.png";
        }
        /*to make sure if the payment it success or not. */
        if(param!=null)
        {
            if(param.equals("success"))
            {
                confirm="true";
            }
        }
        return confirm;
    }

}
