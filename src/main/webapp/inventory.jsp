<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="WebComponent.Inventory" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Inventory management</title>
    <link rel="stylesheet" type="text/css" href="css/inventory.css">
    <script src="js/sweetalert.min.js" type="javascript"></script>
</head>
<body>
<%!
    Inventory inventory = new Inventory();
%>
<%
    String username = (String) request.getSession().getAttribute("username");
    /*get the parameter from the check page.*/
    String param = request.getParameter("param");
    String show_or_not= inventory.core(username, param);
%>
<div class="header">
    <!-- set logo -->
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
        Current goods available for sale
    </div>
    <!-- --------------------use goods div to show the whole inventory-------------------- -->
    <div class="goods">
        <table>
            <tr class="header">
                <th><%=((String[])inventory.get("goodsName"))[0]%></th>
                <th><%=((String[])inventory.get("goods_description"))[0]%></th>
                <th><%=((String[])inventory.get("amount"))[0]%></th>
                <th><%=((String[])inventory.get("prices"))[0]%></th>
            </tr>
            <%
                for(int i=0;i<(int)inventory.get("num")-1;i++){
            %>
            <tr>
                <td><%=((String[])inventory.get("goodsName"))[i+1] %></td>
                <td><%=((String[])inventory.get("goods_description"))[i+1]%></td>
                <td><%=((String[])inventory.get("amount"))[i+1]%></td>
                <td><%=((String[])inventory.get("prices"))[i+1]%></td>
            </tr>
            <%} %>
        </table>
    </div>
    <!-- --------------------use form to pass the update to the back end DBComponent.-------------------- -->
    <form class="form-inline pull-right" id="inventory_update_tool" action="inventory_check.jsp" method="post">
        <div class="Inventory_Update">
            Inventory Update
        </div>
        <div class="table_content">
            <label for="update">Items</label>
            <select name="update_name" class="select_list" id="update">
                <%
                    for(int i=0;i<(int)inventory.get("num")-1;i++){
                %>
                <option value="<%=((String[])inventory.get("goodsName"))[i+1]%>">
                    <%=((String[])inventory.get("goodsName"))[i+1]%></option>
                <%
                    }
                %>
            </select>
            <label class="form_label" for="amount">Amounts</label>
            <input class="form_input " type="text" id="amount" name="amount">

            <label class="form_label" for="price">Unit Price</label>
            <input class="form_input " type="text" id="price" name="price">

            <input class="form_btn" type="submit" value="Submit">
        </div>
    </form>
    <div class="alert">
        <%=inventory.get("alert")%>
    </div>
</div>
<script>
    let display = "<%=show_or_not%>";
    /*the method is used to hide the whole ul*/
    function Display()
    {
        if(display === "no"){
            document.getElementById('inventory_update_tool').style.display = "none";
            display = false;
        }
        else {
            document.getElementById('inventory_update_tool').style.display = "";
            display = true;
        }
    }
    window.onload=Display();
</script>
<!-- --------------------footer panel-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2022 POWERED BY <span>Bocheng</span></p>
</div>
</body>
</html>