<%@ page import="database.database_manage_tool" %>
<%@ page import="database.PageContent" %>
<%@ page import="database.Cart_Management" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Menu</title>
    <link rel="stylesheet" type="text/css" href="css/menu.css">
    <script src="js/sweetalert.min.js"></script>
</head>
<body>
<%!
    String[] names =new String[5];
    database_manage_tool database=new database_manage_tool();
    /*variable to get the parameter of the cart*/
    String cart_param="";
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    PageContent page_tools=new PageContent();
    Cart_Management cart=new Cart_Management();
%>
<%
    /*confirm is used to set the flag for the cart alert.*/
    String confirm="false";
    /*---The method to check if the user login or not.---*/
    if(request.getSession().getAttribute("username")!=null)
    {
        String user_name= (String) request.getSession().getAttribute("username");
        cart_param=request.getParameter("cart");
        if(cart_param!=null)
        {
            /*The condition that the user is a seller.*/
            if (cart.verify_Identity_by_name_in_string_type(user_name).equals("0"))
            {
                confirm="seller";
            }
            else
            {
                cart_param="images/category/"+cart_param+".png";
                cart.create_cart_order(user_name,cart_param,1);
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
        cart_param=request.getParameter("cart");
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
        names[i]=request.getParameter("param")+ (i+1);
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
    <!-- user log in -->
    <div class="auth">
        <ul>
            <li><a href="<%=user_address%>"><%=user_content%></a></li>
        </ul>
    </div>
</div>
<div class="content">
    <div class="welcome">
        -- <%=page_tools.getMenuName(request.getParameter("param"))%> --
    </div>
    <div class="img_content">
        <ul>
            <li>
                <a href="goods.jsp?param=<%=names[0]%>">
                    <img src="images/category/<%=names[0]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[0]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[0]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo. -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[0]+".png")%></div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=names[0]%>&param=<%=names[0].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=names[1]%>">
                    <img src="images/category/<%=names[1]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[1]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[1]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- 价格，购买logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[1]+".png")%></div>
                        <!-- 购物车按钮 -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=names[1]%>&param=<%=names[1].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=names[2]%>">
                    <img src="images/category/<%=names[2]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[2]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[2]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- 价格，购买logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[2]+".png")%></div>
                        <!-- 购物车按钮 -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=names[2]%>&param=<%=names[2].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=names[3]%>">
                    <img src="images/category/<%=names[3]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[3]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[3]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- 价格，购买logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[3]+".png")%></div>
                        <!-- 购物车按钮 -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=names[3]%>&param=<%=names[3].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=names[4]%>">
                    <img src="images/category/<%=names[4]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[4]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[4]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- 价格，购买logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[4]+".png")%></div>
                        <!-- 购物车按钮 -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=names[4]%>&param=<%=names[4].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>

    </div>
</div>
<!-- --------------------foot-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>
