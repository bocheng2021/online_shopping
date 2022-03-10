<%@ page import="database.DBUtilBean" %>
<%@ page import="database.PageContent" %>
<%@ page import="WebComponent.Menu" %>
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
    DBUtilBean database=new DBUtilBean();
    PageContent page_tools=new PageContent();
    Menu menu = new Menu();
%>
<%
    /*---The method to check if the user login or not.---*/
    String username = (String) request.getSession().getAttribute("username");
    String cart_param = request.getParameter("cart");
    String param = request.getParameter("param");

    /*confirm is used to set the flag for the cart alert.*/
    String confirm = menu.core(username, cart_param, param);
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
            <li><a href="<%=menu.get("user_address")%>"><%=menu.get("user_content")%></a></li>
        </ul>
    </div>
</div>
<div class="content">
    <div class="welcome">
        -- <%=page_tools.getMenuName(param)%> --
    </div>
    <div class="img_content">
        <ul>
            <li>
                <a href="goods.jsp?param=<%=((String[])menu.get("names"))[0]%>">
                    <img src="images/category/<%=((String[])menu.get("names"))[0]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+((String[])menu.get("names"))[0]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+((String[])menu.get("names"))[0]+".png")%>
                    </p>
                    <div class="img_btn">
                        <!-- price，buy logo. -->
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+
                                ((String[])menu.get("names"))[0]+".png")%></div>
                        <!-- cart button -->
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=((String[])menu.get("names"))[0]%>&param=<%=((String[])menu.get("names"))[0].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])menu.get("names"))[1]%>">
                    <img src="images/category/<%=((String[])menu.get("names"))[1]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+((String[])menu.get("names"))[1]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+((String[])menu.get("names"))[1]+".png")%>
                    </p>
                    <div class="img_btn">
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+
                                ((String[])menu.get("names"))[1]+".png")%></div>
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=((String[])menu.get("names"))[1]%>&param=<%=((String[])menu.get("names"))[1].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])menu.get("names"))[2]%>">
                    <img src="images/category/<%=((String[])menu.get("names"))[2]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+((String[])menu.get("names"))[2]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+((String[])menu.get("names"))[2]+".png")%>
                    </p>
                    <div class="img_btn">
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+
                                ((String[])menu.get("names"))[2]+".png")%></div>
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=((String[])menu.get("names"))[2]%>&param=<%=((String[])menu.get("names"))[2].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])menu.get("names"))[3]%>">
                    <img src="images/category/<%=((String[])menu.get("names"))[3]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+((String[])menu.get("names"))[3]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+((String[])menu.get("names"))[3]+".png")%>
                    </p>
                    <div class="img_btn">
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+
                                ((String[])menu.get("names"))[3]+".png")%></div>
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=((String[])menu.get("names"))[3]%>&param=<%=((String[])menu.get("names"))[3].substring(0,2)%>" class="cart">
                                <img src="images/cart.svg" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </li>

            <li>
                <a href="goods.jsp?param=<%=((String[])menu.get("names"))[4]%>">
                    <img src="images/category/<%=((String[])menu.get("names"))[4]%>.png"
                         class="img_li" height="240" width="220"  alt="">
                </a>
                <div class="info">
                    <h3><%=database.getSingleNameByPhoto("images/category/"+((String[])menu.get("names"))[4]+".png")%></h3>
                    <p>
                        <%=database.getDetailsByPhoto("images/category/"+((String[])menu.get("names"))[4]+".png")%>
                    </p>
                    <div class="img_btn">
                        <div class="price">¥<%=database.getSinglePriceByPhoto("images/category/"+
                                ((String[])menu.get("names"))[4]+".png")%></div>
                        <div class="btn">
                            <a href="menu.jsp?cart=<%=((String[])menu.get("names"))[4]%>&param=<%=((String[])menu.get("names"))[4].substring(0,2)%>" class="cart">
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
