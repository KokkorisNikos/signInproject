<%-- 
    Document   : user_view
    Created on : 1 Νοε 2018, 8:35:06 μμ
    Author     : nikos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="styles.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/cssmain.css"/>

        <script>
            function checkPhoto()
            {
                var fileInput = document.getElementById('imgupload');
                var extn = fileInput.value.split('.').pop().toLowerCase();
                var allowedExtensions = ['jpeg', 'jpg', '.png'];
                var isValidFile = false;
                for (var index in allowedExtensions)
                {
                    if (extn === allowedExtensions[index])
                    {
                        isValidFile = true;
                    }
                }
                if (!isValidFile) {
                    alert('Allowed Extensions are : *.' + allowedExtensions.join(', *.'));
                    isValidFile = false;
                }
                if (fileInput.files[0].size > 102400) {
                    alert("Image too big (max 100kb");
                    isValidFile = false;
                }
                if (isValidFile === true) {
                    var photoForm = document.getElementById("photoUp");
                    photoForm.action = '${pageContext.request.contextPath}/user/photoUpload.htm';
                    photoForm.submit();
                }
            }
        </script>
        <title>User page</title>
    </head>
    <body>
    <body>
        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header text-center">
                        <h3>Hello  ${user.getFirstName()} </h3>

                    </div>
                    <div class="card-body text-center" style="color: #FFC312">

                        <div class="row justify-content-center">
                            <a>${user.getFirstName()}</a>
                            <a></a>
                            <a>${user.getLastName()}</a>
                            <a>${user.getEmail()}</a>
                        </div>
                        <div class="row justify-content-center">

                            <a  href="#"  onclick="document.getElementById('imgupload').click();">
                                <form id="photoUp" id="file" class="fa fa-camera" onchange="checkPhoto()" method="POST"  enctype="multipart/form-data" >
                                    <input type="file" name="file" id="imgupload" style="display:none" multiple/> </form>Change Image</a>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex float-left">
                            <a  href="${pageContext.request.contextPath}/user/logOut.htm">Log Out</a>
                        </div>
                        <div class="d-flex float-right">
                            <a  href="${pageContext.request.contextPath}/index.htm">Main Page</a>
                        </div>
                    </div>
                </div>
            </div>
    </body>

</body>
</html>
