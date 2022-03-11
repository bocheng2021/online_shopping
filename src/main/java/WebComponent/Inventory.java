package WebComponent;

import database.GoodsManagementBean;
import myBean.WebBean;

import java.util.List;

public class Inventory extends WebBean {
    GoodsManagementBean tools=new GoodsManagementBean();
    /*this is a variable for the goods update.*/
    String alert;
    int num = 0;
    String[] goodsName;
    String[] amount;
    String[] goods_description;
    String[] prices;

    public String core(String username,String param)
    {
        this.alert = "";
        List<List> result=tools.get_goods_title_by_seller_name(username);

        String show_or_not="yes";
        /*To prevent the initial number is not enough.*/
        num = result.size() + 1;
        System.out.println(num);
        /*initialization of the order details.*/
        if(num>1)
        {
            /*initial the data.*/
            goodsName = new String[num];
            goods_description = new String[num];
            amount = new String[num];
            prices = new String[num];
            goodsName[0]="Title";
            goods_description[0]="Description";
            amount[0]="Amount";
            prices[0]="Price";
            System.out.println("run0");
            /*to store data in the string array.*/
            for (int i=0;i<num-1;i++)
            {
                goodsName[i+1]= (String) result.get(i).get(0);
                goods_description[i+1]= (String) result.get(i).get(1);
                amount[i+1]= (String) result.get(i).get(2);
                prices[i+1]= (String) result.get(i).get(3);
            }
            System.out.println("run1");
        }
        /*the condition that there is no goods in the inventory.*/
        else
        {
            System.out.println("run2");
            show_or_not="no";
            goodsName = new String[1];
            goods_description = new String[1];
            amount = new String[1];
            prices = new String[1];
            goodsName[0]="Title";
            goods_description[0]="Description";
            amount[0]="Amount";
            prices[0]="Price";
        }
        /*use string to get the parameter from the data pass form the check page.*/
        if (param!=null)
        {
            /*use switch to show the alert message to tell the manager if the process is successful or not.*/
            switch (param) {
                case "success":
                    alert = "Success!";
                    break;
                case "wrongValue":
                    alert = "* Your input value of price or amount is wrong!";
                    break;
                case "wrongType":
                    alert = "* Amount or price input type is wrong!";
                    break;
                case "no_item":
                    alert = "* You don't have inventory items.";
                    break;
            }
        }
        return show_or_not;
    }
}
