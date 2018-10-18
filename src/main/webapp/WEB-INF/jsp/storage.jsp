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
    <h1 class="mui-title">资源库存管理</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('客户管理')}" > style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>客户管理</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">



                        <li class="mui-table-view-cell" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('客户汇总表')}" > style="display: none" </c:if></c:otherwise></c:choose> onclick="skipCustom()">客户汇总表</li>
                        <li class="mui-table-view-cell" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role3.contains('客户报表')}" > style="display: none" </c:if></c:otherwise></c:choose> onclick="skipCustomDetail()">客户报表</li>
                    </ul>
                </div>


            </div>
        </li>


            <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('房源管理')}" > style="display: none" </c:if></c:otherwise></c:choose>>
                <a class="mui-navigate-right" href="#"><strong>房源管理</strong></a>
                <div class="mui-collapse-content">
                    <%--<div>系统管理员</div>--%>
                    <%--<div>工作日志</div>--%>
                    <%--<div>数据备份</div>--%>
                    <div class="mui-collapse-content" style="margin-top: -20px">
                        <ul class="mui-table-view">
                            <li class="mui-table-view-cell" onclick="skipHouse()">房源管理汇总表</li>

                        </ul>
                    </div>


                </div>
            </li>



                <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('广告位管理')}" > style="display: none" </c:if></c:otherwise></c:choose>>
                    <a class="mui-navigate-right" href="#"><strong>广告位管理</strong></a>
                    <div class="mui-collapse-content">
                        <%--<div>系统管理员</div>--%>
                        <%--<div>工作日志</div>--%>
                        <%--<div>数据备份</div>--%>
                        <div class="mui-collapse-content" style="margin-top: -20px">
                            <ul class="mui-table-view">
                                <li class="mui-table-view-cell" onclick="skipAd()">广告位管理汇总表</li>

                            </ul>
                        </div>


                    </div>
                </li>




                    <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if test="${!role2.contains('车位管理')}" > style="display: none" </c:if></c:otherwise></c:choose>>
                        <a class="mui-navigate-right" href="#"><strong>车位管理</strong></a>
                        <div class="mui-collapse-content">
                            <%--<div>系统管理员</div>--%>
                            <%--<div>工作日志</div>--%>
                            <%--<div>数据备份</div>--%>
                            <div class="mui-collapse-content" style="margin-top: -20px">
                                <ul class="mui-table-view">
                                    <li class="mui-table-view-cell" onclick="skipCar()">车位管理汇总表</li>

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

    function skipUser() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
    function skipHouse() {
        mui.openWindow({
            url: '/seckill/house/'+userId+'/0/house/noExport'

        })
    }
    function skipCustom() {

        $.cookie('page', 0, {expires: 7});

        mui.openWindow({
            url: '/seckill/custom/'+userId+'/0/noExport'

        })
    }
    function skipCustomDetail() {
        mui.openWindow({
            url: '/seckill/custom_detail/'+userId+'/0/noExport'

        })
    }
    function skipAd() {
        mui.openWindow({
            url: '/seckill/house/'+userId+'/0/house_ad/noExport'

        })
    }
    function skipCar() {
        mui.openWindow({
            url: '/seckill/house/'+userId+'/0/house_car/noExport'

        })
    }
    function skipRole() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
</script>
</html>