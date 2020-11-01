<%@ page import="database.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Profile</title>
    <link rel="stylesheet" type="text/css" href="css/profile.css">
</head>
<body>
<%!
    DBUtil database=new DBUtil();
    String [] goods_content=new String[2];
    String name="";
    String id="";
    String type="";
    String address="";
%>
<%
    String balance="";
    name= (String) request.getSession().getAttribute("username");
    id=database.get_ID_By_Name(name);
    balance= String.valueOf(database.get_money_by_user_name(name));
    if(database.verifyIdentity(id))
    {
        type="Seller";
        goods_content[0]="Your Inventory";
        goods_content[1]="inventory.jsp";

    }
    else
    {
        type="Buyer";
        goods_content[0]="Your Order";
        goods_content[1]="order.jsp";
    }
    address=database.get_address_by_id(id);
%>
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
    <div class="welcome">
        -- Personal profile --
    </div>
    <div class="picture">
        <img src="images/profile_photo.jpg" class="img_one" height="500" width="500">
    </div>
    <div class="description">
        <table>
            <tr>
                <td>User Name</td>
                <td><%=name%></td>
            </tr>
            <tr class="second">
                <td>User ID</td>
                <td><%=id%></td>
            </tr>
            <tr>
                <td>User Type</td>
                <td><%=type%></td>
            </tr>
            <tr class="second">
                <td>Default Address</td>
                <td><%=address%></td>
            </tr>
            <tr>
                <td><%=goods_content[0]%></td>
                <td><button><a href="<%=goods_content[1]%>">Check</a></button></td>
            </tr>
            <tr class="second">
                <td>Balance of account</td>
                <td><%=balance%></td>
            </tr>

        </table>
    </div>
</div>
<!-- --------------------页脚板块-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2020 POWERED BY <span>Group6</span></p>
</div>
</body>
</html>