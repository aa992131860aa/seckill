<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>
    <meta name="viewport" content="width=width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0,minimum-scale=1.0">
    <title>网站标题</title>
    <meta name="keywords" content="关键词">
    <meta name="description" content="网站简介">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/resources/css/index.css">


</head>

<body>
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
    .round {
        width: 413px;
        overflow: hidden;
        position: absolute;
    }

    .round .r_top,
    .round .r_bottom {
        float: left;
        width: 413px;
        height: 5px;
        overflow: hidden;
    }

    .round .r_top {
        background-position: 0px -510px;
    }

    .round .r_bottom {
        background-position: 0px -517px;
    }

    .round .round_container {
        float: left;
        width: 403px;
        padding: 0 5px;
        margin: 0px;
        overflow: hidden;
    }

    .round .round_container .r_title {
        float: left;
        width: 403px;
        height: 30px;
        line-height: 30px;
        background: #f1f7fc;
        text-indent: 9px;
        font-size: 14px;
        position: relative;
    }

    .round .round_container .r_title a.close,
    a.close:hover {
        right: 7px;
        top: 6px;
    }

    .round .round_container .round_content,
    .round_content2 {
        float: left;
        width: 385px;
        min-height: 200px;
        _height: 200px;
        padding: 10px 9px;
        background: #fff;
        position: relative;
    }

    .round .round_container .round_content2 {
        width: 403px;
        padding: 0px;
    }

    .round .round_container .round_content2 .rc_tabs {
        display: block;
        height: 27px;
        padding-left: 9px;
        background: #f1f7fc;
        border-bottom: 1px solid #d9d9d9;
    }

    .round .round_container .round_content2 .rc_tabs li {
        float: left;
        margin-right: 5px;
        color: #6e6e6e;
    }

    .round .round_container .round_content2 .rc_tabs li a {
        float: left;
        line-height: 27px;
        padding: 0 9px;
        color: #6e6e6e;
        text-decoration: none;
    }

    .round .round_container .round_content2 .rc_tabs .rc_on {
        line-height: 27px;
        color: #333;
        background: #fff;
        border: 1px solid #d9d9d9;
        cursor: default;
        border-bottom: none;
        -webkit-border-top-left-radius: 3px;
        -webkit-border-top-right-radius: 3px;
        -moz-border-radius-topleft: 3px;
        -moz-border-radius-topright: 3px;
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
    }

    .round .round_container .round_content .gm {
        width: 168px;
        height: 222px;
        position: absolute;
        right: 10px;
        top: 15px;
    }

    .round .round_container .round_content .survey {
        font-size: 14px;
        padding: 5px 0 5px 30px;
    }

    .round .round_container .round_content .survey li {
        padding: 8px 0 0 0;
        *padding: 5px 0 0 0;
    }

    .round .round_container .round_content .survey li input {
        width: 15px;
        margin-right: 5px;
    }

    .round .round_container .round_info,
    .round_info1,
    .round_info2 {
        padding: 35px 0 40px 40px;
        overflow: hidden;
    }

    .round .round_container .round_info h3 {
        padding: 0 10px 3px 55px;
        font-size: 14px;
    }

    .round .round_container .round_info p {
        padding: 0 10px 5px 55px;
        font-size: 12px;
        line-height: 20px;
    }

    .round .round_container .round_info ul,
    .round_info2 ul {
        padding-left: 55px;
    }

    .round .round_container .round_info2 ul,
    .round .round_container .round_info2 p {
        padding-left: 20px;
    }

    .round .round_container .round_info li {
        float: left;
        width: 350px;
        padding: 5px 0 5px 0;
        display: block;
        font-size: 14px;
        line-height: 16px;
        *line-height: 18px;
    }

    .round .round_container .round_info li .remarks {
        float: left;
        width: 230px;
        padding: 5px 30px 0 24px;
        font-size: 12px;
        color: #999;
        display: none;
    }

    .round .round_container .round_info li .ri_input {
        float: left;
        width: 14px;
        height: 14px;
        margin-right: 10px;
    }

    .round .round_container .round_info li i {
        margin: 0 8px 0 0;
    }

    .round .round_container .round_info1 {
        padding: 10px 0 40px 10px;
    }

    .round .round_container .round_info2 {
        padding: 30px 0 40px 0;
    }

    .round .round_button {
        float: left;
        width: 383px;
        padding: 8px 10px;
        background: #f9f9f9;
    }

    .round .round_button a.button,
    .round .round_button a.button1 {
        float: right;
        margin-left: 15px;
    }

    /*阴影背景*/

    .login,
    .accounts_list,
    .accounts_list li a.a1:hover,
    .accounts_list li a.a2:hover,
    .accounts_list li a.a3:hover,
    .accounts_list li a.a4:hover,
    .password_list,
    .accounts_list li a.pw1:hover,
    .accounts_list li a.pw2:hover,
    .accounts_list li a.pw3:hover,
    .accounts_list li a.pw4:hover,
    .toolbox_list,
    .toolbox_list li a.t1:hover,
    .toolbox_list li a.t2:hover,
    .toolbox_list li a.t3:hover,
    .toolbox_list li a.t4:hover,
    .toolbox_list li a.t5:hover,
    a.title_icon:hover,
    .ue_warn,
    .r_top,
    .r_bottom {
    }

    /* CSS Bg */

    a.close,
    a.close:hover,
    a.t_close,
    a.t_close:hover,
    a.handheld:hover {
        background-image: url(/resources/img/bg.png);
        background-repeat: no-repeat;
        _background-image: url(/resources./img/ie6_bg.png);
        background-repeat: no-repeat;
    }

    /*关闭*/

    a.close {
        width: 17px;
        height: 17px;
        position: absolute;
        background-position: -675px -130px;
    }

    a.close:hover {
        background-position: -720px -220px;
    }

    #login_alert::before {
        content: "";
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: #000000;
        opacity: 0.3;
    }
</style>
<div class="round" id="login_alert" style="display:none;z-index:10003;left:30%;top:30%;">
    <div class="r_top"></div>
    <div class="round_container">
        <div class="r_title">用户登录
            <a class="close" href="javascript:alert_login_close();"></a>
        </div>
        <div class="round_content">
            <iframe style="margin: auto;width: 370px;height: 340px;background-color:transparent;"
                    allowTransparency="true" name="embed_login_frame"
                    id="embed_login_frame" frameborder="0" scrolling="no" src=""></iframe>

        </div>
    </div>
    <div class="r_bottom"></div>
</div>
<script>

    /*
     *兼容IE6的居中定位
     */
    function setCenter() {
        $("#login_alert").css("position", "absolute");
        var FrameMarginTop = document.documentElement.scrollTop - document.getElementById("login_alert").offsetHeight / 2 + "px";
        var FrameMarginLeft = document.documentElement.scrollLeft - document.getElementById("login_alert").offsetWidth / 2 + "px";
        $("#login_alert").css({"marginTop": FrameMarginTop, "marginLeft": FrameMarginLeft});
    }

    function reload_top(n) {
        document.cookie = "pt_mbkey=; EXPIRES=Fri, 02-Jan-1970 00:00:00 GMT; PATH=/; DOMAIN=.qq.com";
        top.location.reload();
    }
</script>
<div id="app" class="container">
    <div id="banner" class="banner">
        <div class="banner-bg">
            <div class="banner-header">
                <div class="header-wrap">
                    <div class="header-left">
                        <%--<img src="/resources/img/ico_logo.png" class="header-logo">--%>
                    </div>
                    <div class="header-right">
                        <a id="my_feedback" href="#" target="_blank">
                            <p>反馈问题</p>
                        </a>
                        <a id="header-right-app" onMouseOver="onAppDownloadShow()" onmouseleave="onAppDownloadHide()"
                           style="cursor:default">
                            <p>手机App</p>
                        </a>
                        <div class="header-divide-line"></div>
                        <div class="header-login">
                            <a href="javascript:alert_login('');">登录</a>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <div id="header-right-qrcode" class="up-qrcode" style="display:none;">
            <div class="icon"></div>
            <p class="desc">扫码下载手机App</p>
        </div>
    </div>
    <div class="content">
        <div class="content-wrap clearfix">
            <div class="row">
                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="work" ></div>
                            <p>我的工作台</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="storage" ></div>
                            <p>资源库存管理</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="contact" ></div>
                            <p>合同管理</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="money" ></div>
                            <p>费用管理</p>

                        </a>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="receivable" ></div>
                            <p>应收管理</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="handle" ></div>
                            <p>应付管理</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="query" ></div>
                            <p>查询管理</p>

                        </a>
                    </div>
                </div>

                <div class="col-xs-6 col-sm-3 col-md-3">
                    <div class="content-elem find-pwd">
                        <a target="_blank" class="title" href="#" style="text-decoration: none">
                            <%--<i class="sprite-content pwd-manage-icon"></i>--%>
                            <div class="base" ></div>
                            <p>基本设置</p>

                        </a>
                    </div>
                </div>


            </div>
        </div>
    </div>

</div>




<div class="content" style="display: none;">
    <div class="function">
        <img src="/resources/img/work.png">
        <div>我的工作台</div>
    </div>

    <div class="function">
        <img src="/resources/img/storage.png">
        <div>资源库存管理</div>
    </div>

    <div class="function">
        <img src="/resources/img/contact.png">
        <div>合同管理</div>
    </div>

    <div class="function">
        <img src="/resources/img/money.png">
        <div>费用管理1</div>
    </div>


    <div class="function">
        <img src="/resources/img/receivable.png">
        <div>应收管理</div>
    </div>


    <div class="function">
        <img src="/resources/img/handle.png">
        <div>应付管理</div>
    </div>


    <div class="function">
        <img src="/resources/img/query.png">
        <div>查询管理</div>
    </div>
</div>


<script type="text/javascript">
    var cur_time = new Date();
    var cur_year = cur_time.getFullYear();
    document.getElementById("current_year").innerHTML = cur_year;
</script>

</body>

</html>
<script type="text/javascript">
    $(document).ready(function () {
        make_tucao_url();
    });

    function initDomStyle() {
        var e1 = document.getElementById('header-right-app');
        var e2 = document.getElementById('header-right-qrcode');
        if (e1 == null || e2 == null) return;
        var pos = e1.getBoundingClientRect();
        e2.style.left = (pos.left - 10) + 'px';
    }

    function onAppDownloadShow() {
        initDomStyle();
        document.getElementById('header-right-qrcode').style.display = 'block';
    }

    function onAppDownloadHide() {
        document.getElementById('header-right-qrcode').style.display = 'none';
    }

    /*
        window.onload = function() {
            if (document.documentElement.clientHeight < 1050) {
                document.getElementById('banner').style.height = '300px';
            }
        }
        window.onresize = function() {
            if (document.documentElement.clientHeight < 1050) {
                document.getElementById('banner').style.height = '300px';
            }
            else {
                document.getElementById('banner').style.height = '360px';
            }
        }
    */
</script>









