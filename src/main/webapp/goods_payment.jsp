<%@ page import="database.DBUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="database.Cart_Management" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="database.Goods_Management" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Goods payment</title>
    <link rel="stylesheet" type="text/css" href="css/goods_payment.css">
    <script src="js/sweetalert.min.js"></script>
</head>
<body>
<%!
    DBUtil database=new DBUtil();
    Cart_Management cart=new Cart_Management();
    Goods_Management tools=new Goods_Management();
    /*variable for detail information about name and amount of goods in the cart*/
    String[] goodsName;
    String[] goodsAmounts;
    String[] picture;
    String[] prices;
    List<List> cart_info;
    int num=1;
%>
<%
    /*the variable to make sure if it is confirm or not.*/
    String confirm="false";
    /*The method to create an order and give a result to the user.*/
    java.sql.Date sqlDate = new java.sql.Date(new Date().getTime());
    String user_name= (String) request.getSession().getAttribute("username");
    /*to initial the price value.*/
    String total_money_for_cart="0";
    String param=request.getParameter("param");

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
    if(request.getParameter("param")!=null)
    {
        if(request.getParameter("param").equals("success"))
        {
            confirm="true";
        }
    }
%>
<script>
    const confirm = "<%=confirm%>";
    if (confirm==="true")
    {
        swal("Success!", "Your order will arrive soon", "success");
    }
    else if (confirm==="no_money")
    {
        swal("You don't have enough money.");
    }
    else if (confirm==="no_item")
    {
        swal("You don't have items in your cart.");
    }
    else if (confirm==="seller")
    {
        swal("You are a seller.");
    }
    else if (confirm==="noAmount")
    {
        swal("The amount of some goods in the cart is no enough!");
    }
</script>
<div class="header">
    <!-- 设置logo -->
    <div class="logo" style="width:150px">
        <img style="transform:scale(0.3)" src="images/logo.png" alt="">
    </div>
    <div class="home">
        <button><a href="index.jsp">Home</a></button>
    </div>
    <div class="auth">
        <ul>
            <li><a href="logout.jsp">Log out</a></li>
        </ul>
    </div>
</div>

<div class="content">
    <table>
        <tr class="header">
            <th>Goods</th>
            <th>Amounts</th>
            <th>Price</th>
        </tr>
        <%
            for(int i=0;i<num;i++){
        %>
        <tr>
            <td>
                <div class="picture">
                    <img src="<%=picture[i]%>" class="img_li" height="100" width="100"  alt="">
                </div>
                <div class="name">
                    <%=goodsName[i]%>
                </div>
            </td>
            <td><%=goodsAmounts[i]%></td>
            <td>¥<%=prices[i]%></td>
        </tr>
        <%} %>
        <tr class="buy_footer">
            <th class="money">
                Total: ¥ <%=total_money_for_cart%>
            </th>
            <th>
                <a href="goods_payment.jsp?param=buy">Buy</a>
            </th>
        </tr>
    </table>
</div>
<!-- --------------------footer panel-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2020 POWERED BY <span>Group6</span></p>
</div>
</body>
</html>