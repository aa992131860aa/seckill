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
    <h1 class="mui-title">合同管理</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('房源合同管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>房源合同管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipContractHouse()">房源合同管理</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('广告位合同管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>广告位合同管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipContractAd()">广告位合同管理</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('车位合同管理')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>车位合同管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipContractCar()">车位合同管理</li>

                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('合同撤销')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>合同撤销</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipContractCancel()">合同撤销,清账管理</li>

                    </ul>
                </div>


            </div>
        </li>


        <%--<li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('合同续签快捷键')}" > style="display: none" </c:if></c:otherwise></c:choose>>--%>
        <%--<a class="mui-navigate-right" href="#"><strong>合同续签快捷键</strong></a>--%>
        <%--<div class="mui-collapse-content">--%>
        <%--&lt;%&ndash;<div>系统管理员</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div>工作日志</div>&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div>数据备份</div>&ndash;%&gt;--%>
        <%--<div class="mui-collapse-content" style="margin-top: -20px">--%>
        <%--<ul class="mui-table-view">--%>
        <%--<li class="mui-table-view-cell">复制原合同,允许编辑,保证金延续</li>--%>

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

    function skipContractHouse() {
        mui.openWindow({
            url: '/seckill/contract_house/' + userId + '/0/noExport'

        })
    }

    function skipContractAd() {
        mui.openWindow({
            url: '/seckill/contract_ad/' + userId + '/0/noExport'

        })
    }

    function skipContractCar() {
        mui.openWindow({
            url: '/seckill/contract_car/' + userId + '/0/noExport'

        })
    }

    function skipContractCancel() {
        mui.openWindow({
            url: '/seckill/contract_cancel/' + userId + '/0/noExport'

        })
    }

    function skipUser() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }

    function skipRole() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
</script>
</html>