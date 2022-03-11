package WebComponent;

import database.GoodsManagementBean;
import myBean.WebBean;

import java.util.List;

public class OrderBean extends WebBean {
    GoodsManagementBean tools=new GoodsManagementBean();
    String[] goodsName;
    String[] amounts;
    String[] address;
    String[] prices;
    int num;

    public String core(String username)
    {
        String description="";
        List<List> result=tools.get_details_by_user_name(username);
        /*To prevent the initial number is not enough.*/
        num=result.size()+1;
        /*initialization of the order details.*/
        if(num>1)
        {
            goodsName = new String[num];
            amounts = new String[num];
            address = new String[num];
            prices = new String[num];
            goodsName[0]="Items";
            amounts[0]="Amount";
            address[0]="Address";
            prices[0]="Total Price";
            for (int i=0;i<num-1;i++)
            {
                goodsName[i+1]= tools.get_goods_name_by_id((String) result.get(i).get(0));
                amounts[i+1]= (String) result.get(i).get(1);
                address[i+1]= (String) result.get(i).get(2);
                prices[i+1]= (String) result.get(i).get(3);
            }
        }
        else
        {
            goodsName = new String[1];
            amounts = new String[1];
            address = new String[1];
            prices = new String[1];
            description="no_order";
            goodsName[0]="Items";
            amounts[0]="Amount";
            address[0]="Address";
            prices[0]="Total Price";
        }
        return description;
    }
}
