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
    <script type="text/javascript" src="http://static.runoob.com/assets/qrcode/qrcode.min.js"></script>

</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">保洁清洁汇总表</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>

    <%--<button type="button" style="float: right;margin-right: 30px"--%>
    <%--class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"--%>
    <%--onclick="excelExport()"> 导出Excel--%>
    <%--</button>--%>

</header>
<div class="mui-content">

    <%--<button onclick="createQrcode()">点我生成网二维码</button>--%>
    <%--<button onclick="downloadQrcode()">点我下载二维码</button>--%>
    <div style="display: none" id="qrcode"></div>

    <div class="form-group-sm" style="margin-top: 30px;margin-left: 30px;">

        <label for="startDate" style="float: left;" class=" control-label">保洁人查询</label>
        <div class="col-md-1">
            <input type="text" class="form-control input-sm" placeholder="" id="userName"
                   value="${userName}">
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

    </div>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>点位码</th>
                <th>完工状态</th>
                <th>时间</th>
                <th>操作</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${safeList}" var="list">
                <tr <c:if test="${list.isNormal==0}"> style="color: #ff0000" </c:if>>
                    <td>${list.id}</td>
                    <td>${list.dot}</td>
                    <td>
                        <c:if test="${list.isNormal==1}"> 完毕 </c:if>
                        <c:if test="${list.isNormal==0}"> </c:if>
                    </td>
                    <td>${list.createTime}</td>
                    <td><a style="color: #1d4499" onclick="skipFinanceAdd('${list.dot}')">详情</a></td>

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
    var isAdmin = $.cookie('is_admin');

    $.cookie('selectUuid', "fantasy_9921", {expires: 30, path: '/'});

    function createQrcode() {
        qrcode1 = new QRCode(document.getElementById("qrcode"),
            {
                text: "hahaha", width: 300,
                //生成的二维码的宽度
                height: 300,
                //生成的二维码的高度
                colorDark: "#000000",
                // 生成的二维码的深色部分
                colorLight: "#ffffff",
                //生成二维码的浅色部分
                correctLevel: QRCode.CorrectLevel.H
            });
    }

    function downloadQrcode(no) {
        $("#qrcode").html("")
        new QRCode(document.getElementById("qrcode"),
            {
                text: no, width: 300,
                //生成的二维码的宽度
                height: 300,
                //生成的二维码的高度
                colorDark: "#000000",
                // 生成的二维码的深色部分
                colorLight: "#ffffff",
                //生成二维码的浅色部分
                correctLevel: QRCode.CorrectLevel.H
            });
        setTimeout(function () {
            var qrcode = document.getElementById('qrcode');
            var img = qrcode.getElementsByTagName('img')[0];
            var link = document.createElement("a");
            var url = img.getAttribute("src");
            link.setAttribute("href", url);
            link.setAttribute("download", no + '.png');
            link.click();
        }, 500)

    }


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
            //{userId}/{page}/{isAdmin}/{code}/{startDate}/{endDate}
            var url = '/seckill/interact/' + userId + '/' + page + '/' + isAdmin + '/' + code + '/' + startDate + '/' + endDate;


            mui.openWindow({
                url: url

            })
        } else {

            var url = '/seckill/interact/' + userId + '/' + page + '/' + isAdmin;

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

                var userName = $("#userName").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var rs = "fantasy";
                if (userName == '') {
                    userName = rs;
                }
                if (startDate == '') {
                    startDate = rs;
                }

                if (endDate == '') {
                    endDate = rs;
                }


                // /interact_safe_deal/{userId}/{page}/{type}/safe
                var url = '/seckill/interact_safe_deal/' + userId + '/' + (params.pageNum - 1) + '/safe/safe/' + userName + '/' + startDate + '/' + endDate;

                $(window).attr('location', url);

            } else {
                var url = '/seckill/interact_safe_deal/' + userId + '/' + (params.pageNum - 1) + '/safe/safe';
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

    function skipFinanceAdd(dot) {

        mui.openWindow({
            url: '/seckill/interact_clean/' + dot + '/insert/detail'

        })

        // mui.openWindow({
        //     url: '/seckill/interact_safe_deal/' + dot + '/safe/safe'
        //
        // })
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
        var userName = $("#userName").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var rs = "fantasy";

        if (userName == '') {
            userName = rs;
        }
        if (startDate == '') {
            startDate = rs;
        }
        if (endDate == '') {
            endDate = rs;
        }

        var url = '/seckill/interact_clean_deal/' + userId + '/0/clean/clean/' + userName + '/' + startDate + '/' + endDate;

        mui.openWindow({
            url: url

        })

    }

    function delFinance(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/interact_dot/" + id + "/del";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>