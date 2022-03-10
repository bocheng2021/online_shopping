<%@ page import="database.UserSystemBean" %>
<%@ page import="encrypt.MyCryptoTool" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head><title>check</title>
</head>
<body>
<%!
    MyCryptoTool cryptoTool=new MyCryptoTool();
    UserSystemBean db_tools =new UserSystemBean();
%>
<%
    /*the below is used for check is the request parameter of param is null or not.*/
    if(request.getParameter("param")!=null)
    {
        String name=request.getParameter("username");
        String password=request.getParameter("password");
        String type = request.getParameter("type");
        if((type.equals("0")||type.equals("seller")||type.equals("Buyer")||type.equals("buyer")||type.equals("Seller")
                ||type.equals("1")) && !db_tools.check_user(name))
        {
            db_tools.registration(name,cryptoTool.encyptMessage(password),type);
            session.setAttribute("username",name);//create the session
            session.setAttribute("password",password);
            //get the sessionID and print it out
            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        else
        {
            /*The user input the wrong user type, it will return wrong.*/
            response.sendRedirect("login.jsp?param=wrongType");
        }
    }
    else
    {
        request.setCharacterEncoding("utf-8");

        //Get the user name and password
        String name=request.getParameter("usernameIn");
        String password=request.getParameter("passwordIn");
        //if fails, return the first page.
        if(!db_tools.verify_User_By_Name(name))
        {
            response.sendRedirect("login.jsp?param=noUser");
        }
        //check if the user exists or the password is right or not.
        else if(db_tools.verify_Password_By_Name(name,cryptoTool.encyptMessage(password))){
            //if success, begin to create the session.
            session.setAttribute("username",name);//create the session
            session.setAttribute("password",password);
            //get the sessionID and print it out
            System.out.println("The session runs.");

            request.getRequestDispatcher("index.jsp").forward(request,response);
        }
        //if fails, return the first page.
        else
        {
            response.sendRedirect("login.jsp?param=wrongPassword");
        }
    }
%>
</body>
</html>