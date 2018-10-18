<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <%@include file="common/head.jsp"%>
    <%@include file="common/tag.jsp"%>
    <%@include file="common/common.jsp" %>
    <%--<script src="/seckill/resources/js/mui.min.js"></script>--%>
    <%--<link href="/seckill/resources/css/mui.min.css" rel="stylesheet"/>--%>
    <%--<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">--%>
    <%--<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" rel="stylesheet">--%>
    <%--<link href="/seckill/resources/css/department.css" rel="stylesheet"/>--%>

    <%--<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
</head>

<body>

<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">基本设置</h1>
    <%--<c:choose> <c:when test="${is_admin=='1'}">asdfs</c:when><c:otherwise><c:if test="${!role1.contains('系统设置')}" > a第二ds </c:if></c:otherwise></c:choose>--%>

</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active"  <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('系统设置')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>系统设置</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipSystem()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('系统管理员')}" > style="display: none" </c:if></c:otherwise></c:choose>>系统管理员</li>
                        <li class="mui-table-view-cell" onclick="skipSysLogs()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('工作日志')}" > style="display: none" </c:if></c:otherwise></c:choose>>工作日志</li>
                        <li class="mui-table-view-cell" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('数据备份')}" > style="display: none" </c:if></c:otherwise></c:choose>>数据备份</li>
                        <li class="mui-table-view-cell" onclick="skipDot()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('点位码')}" > style="display: none" </c:if></c:otherwise></c:choose>>点位码</li>
                    </ul>
                </div>


            </div>
        </li>

        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('费用类别')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>费用类别</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipFree()">各类费用</li>

                    </ul>
                </div>


            </div>
        </li>

        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('合同类型')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>合同类型</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipContact()">合同设置</li>
                    </ul>
                </div>


            </div>
        </li>

        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('商品设置')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>商品设置</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('商品状态')}" > style="display: none" </c:if></c:otherwise></c:choose> onclick="skipGoodsStatus()">商品状态</li>
                        <li class="mui-table-view-cell" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('商品名称')}" > style="display: none" </c:if></c:otherwise></c:choose> onclick="skipGoodsName()">商品名称</li>

                    </ul>
                </div>


            </div>
        </li>

        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('车位类型')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>车位类型</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipCar()">车位类型</li>


                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('广告类型')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>广告类型</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipAd()">广告设置</li>


                    </ul>
                </div>


            </div>
        </li>

        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('部门设置')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>部门设置</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipDepartment()">部门新增</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('用户设置')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>用户设置</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipUser()">员工新增</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('权限')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>权限</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipRole()">权限分配</li>

                    </ul>
                </div>


            </div>
        </li>


    </ul>
</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();
    var userId = $.cookie('user_id');
    var isAdmin=$.cookie('is_admin');

    function skipDepartment() {
        mui.openWindow({
            url: '/seckill/department/0/query'

        })
    }
    function skipDot() {
        mui.openWindow({
            url: '/seckill/interact_dot/' + userId + '/0'
        })
    }
    function skipSystem(){
        mui.openWindow({
            url: '/seckill/system/0/query'

        })
    }
    function skipGoodsName(){
        mui.openWindow({
            url: '/seckill/goods_name/0/query'

        })
    }
    function skipGoodsStatus(){
        mui.openWindow({
            url: '/seckill/goods_status/0/query'

        })
    }
    function skipCar(){
        mui.openWindow({
            url: '/seckill/car/0/query'

        })
    }

    function skipAd(){
        mui.openWindow({
            url: '/seckill/ad/0/query'

        })
    }

    function skipContact(){
        mui.openWindow({
            url: '/seckill/contact/0/query'

        })
    }
    function skipSysLogs(){
        mui.openWindow({
            url: '/seckill/sys_logs/0/query'

        })
    }
   function skipFree(){
       mui.openWindow({
           url: '/seckill/free/0/query'

       })
   }
    function skipUser() {
        mui.openWindow({
            url: '/seckill/user/0/query'

        })
    }

    function skipRole() {
        mui.openWindow({
            url: '/seckill/user_role/0/query'

        })
    }
</script>
</html>