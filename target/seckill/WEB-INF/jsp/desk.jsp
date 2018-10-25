<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>恒山实业</title>
    <%@include file="common/head.jsp" %>
    <%@include file="common/tag.jsp" %>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">

    <!--标准mui.css-->
    <link rel="stylesheet" href="/seckill/resources/css/mui.min.css">
    <!--App自定义的css-->
    <%--<link rel="stylesheet" type="text/css" href="/seckill/resources/css/app.css" />--%>
</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <!--<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>-->
    <h1 class="mui-title">操作台</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="logout()"> 退出登录
    </button>
</header>
<div class="mui-slider" style="height: 30%;">
    <div class="mui-slider-group">
        <div class="mui-slider-item">
            <a href="#"><img src="/seckill/resources/img/banner.jpg"/></a>
        </div>
        <!--<div class="mui-slider-item">
            <a href="#"><img src="img/2.jpg" /></a>
        </div>
        <div class="mui-slider-item">
            <a href="#"><img src="img/3.jpg" /></a>
        </div>-->
    </div>
</div>
<div class="mui-content">
    <ul class="mui-table-view mui-grid-view mui-grid-9">
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('我的工作台')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipMy()">
            <a href="#">
                <span class="mui-icon mui-icon-home"><span style="display: none;" class="mui-badge">5</span></span>
                <div class="mui-media-body">我的工作台</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"   <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('资源库存管理')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipStorage()">
            <a href="#">
                <span class="mui-icon mui-icon-list"></span>
                <div class="mui-media-body">资源库存管理</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"   <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('合同管理')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipContact()">
            <a href="#">
                <span class="mui-icon mui-icon-compose"></span>
                <div class="mui-media-body">合同管理</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"  <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('费用管理')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipMoney()">
            <a href="#">
                <span class="mui-icon mui-icon-help"></span>
                <div class="mui-media-body">费用管理</div>
            </a>
        </li>
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"   <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('应收应付')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipHandle()">
            <a href="#">
                <span class="mui-icon mui-icon-search"></span>
                <div class="mui-media-body">应收应付</div>
            </a>
        </li>
        <%--<li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3">--%>
        <%--<a href="#">--%>
        <%--<span class="mui-icon mui-icon-phone"></span>--%>
        <%--<div class="mui-media-body">应付管理</div>--%>
        <%--</a>--%>
        <%--</li>--%>
        <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"   <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('互动模块')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipInteract()">
            <a href="#">
                <span class="mui-icon mui-icon-info"></span>
                <div class="mui-media-body">互动模块</div>
            </a>
        </li>

        <li id="base" class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"   <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role1.contains('基本设置')}"> style="display: none" </c:if></c:otherwise></c:choose>
            onclick="skipBase()"><a href="#">

            <span class="mui-icon mui-icon-gear"></span>
            <div class="mui-media-body">基本设置</div>
        </a></li>
        <!-- <li class="mui-table-view-cell mui-media mui-col-xs-4 mui-col-sm-3"><a href="#">
                  <span class="mui-icon mui-icon-more"></span>
                  <div class="mui-media-body">more</div></a></li>-->
    </ul>
</div>

</body>
<script src="/seckill/resources/js/mui.min.js"></script>
<script>
    mui.init({
        swipeBack: true //启用右滑关闭功能
    });
    var userId = $.cookie("user_id");
    var account = $.cookie('account');

    function logout() {

        $.cookie("pwd", "", {expires: -1});
        window.location.href = '/seckill/login';
    }

    function skipMy() {
        mui.openWindow({
            url: '/seckill/my/' + userId,
            id: 'my'
        })
    }

    function skipStorage() {
        mui.openWindow({
            url: '/seckill/storage/' + userId,
            id: 'storage'
        })
    }

    function skipContact() {
        mui.openWindow({
            url: '/seckill/contact1/' + userId

        })
    }

    function skipMoney() {
        mui.openWindow({
            url: '/seckill/money/' + userId,
            id: 'money'
        })
    }

    function skipHandle() {
        mui.openWindow({
            url: '/seckill/handle/' + userId,
            id: 'handle'
        })
    }

    function skipInteract() {
        mui.openWindow({
            url: '/seckill/interact/' + userId,
            id: 'interact'
        })
    }

    if (account == 'ts') {
        skipInteract();
    }

    function skipBase() {
        mui.openWindow({
            url: '/seckill/base/' + userId,
            id: 'base'
        })
    }
</script>

</html>