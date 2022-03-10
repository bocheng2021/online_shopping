<%@ page import="database.DBUtil" %>
<%@ page import="database.PageContent" %>
<%@ page import="database.Cart_Management" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
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
    /*---initial the whole page.---*/
    String [] names=new String[6];
    /*variable for detail information about name and amount of goods in the cart*/
    String[] goodsName;
    String[] goodsAmounts;
    String[] prices;
    /*variable for page change.*/
    String pageNumNext="";
    String pageNumLast="";
    /*variable for cart money*/

    String total_money_for_cart="";

    /*variable to record the page.*/
    String request_order="";
    /*variable for the sign in or sign up.*/
    String proFile="";
    String user_content="Sign up/ in";
    String user_address="login.jsp";
    /*call the interface to get the data from database.*/
    DBUtil database=new DBUtil();
    List<List> cart_info;
    int num=1;
    PageContent page_tool=new PageContent();
    Cart_Management cart=new Cart_Management();
%>
<%
    /*confirm is used to set the flag for the cart alert.*/
    String confirm="false";

    /*variable to get the parameter of the cart*/
    String cart_param =request.getParameter("cart");

    /*local variable of path.*/
    String cart_path="login.jsp?param=noLogin";
    String user_name= (String) request.getSession().getAttribute("username");
    /*----The method to check if the user login or not.----*/
    if(request.getSession().getAttribute("username")!=null)
    {
        /*the function to add item to the cart.*/
        cart_path="goods_payment.jsp";
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
        /*to initial the price value.*/
        total_money_for_cart="0";
        cart_info =cart.get_all_cart_info_by_user_name(user_name);
        /*----To record the number of the cart.----*/
        num=cart_info.size();
        if(num>0)
        {
            goodsName=new String[num];
            goodsAmounts=new String[num];
            prices=new String[num];
            for (int i=0;i<num;i++)
            {
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
        }
        /*----the condition that there is no items in the cart.----*/
        else
        {
            num=1;
            goodsName=new String[1];
            goodsAmounts=new String[1];
            goodsName[0]="There is no items in the cart.";
            goodsAmounts[0]="";
            total_money_for_cart="0";
        }
        user_content="Log out";
        proFile="profile.jsp";
        user_address="logout.jsp";
    }
    /*if the user do not log in, the variable will change and turn to the log in page.*/
    else
    {
        /*the condition for there is no user log in.*/
        if(cart_param!=null)
        {
            confirm="no_user";
        }
        /*cart variable initialization.*/
        num=1;
        goodsName=new String[1];
        goodsAmounts=new String[1];
        goodsName[0]="There is no items in the cart.";
        goodsAmounts[0]="";
        total_money_for_cart="0";
        proFile="login.jsp?param=noLogin";
        user_content="Sign up/ in";
        user_address="login.jsp";
    }

    /*---The method to get the page num---*/
    request_order=request.getParameter("page");
    if(request_order != null)
    {
        if(request_order.equals("7"))
        {
            pageNumNext="7";
        }
        else
        {
            pageNumNext=String.valueOf(Integer.parseInt(request_order)+1);
        }
        if(request_order.equals("1"))
        {
            pageNumLast="1";
        }
        else
        {
            pageNumLast=String.valueOf(Integer.parseInt(request_order)-1);
        }
        names=page_tool.getPageName(request_order);
    }
    /*this is used to change the next page and the last page number.*/
    else
    {
        request_order="1";
        pageNumNext="2";
        pageNumLast="1";
        names=page_tool.getPageName("1");
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
                for(int i=0;i<num;i++){
            %>
            <li>
                <div class="amounts">
                    <%=goodsAmounts[i]%>
                </div>
                <div class="goods_name">
                    <%=goodsName[i]%>
                </div>
            </li>
            <%} %>
            <li>
                <div class="money">
                    ¥ <%=total_money_for_cart%>
                </div>
                <a href="<%=cart_path%>">Buy</a>
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
            <li><a href="<%=proFile%>">Profile</a></li>
            <li><a href="<%=user_address%>"><%=user_content%></a></li>
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
                <a href="goods.jsp?param=<%=names[0]%>">
                    <img src="images/category/<%=names[0]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[0]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[0]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[0]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[0]%>&page=<%=request_order%>" class="cart">
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
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[1]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[1]%>&page=<%=request_order%>" class="cart">
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
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[2]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[2]%>&page=<%=request_order%>" class="cart">
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
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[3]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[3]%>&page=<%=request_order%>" class="cart">
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
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[4]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[4]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=names[5]%>">
                    <img src="images/category/<%=names[5]%>.png" class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+names[5]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+names[5]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+names[5]+".png")%>
                        </div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="index.jsp?cart=<%=names[5]%>&page=<%=request_order%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>

    </div>
    <!-- 分页 -->
    <div class="page_nav">
        <ul>
            <li><a href="index.jsp">First</a></li>
            <li><a href="index.jsp?page=<%=pageNumLast%>">上一页</a></li>
            <li><a href="index.jsp?page=1">1</a></li>
            <li><a href="index.jsp?page=2">2</a></li>
            <li><a href="index.jsp?page=3">3</a></li>
            <li><a href="index.jsp?page=4">4</a></li>
            <li><a href="index.jsp?page=5">5</a></li>
            <li><a href="index.jsp?page=6">6</a></li>
            <li><a href="index.jsp?page=7">7</a></li>
            <li><a href="index.jsp?page=<%=pageNumNext%>">下一页</a></li>
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
