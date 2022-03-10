<%@ page import="WebComponent.Payment" %>
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
    Payment payment =new Payment();
%>
<%
    /*the variable to make sure if it is confirm or not.*/
    String confirm="false";
    String user_name= (String) request.getSession().getAttribute("username");
    String param=request.getParameter("param");
    confirm = payment.core(user_name,param,request,response);

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
            for(int i=0;i< (int)payment.get("num");i++){
        %>
        <tr>
            <td>
                <div class="picture">
                    <img src="<%=((String[])payment.get("picture"))[i]%>" class="img_li" height="100" width="100"  alt="">
                </div>
                <div class="name">
                    <%= ((String[])payment.get("goodsName"))[i]%>
                </div>
            </td>
            <td><%=((String[])payment.get("goodsAmounts"))[i]%></td>
            <td>¥<%=((String[])payment.get("prices"))[i]%></td>
        </tr>
        <%} %>
        <tr class="buy_footer">
            <th class="money">
                Total: ¥ <%=payment.get("total_money_for_cart")%>
            </th>
            <th>
                <a href="goods_payment.jsp?param=buy">Buy</a>
            </th>
        </tr>
    </table>
</div>
<!-- --------------------footer panel-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>