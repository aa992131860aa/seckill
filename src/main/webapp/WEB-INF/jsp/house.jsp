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
    <style type="text/css">

        /*.table th, .table td {*/
        /*text-align: center;*/
        /*vertical-align: middle !important;*/
        /*}*/

        .modal-dialog {
            width: 50%;
            position: absolute;
            top: 15%;
            bottom: 15%;
            left: 0;
            right: 0;
        }

        .modal-content {
            /*overflow-y: scroll; */
            position: absolute;
            top: 0;
            bottom: 0;
            width: 100%;
        }

        .modal-body {
            overflow-y: scroll;
            position: absolute;
            top: 55px;
            bottom: 65px;
            width: 100%;
        }

        .modal-header .close {
            margin-right: 15px;
        }

        .modal-footer {
            position: absolute;
            width: 100%;
            bottom: 0;
        }

    </style>
</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:if test="${role4=='fantasy'}">
        <h1 class="mui-title">查询房源资源</h1>
    </c:if>
    <c:if test="${role4!='fantasy'}">
        <h1 class="mui-title">房源资源管理</h1>
    </c:if>
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
            新增房源
        </button>

        <button style="float: right;margin-right: 50px;
        <c:choose>
        <c:when test="${role4=='fantasy'}">display: none;</c:when>
            <c:when test="${is_admin=='1'}"></c:when>
        <c:otherwise>
        <c:if test="${!role4.contains('查询')}"> display: none; </c:if></c:otherwise></c:choose>" type="button"
                class="mui-btn mui-btn-warning" onclick="skipQuery()">查询
        </button>

        <button style="float: right;margin-right: 50px;"
                type="button"
                class="mui-btn mui-btn-warning" data-toggle="modal" data-target="#freeModal">数据导入
        </button>

        <button style="float: right;margin-right: 50px;"
                type="button"
                class="mui-btn mui-btn-warning" onclick="houseControl()">销控图
        </button>

    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>商品名称</th>
                <th>位置编号</th>
                <th>楼层</th>
                <th>建筑面积</th>
                <th>是否带窗</th>
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
                    <td>${list.floor}</td>
                    <td>${list.buildArea}</td>
                    <td><input
                            <c:if test="${list.isWindow==1}">checked</c:if> disabled
                            style="width: 20px;height: 20px;" type="checkbox"></td>
                    <td>
                            ${list.goodsStatusName}
                    </td>
                    <td>${list.num}</td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('删除')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="deleteHouse(${list.id})" style="color: #f00;">删除</a></td>

                    <td <c:choose> <c:when test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                            test="${!role4.contains('编辑')}"> style="display: none" </c:if></c:otherwise></c:choose>><a
                            onclick="modifyHouse('${list.id}','${list.userId}','${list.goodsNameId}'
                                    ,'${list.location}','${list.useArea}','${list.buildArea}','${list.num}','${list.linkHouse}'
                                    ,'${list.unit}','${list.cash}','${list.waterNo}','${list.powerNo}','${list.airNo}'
                                    ,'${list.startTime}','${list.endTime}','${list.goodsStatusId}','${list.floor}','${list.chartLoc}')">详情</a>
                    </td>
                </tr>
            </c:forEach>

            <tr>
                <td>合计</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>${totalNum}</td>

                <td></td>

                <td>
                </td>
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

<!--各种费用的模态框-->
<div class="modal fade" id="freeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="freeModalLabel">
                    导入菜单
                </h4>
            </div>
            <div class="modal-body" style="overflow:auto;">
                <ul class="list-group">
                    <li class="list-group-item" onclick="freeExport('water')">水表数据导入</li>
                    <li class="list-group-item" onclick="freeExport('power')">电表数据导入</li>
                    <li class="list-group-item" onclick="freeExport('air')">空调表数据导入</li>
                    <li class="list-group-item"></li>
                    <li class="list-group-item" onclick="freeExportHandle('water')">水表数据手动输入</li>
                    <li class="list-group-item" onclick="freeExportHandle('power')">电表数据手动输入</li>
                    <li class="list-group-item" onclick="freeExportHandle('air')">空调表数据手动输入</li>
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <%--<button type="button" class="btn btn-primary">--%>
                <%--提交更改--%>
                <%--</button>--%>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


</body>
<script type="text/javascript" charset="utf-8">
    var userId = $.cookie('user_id');
    mui.init();
    //mui('.mui-off-canvas-wrap').offCanvas().isShown();
    var needRefresh = sessionStorage.getItem("need-refresh");
    if (needRefresh) {
        sessionStorage.removeItem("need-refresh");
        location.reload();
    }

    function houseControl() {
        var url = "/seckill/display/1/house";
        mui.openWindow({
            url: url

        })
    }

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
                $(window).attr('location', '/seckill/house/' + userId + '/' + (params.pageNum - 1) + '/house/noExport');

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
            var url = '/seckill/house/' + userId + '/' + page + '/house/export';
            mui.openWindow({
                url: url

            })
        }

    }

    function showDialog() {
        mui('.mui-off-canvas-wrap').offCanvas().isShown();
    }

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

    function freeExport(type) {
        mui.openWindow({
            url: '/seckill/house/freeExport/' + type

        })
    }

    function freeExportHandle(type) {
        mui.openWindow({
            url: '/seckill/house/freeExport/handle/' + type

        })
    }

    function skip_house_add() {

        mui.openWindow({
            url: '/seckill/house/' + userId + '/house_add/add',
            id: 'department'
        })

    }

    function modifyHouse(id, userId, goodsNameId, loctionL, useArea, buildArea, num, linkHouse, unit, cash, waterNo, powerNo, airNo, startTime, endTime, goodsStatusId, floor, chartLoc) {
        if (linkHouse == '') {
            linkHouse = 'fantasy';
        }
        if (waterNo == '') {
            waterNo = 'fantasy';
        }
        if (powerNo == '') {
            powerNo = 'fantasy';
        }
        if (airNo == '') {
            airNo = 'fantasy';
        }
        if (chartLoc == '') {
            chartLoc = 'fantasy';
        }
        var url = "/seckill/house/" + id + "/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + buildArea
            + "/" + num + "/" + linkHouse + "/" + unit + "/" + cash + "/" + waterNo + "/" + powerNo + "/" + airNo + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + chartLoc + "/info";

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