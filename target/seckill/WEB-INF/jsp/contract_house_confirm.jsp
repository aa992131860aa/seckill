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

    <h1 class="mui-title">合同审批复核</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <%--// 新增 复核 审批/退回 删除--%>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>客户名称</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>合同号</th>
                <th>类型</th>
                <th>操作
                </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${contractList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.codeAuto}</td>

                    <td>${list.linkMan}</td>
                    <td>${list.phone}</td>
                    <td>${list.no}</td>
                    <td>
                        <c:if test="${list.style=='house'}"> 房源合同</c:if>
                        <c:if test="${list.style=='car'}"> 车位合同</c:if>
                        <c:if test="${list.style=='ad'}"> 广告合同</c:if>
                        <c:if test="${list.isPay==1}"> 终止</c:if>
                    </td>
                    <td>
                        <a onclick="updateContractDetaill('${list.uuid}','${list.style}','${list.isPay}')">详情</a>


                    </td>
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

    $(document).ready(function () {

        var total = $("#total").val();
        var page = $("#page").val();
        var pageSize = $("#pageSize").val();
        var userId = $.cookie("user_id");
        var query = $("#query").val();
        var no = $("#no").val();


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


            $(window).attr('location', '/seckill/contract_house_confirm/' + userId + '/' + (params.pageNum - 1));


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

    function skipContractHouse() {
        mui.openWindow({
            url: '/seckill/contract_house/insert'
        })

    }


    function updateContractDetaill(uuid, style, isPay) {
        //是否是撤销合同的审批
        var url = "/seckill/contract_" + style + "/" + uuid + "/confirm/detail";
        if (isPay == '1') {
            url = "/seckill/contract_" + style + "/" + uuid + "/" + isPay + "/del/2018/0";
            mui.openWindow({
                url: url

            })
        } else {
            mui.openWindow({
                url: url

            })
        }


    }

    function updateContract(uuid) {
        var url = "/seckill/contract_house/" + uuid + "/update";
        mui.openWindow({
            url: url

        })
    }

    function updateCustom(uuid) {
        var url = "/seckill/contract_house/" + uuid + "/del";
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


    function queryContract() {
        //custom/{userId}/{page}/{code}/{linkMan}/query
        var code = $("#code").val();
        var linkMan = $("#linkMan").val();
        var no = $("#no").val();
        var rs = "fantasy";
        if (code == '' && linkMan == '' && no == '') {
            mui.toast('请输入查询条件');
        } else {
            if (code == '') {
                code = rs;
            }
            if (linkMan == '') {
                linkMan = rs;
            }
            if (no == '') {
                no = rs;
            }
            var url = "/seckill/contract_house/" + userId + '/0/' + code + '/' + linkMan + '/' + no + "/query";
            mui.openWindow({
                url: url

            })
        }
    }

    function deleteCustom(uuid) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/contract_house/" + uuid + "/del";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>