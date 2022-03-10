<%@ page import="WebComponent.MainPage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>online shopping</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <script type="text/javascript" src="js/index.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/sweetalert.min.js"></script>
</head>
<body>
<%!
    MainPage mainPage = new MainPage();
%>
<%
    /*variable to get the parameter of the cart*/
    String cart_param =request.getParameter("cart");

    /*variable to get the parameter of the page*/
    String request_order=request.getParameter("page");

    /*local variable of path.*/
    String user_name= (String) request.getSession().getAttribute("username");
    /*confirm is used to set the flag for the cart alert.*/
    String[] result = mainPage.core(user_name, cart_param, request_order);
    String confirm = result[0];
    request_order= result[1];
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
    <!-- logo -->
    <div class="logo" style="width:150px">
        <img style="transform:scale(0.3)" src="images/logo.png" alt="">
    </div>
    <!-- cart -->
    <div class="cart" onmouseleave="show_menu1()">
        <button class="cart_button" onclick="show_menu()">
            <img src="images/cart.svg" alt=""></button>
        <!-- used for the cart content. -->
        <ul id="cart_content" >
            <li>
                <div class="amounts">
                    Amounts
                </div>
                <div class="goods_name">
                    Name
                </div>
            </li>
            <%
                for(int i=0;i<(int)mainPage.get("num");i++){
            %>
            <li>
                <div class="amounts">
                    <%=((String[])mainPage.get("goodsAmounts"))[i]%>
                </div>
                <div class="goods_name">
                    <%=((String[])mainPage.get("goodsName"))[i]%>
                </div>
            </li>
            <%} %>
            <li>
                <div class="money">
                    ¥ <%=mainPage.get("total_money_for_cart")%>
                </div>
                <a href="<%=mainPage.get("cart_path")%>">Buy</a>
            </li>
        </ul>
    </div>

    <div class="search">
        <form action="search.jsp" method="post">
            <label for="search_input"></label>
            <input class= search_input id="search_input" type="text" placeholder="Please input..." name="search_input">
            <input class="search_btn" type="submit" value="Search">
        </form>
    </div>
    <!-- set the user log in -->
    <div class="auth">
        <ul>
            <li><a href="<%=mainPage.get("proFile")%>">Profile</a></li>
            <li><a href="<%=mainPage.get("user_address")%>"><%=mainPage.get("user_content")%></a></li>
        </ul>
    </div>
</div>

<!-- --------------------content-------------------- -->
<div class="content">
    <div class="guide">
        <div class="left">
            <div class="description">
                Detailed Categories
            </div>
            <ul>
                <li id="Categories_Leisure">---Leisure---</li>
                <ul>
                    <li><a href="menu.jsp?param=01">Chips</a></li>
                    <li><a href="menu.jsp?param=02">Cookie</a></li>
                    <li><a href="menu.jsp?param=03">Chocolate</a></li>
                </ul>
                <li id="Categories_Drinks">---Drinks---</li>
                <ul>
                    <li><a href="menu.jsp?param=11">Milk</a></li>
                    <li><a href="menu.jsp?param=12">Soft drinks</a></li>
                    <li><a href="menu.jsp?param=13">Wine</a></li>
                </ul>
                <li id="Categories_Care">---Persona Care---</li>
                <ul>
                    <li><a href="menu.jsp?param=21">Toothpaste and toothbrush</a></li>
                    <li><a href="menu.jsp?param=22">Bath Supplies</a></li>
                    <li><a href="menu.jsp?param=23">Facial Care</a></li>
                </ul>
            </ul>
        </div>
        <div class="right">
            <img style="transform:scale(1.0)" src="images/welcome.png" class="welcome" alt="">
        </div>
    </div>
    <div class="recommend">
        -- Recommend to you --
    </div>
    <!-----------------the content of recommend goods.------------------>
    <div class="img_content">
        <ul>
            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[0]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[0]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+((String[])mainPage.get("names"))[0]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+((String[])mainPage.get("names"))[0]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[0]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[0]%>&page=<%=request_order%>"
                               class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[1]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[1]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+ ((String[])mainPage.get("names"))[1]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+ ((String[])mainPage.get("names"))[1]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[1]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[1]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[2]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[2]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+((String[])mainPage.get("names"))[2]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+((String[])mainPage.get("names"))[2]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[2]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[2]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[3]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[3]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+ ((String[])mainPage.get("names"))[3]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+ ((String[])mainPage.get("names"))[3]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[3]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[3]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[4]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[4]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+ ((String[])mainPage.get("names"))[4]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+ ((String[])mainPage.get("names"))[4]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[4]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[4]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])mainPage.get("names"))[5]%>">
                    <img src="images/category/<%=((String[])mainPage.get("names"))[5]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=mainPage.getDatabase().getSingleNameByPhoto("images/category/"+((String[])mainPage.get("names"))[5]+".png")%></h3>
                    <p>
                        <%=mainPage.getDatabase().getDetailsByPhoto("images/category/"+((String[])mainPage.get("names"))[5]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=mainPage.getDatabase().getSinglePriceByPhoto("images/category/"+((String[])mainPage.get("names"))[5]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=((String[])mainPage.get("names"))[5]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>

    </div>
    <!-- div -->
    <div class="page_nav">
        <ul>
            <li><a href="index.jsp">First</a></li>
            <li><a href="index.jsp?page=<%=mainPage.get("pageNumLast")%>">Last Page</a></li>
            <li><a href="index.jsp?page=1">1</a></li>
            <li><a href="index.jsp?page=2">2</a></li>
            <li><a href="index.jsp?page=3">3</a></li>
            <li><a href="index.jsp?page=4">4</a></li>
            <li><a href="index.jsp?page=5">5</a></li>
            <li><a href="index.jsp?page=6">6</a></li>
            <li><a href="index.jsp?page=7">7</a></li>
            <li><a href="index.jsp?page=<%=mainPage.get("pageNumNext")%>">Next Page</a></li>
            <li><a href="index.jsp?page=7">Last</a></li>
        </ul>
    </div>

</div>
<!-- --------------------footer page-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>
