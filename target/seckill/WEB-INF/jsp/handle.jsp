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
    <h1 class="mui-title">应收应付</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('应收管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>应收管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipHandleReceivable()">应收款汇总表</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('收款管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>收款管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipHandlePay()">收款汇总表</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('结算核销')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>结算核销</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipHandleFinish()">核销汇总表</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active"  <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('应付管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>应付管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipHandleReceivablePay()">应付款汇总表</li>

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

    function skipDepartment() {
        mui.openWindow({
            url: 'department/0/query'

        })
    }

    function skipHandleReceivable() {
        mui.openWindow({
            url: '/seckill/handle_receivable/' + userId + '/0'

        })
    }

    function skipHandleReceivablePay() {
        mui.openWindow({
            url: '/seckill/handle_receivable_pay/' + userId + '/0'

        })
    }

    function skipHandleFinish() {
        mui.openWindow({
            url: '/seckill/handle_finish/' + userId + '/0'

        })
    }

    function skipHandlePay() {
        mui.openWindow({
            url: '/seckill/handle_pay/' + userId + '/0'

        })
    }


    function skipRole() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
</script>
</html>