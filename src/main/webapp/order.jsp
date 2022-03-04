<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="database.Goods_Management" %>
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
    Goods_Management tools=new Goods_Management();
    String name="";
    String[] goodsName;
    String[] amounts;
    String[] address;
    String[] prices;

%>
<%
    int num;
    String description="";
    name= (String) request.getSession().getAttribute("username");
    List<List> result=tools.get_details_by_user_name(name);
    /*To prevent the initial number is not enough.*/
    num=result.size()+1;
    /*initialization of the order details.*/
    if(num>1)
    {
        goodsName = new String[num];
        amounts = new String[num];
        address = new String[num];
        prices = new String[num];
        goodsName[0]="Items";
        amounts[0]="Amount";
        address[0]="Address";
        prices[0]="Total Price";
        for (int i=0;i<num-1;i++)
        {
            goodsName[i+1]= tools.get_goods_name_by_id((String) result.get(i).get(0));
            amounts[i+1]= (String) result.get(i).get(1);
            address[i+1]= (String) result.get(i).get(2);
            prices[i+1]= (String) result.get(i).get(3);
        }
    }
    else
    {
        goodsName = new String[1];
        amounts = new String[1];
        address = new String[1];
        prices = new String[1];
        description="no_order";
        goodsName[0]="Items";
        amounts[0]="Amount";
        address[0]="Address";
        prices[0]="Total Price";
    }
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
                <th><%=goodsName[0]%></th>
                <th><%=amounts[0]%></th>
                <th><%=address[0]%></th>
                <th><%=prices[0]%></th>
            </tr>
            <%
                for(int i=0;i<num-1;i++){
            %>
            <tr>
                <td align="center"><%=goodsName[i+1] %></td>
                <td align="center"><%=amounts[i+1]%></td>
                <td align="center"><%=address[i+1]%></td>
                <td align="center"><%=prices[i+1]%></td>
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