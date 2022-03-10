<%@ page import="WebComponent.ProfileBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Profile</title>
    <link rel="stylesheet" type="text/css" href="css/profile.css">
</head>
<body>
<%!
    ProfileBean profileBean = new ProfileBean();
%>
<%
    String username = (String) request.getSession().getAttribute("username");
    String balance = profileBean.core(username);

%>
<div class="header">
    <!-- set for logo -->
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
                <td><%=profileBean.get("name")%></td>
            </tr>
            <tr class="second">
                <td>User ID</td>
                <td><%=profileBean.get("id")%></td>
            </tr>
            <tr>
                <td>User Type</td>
                <td><%=profileBean.get("type")%></td>
            </tr>
            <tr class="second">
                <td>Default Address</td>
                <td><%=profileBean.get("address")%></td>
            </tr>
            <tr>
                <td><%=((String[])profileBean.get("goods_content"))[0]%></td>
                <td><button><a href="<%=((String[])profileBean.get("goods_content"))[1]%>">Check</a></button></td>
            </tr>
            <tr class="second">
                <td>Balance of account</td>
                <td><%=balance%></td>
            </tr>

        </table>
    </div>
</div>
<!-- --------------------footer-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>