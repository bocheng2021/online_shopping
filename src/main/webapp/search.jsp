<%@ page import="database.DBUtil" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Search page</title>
    <link rel="stylesheet" type="text/css" href="css/search.css">
</head>
<body>
<%!
    DBUtil database_tools=new DBUtil();
    String user_content="Sign up/ in";
    String user_address="login.jsp";
%>
<%
    String show_or_not="yes";
    String description="Sorry, we don't have such goods";
    /*the number of the search items.*/
    int num=1;
    String[] result_names;

    String search_input = request.getParameter("search_input");
    List<List> result=database_tools.Search(search_input);
    if (result!=null)
    {
        description="";
        /*let number equal to the result size.*/
        num=result.size();
        result_names=new String[result.size()];
        /*get the name from the database.*/
        for (int i=0;i<result.size();i++)
        {
            result_names[i]=((result.get(i).get(0).toString()).replace("images/category/", "").
                    replace(".png", ""));
        }
    }
    else
    {
        /*to show that the search content will not show out*/
        show_or_not="no";
        result_names= new String[1];
        result_names[0]="011";
    }
    /*the method to process the user login*/
    if(request.getSession().getAttribute("username")!=null)
    {
        user_content="Log out";
        user_address="logout.jsp";
    }
    else
    {
        user_content="Sign up/ in";
        user_address="login.jsp";
    }
%>
<div class="header">
    <!-- 设置logo -->
    <div class="logo" style="width:150px">
        <img style="transform:scale(0.3)" src="images/logo.png" alt="">
    </div>
    <!-- Set home -->
    <div class="home">
        <button><a href="index.jsp">Home</a></button>
    </div>
    <!-- set user log in or log out. -->
    <div class="auth">
        <ul>
            <li><a href="<%=user_address%>"><%=user_content%></a></li>
        </ul>
    </div>
</div>
<div class="content">
    <div class="welcome">
        -- Search Result  --
    </div>
    <ul id="search_content">
        <%
            for(int i=0;i<num;i++){
        %>
        <li>
            <a href="goods.jsp?param=<%=result_names[i]%>">
                <img src="images/category/<%=result_names[i]%>.png" class="img_li" height="240" width="220"  alt="">
            </a>
            <div class="info">
                <h3><%=database_tools.getSingleNameByPhoto("images/category/"+result_names[i]+".png")%></h3>
                <p>
                    <%=database_tools.getDetailsByPhoto("images/category/"+result_names[i]+".png")%>
                </p>
                <div class="img_btn">
                    <!-- price，buy logo -->
                    <div class="price">¥<%=database_tools.getSinglePriceByPhoto("images/category/"+result_names[i]+".png")%>
                    </div>
                    <!-- cart button -->
                    <button class="btn" id="detail_button">
                        <a href="goods.jsp?param=<%=result_names[i]%>">
                            Details
                        </a>
                    </button>
                </div>
            </div>
        </li>
        <%} %>
    </ul>
    <div class="description">
        <%=description%>
    </div>
</div>
<script>
    let display = "<%=show_or_not%>";
    /*the method is used to hide the whole ul*/
    function Display()
    {
        if(display === "no"){
            document.getElementById('search_content').style.display = "none";
            display = false;
        }
        else {
            document.getElementById('search_content').style.display = "";
            display = true;
        }
    }
    window.onload=Display();
</script>
<!-- --------------------footer page-------------------- -->
<div class="footer">
    <p class="p2">HiShop© 2020 POWERED BY <span>Group6</span></p>
</div>
</body>
</html>