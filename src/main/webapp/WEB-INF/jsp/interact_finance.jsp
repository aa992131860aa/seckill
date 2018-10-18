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

    <h1 class="mui-title">财务数据录入</h1>
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


    <div class="form-group-sm" style="margin-top: 30px;margin-left: 30px;">

        <label for="startDate" style="float: left;" class=" control-label">助记码</label>
        <div class="col-md-1">
            <input type="text" class="form-control input-sm" placeholder="" id="code"
                   value="${code}">
        </div>


        <label for="startDate" style="float: left;" class=" control-label">时间区间</label>
        <div class="col-md-3 ">


            <div class=" date form_datetime col-md-6" data-date="1979-09-16T05:25:07Z"
                 data-link-field="startDate">
                <input style="background-color: #fff" class="form-control input-sm" id="startDate"
                       size="16" type="text" value="${startDate}" placeholder="开始"
                       readonly
                >
                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                <span class="input-group-addon" style="display: none"><span
                        class="glyphicon glyphicon-th"></span></span>
            </div>

            <div class="date form_datetime col-md-6" data-date="1979-09-16T05:25:07Z"
                 data-link-field="endDate">
                <input style="background-color: #fff" class="form-control input-sm" id="endDate" size="16"
                       type="text" readonly placeholder="结束" value="${endDate}"
                       required>
                <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                <span style="display:none;" class="input-group-addon"><span
                        class="glyphicon glyphicon-th"></span></span>
            </div>
        </div>


        <button style="margin-left: 30px;" type="button" onclick="queryFinance()" class="mui-btn mui-btn-warning">查询
        </button>
        <button class="mui-btn mui-btn-primary" style="margin-left: 30px;float: right;margin-right: 50px;"
                onclick="skipFinanceAdd(0,'insert')">
            新增
        </button>
    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>公司名称</th>
                <th>销售收入</th>
                <th>利润</th>
                <th>税收</th>
                <th>时间</th>
                <th>操作</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${financeList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.name}</td>
                    <td>${list.sale}</td>
                    <td>${list.profit}</td>
                    <td>${list.tax}</td>
                    <td>${list.date}</td>

                    <td><a style="color: #1d4499" onclick="skipFinanceAdd('${list.id}','update')">修改</a> | <a
                            onclick="delFinance('${list.id}')" style="color: #ff0000">删除</a></td>

                </tr>
            </c:forEach>
            <tr>
                <td>合计</td>
                <td></td>
                <td>${saleTotal}</td>
                <td>${profitTotal}</td>
                <td>${taxTotal}</td>
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
    var isAdmin = $.cookie('is_admin');

    $.cookie('selectUuid', "fantasy_9921", {expires: 30, path: '/'});


    function excelExport() {

        var query = $("#query").val();
        var page = $("#page").val();

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

            var url = '/seckill/interact/' + userId + '/' + page + '/' + isAdmin + '/' + code + '/' + startDate + '/' + endDate + '/export';


            mui.openWindow({
                url: url

            })
        } else {

            var url = '/seckill/interact/' + userId + '/' + page + '/' + isAdmin + '/export';

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

                var url = '/seckill/interact/' + userId + '/' + (params.pageNum - 1) + '/' + isAdmin + '/' + code + '/' + startDate + '/' + endDate + '/noExport';

                $(window).attr('location', url);

            } else {
                var url = '/seckill/interact/' + userId + '/' + (params.pageNum - 1) + '/' + isAdmin + '/noExport';
                $(window).attr('location', url);

            }
            $.cookie('page', (params.pageNum - 1), {expires: 7, path: "/"});


        })

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

    });

    function back() {
        var page = parseInt($("#page").val()) + 1;
        var p = -page;

        window.history.go(-1)

    }

    function skipFinanceAdd(id, type) {
        mui.openWindow({
            url: '/seckill/interact/' + id + '/' + type + '/add'

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

    function queryFinance() {
        //custom/{userId}/{page}/{code}/{linkMan}/query
        var code = $("#code").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var rs = "fantasy";
        if (code == '' && startDate == '' && endDate == '') {
            mui.toast('请输入查询条件');
        } else {
            if (code == '') {
                code = rs;
            }
            if (startDate == '') {
                startDate = rs;
            }
            if (endDate == '') {
                endDate = rs;
            }
            var url = "/seckill/interact/" + userId + '/0/' + isAdmin + '/' + code + '/' + startDate + '/' + endDate+'/noExport';
            mui.openWindow({
                url: url

            })
        }
    }

    function delFinance(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/interact/" + id + "/del";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>