<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Register Page</title>
        <!--Made with love by Mutiullah Samim -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src=" //cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!--Bootsrap 4 CDN-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <!--Fontawesome CDN-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!--        <script src="jquery-1.7.1.min.js"></script>-->
        <!--Custom styles-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cssmain.css"/>
        <script>
            $(document).ready(function () {
                $("#email").blur(function () {
                    var text = $(this).val();
                    $.ajax({
                        url: "${pageContext.request.contextPath}/emailConfirmation.htm?userInput=" + text, //tou lew pou na steilei to request kai me ti parametrous
                        contentType: "application/json", //ti perimenei na parei pisw(edw 8elei json)
                        success: function (result) {           //sto result einai auto pou mas fernei o controler(to json)
                            $("#message").empty();
                            var jsonobj = $.parseJSON(result);   //pairnei to result kai to kanei jsonObject

                            $.each(jsonobj, function (i, item) {
                                $tr = $('<tr>').append(
                                        $('<td>').text(item.message),
                                        );
                                $("#message").append($tr);
                                if ($("#message").text() === "Email allready exists!") {
                                    $("#message").css(({"color": "red"}));
                                    $("#sbmt").attr("disabled", false);
                                } else {
                                    $("#message").empty();
                                }
                            });
                        }
                    });
                });
            });
        </script>

    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">


                <div class="card">
                    <div class="card-header text-center">
                        <h3>Sign Up</h3>

                    </div>
                    <div class="card-body">
                        <spring:form id="register_form" name="form"   method="POST" action="${pageContext.request.contextPath}/user/userregistration.htm" modelAttribute="user" >

                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <spring:input path="firstName" id="firstname"  class="form-control" placeholder="Firstname" type="firstName" required="required"/>
                                <h1 style="color: red">
                                    <spring:errors path="firstName"/></h1>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                </div>
                                <spring:input path="lastName" id="lastname"  class="form-control" placeholder="Lastname" type="lastName" required="required"/>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-envelope "></i></span>
                                </div>
                                <spring:input path="email" id="email"  class="form-control" placeholder="e-mail" type="email" required="required"/>
                            </div>
                            <div id="message"></div>
                            <h6 style="color: red">
                                <spring:errors path="email"/>

                                <div class="input-group form-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-building"></i></span>
                                    </div>
                                    <spring:input path="company"   class="form-control" placeholder="Company (optional)" type="company"/>
                                </div>
                                <div class="input-group form-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    </div>
                                    <spring:input path="phone" class="form-control" placeholder="Phone (optional)" type="phone"/>
                                </div>
                                <div class="input-group form-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    </div>
                                    <spring:input path="password"  id="password" class="form-control" onkeyup="passValidation() " placeholder="Password" type="password" required="required"/><span class="error_msg"></span>
                                </div>
                                <div class="input-group form-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    </div>
                                    <spring:input path="passwordValidation"  id="passwordValidation" class="form-control" onkeyup="passValidation() " placeholder="Validate password" type="password" required="required"/>
                                </div>

                                <div id="errorid" style="visibility: hidden"><p id='p1'></p></div>
                                <div class="form-group">
                                    <input id="sbmt"  type="submit" value="Submit" class="btn float-right login_btn" >
                                </div>
                                <div>${message}</div>
                            </spring:form>
                    </div>

                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            <a href="${pageContext.request.contextPath}/index.htm">Main Page</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <script type='text/javascript'>

            $('#firstname').bind("propertychange change click keyup input paste", function (event) {

                var firstname = document.getElementById('firstname').value;

                if (firstname < 8)
                {
                    $("#firstnameerror").append("Firstname name must contain at least 8 characters");
                } else
                {
                    $("#message").empty();
                }
            });


            function passValidation() {
                var pass1 = document.getElementById("password").value;
                var pass2 = document.getElementById("passwordValidation").value;
                var ok = true;
                if (pass1 !== pass2) {
                    document.getElementById("password").style.borderColor = "#E34234";
                    document.getElementById("passwordValidation").style.borderColor = "#E34234";
                    sbmt.disabled = true;
                    document.getElementById("errorid").style = {"visibility": "visible"};
                    document.getElementById("errorid").style.color = 'red';
                    document.getElementById("errorid").innerHTML = "Passwords do not match";
                    $("#sbmt").disabled = "true";
                    ok = false;
                } else {
                    sbmt.disabled = false;
                    document.getElementById("errorid").innerHTML = "";
                    document.getElementById("password").style.borderColor = "green";
                    document.getElementById("passwordValidation").style.borderColor = "green";

                }
                return ok;
            }

        </script>
    </body>
</html>