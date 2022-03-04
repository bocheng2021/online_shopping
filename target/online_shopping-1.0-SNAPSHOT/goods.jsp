<%@ page import="database.database_manage_tool" %>
<%@ page import="database.Cart_Management" %>
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
    String name ="";
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    database_manage_tool database=new database_manage_tool();
    Cart_Management cart=new Cart_Management();
%>
<%
    /*confirm is used to set the flag for the cart alert.*/
    String confirm="false";

    /*the below two variables are used for the cart addition.*/
    String param=request.getParameter("param");
    String cart_param=request.getParameter("cart_param");
    /* record the user name.*/
    String user_name;
    name="images/category/"+param+".png";
    /*---The method to check if the user login or not.---*/
    if(request.getSession().getAttribute("username")!=null)
    {
        user_name= (String) request.getSession().getAttribute("username");
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
            <li><a href="<%=user_address%>"><%=user_content%></a></li>
        </ul>
    </div>
</div>
<div class="content">
    <div class="welcome">
        -- Selected goods --
    </div>
    <div class="goods">
        <img src="<%=name%>" height="500" width="500" alt="">
    </div>
    <div class="description">
        <div class="name">
            <%=database.getSingleNameByPhoto(name)%>
        </div>
        <div class="price">¥<%=database.getSinglePriceByPhoto(name)%></div>
        <div class="amount">
            The available amount is:<%=database.getAmountByPhoto(name)%>
        </div>
        <div class="details">
            <div class="bg">
                Goods Detail
            </div>
            <div class="det"><%=database.getDetailsByPhoto(name)%></div>
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
