<%@ page import="database.DBUtilBean" %>
<%@ page import="WebComponent.GoodsPage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Goods</title>
    <link rel="stylesheet" type="text/css" href="css/goods.css">
    <script src="js/sweetalert.min.js"></script>
</head>
<body>
<%!
    GoodsPage goodsPage = new GoodsPage();
    DBUtilBean database=new DBUtilBean();
%>
<%
    String confirm ="false";
    String hasUser = (String) request.getSession().getAttribute("username");
    /*the below two variables are used for the cart addition.*/
    String param=request.getParameter("param");
    String cart_param=request.getParameter("cart_param");
    confirm = goodsPage.core(param, cart_param, hasUser);
%>
<script>
    const confirm = "<%=confirm%>";
    if (confirm ==="true")
    {
        swal("You have successfully added this item into your cart!");
    }
    else if (confirm==="no_user")
    {
        swal("You have to log in your account.");
    }
    else if (confirm==="seller")
    {
        swal("You are a seller and you cannot buy items.");
    }
</script>
<div class="header">
    <!-- 设置logo -->
    <div class="logo" style="width:150px">
        <img style="transform:scale(0.3)" src="images/logo.png" alt="">
    </div>
    <!-- Set home -->
    <div class="home">
        <button><a href="index.jsp">Home</a></button>
    </div>
    <!-- set user log in or log out. -->
    <div class="auth">
        <ul>
            <li><a href="<%=goodsPage.get("user_address")%>"><%=goodsPage.get("user_content")%></a></li>
        </ul>
    </div>
</div>
<div class="content">
    <div class="welcome">
        -- Selected goods --
    </div>
    <div class="goods">
        <img src="<%=goodsPage.get("name")%>" height="500" width="500" alt="">
    </div>
    <div class="description">
        <div class="name">
            <%=database.getSingleNameByPhoto((String) goodsPage.get("name"))%>
        </div>
        <div class="price">¥<%=database.getSinglePriceByPhoto((String) goodsPage.get("name"))%></div>
        <div class="amount">
            The available amount is:<%=database.getAmountByPhoto((String) goodsPage.get("name"))%>
        </div>
        <div class="details">
            <div class="bg">
                Goods Detail
            </div>
            <div class="det"><%=database.getDetailsByPhoto((String) goodsPage.get("name"))%></div>
        </div>
        <div class="buy">
            <div class="img_btn">
                <a href="goods.jsp?param=<%=param%>&cart_param=buy" class="cart">
                    <img src="images/cart.svg" alt="">
                </a>
            </div>
        </div>
    </div>
    <div class="final">
        <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
    </div>
</div>
</body>
</html>
