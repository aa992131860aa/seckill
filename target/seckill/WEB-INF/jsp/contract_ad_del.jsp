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
    <%@include file="common/jquery_ui.jsp" %>
    <style type="text/css">

        .table th, .table td {
            text-align: center;
            vertical-align: middle !important;
        }

        .modal-dialog {
            width: 90%;
            position: absolute;
            top: 0;
            bottom: 0;
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
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">广告合同管理--终止撤销</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">
    <input type="hidden" id="free" value="${free}">
    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">


        <div class="form-group">
            <label for="type" class="col-sm-2 control-label">合同类型</label>
            <select id="type" onchange="remarkChange()" class="col-sm-3 selectpicker">
                <c:forEach items="${contactList}" var="d">
                    <option <c:if
                            test="${contractId == d.id}"> selected="selected" </c:if>
                            value="${d.id}">${d.name}</option>
                </c:forEach>

            </select>

        </div>
        <input id="code" type="hidden">


        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled placeholder="请输入助记码"
                       required id="code_auto"
                       value="${contract.codeAuto}">
            </div>


            <label for="remark" class="col-sm-2 control-label">备注</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="remark"
                       value="${contract.remark}">

            </div>
        </div>

        <div class="form-group">
            <label for="linkMan" class="col-sm-2 control-label">联系人</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="linkMan"
                       value="${contract.linkMan}">
            </div>


            <label for="phone" class="col-sm-2 control-label">联系电话</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="phone"
                       value="${contract.phone}">

            </div>
        </div>


        <div class="form-group">
            <label for="startDate" class="col-md-2 control-label">合同有效期</label>
            <div class="col-md-3 ">


                <label for="startDate" class="col-md-4 control-label">起始</label>
                <div class="input-group date form_datetime col-md-8" data-date="1979-09-16T05:25:07Z"
                     data-link-field="startDate">
                    <input style="background-color: #fff" class="form-control" id="startDate" onchange="dateTotal()"
                           style="" size="16" type="text" value="${contract.startDate}"
                           readonly
                    >
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon" style="display: none"><span
                            class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <div class="col-md-3 ">
                <label for="endDate" class="col-md-4  control-label">终止</label>
                <div class="input-group date form_datetime col-md-8" data-date="1979-09-16T05:25:07Z"
                     data-link-field="endDate">
                    <input style="background-color: #fff" class="form-control" id="endDate" size="16"
                           onchange="dateTotal()" type="text" readonly value="${contract.endDate}"
                           required>
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span style="display:none;" class="input-group-addon"><span
                            class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <input type="hidden" id="dtp_input1" value=""/>
            <label class=" control-label col-md-offset-1 col-xs-offset-1">合计:<span
                    style="color: #f00" id="totalDay">0</span>天</label>
        </div>


        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">合同到期提前预警(天)</label>
            <div class="col-sm-3">
                <input type="number" disabled class="form-control " id="warnDay"
                       value="${contract.warnDay}">
            </div>


        </div>

        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">合同结束日期</label>
            <div class="col-sm-3">
                <%--<input type="text" class="form-control " style="background-color: #fff"--%>
                <%--required id="contractEndDate"--%>
                <%-->--%>
                <div class="input-group date form_datetime col-md-8" data-date="1979-09-16T05:25:07Z"
                     data-link-field="startDate">
                    <input style="background-color: #fff"
                           onchange="setContractEndDate()"

                           class="form-control" id="contractEndDate"
                           style="" size="16" type="text"
                           readonly
                    >
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon" style="display: none"><span
                            class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>


            <label for="remark" class="col-sm-2 control-label">租赁退订天数</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="endDay">

            </div>
        </div>

        <div class="form-group">


            <label class="col-sm-3 control-label">
                正常终止
                <input type="radio" style="width: 20px;height: 20px;" name="optionsRadios" id="isOver1"
                       value="1" <c:if test="${house.isWindow==1}"> checked </c:if>>

            </label>


            <label class="col-sm-2 control-label">
                异常终止
                <input type="radio" checked style="width: 20px;height: 20px;" name="optionsRadios" id="isOver2"
                       value="0" <c:if test="${house.isWindow==0}"> checked </c:if>>

            </label>


        </div>
        <div class="form-group">
            <label for="explain" class="col-sm-2 control-label">备注栏</label>
            <div class="col-sm-6">

                <textarea rows="3"
                          <c:if test="${isPay==0}">disabled</c:if>
                          id="explain"
                          placeholder="审批说明或意见">${contract.explain}</textarea>

            </div>
        </div>

        <div style="height: 40px;"></div>
        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">商品名称:车位</label>


                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-9 col-md-offset-1" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>位置编号</th>
                                <%--<th>使用面积</th>--%>
                                <th>状态</th>
                                <th>交付时间</th>

                            </tr>
                            </thead>
                            <tbody id="shoppingTb">
                            <c:forEach items="${contract.tableList1}" var="b">
                                <%--table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1;--%>
                                <tr>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            onclick="search(this)" id="l${b.table0}" type="text" value="${b.table1}"
                                            style=""
                                            name="loc1"/></td>
                                        <%--<td><input disabled="disabled"--%>
                                        <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                        <%--id="uId " type="text" value="${b.table3}" name="useArea1"/></td>--%>
                                    <td><select disabled style="width: 120px;padding-left: 40px;"
                                                class="form-control "
                                                name="goodsStatus1">


                                        <c:forEach items="${goodsStatusList}" var="list">
                                            <option<c:if
                                                    test="${b.table7 == list.id}"> selected="selected" </c:if>
                                                    value="${list.id}">${list.name} </option>
                                        </c:forEach>


                                    </select></td>
                                    <td>
                                        <div class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z"
                                             data-link-field="startTime">
                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                   name="time1" size="16" type="text" value="${b.table2}"
                                                   class="form-control" readonly>
                                            <span style="height: 30px;display: none;" class="input-group-addon">
                                             <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span>
                                        </div>
                                    </td>

                                    <input type="hidden" name="cash1" value="${b.table4}" id="c${b.table0}">
                                    <input type="hidden" name="money1" value="${b.table5}" id="m${b.table0}">
                                    <input type="hidden" name="price1" value="${b.table6}" id="p${b.table0}">

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


            </div>


        </div>


        <div style="height: 40px;"></div>
        <div class="panel panel-default     col-sm-10 col-sm-offset-1  ">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">应收费用组成(单位:元)</label>


                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-10 col-md-offset-1" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th colspan="2">费用名称</th>


                                <th>应收费用</th>
                                <th>应收时间</th>
                                <th>违约金</th>

                            </tr>
                            </thead>
                            <tbody id="shoppingTb">


                            <%--table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1;--%>


                            <c:forEach items="${contract.adTempList}" var="ad" varStatus="loop">
                                <tr>


                                    <td colspan="2"><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           id="uId " type="text" value="${ad.name}"
                                                           name="useArea1"/></td>


                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="${ad.total}" name="useArea1"/></td>

                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="${ad.date}" name="useArea1"/></td>

                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="" name="useArea1"/></td>

                                </tr>

                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-lable col-sm-offset-1">应收金额合计:<span id="total"
                                                                              style="color: #f00">${allTotal}</span>元</label>
                </div>


                <div class="form-group">
                    <label class="control-lable col-sm-offset-1">费用清算:</label>
                    <div class="form-group">

                        <div class="table-responsive col-sm-10 col-sm-offset-1" style="clear: both;margin-top: 30px">
                            <table class="table">

                                <thead>
                                <tr>

                                    <th>应退金额</th>
                                    <th>应收金额</th>
                                    <th>是否需要申免</th>


                                </tr>
                                </thead>
                                <tbody id="shoppingTb">
                                <tr>

                                    <td>
                                        <span id="payInId">${allTotal}</span>

                                    </td>
                                    <td>
                                        <input
                                                style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                <c:if test="${isPay== 1 || isPay==-1}">disabled</c:if>
                                                value="${contract.payOut}"
                                                id="payOutId" <c:if test="${isPay==0}"> placeholder="请输入应付金额" </c:if>
                                                type="number" onchange="payOut()"
                                                name="useArea1"/>

                                    </td>
                                    <td>
                                        <input style="width: 20px;height: 20px;"
                                               <c:if test="${isPay== 1 || isPay==-1}">disabled</c:if> name="checkbox"
                                               id="freeMoney"
                                               onclick="free()"
                                        <c:if test="${contract.isFree==1}"> checked </c:if>
                                               type="checkbox">
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>


                </div>


                <div class="form-group">
                    <%--<label class="control-lable col-sm-offset-1">清算金额合计(单位/元):<span id="totalAll"--%>
                    <%-->${allTotal}</span>元</label>--%>

                    <label class="control-lable col-sm-offset-1">申免金额:
                        <input id="payFree"
                               <c:if test="${isPay==1||isPay==-1}">disabled</c:if>
                               style="display:inline-block;width:200px;border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                               type="number" value="${contract.payFree}">
                        <%--<span id="allTotalOutFree"--%>
                        <%--style="color: #f00">${allTotalOut}</span>--%>
                        (单位:元)</label>
                </div>
                <div class="form-group">
                    <textarea id="freeReason" style="display: none;" rows="3"
                              placeholder="申免理由">${contract.freeReason}</textarea>
                </div>

                <%--<div class="form-group">--%>
                <%--<label class="control-lable col-sm-offset-1">制单人:${contract.userName}</label>--%>
                <%--</div>--%>
            </div>


        </div>


        <%--<div class="form-group">--%>
        <%--<div class="col-xs-offset-4 col-sm-offset-9 col-sm-4">--%>


        <%--<label class="control-label">制单人<span id="userName"></span></label>--%>
        <%--<button type="button" class=" mui-btn mui-btn-primary col-sm-offset-1" onclick="confirm()"> 退订合同--%>
        <%--</button>--%>


        <%--</div>--%>

        <%--</div>--%>
        <div class="form-group ">
            <div class="col-sm-11">
                <c:if test="${isPay==-1}">

                    <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="back()"> 返回
                    </button>

                    <button style="float: right;margin-right: 3%" type="button" class="mui-btn mui-btn-primary "
                            onclick="deal(-1)"> 撤销审核
                    </button>
                    <label style="float: right;margin-right: 3%" class="control-label">审核人:<span
                            id="userName"></span></label>
                </c:if>

                <c:if test="${isPay==1}">

                    <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="back()"> 返回
                    </button>
                    <button style="float: right;margin-left: 3%;margin-right: 3%" type="button"
                            class="mui-btn mui-btn-primary " onclick="deal(1)"> 确定审核
                    </button>
                    <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="deal(-1)">
                        驳回审核
                    </button>
                    <label style="float: right;margin-right: 3%" class="control-label">审核人:<span
                            id="userName"></span></label>
                </c:if>

                <c:if test="${isPay==0}">


                    <button type="button" style="float: right;margin-left:3%;margin-bottom: 3%"
                            class=" mui-btn mui-btn-primary col-sm-offset-1"
                            onclick="confirm()"> 终止合同
                    </button>
                    <label style="float: right" class="control-label">制单人<span
                            id="userName1">${contract.userName}</span></label>

                </c:if>

            </div>
        </div>
    </form>
    <div style="height: 50px;"></div>

</div>


</body>
<script type="text/javascript" charset="utf-8">

    mui.init({

        beforeback: function () {


        }
    });


    function setContractEndDate() {

        var date = $("#contractEndDate").val();

        var endDate = '${contract.endDate}';

        var sDate = new Date(date.replace(/-/g, "/"));
        var eDate = new Date(endDate.replace(/-/g, "/"));
        var days = eDate - sDate;
        var day = parseFloat(days / (1000 * 60 * 60 * 24));

        if (!isNaN(day)) {
            $("#endDay").val(day)

        }

        var dateCount = '${dateCount}';

        var uuid = '${uuid}';
        var url = "/seckill/contract_ad/" + uuid + "/0/del/" + date + "/" + dateCount;
        mui.openWindow({
            url: url
        })
    }
    function deal(isOk) {
        var explain = $("#explain").val();
        var uuid = '${contract.uuid}';
        var userName = $.cookie('account');
        if (explain == '') {
            explain = 'fantasy';
        }
        var url = '/seckill/contract_house_confirm/' + uuid + '/' + isOk + '/' + explain + '/' + userName;
        $.post(url, {}, function (result) {
            console.log("result:" + result + ',' + uuid)
            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                //window.history.back();
                //location.reload()
                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('审核失败', {duration: 'short', type: 'div'})
            }
        });
    }

    free();

    function free() {
        var freeMoney = $("#freeMoney").is(':checked');
        if (freeMoney == true) {
            $("#freeReason").css("display", "block")
        } else {
            $("#freeReason").css("display", "none")
        }
    }

    payOut();

    function payOut() {
        var payInId = $("#payInId").text();
        var payOutId = $("#payOutId").val();
        if (payOutId == '') {
            payOutId = 0;
        }
        $("#payOutIdFree").text(payOutId)

        var t = parseFloat(payInId) - parseFloat(payOutId);
        $("#totalAll").text(t)
    }

    function setTotal1() {
        var date = '${contractEndDate}';
        $("#contractEndDate").val(date)
        var endDate = '${contract.endDate}';

        var sDate = new Date(date.replace(/-/g, "/"));
        var eDate = new Date(endDate.replace(/-/g, "/"));
        var days = eDate - sDate;
        var day = parseFloat(days / (1000 * 60 * 60 * 24));

        if (!isNaN(day)) {
            $("#endDay").val(day)

        }

        var total1 = 0;
        $("input[name='useArea1']").each(function (index, item) {
            if ($(this).val() != '') {
                total1 += parseFloat($(this).val());
            }

        });

        $("#total1").text(total1);

        dateTotal();

    }

    setTotal1();

    function dateTotal() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var sDate = new Date(startDate.replace(/-/g, "/"));
        var eDate = new Date(endDate.replace(/-/g, "/"));
        var days = eDate - sDate;
        var day = parseFloat(days / (1000 * 60 * 60 * 24));
        if (!isNaN(day)) {
            $("#totalDay").text(day)

        }
        console.log(isNaN(day))
    }


    $(function () {

        //制单人
        var userName = $.cookie('account');
        $("#userName").text(userName)


        //更新上个页面传递的值
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


        window.history.go(-1);
    }

    function modify() {


    }

    function confirm() {

        var code_auto = $("#code_auto").val();
        var remark = $("#remark").val();
        var uuid = '${contract.uuid}';
        var freeMoney = $("#freeMoney").is(':checked');
        var freeReason = $("#freeReason").val();
        var isOver1 = $("#isOver1").is(':checked');
        var isOver2 = $("#isOver2").is(':checked');
        var isOver = 0;
        if (isOver1 == true) {
            isOver = 0;
        }
        if (isOver2 == true) {
            isOver = 1;
        }
        var isFree = 0;
        if (freeMoney == true) {
            isFree = 1;
        } else {
            isFree = 0;
        }
        var otherIn = 0;
        var otherOut = 0;
        var payIn = $("#payInId").text();
        var payOut = $("#payOutId").val();
        if (freeReason == '') {
            freeReason = 'fantasy';
        }
        var reason = 'fantasy';

        var payTotal = $("#payInId").text();
        if (isNaN(payOut)) {
            payOut = 0;
        }
        var payFree = $("#payFree").val();
        var contractEndDate = $("#contractEndDate").val();

        var url = "/seckill/contract_house/" + isFree + "/" + freeReason + "/" + otherIn + "/" + otherOut + "/" + reason + "/" + uuid + "/" + payTotal + "/" + isOver + "/" + payIn + "/" + payOut + "/" + payFree  +"/"+contractEndDate+"/delPay";


        //var url = "/seckill/contract_house/" + uuid + "/update/del";


        $.post(url, {}, function (result) {
            console.log("result:" + result + ',' + uuid)
            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                //window.history.back();
                //location.reload()
                window.location.href = document.referrer;
                var dateCount = '${dateCount}';
                if (dateCount > 1) {
                    window.history.go(-dateCount);
                } else {
                    window.history.back();
                }
            } else {
                mui.toast('撤销失败', {duration: 'short', type: 'div'})
            }
        });
        //


    }
</script>
</html>