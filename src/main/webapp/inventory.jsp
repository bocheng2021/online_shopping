<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="database.Goods_Management" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Inventory management</title>
    <link rel="stylesheet" type="text/css" href="css/inventory.css">
    <script src="js/sweetalert.min.js" type="javascript"></script>
</head>
<body>
<%!
    Goods_Management tools=new Goods_Management();
    String name="";
    int num=0;
    String[] goodsName;
    String[] amount;
    String[] goods_description;
    String[] prices;
%>
<%
    /*this is a variable for the goods update.*/
    String alert="";
    name= (String) request.getSession().getAttribute("username");
    List<List> result=tools.get_goods_title_by_seller_name(name);

    String show_or_not="yes";
    /*To prevent the initial number is not enough.*/
    num=result.size()+1;

    /*get the parameter from the check page.*/
    String param=request.getParameter("param");

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
        /*to store data in the string array.*/
        for (int i=0;i<num-1;i++)
        {
            goodsName[i+1]= (String) result.get(i).get(0);
            goods_description[i+1]= (String) result.get(i).get(1);
            amount[i+1]= (String) result.get(i).get(2);
            prices[i+1]= (String) result.get(i).get(3);
        }
    }
    /*the condition that there is no goods in the inventory.*/
    else
    {
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
%>
<div class="header">
    <!-- 设置logo -->
    <div class="logo" style="width:150px">
        <img style="transform:scale(0.3)" src="images/logo.png" alt="">
    </div>
    <div class="home">
        <button><a href="index.jsp">Home</a></button>
    </div>
</div>
<!-- --------------------content panel-------------------- -->
<div class="content">
    <div class="welcome">
        Current goods available for sale
    </div>
    <!-- --------------------use goods div to show the whole inventory-------------------- -->
    <div class="goods">
        <table>
            <tr class="header">
                <th><%=goodsName[0]%></th>
                <th><%=goods_description[0]%></th>
                <th><%=amount[0]%></th>
                <th><%=prices[0]%></th>
            </tr>
            <%
                for(int i=0;i<num-1;i++){
            %>
            <tr>
                <td><%=goodsName[i+1] %></td>
                <td><%=goods_description[i+1]%></td>
                <td><%=amount[i+1]%></td>
                <td><%=prices[i+1]%></td>
            </tr>
            <%} %>
        </table>
    </div>
    <!-- --------------------use form to pass the update to the back end database.-------------------- -->
    <form class="form-inline pull-right" id="inventory_update_tool" action="inventory_check.jsp" method="post">
        <div class="Inventory_Update">
            Inventory Update
        </div>
        <div class="table_content">
            <label for="update">Items</label>
            <select name="update_name" class="select_list" id="update">
                <%
                    for(int i=0;i<num-1;i++){
                %>
                <option value="<%=goodsName[i+1]%>"><%=goodsName[i+1]%></option>
                <%
                    }
                %>
            </select>
            <label class="form_label" for="amount">Amounts</label>
            <input class="form_input " type="text" id="amount" name="amount">

            <label class="form_label" for="price">Unit Price</label>
            <input class="form_input " type="text" id="price" name="price">

            <input class="form_btn" type="submit" value="Submit">
        </div>
    </form>
    <div class="alert">
        <%=alert%>
    </div>
</div>
<script>
    let display = "<%=show_or_not%>";
    /*the method is used to hide the whole ul*/
    function Display()
    {
        if(display === "no"){
            document.getElementById('inventory_update_tool').style.display = "none";
            display = false;
        }
        else {
            document.getElementById('inventory_update_tool').style.display = "";
            display = true;
        }
    }
    window.onload=Display();
</script>
<!-- --------------------footer panel-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>