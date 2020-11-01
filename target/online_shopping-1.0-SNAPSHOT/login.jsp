<html>
<head>
    <meta charset="UTF-8">
    <title>Log in</title>
    <link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
<%!
    String alert="";
%>
<%
    alert="";
    String request_order=request.getParameter("param");
    if(request_order!=null)
    {
        switch (request_order) {
            case "noUser":
                alert = "* The user does not exist.";
                break;
            case "wrongPassword":
                alert = "* The password is wrong.";
                break;
            case "noLogin":
                alert = "Please log in your account.";
                break;
            case "wrongType":
                alert = "* The input user name has existed.";
                break;
        }
    }

%>
<div class="page">
    <div class="panel">
        <div class="panel_visible">
            <!--sign up-->
            <div class="panel_content">
                <h1 class="panel_title">  Sign up </h1>
                <form action="check.jsp?param=register" method="post">
                    <label class="form_label" for="username">Username</label>
                    <input class="form_input" type="text" id="username" name="username">
                    <label class="form_label" for="password">Password</label>
                    <input class="form_input " type="password" id="password" name="password">
                    <label class="form_label" for="userType">User Type</label>
                    <select name="type" class="select_list" id="userType">
                        <option value="0">Seller</option>
                        <option value="1">Buyer</option>
                    </select>
                    <input class="form_btn" type="submit" value="Sign up">
                    <button class="form_toggle js-formToggle" type="button">Or, Sign in</button>
                </form>
            </div>
            <!--sign in-->
            <div class="panel_content panel_content-overlay js-panel_content ">
                <h1 class="panel_title">  Sign in </h1>
                <form action="check.jsp" method="post">
                    <label class="form_label" for="usernameIn">Username</label>
                    <input class="form_input" type="text" id="usernameIn" name="usernameIn">
                    <label class="form_label" for="passwordIn">Password</label>
                    <input class="form_input " type="password" id="passwordIn" name="passwordIn">
                    <input class="form_btn" type="submit" value="Sign in">
                    <br>
                    <button class="form_toggle js-formToggle" type="button">Or, Sign up</button>
                </form>
            </div>
        </div>
        <div class="panel_back js-imageAnimate">
            <img class="panel_img" src="images/login.png" />
        </div>
        <div class="alert_text">
            <%=alert%>
        </div>
    </div>
</div>
<script src="js/login.js"></script>
</body>
</html>
