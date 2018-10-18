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
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:if test="${type=='water'}">
        <h1 class="mui-title">水表数据</h1>
    </c:if>
    <c:if test="${type=='power'}">
        <h1 class="mui-title">电表数据</h1>
    </c:if>
    <c:if test="${type=='air'}">
        <h1 class="mui-title">空调表数据</h1>
    </c:if>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <div style="margin-top: 3%;" class="table-responsive" id="table">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>房号</th>
                <th>
                    <c:if test="${type=='water'}">水表号</c:if>
                    <c:if test="${type=='power'}">电表号</c:if>
                    <c:if test="${type=='air'}">空调表号</c:if>
                </th>
                <th>抄表时间</th>
                <th>抄表度数</th>
                <th>使用度数</th>
                <th>单价</th>
                <th>总价(元)</th>
                <th>数据来源</th>
                <th>复核</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${freeExportList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.loc}</td>
                    <td>${list.no}</td>
                    <td>${list.date}</td>
                    <td>${list.degree}</td>
                    <td>${list.useDegree}</td>
                    <th>${list.price}</th>
                    <th>${list.total}</th>
                    <td>

                        <c:if test="${list.source=='auto'}">导入</c:if>
                        <c:if test="${list.source=='handle'}">手动输入</c:if>
                        <c:if test="${list.source=='contract'}">合同录入</c:if>
                    </td>
                    <td>
                        <c:if test="${list.isOk==0}">
                            <a onclick="confirmFreeReport('${list.contractUuid}','${list.loc}','${list.type}')"
                               style="color: #ff0000;">确定</a>
                        </c:if>
                        <c:if test="${list.isOk==1}">
                            <a
                                    style="color: #1d4499;">已复核</a>
                        </c:if>
                    </td>
                    <td><a onclick="delFreeReport(${list.id})" style="color: #f00;">删除</a></td>

                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

    <%--<c:if test="${total>0}">--%>
    <div>
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
    $(document).ready(function () {

        var total = $("#total").val();
        var page = $("#page").val();
        var pageSize = $("#pageSize").val();
        var userId = $.cookie('user_id');
        var type = '${type}';

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


            $(window).attr('location', '/seckill/house/freeExport/list/' + userId + '/' + type + '/' + (params.pageNum - 1));


        })


    });

    function confirmFreeReport(contractUuid, loc, type) {
        if (contractUuid == '') {
            contractUuid = 'fantasy';
        }

        mui.confirm('真的要核销吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {

                var url = "/seckill/contract_house/updateWater/" + 1 + "/" + contractUuid + "/" + loc + "/" + type;
                console.log(url)
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });

    }

    function skip_goods_status_add() {
        mui.openWindow({
            url: '/seckill/goods_status_add',
            id: 'department'
        })

    }

    function modifyGoodsStatus(id, name, sort) {

        mui.openWindow({
            url: '/seckill/goods_status/' + id + '/' + name + '/' + sort + '/modify',
            id: 'department',

        })

    }

    function delFreeReport(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/house/freeExport/" + id + "/del";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>