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
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">我的工作台</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('预警')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>预警</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">

                        <li class="mui-table-view-cell" onclick="skipWarn()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('合同到期预警')}" > style="display: none" </c:if></c:otherwise></c:choose>>合同到期预警  <c:if test="${warnCount>0}"><span style="background-color: red;color: white" class="mui-badge">${warnCount}</span></c:if></li>
                        <li class="mui-table-view-cell" onclick="skipContractWarn()"  <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('收款时间预警')}" > style="display: none" </c:if></c:otherwise></c:choose>>收款时间预警<c:if test="${contractWarnCount>0}"><span style="background-color: red;color: white" class="mui-badge">${contractWarnCount}</span></c:if></li>
                    </ul>
                </div>


            </div>
        </li>


            <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('审批')}" > style="display: none" </c:if></c:otherwise></c:choose>>
                <a class="mui-navigate-right" href="#"><strong>审批</strong></a>
                <div class="mui-collapse-content">
                    <%--<div>系统管理员</div>--%>
                    <%--<div>工作日志</div>--%>
                    <%--<div>数据备份</div>--%>
                    <div class="mui-collapse-content" style="margin-top: -20px">
                        <ul class="mui-table-view">
                            <li class="mui-table-view-cell" onclick="skipConfirm()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('合同审批复核')}" > style="display: none" </c:if></c:otherwise></c:choose>>合同审批复核 <c:if test="${confirmCount>0}"><span style="background-color: red;color: white" class="mui-badge">${confirmCount}</span></c:if></li>
                            <li class="mui-table-view-cell" onclick="skipCancel()" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('合同撤销审批')}" > style="display: none" </c:if></c:otherwise></c:choose>>合同撤销审批 <c:if test="${cancelCount>0}"><span style="background-color: red;color: white" class="mui-badge">${cancelCount}</span></c:if></li>
                        </ul>
                    </div>


                </div>
            </li>



                <%--<li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('报表')}" > style="display: none" </c:if></c:otherwise></c:choose>>--%>
                    <%--<a class="mui-navigate-right" href="#"><strong>报表</strong></a>--%>
                    <%--<div class="mui-collapse-content">--%>
                        <%--&lt;%&ndash;<div>系统管理员</div>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<div>工作日志</div>&ndash;%&gt;--%>
                        <%--&lt;%&ndash;<div>数据备份</div>&ndash;%&gt;--%>
                        <%--<div class="mui-collapse-content" style="margin-top: -20px">--%>
                            <%--<ul class="mui-table-view">--%>
                                <%--<li class="mui-table-view-cell">常用报表</li>--%>

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
    function skipDepartment() {
        mui.openWindow({
            url: 'department/0/query'

        })
    }

    function skipWarn() {
        mui.openWindow({
            url: '/seckill/contract_warn/'+userId+'/0/query'

        })
    }
    function skipConfirm() {
        mui.openWindow({
            url: '/seckill/contract_house_confirm/'+userId+'/0'

        })
    }
    function skipCancel() {
        mui.openWindow({
            url: '/seckill/contract_house_cancel/'+userId+'/0'

        })
    }

    function skipContractWarn() {
        mui.openWindow({
            url: '/seckill/contract_contract_warn/'+userId+'/0/query'

        })
    }

    function skipRole() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
</script>
</html>