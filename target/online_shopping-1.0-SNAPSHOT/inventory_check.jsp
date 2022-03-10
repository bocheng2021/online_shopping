<%@ page import="database.GoodsManagementBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>inventory_check</title>
</head>
<body>
<%!
    /*initial the management tools of back-end.*/
    GoodsManagementBean management_tools=new GoodsManagementBean();
%>
<%
    /*get the goods name*/
    String name= request.getParameter("update_name");
    /*make sure there is a item in the update process*/
    if (name==null)
    {
        response.sendRedirect("inventory.jsp?param=no_item");
    }
    else
    {
        try
        {
            /*get the value return from the inventory update submit*/
            int amount= Integer.parseInt(request.getParameter("amount"));
            double price= Double.parseDouble(request.getParameter("price"));
            if (amount>0 && price>0)
            {
                /*update the inventory.*/
                management_tools.updateSellerInventory(name,amount,price);
                response.sendRedirect("inventory.jsp?param=success");
            }
            else
            {
                /*tell the seller that the input value of price or amount is wrong*/
                response.sendRedirect("inventory.jsp?param=wrongValue");
            }
        }
        catch(Exception e)
        {
            /*tell the seller that the input type of price or amount is wrong*/
            response.sendRedirect("inventory.jsp?param=wrongType");
        }
    }
%>
</body>
</html>
