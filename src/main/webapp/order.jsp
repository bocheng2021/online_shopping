<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="WebComponent.OrderBean" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>Order management</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <link rel="stylesheet" type="text/css" href="css/order.css">
    <script src="js/sweetalert.min.js" type="javascript"></script>
</head>
<body>
<%!
    OrderBean orderBean = new OrderBean();

%>
<%
    String username= (String) request.getSession().getAttribute("username");
    String description = orderBean.core(username);
%>
<script type="javascript">
    const confirm = "<%=description%>";
    if (confirm==="no_order")
    {
        swal("You don't have orders.");
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
</div>
<!-- --------------------content panel-------------------- -->
<div class="content">
    <div class="welcome">
        -- Current goods available for sale --
    </div>
    <div class="goods">
        <table>
            <tr class="header">
                <th><%=((String[])orderBean.get("goodsName"))[0]%></th>
                <th><%=((String[])orderBean.get("amounts"))[0]%></th>
                <th><%=((String[])orderBean.get("address"))[0]%></th>
                <th><%=((String[])orderBean.get("prices"))[0]%></th>
            </tr>
            <%
                for(int i=0;i<(int)orderBean.get("num")-1;i++){
            %>
            <tr>
                <td align="center"><%=((String[])orderBean.get("goodsName"))[i+1] %></td>
                <td align="center"><%=((String[])orderBean.get("amounts"))[i+1]%></td>
                <td align="center"><%=((String[])orderBean.get("address"))[i+1]%></td>
                <td align="center"><%=((String[])orderBean.get("prices"))[i+1]%></td>
            </tr>
            <%} %>
        </table>
    </div>
</div>
<!-- --------------------footer panel-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>