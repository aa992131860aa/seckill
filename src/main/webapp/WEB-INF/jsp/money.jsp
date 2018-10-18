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
    <%@include file="common/common.jsp" %>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">费用管理</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <%--<li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when--%>
                <%--test="${is_admin=='1'}"></c:when><c:otherwise><c:if--%>
                <%--test="${!role2.contains('期间收费预警')}"> style="display: none" </c:if></c:otherwise></c:choose>>--%>
            <%--<a class="mui-navigate-right" href="#"><strong>期间收费预警</strong></a>--%>
            <%--<div class="mui-collapse-content">--%>
                <%--&lt;%&ndash;<div>系统管理员</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div>工作日志</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div>数据备份</div>&ndash;%&gt;--%>
                <%--<div class="mui-collapse-content" style="margin-top: -20px">--%>
                    <%--<ul class="mui-table-view">--%>
                        <%--<li class="mui-table-view-cell">时间设置</li>--%>

                    <%--</ul>--%>
                <%--</div>--%>


            <%--</div>--%>
        <%--</li>--%>


        <li class="mui-table-view-cell mui-collapse mui-active"  <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('电')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>电</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipMoney('power')">电能耗度数复核</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('水')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>水</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipMoney('water')">水能耗度数复核</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('空调')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>空调</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell"  onclick="skipMoney('air')">空调能耗度数复核</li>

                    </ul>
                </div>


            </div>
        </li>


        <%--<li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when--%>
                <%--test="${is_admin=='1'}"></c:when><c:otherwise><c:if--%>
                <%--test="${!role2.contains('物业</')}"> style="display: none" </c:if></c:otherwise></c:choose>>--%>
            <%--<a class="mui-navigate-right" href="#"><strong>物业</strong></a>--%>
            <%--<div class="mui-collapse-content">--%>
                <%--&lt;%&ndash;<div>系统管理员</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div>工作日志</div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<div>数据备份</div>&ndash;%&gt;--%>
                <%--<div class="mui-collapse-content" style="margin-top: -20px">--%>
                    <%--<ul class="mui-table-view">--%>
                        <%--<li class="mui-table-view-cell">物业费录入</li>--%>

                    <%--</ul>--%>
                <%--</div>--%>


            <%--</div>--%>
        <%--</li>--%>


    </ul>
</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();

    var userId = $.cookie('user_id');

    function skipMoney(type) {
        mui.openWindow({
            url: '/seckill/house/freeExport/list/' + userId + '/' + type + '/0'

        })
    }


</script>
</html>