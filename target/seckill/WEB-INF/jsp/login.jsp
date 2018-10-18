<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <%@include file="common/head.jsp" %>
    <%@include file="common/tag.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/seckill/resources/css/login.css">
</head>

<body style="overflow: hidden">
<%--<%@include file="common/common.jsp" %>--%>
<%--<header class="mui-bar mui-bar-nav">--%>
<%--&lt;%&ndash;<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>&ndash;%&gt;--%>
<%--<h1 class="mui-title">登录</h1>--%>
<%--</header>--%>

<div class="mui-content" style="height: 3000px;overflow: hidden;">
    <%--style="background-image: url('img/img-01.jpg');"--%>
    <div class="container-login100">
        <div class="wrap-login100 p-t-190 p-b-30">
            <form class="login100-form validate-form">
                <div class="login100-form-avatar">
                    <img src="/seckill/resources/img/logo.jpg" alt="AVATAR">
                </div>

                <span class="login100-form-title p-t-20 p-b-45"
                      style="margin-top: 40px;margin-bottom: 40px;">用户登录</span>

                <div class="wrap-input100 validate-input m-b-10" data-validate="请输入用户名">
                    <%--<input class="input100" type="text" name="username" placeholder="用户名" autocomplete="off">--%>

                    <input type="text" class="input100" id="account" value="${account}" placeholder="请输入用户名称">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-user"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input m-b-10" data-validate="请输入密码">
                    <%--<input class="input100" type="password" name="pass" placeholder="密码">--%>
                    <input type="password" class="input100" id="pwd" value="${pwd}" placeholder="请输入密码">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-lock"></i>
                    </span>
                </div>

                <div class="container-login100-form-btn p-t-10">
                    <input type="button" class="login100-form-btn" onclick="login()" style="text-align: center;"
                           value="登 录"></input>
                </div>

                <%--<div class="text-center w-full p-t-25 p-b-230">--%>
                <%--<a href="http://www.dowebok.com/" class="txt1" target="_blank">忘记密码？</a>--%>
                <%--</div>--%>

                <%--<div class="text-center w-full">--%>
                <%--<a class="txt1" href="http://www.dowebok.com/898.html" target="_blank">--%>
                <%--立即注册--%>
                <%--<i class="fa fa-long-arrow-right"></i>--%>
                <%--</a>--%>
                <%--</div>--%>
            </form>
        </div>
    </div>

</div>
</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();


    function login() {


        var account = $("#account").val();
        var pwd = $("#pwd").val();
        var url = "/seckill/login/" + account + "/" + pwd + "/query";

        // $.ajax({
        //     type: "GET", //提交方式
        //     url: url,
        //     success: function (res) {
        //         if (res.account != "") {
        //             alert(res.account)
        //             $.cookie('account', res.account, {expires: 1});
        //             $.cookie('pwd', res.pwd, {expires: 1});
        //             $.cookie('user_id', res.id, {expires: 1});
        //             $.cookie('is_admin', res.isAdmin, {expires: 1});
        //             $.cookie('name', res.name, {expires: 1});
        //             console.log(res.is_admin);
        //             window.location.href = '/seckill/desk/' + res.id;
        //         } else {
        //             alert(res.account)
        //         }
        //     }
        // });
        $.get(url, function (res) {
            // console.log(res)
            console.log("res");
            console.log(res)
            if (res && res.account != "") {


                $.cookie('account', res.account, {expires: 1});
                $.cookie('pwd', res.pwd, {expires: 1});
                $.cookie('user_id', res.id, {expires: 1});
                $.cookie('is_admin', res.isAdmin, {expires: 1});
                $.cookie('name', res.name, {expires: 1});
                console.log($.cookie('pwd'));
                window.location.href = '/seckill/desk/' + res.id;
            } else {
                mui.toast('账号或者密码错误', {duration: 'short', type: 'div'})
            }


        })
        $.cookie('company', '浙江恒山实业集团')

        // mui.toast('c:' + c, {duration: 'short', type: 'div'})
    }

    function skip_department_add() {
        mui.openWindow({
            url: '/seckill/department_add',
            id: 'department'
        })

    }


</script>
</html>