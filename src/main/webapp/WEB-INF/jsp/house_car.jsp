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
    <c:if test="${role4=='fantasy'}">
        <h1 class="mui-title">车位房源资源</h1>
    </c:if>
    <c:if test="${role4!='fantasy'}">
        <h1 class="mui-title">车位资源管理</h1>
    </c:if>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
    <button type="button" style="float: right;margin-right: 30px"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="excelExport()"> 导出Excel
    </button>
    <button style="float: right;margin-right: 50px;"
            type="button"
            class="mui-btn mui-btn-warning" onclick="houseControl()">销控图
    </button>
</header>
<div class="mui-content">
    <div style="margin-top: 30px;" class="form-group">
        <%--<label style="" class="col-md-offset-1">单位:<font style="color: #ff0000">平方米</font></label>--%>
        <button style="float: right;margin-right: 50px;
        <c:choose>
        <c:when test="${role4=='fantasy'}">display: none;</c:when>
            <c:when test="${is_admin=='1'}"></c:when>
        <c:otherwise>
        <c:if test="${!role4.contains('新增')}"> display: none; </c:if></c:otherwise></c:choose>" type="button"
                class="mui-btn mui-btn-primary"
                onclick="skip_house_add()">
            新增车位
        </button>
        <button style="float: right;margin-right: 50px;
        <c:choose>
        <c:when test="${role4=='fantasy'}">display: none;</c:when>
            <c:when test="${is_admin=='1'}"></c:when>
        <c:otherwise>
        <c:if test="${!role4.contains('查询')}"> display: none; </c:if></c:otherwise></c:choose>" type="button"
                class="mui-btn mui-btn-warning" onclick="skipQuery()">查询
        </button>


    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>商品名称</th>
                <th>位置编号</th>
                <th>类型</th>
                <th>状态</th>
                <th>数量</th>
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
            <c:forEach items="${houseList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.goodsName}</td>
                    <td>${list.location}</td>
                    <td>${list.carName}</td>
                    <td>${list.goodsStatusName}</td>
                    <td>${list.num}</td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('删除')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="deleteHouse(${list.id})" style="color: #f00;">删除</a></td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('编辑')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="modifyHouse('${list.id}','${list.userId}','${list.goodsNameId}'
                                    ,'${list.location}','${list.useArea}','${list.num}','${list.startTime}','${list.endTime}','${list.goodsStatusId}','${list.floor}','${list.carId}','${list.chartLoc}')">详情</a>
                    </td>
                </tr>
            </c:forEach>
            <tr>
                <td>合计</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>${totalNum}</td>

                <td></td>

                <td></td>
            </tr>
            </tbody>
        </table>
    </div>

    <input type="hidden" id="type" value="${type}">
    <input type="hidden" id="typeId" value="${typeId}">
    <input type="hidden" id="goodsNameId" value="${goodsNameId}">
    <input type="hidden" id="locationL" value="${locationL}">
    <input type="hidden" id="goodsStatusId" value="${goodsStatusId}">
    <input type="hidden" id="floor" value="${floor}">
    <input type="hidden" id="startTime" value="${startTime}">
    <input type="hidden" id="endTime" value="${endTime}">
    <input type="hidden" id="startArea" value="${startArea}">
    <input type="hidden" id="endArea" value="${endArea}">
    <input type="hidden" id="isWindow1" value="${isWindow1}">
    <input type="hidden" id="isWindow2" value="${isWindow2}">
    <input type="hidden" id="status0" value="${status0}">
    <input type="hidden" id="status1" value="${status1}">
    <input type="hidden" id="status2" value="${status2}">
    <input type="hidden" id="statusVal0" value="${statusVal0}">
    <input type="hidden" id="statusVal1" value="${statusVal1}">
    <input type="hidden" id="statusVal2" value="${statusVal2}">
    <input type="hidden" id="adType0" value="${adType0}">
    <input type="hidden" id="adType1" value="${adType1}">
    <input type="hidden" id="adTypeVal0" value="${adTypeVal0}">
    <input type="hidden" id="adTypeVal1" value="${adTypeVal1}">
    <input type="hidden" id="carType0" value="${carType0}">
    <input type="hidden" id="carType1" value="${carType1}">
    <input type="hidden" id="carTypeVal0" value="${carTypeVal0}">
    <input type="hidden" id="carTypeVal1" value="${carTypeVal1}">
    <input type="hidden" id="house1" value="${house1}">
    <input type="hidden" id="house2" value="${house2}">
    <input type="hidden" id="house3" value="${house3}">


    <input type="hidden" id="query" value="${query}">
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
    function houseControl() {
        var url = "/seckill/display/1/car";
        mui.openWindow({
            url: url

        })
    }
    var userId = $.cookie('user_id');
    $(document).ready(function () {

        var total = $("#total").val();
        var page = $("#page").val();
        var pageSize = $("#pageSize").val();
        var userId = $.cookie("user_id");

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

            var query = $("#query").val();
            if (query == 'query') {


                var page = $("#page").val();
                var type = $("#type").val();
                var typeId = $("#typeId").val();
                var goodsNameId = $("#goodsNameId").val();
                var loctionL = $("#locationL").val();

                var goodsStatusId = $("#goodsStatusId").val();


                var floor = $("#floor").val();

                var startTime = $("#startTime").val();

                var endTime = $("#endTime").val();

                var startArea = $("#startArea").val();

                var endArea = $("#endArea").val();


                var house1 = $("#house1").val();
                var house2 = $("#house2").val();
                var house3 = $("#house3").val();

                var isWindow1 = $("#isWindow1").val();
                var isWindow2 = $("#isWindow2").val();

                var status0 = $("#status0").val();
                var status1 = $("#status1").val();
                var status2 = $("#status2").val();

                var statusVal0 = $("#statusVal0").val();
                var statusVal1 = $("#statusVal1").val();
                var statusVal2 = $("#statusVal2").val();

                var adType0 = $("#adType0").val();
                var adType1 = $("#adType1").val();

                var adTypeVal0 = $("#adTypeVal0").val();
                var adTypeVal1 = $("#adTypeVal1").val();

                var carType0 = $("#carType0").val();
                var carType1 = $("#carType1").val();

                var carTypeVal0 = $("#carTypeVal0").val();
                var carTypeVal1 = $("#carTypeVal1").val();


                var url = "/seckill/house/" + userId + "/" + (params.pageNum - 1) + "/" + type + "/" + typeId + "/" + goodsNameId
                    + "/" + loctionL + "/" + goodsStatusId + "/" + floor + "/" + startTime + "/"
                    + endTime + "/" + startArea + "/" + endArea + "/" + isWindow1 + "/" + isWindow2 + "/"
                    + status0 + "/" + status1 + "/" + status2 + "/" + statusVal0 + "/" + statusVal1 + "/" + statusVal2
                    + "/" + adType0 + "/" + adType1 + "/" + adTypeVal0 + "/" + adTypeVal1
                    + "/" + carType0 + "/" + carType1 + "/" + carTypeVal0 + "/" + carTypeVal1
                    + "/" + house1 + "/" + house2 + "/" + house3 + "/query/noExport";
                $(window).attr('location', url);
            } else {
                $(window).attr('location', '/seckill/house/' + userId + '/' + (params.pageNum - 1) + '/house_car/noExport');
            }

        })


    });

    function excelExport() {
        var page = $("#page").val();
        var query = $("#query").val();
        if (query == 'query') {


            var page = $("#page").val();
            var type = $("#type").val();
            var typeId = $("#typeId").val();
            var goodsNameId = $("#goodsNameId").val();
            var loctionL = $("#locationL").val();

            var goodsStatusId = $("#goodsStatusId").val();


            var floor = $("#floor").val();

            var startTime = $("#startTime").val();

            var endTime = $("#endTime").val();

            var startArea = $("#startArea").val();

            var endArea = $("#endArea").val();


            var house1 = $("#house1").val();
            var house2 = $("#house2").val();
            var house3 = $("#house3").val();

            var isWindow1 = $("#isWindow1").val();
            var isWindow2 = $("#isWindow2").val();

            var status0 = $("#status0").val();
            var status1 = $("#status1").val();
            var status2 = $("#status2").val();

            var statusVal0 = $("#statusVal0").val();
            var statusVal1 = $("#statusVal1").val();
            var statusVal2 = $("#statusVal2").val();

            var adType0 = $("#adType0").val();
            var adType1 = $("#adType1").val();

            var adTypeVal0 = $("#adTypeVal0").val();
            var adTypeVal1 = $("#adTypeVal1").val();

            var carType0 = $("#carType0").val();
            var carType1 = $("#carType1").val();

            var carTypeVal0 = $("#carTypeVal0").val();
            var carTypeVal1 = $("#carTypeVal1").val();


            var url = "/seckill/house/" + userId + "/" + page + "/" + type + "/" + typeId + "/" + goodsNameId
                + "/" + loctionL + "/" + goodsStatusId + "/" + floor + "/" + startTime + "/"
                + endTime + "/" + startArea + "/" + endArea + "/" + isWindow1 + "/" + isWindow2 + "/"
                + status0 + "/" + status1 + "/" + status2 + "/" + statusVal0 + "/" + statusVal1 + "/" + statusVal2
                + "/" + adType0 + "/" + adType1 + "/" + adTypeVal0 + "/" + adTypeVal1
                + "/" + carType0 + "/" + carType1 + "/" + carTypeVal0 + "/" + carTypeVal1
                + "/" + house1 + "/" + house2 + "/" + house3 + "/query/export";
            mui.openWindow({
                url: url

            })
        } else {
            var url = '/seckill/house/' + userId + '/' + page + '/house_car/export';
            mui.openWindow({
                url: url

            })
        }

    }

    function back() {
        var page = parseInt($("#page").val()) + 1;
        var p = -page;

        window.history.go(-1)

    }

    function skipQuery() {
        mui.openWindow({
            url: '/seckill/house/' + 2 + '/query'

        })
    }

    function skip_house_add() {
        mui.openWindow({
            url: '/seckill/house/' + userId + '/house_car_add/add',
            id: 'department'
        })

    }

    function modifyHouse(id, userId, goodsNameId, loctionL, useArea, num, startTime, endTime, goodsStatusId, floor, carType, chartLoc) {
        if (chartLoc == '') {
            chartLoc = 'fantasy';
        }
        var url = "/seckill/house_car/" + id + "/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + num + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + carType + "/" + chartLoc + "/info";
        mui.openWindow({
            url: url,
            id: 'department',

        })

    }

    function deleteHouse(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/house/" + id + "/delete";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>