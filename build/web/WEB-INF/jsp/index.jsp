<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Login Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="styles.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cssmain.css"/>
        <style> 
            input.placeholderred::-webkit-input-placeholder {
                color: red;}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Sign In</h3>

                    </div>
                    <div class="card-body">
                        <form id="form" name="form" onsubmit="return ValidateForm()" action="${pageContext.request.contextPath}/user/userSignIn.htm" method="GET">
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <input type="text" id="username" name="email" id='name' class="form-control" placeholder="email">

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                </div>
                                <input type="password" id="password" name="password" class="form-control" placeholder="password">
                            </div>
                            <div>${message}</div>
                            <div class="row align-items-center remember">
                                <input id="radio" type="checkbox" value="Accept" onclick="EnableSubmit(this)" />I am not a robot
                            </div>
                            <div class="form-group">
                                <input id="sbmt" type="submit" value="Login" class="btn float-right login_btn"disabled >
                            </div>
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            Don't have an account?<a href="${pageContext.request.contextPath}/user/userregister.htm">Sign Up</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <script type='text/javascript'>
            EnableSubmit = function (val)
            {
                var sbmt = document.getElementById("sbmt");

                if (val.checked === true)
                {
                    sbmt.disabled = false;
                } else
                {
                    sbmt.disabled = true;
                }
            };

            function ValidateForm()
            {
                var success = true;
                $("#form input").each(function ()
                {
                    if ($(this).val() === "")
                    {
                        document.getElementById("username").style.borderColor = "#E34234";
                        document.getElementById("password").style.borderColor = "#E34234";
                        $(this).addClass('placeholderred');
                        $(this).attr("placeholder", "Mandatory field");
                        success = false;
                    }
                });
                return success;
            }
        </script>
    </body>
</html>