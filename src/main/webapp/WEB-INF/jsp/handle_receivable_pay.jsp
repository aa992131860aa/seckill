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
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">应付款汇总表</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <div class="form-inline" style="margin-top: 20px">

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">
            <label for="code" style="display: inline" class="form-label">客户助记码查询</label>
            <input style="display: inline;height: 30px;" type="text" value="${code}" class="form-control input-sm"
                   id="code">

        </div>

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">

            <label for="linkMan" style="display: inline" class="form-label">时间区间查询</label>

            <div class="input-group date form_datetime " data-date="1979-09-16T05:25:07Z"
                 data-link-field="startDate">
                <input style="background-color: #fff;height: 30px;" class="form-control" id="startDate"
                       style="" size="16" type="text" value="${startDate}"
                       placeholder="开始"
                       readonly
                >
                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                <span class="input-group-addon" style="display: none"><span
                        class="glyphicon glyphicon-th"></span></span>
            </div>
            --
            <div class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z"
                 data-link-field="startDate">
                <input style="background-color: #fff;height: 30px;" class="form-control" id="endDate"
                       style="" size="16" type="text" value="${endDate}"
                       readonly
                       placeholder="结束"
                >
                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                <span class="input-group-addon" style="display: none"><span
                        class="glyphicon glyphicon-th"></span></span>
            </div>

        </div>


        <button style="margin-left: 30px;" type="button" onclick="queryContract()" class="mui-btn mui-btn-warning">
            查询
        </button>

    </div>
    <%--// 新增 复核 审批/退回 删除--%>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>

                <th>序号</th>
                <th>客户名称</th>
                <th>应付金额</th>
                <th>合同号</th>
                <th>类型</th>
                <th>是否核销</th>

                <th>详情</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${contractList}" var="list">
                <tr>

                    <td>${list.id}</td>

                    <td>${list.codeAuto} ${list.remark}</td>
                    <td>${list.payIn} </td>
                    <td>${list.no}</td>
                    <td><c:if test="${list.style=='house'}"> 房源合同</c:if>
                        <c:if test="${list.style=='car'}"> 车位合同</c:if>
                        <c:if test="${list.style=='ad'}"> 广告合同</c:if></td>

                    <td>
                        <c:if test="${list.isFinish==0}">
                            <input type="checkbox" disabled style="width: 20px;height: 20px">
                        </c:if>
                        <c:if test="${list.isFinish==1}">
                            <input checked type="checkbox" disabled style="width: 20px;height: 20px">
                        </c:if>
                    </td>
                    <td>
                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('续签')}"> display: none </c:if>
                        </c:otherwise>
                        </c:choose>;color: #1d4499"
                           onclick="updateContract('${list.codeAuto}','${list.remark}','${list.uuid}','${list.style}')">详情 </a>


                    </td>
                </tr>
            </c:forEach>

            <tr>
                <td>
                    <div style="display: flex;justify-content: center;align-items: center ">
                        合计
                    </div>

                </td>
                <td></td>
                <td>${payTotal}</td>
                <td></td>
                <td></td>

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

    $(document).ready(function () {


        $('.form_datetime').datepicker({
            language: "zh-CN",    //语言选择中文
            format: "yyyy-mm-dd",    //格式化日期
            timepicker: true,     //关闭时间选项
            yearEnd: 2050,        //设置最大年份
            todayButton: true,    //关闭选择今天按钮
            autoclose: 1,        //选择完日期后，弹出框自动关闭
            // startView: 4,         //打开弹出框时，显示到什么格式,3代表月
            // minView: 3,          //能选择到的最小日期格式
        });

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
            if (query == 'query') {
                var code = $("#code").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var rs = "fantasy";
                if (code == '') {
                    code = rs;
                }
                if (startDate == '') {
                    startDate = rs;
                }
                if (endDate == '') {
                    endDate = rs;
                }

                $(window).attr('location', '/seckill/handle_receivable_pay/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + startDate + '/' + endDate );

            } else {

                $(window).attr('location', '/seckill/handle_receivable_pay/' + userId + '/' + (params.pageNum - 1));

            }


        })


    });

    function back() {
        var page = parseInt($("#page").val()) + 1;
        var p = -page;

        window.history.go(-1)

    }


    function updateContract(codeAuto, remark, uuid, style) {
        if (remark == '') {
            remark = 'fantasy';
        }
        var url = '';
        if (style == 'house') {
            url = "/seckill/contract_house_pay/" + uuid + "/del";
        }
        if (style == 'ad') {
            url = "/seckill/contract_ad_pay/" + uuid + "/del";
        }
        if (style == 'car') {
            url = "/seckill/contract_car_pay/" + uuid + "/del";
        }
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
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var rs = "fantasy";
        // if (code == '' && linkMan == '' && no == '') {
        //     mui.toast('请输入查询条件');
        // } else {
            if (code == '') {
                code = rs;
            }
            if (startDate == '') {
                startDate = rs;
            }
            if (endDate == '') {
                endDate = rs;
            }
            var url = "/seckill/handle_receivable_pay/" + userId + '/0/' + code + '/' + startDate + '/' + endDate;
            mui.openWindow({
                url: url

            })
        // }
    }

    function printContract() {
        $.each($('input:checkbox'), function () {
            if (this.checked) {
                window.alert("你选了：" +
                    $('input[type=checkbox]:checked').length + "个，其中有：" + $(this).val());
            }
        });
    }

    function allSelect() {
        var all = $("#all").is(':checked');


        if (all == true) {
            $("input[name='checkbox']").attr("checked", "true");
        } else {
            $("input[name='checkbox']").removeAttr("checked");
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