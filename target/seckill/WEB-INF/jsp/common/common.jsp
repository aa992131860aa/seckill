<%--
  Created by IntelliJ IDEA.
  User: 99213
  Date: 2018-07-01
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--<head>--%>
    <%--<title>Title</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--</body>--%>

<%--</html>--%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script type="text/javascript">

    var pwd = $.cookie('pwd');
     console.log('pwd:'+pwd)
    if(pwd=='null' || pwd==null){
        window.location.href='/seckill/login';
    }


</script>