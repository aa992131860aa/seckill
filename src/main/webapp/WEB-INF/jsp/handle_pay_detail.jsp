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

<body style="height: 100%;">

<header class="mui-bar mui-bar-nav">
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">收款(实收)明细单</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content" style="height: 100%;">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">
        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled placeholder="请输入助记码"
                       required id="code_auto"
                       value="${codeAuto}">
            </div>


            <label for="remark" class="col-sm-2 control-label">备注</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="remark"
                       value="${remark}">

            </div>


            <div style="height: 40px;"></div>
            <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                <div class="panel-body">
                    <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                        <label for="name" class="col-md-offset-1 control-label">应收明细(金额:元)</label>


                    </div>

                    <div class="form-group">
                        <div class="table-responsive col-md-9 col-md-offset-1" style="clear: both;margin-top: 30px">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>实收金额</th>
                                    <th>收款时间</th>
                                    <th>备注</th>
                                    <th>方式</th>
                                </tr>
                                </thead>
                                <tbody id="shoppingTb">
                                <c:forEach items="${tableMList}" var="list">
                                    <tr>

                                        <td>${list.id}</td>
                                        <input type="hidden" name="moneyM" value="${list.moneyM}">
                                        <td>${list.moneyM} </td>
                                        <td>${list.dateM}</td>
                                        <td>${list.remark}</td>

                                        <td>
                                            <c:if test="${list.pay1==true}">
                                                现金
                                            </c:if>
                                            <c:if test="${list.pay2==true}">
                                                微信
                                            </c:if>

                                            <c:if test="${list.pay3==true}">
                                                支付宝
                                            </c:if>

                                            <c:if test="${list.pay4==true}">
                                                转账
                                            </c:if>

                                            <c:if test="${list.pay5==true}">
                                                申免
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-lable col-sm-offset-1">合计:<span id="total1"
                                                                              style="color: #f00">100</span>元</label>
                    </div>

                </div>


            </div>

        </div>

    </form>
    <%--// 新增 复核 审批/退回 删除--%>


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
                var linkMan = $("#linkMan").val();
                var rs = "fantasy";
                if (code == '') {
                    code = rs;
                }
                if (linkMan == '') {
                    linkMan = rs;
                }

                $(window).attr('location', '/seckill/handle_pay/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + linkMan + '/' + no + '/query');

            } else {

                $(window).attr('location', '/seckill/handle_pay/' + userId + '/' + (params.pageNum - 1));

            }


        })


    });
    setTotal()

    function setTotal() {
        var total = 0;
        $("input[name='moneyM']").each(function (index, item) {
            if ($(this).val() != "") {
                total += parseFloat($(this).val());
            }
        })

        $("#total1").text(total);
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

    function skipContractHouse() {
        mui.openWindow({
            url: '/seckill/contract_house/insert'
        })

    }

    function updateContract(codeAuto, remark) {
        if (remark == '') {
            remark = 'fantasy';
        }
        var url = "/seckill/handle_receivable_detail/" + codeAuto + "/" + remark + "/" + userId + "/update";
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