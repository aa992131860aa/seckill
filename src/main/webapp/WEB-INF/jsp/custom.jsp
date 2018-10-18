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

</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">客户汇总表</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>

    <button type="button" style="float: right;margin-right: 30px"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="excelExport()"> 导出Excel
    </button>

</header>
<div class="mui-content">


    <div class="form-inline" style="margin-top: 20px">

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">
            <label for="code" style="display: inline" class="form-label">公司助记码查询</label>
            <input style="display: inline" type="text" value="${code}" class="form-control" id="code">

        </div>

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">
            <label for="linkMan" style="display: inline" class="form-label">联系人查询</label>
            <input style="display: inline" type="text" value="${linkMan}" class="form-control" id="linkMan">

        </div>

        <button style="margin-left: 30px;" type="button" onclick="queryCustom()" class="mui-btn mui-btn-warning">查询
        </button>
        <button style="margin-left: 30px;float: right;margin-right: 50px;
        <c:choose>
        <c:when test="${role4=='fantasy'}">display: none;</c:when>
            <c:when test="${is_admin=='1'}"></c:when>
        <c:otherwise>
        <c:if test="${!role4.contains('新增')}"> display: none; </c:if></c:otherwise></c:choose>" type="button"
                class="mui-btn mui-btn-primary"
                onclick="skip_custom_add()">
            新增客户
        </button>
    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>客户名称</th>
                <th>备注</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                        test="${!role4.contains('删除')}"> style="display: none" </c:if></c:otherwise></c:choose>>操作
                </th>
                <th style="color: #1d4499;
                <c:choose>
                    <c:when test="${is_admin=='1'}"></c:when>
                <c:otherwise>
                <c:if test="${!role4.contains('编辑')}"> display: none; </c:if></c:otherwise></c:choose>">详情
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${customList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.name}</td>
                    <td>${list.remark}</td>

                    <td><c:if test="${list.workerList.size()>0}">${list.workerList.get(0).name}</c:if></td>
                    <td><c:if test="${list.workerList.size()>0}">${list.workerList.get(0).phone}</c:if></td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('删除')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="deleteCustom('${list.uuid}','${list.name}')" style="color: #f00;">删除</a></td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('编辑')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="updateCustom('${list.uuid}','${list.name}')">详情</a></td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>


    <%--<c:if test="${total>0}">--%>
        <div>
            <input type="hidden" id="query" value="${query}">
            <input type="hidden" id="total" value="${total}">
            <input type="hidden" id="page" value="${page}">
            <input type="hidden" id="pageSize" value="${pageSize}">
            <div style="float: left;margin-left: 2%;line-height: 80px">总共 ${total} 条记录,每页显示${pageSize}条记录</div>
            <div id="page-container-static-big" style="float: right;margin-right: 2%;"></div>
        </div>
    <%--</c:if>--%>

</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();
    var needRefresh = sessionStorage.getItem("need-refresh");
    if (needRefresh) {
        sessionStorage.removeItem("need-refresh");
        location.reload();
    }
    var userId = $.cookie('user_id');
    $.cookie('selectUuid', "fantasy_9921", {expires: 30, path: '/'});


    function excelExport() {

        var query = $("#query").val();
        var page = $("#page").val();
        if (query == 'query') {
            var code = $("#code").val();
            var linkMan = $("#linkMan").val();
            var rs = "fantasy";
            if (code == '') {
                code = rs;
            }
            if (linkMan == '') {
                linkMan = rs;
            }
            var url = '/seckill/custom/' + userId + '/' + page + '/' + code + '/' + linkMan + '/query/export';


            mui.openWindow({
                url: url

            })
        } else {

            var url = '/seckill/custom/' + userId + '/' + page + '/export';
            mui.openWindow({
                url: url

            })
        }

    }

    $(document).ready(function () {

        var total = $("#total").val();
        var page = $("#page").val();
        var pageSize = $("#pageSize").val();
        var userId = $.cookie("user_id");
        var query = $("#query").val();


        //静态  大型图标样式
        $("#page-container-static-big").page({
            count: total,
            pageSize: pageSize,
            maxPage: 7,
            pageNum: (parseInt(page) + 1),
            theme: "normal"
        });


        $("#page-container-static-big").on("pageChanged", function (event, params) {
            console.log(params);


            $(this).data("page").refresh(params);
            if (query == 'query') {
                var code = $("#code").val();
                var linkMan = $("#linkMan").val();
                var rs = "fantasy";
                if (code == '') {
                    code = rs;
                }
                if (linkMan == '') {
                    linkMan = rs;
                }

                $(window).attr('location', '/seckill/custom/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + linkMan + '/query/noExport');

            } else {

                $(window).attr('location', '/seckill/custom/' + userId + '/' + (params.pageNum - 1) + '/noExport');

            }
            $.cookie('page', (params.pageNum - 1), {expires: 7, path: "/"});


        })


    });

    function back() {
        var page = parseInt($("#page").val()) + 1;
        var p = -page;

        window.history.go(-1)

    }

    function skipQuery() {
        mui.openWindow({
            url: '/seckill/house/' + 0 + '/query'

        })
    }

    function skip_custom_add() {
        mui.openWindow({
            url: '/seckill/custom/insert',
            id: 'department'
        })

    }

    function updateCustom(uuid, name) {
        var url = "/seckill/custom/" + uuid + "/" + name + "/update";
        mui.openWindow({
            url: url

        })
    }

    function modifyHouse(id, userId, goodsNameId, loctionL, useArea, buildArea, num, linkHouse, unit, cash, waterNo, powerNo, airNo, startTime, endTime, goodsStatusId, floor) {
        var url = "/seckill/house/" + id + "/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + buildArea
            + "/" + num + "/" + linkHouse + "/" + unit + "/" + cash + "/" + waterNo + "/" + powerNo + "/" + airNo + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/info";
        mui.openWindow({
            url: url,
            id: 'department',

        })

    }

    function queryCustom() {
        //custom/{userId}/{page}/{code}/{linkMan}/query
        var code = $("#code").val();
        var linkMan = $("#linkMan").val();
        var rs = "fantasy";
        if (code == '' && linkMan == '') {
            mui.toast('请输入查询条件');
        } else {
            if (code == '') {
                code = rs;
            }
            if (linkMan == '') {
                linkMan = rs;
            }
            var url = "/seckill/custom/" + userId + '/0/' + code + '/' + linkMan + "/query/noExport";
            mui.openWindow({
                url: url

            })
        }
    }

    function deleteCustom(uuid, name) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/custom/" + uuid + "/" + name + "/del";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>