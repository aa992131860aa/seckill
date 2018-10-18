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

    <h1 class="mui-title">客户报表</h1>
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

    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>客户名称</th>
                <th>备注</th>
                <th>法人</th>
                <th>法人电话</th>
                <th>主要财务</th>
                <th>财务电话</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>企业注册信息</th>
                <th>是否在租</th>
                <th>数量</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${customList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.name}</td>
                    <td>${list.remark}</td>

                    <td>

                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty=='法人'}">
                                ${w.name}
                            </c:if>
                        </c:forEach>

                    </td>
                    <td>
                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty=='法人'}">
                                ${w.phone}
                            </c:if>
                        </c:forEach>
                    </td>

                    <td>

                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty=='主要财务'}">
                                ${w.name}
                            </c:if>
                        </c:forEach>

                    </td>
                    <td>
                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty=='主要财务'}">
                                ${w.phone}
                            </c:if>
                        </c:forEach>
                    </td>


                    <td>
                        <c:set var="isDoing" value="0"/>
                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty!='法人'}">
                                <c:if test="${w.duty!='主要财务'}">
                                    <c:if test="${isDoing!=1}">
                                        ${w.name}
                                    </c:if>
                                    <c:set var="isDoing" value="1" scope="page"/>


                                </c:if>
                            </c:if>
                        </c:forEach>

                    </td>
                    <td>
                        <c:set var="isDoing" value="0"/>
                        <c:forEach items="${list.workerList}" var="w">
                            <c:if test="${w.duty!='法人'}">
                                <c:if test="${w.duty!='主要财务'}">

                                    <c:if test="${isDoing!=1}">
                                        ${w.phone}
                                    </c:if>
                                    <c:set var="isDoing" value="1"/>


                                </c:if>
                            </c:if>
                        </c:forEach>
                    </td>


                    <th>${list.registerInfo}</th>
                    <th>${list.isRent}</th>
                    <th>${list.num}</th>

                </tr>
            </c:forEach>

            <tr>
                <th>合计</th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th>${totalNum}</th>
            </tr>
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
            var url = '/seckill/custom_detail/' + userId + '/' + page + '/' + code + '/' + linkMan + '/query/export';


            mui.openWindow({
                url: url

            })
        } else {

            var url = '/seckill/custom_detail/' + userId + '/' + page + '/export';
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

                $(window).attr('location', '/seckill/custom_detail/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + linkMan + '/query/noExport');

            } else {

                $(window).attr('location', '/seckill/custom_detail/' + userId + '/' + (params.pageNum - 1)+'/noExport');

            }


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
            var url = "/seckill/custom_detail/" + userId + '/0/' + code + '/' + linkMan + "/query/noExport";
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