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

    <h1 class="mui-title">广告合同</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">
    <input type="hidden" id="free" value="${free}">
    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

        <input type="hidden" id="customId" value="${contract.customId}">
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
                <input type="text" class="form-control " placeholder="请输入助记码" required id="code_auto"
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
            <div class="col-md-2 ">


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
            <div class="col-md-2 ">
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
            <select onchange="dateChange()" id="dateSelect" class="selectpicker">

                <option
                        value="0">请选择合同有效期
                </option>
                <option
                        value="1">一年
                </option>
                <option
                        value="2">二年
                </option>
                <option
                        value="3">三年
                </option>
                <option
                        value="4">四年
                </option>

            </select>
            <input type="hidden" id="dtp_input1" value=""/>
            <label class=" control-label col-md-offset-1 col-xs-offset-1">合计:<span
                    style="color: #f00" id="totalDay">0</span>天</label>
        </div>


        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">合同到期提前预警(天)</label>
            <div class="col-sm-3">
                <input type="number" class="form-control " id="warnDay"
                       value="${contract.warnDay}">
            </div>


        </div>

        <div class="form-group">
            <label for="explain" disabled class="col-sm-2 control-label">备注栏</label>
            <div class="col-sm-6">

                <textarea rows="3" id="explain" placeholder="审批说明或意见">${contract.explain}</textarea>

            </div>
        </div>

        <div style="height: 40px;"></div>
        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">商品名称:广告位</label>


                    <button type="button" style="float: right;"
                            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                            onclick="addWork()"> 添加广告位
                    </button>

                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-9 col-md-offset-1" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>位置编号</th>
                                <th style="display: none;">使用面积</th>
                                <th>状态</th>
                                <th>交付时间</th>
                                <th>操作</th>
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
                                    <td style="display: none;"><input disabled="disabled"
                                                                      style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                                      id="uId " type="text" value="${b.table3}"
                                                                      name="useArea1"/></td>
                                    <td><select style="width: 120px;padding-left: 40px;"
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
                                    <td nowrap="nowrap"><a id="${b.table0}a" onclick="delWork(this)"
                                                           style="color: #ff0000">删除</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <%--<div class="form-group">--%>
                <%--<label class="control-lable col-sm-offset-1">合计(平方米):<span id="total1"--%>
                <%--style="color: #f00">0</span></label>--%>
                <%--</div>--%>

            </div>


        </div>


        <div style="height: 40px;"></div>
        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">租赁费用</label>


                    <button type="button" style="float: right"
                            class="mui-btn mui-btn-outlined   mui-btn mui-btn-primary"
                            onclick="addContactOne()"> 添加租赁费用
                    </button>

                </div>
                <div class="form-group">
                    <div class="table-responsive col-md-9 col-md-offset-1" id="free"
                         style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>名称</th>
                                <th>金额</th>
                                <th nowrap="nowrap">详情</th>
                            </tr>
                            </thead>
                            <tbody id="contactTb">
                            <%--<c:if test="${contract==null}">--%>
                            <%--<tr>--%>


                            <%--<td><input id="cashR" type="text" value="违约金" align="center"--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--name="name2H"/></td>--%>

                            <%--<td><input--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--id="mId" value="0" type="number" onchange="changeMoney(this)"--%>
                            <%--name="money2H"/></td>--%>
                            <%--<td nowrap="nowrap"><a onclick="delContact(this)" style="color: #ff0000">删除</a></td>--%>
                            <%--</tr>--%>
                            <%--</c:if>--%>

                            <c:forEach items="${contract.tableList2H}" var="b">
                                <tr>


                                    <td><input id="cashR" type="text" value="${b.table0}" align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               name="name2H"/></td>

                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                            id="mId" value="${b.table1}" type="number" onchange="changeMoney(this)"
                                            name="money2H"/></td>
                                    <td nowrap="nowrap"><a onclick="delContact(this)" style="color: #ff0000">删除</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <div class="form-group">
            <div class="col-xs-offset-4 col-sm-offset-9 col-sm-4">


                <c:choose>
                    <c:when test="${type=='update'}">
                        <label class="control-label">制单人<span id="userName"></span></label>
                        <button type="button" class=" mui-btn mui-btn-primary col-sm-offset-1" onclick="confirm()">
                            审批
                        </button>

                    </c:when>
                    <c:otherwise>
                        <label class="control-label">制单人:<span id="userName"></span></label>
                        <button type="button" class="mui-btn mui-btn-primary col-sm-offset-1" onclick="confirm()"> 审批
                        </button>
                    </c:otherwise>


                </c:choose>
            </div>

        </div>
    </form>
    <div style="height: 50px;"></div>

</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="myModalLabel">
                    广告租赁费
                </h4>
            </div>
            <div class="modal-body" style="overflow:auto;">
                <form id="form" data-toggle="validator" class="form-horizontal" role="form"
                      style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                                   placeholder="请输入助记码" id="code_auto11"
                                   value="${contract.codeAuto}">
                        </div>


                        <label for="remark" class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                                   id="remark11"
                                   value="${contract.remark}">

                        </div>
                    </div>

                    <div class="form-group">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class=" control-label">租金明细</label>


                                </div>

                                <div class="form-group">
                                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>位置编号</th>
                                                <th>楼层</th>
                                                <th>年总价(元)</th>
                                                <th>广告位类型</th>
                                            </tr>
                                            </thead>
                                            <tbody id="shoppingTb11">
                                            <c:forEach items="${contract.tableList11}" var="b">
                                                <tr id="${b.table4}t11">

                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                               type="text" value="${b.table0}" style="" name="loc11"/>
                                                    </td>
                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="floor11" value="${b.table1}"/></td>
                                                    <td><input onchange="dischange11(this)"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="number" name="money11" value="${b.table2}"/></td>
                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="name11" value="${b.table3}"/></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-lable col-sm-offset-1">租赁金额合计:<span id="total11"
                                                                                              style="color: #f00">0</span>元</label>
                                </div>

                            </div>


                        </div>
                    </div>


                    <div class="form-group">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class=" control-label">付款比例(金额单位:元)</label>

                                    <button type="button" style="float: right;"
                                            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addPay()"> 添加付款
                                    </button>
                                </div>

                                <div class="form-group">
                                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>应付金额</th>
                                                <th>收款截止日</th>
                                                <th>提前预警</th>
                                                <th>操作</th>


                                            </tr>
                                            </thead>
                                            <tbody id="payTb">
                                            <c:forEach items="${contract.tableList33}" var="b">
                                                <tr>


                                                    <td><input id="cashR" type="number" value="${b.table1}"
                                                               align="center"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                                               name="money33"/></td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="time33" size="16" type="text"
                                                                   value="${b.table0}"
                                                                   class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                                            value="${b.table2}" type="number" name="warn33"/></td>
                                                    <td nowrap="nowrap"><a onclick="delPay(this)"
                                                                           style="color: #ff0000">删除</a></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                            </div>


                        </div>
                    </div>
                </form>
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

    mui.init({

        beforeback: function () {


        }
    });

    function initToatal() {



        //签订天数
        dateTotal();


        setTotal1();
    }

    function updateMoney(day) {
        //
        $("input[name='useArea1']").each(function (index, item) {

            var price = $("#" + item.id.split('u')[0] + 'p').val();
            console.log("price:" + price)
            var useArea = $(this).val();
            console.log("useArea:" + useArea)
            var total = 0;
            total = parseFloat(price) * parseFloat(useArea) * day;
            console.log("total:" + total)
            $("#" + item.id.split('u')[0] + 'm11').val(total)
            $("#" + item.id.split('u')[0] + 'm2').val(total)
            var discount = $("#" + item.id.split('u')[0] + 'd11').val();
            if (!isNaN(parseFloat(discount))) {
                $("#" + item.id.split('u')[0] + 'md11').val(total - total * parseFloat(discount) / 100)
            } else {
                $("#" + item.id.split('u')[0] + 'md11').val(total)
            }


        });
        setTotal1();

    }

    function setTotal1() {

        delContactTotal()

        delContactRent();
        var money11 = 0;
        $("input[name='money11']").each(function (index, item) {
            if ($(this).val() != '') {
                money11 += parseFloat($(this).val());
            }

        });
        addContactRent("租金", money11)
        $("#total11").text(money11)
        //money11累加
        $("input[name='money2H']").each(function (index, item) {
            if ($(this).val() != '') {
                money11 += parseFloat($(this).val());
            }

        });

        addContactTotal("合计", money11)

    }

    setTotal1();


    function dateTotal() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var sDate = new Date(startDate.replace(/-/g, "/"));
        var eDate = new Date(endDate.replace(/-/g, "/"));
        var days = eDate - sDate;
        var day = parseFloat(days / (1000 * 60 * 60 * 24) + 1);
        if (!isNaN(day)) {
            $("#totalDay").text(day)
            updateMoney(day);
        }
        console.log(isNaN(day))
    }

    $(function () {
        initToatal();
        //制单人
        var userName = $.cookie('account');
        $("#userName").text(userName)


        //更新上个页面传递的值


        $("#code_auto").autocomplete({
            // searchStreedRoad_auto 输入框id
            source: function (request, response) {
                var url = '/seckill/contract_house/' + request.term + '/code';


                $.get(url, function (res) {
                    console.log(res)
                    response(
                        $.map(res, function (item) { // 此处是将返回数据转换为 JSON对象，并给每个下拉项补充对应参数
                            return {
                                // 设置item信息
                                label: item.name + "       " + item.remark, // 下拉项显示内容
                                value: item.name,   // 下拉项对应数值
                                code: item.code, // 其他参数， 可以自定义
                                companyList: item.companyList,  // 其他参数， 可以自定义</span>
                                workerList: item.workerList,
                                remark: item.remark,
                                id: item.id


                            }
                        }));
                })
            },
            minLength: 1,  // 输入框字符个等于2时开始查询
            select: function (event, ui) { // 选中某项时执行的操作
                // 存放选中选项的信息
                $("#remark").val(ui.item.remark);
                $("#code").val(ui.item.code);
                $("#customId").val(ui.item.id)
                console.log(ui.item)
                if (ui.item.workerList.length > 0) {
                    $("#linkMan").val(ui.item.workerList[0].name);
                    $("#phone").val(ui.item.workerList[0].phone);
                } else {
                    $("#linkMan").val('');
                    $("#phone").val('');
                }

                //模态框数据

                $("#code_auto11").val(ui.item.value)
                $("#remark11").val(ui.item.remark)

                $("#code_auto33").val(ui.item.value)
                $("#remark33").val(ui.item.remark)

            }

        });


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

    function crtTimeFtt(date) {
        var month = 0;
        if (date.getMonth() < 9) {
            month = "0" + (date.getMonth() + 1);
        } else {
            month = date.getMonth() + 1;
        }
        var day = 0;
        if (date.getDate() < 10) {
            day = "0" + date.getDate();
        } else {
            day = date.getDate();
        }
        return date.getFullYear() + '-' + month + '-' + day;

    }

    function dateChange() {
        var startDate = $("#startDate").val();
        var dateSelect = $("#dateSelect").val();
        var now = new Date();
        if (startDate == "") {
            $("#startDate").val(crtTimeFtt(new Date()));
        } else {
            now.setFullYear(startDate.split("-")[0]);
            now.setMonth(parseInt(startDate.split("-")[1]) - 1);
            now.setDate(startDate.split("-")[2])
        }


        now.setFullYear(now.getFullYear() + parseInt(dateSelect));
        now.setDate(now.getDate() - 1);
        $("#endDate").val(crtTimeFtt(now));
        dateTotal();
    }

    function updateRemark(obj) {
        var remartList = $("#remarkList").find("option:selected").text();
        var aText = $("#updateRemark").text();
        if (aText == '修改备注') {
            obj.parentNode.remove()
            var trObj = document.createElement("div");

            var input = '   <div class="col-sm-2"> <input type="text" class="form-control" id="remark" value="' + remartList + '"> </div> <a type="button" id="updateRemark" onclick="updateRemark(this)" class="btn btn-default" value="">取消修改</a>';
            trObj.innerHTML = input;
            document.getElementById("remarkListOut").appendChild(trObj)
        } else {
            window.location.reload();
        }


    }


    function remarkChange(obj) {


        var s = $("#remarkList").val();
        // $.cookie('selectUuid', s);
        $.cookie('selectUuid', s, {expires: 30, path: '/'});

        console.log("cookie:" + s + ",name:");
        console.log($("#remarkList").find("option:selected").text())

        window.location.reload()
    }

    function search(obj) {
        var uid = obj.id + 'u';
        var cid = obj.id + 'c';
        var mid = obj.id + 'm';
        var pid = obj.id + 'p';
        $("#" + obj.id).autocomplete({
            // searchStreedRoad_auto 输入框id
            source: function (request, response) {
                var url = '/seckill/contract_ad/' + request.term + '/loc';
                console.log(url)

                $.get(url, function (res) {
                    console.log(res)
                    response(
                        $.map(res, function (item) { // 此处是将返回数据转换为 JSON对象，并给每个下拉项补充对应参数
                            return {
                                // 设置item信息
                                label: item.location, // 下拉项显示内容
                                value: item.location,   // 下拉项对应数值
                                useArea: item.useArea, // 其他参数， 可以自定义
                                cash: item.cash,
                                // price:item.price,
                                unit: item.unit,
                                linkHouse: item.linkHouse,
                                floor: item.floor,
                                waterNo: item.waterNo,
                                powerNo: item.powerNo,
                                airNo: item.airNo,
                                loc: item.location,
                                name: item.name


                            }
                        }));
                })
            },
            minLength: 1,  // 输入框字符个等于2时开始查询
            select: function (event, ui) { // 选中某项时执行的操作

                document.getElementById(obj.id).disabled = 'disabled'

                // 存放选中选项的信息
                $("#" + uid).val(ui.item.useArea);
                $("#" + cid).val(ui.item.cash);
                $("#" + pid).val(ui.item.unit)

                var tid11 = obj.id + 't11';

                var money = ui.item.unit * ui.item.useArea * parseFloat($("#totalDay").text())

                $("#" + mid).val(money)


                //加载模态框
                addWork11(tid11, ui.item.loc, ui.item.floor, ui.item.name);


                setTotal1()
            }

        });
    }

    function delWork(obj) {
        obj.parentNode.parentNode.remove();
        console.log(obj)
        var id = obj.id;


        //模态框
        var tid22 = document.getElementById(id.split('a')[0] + "t11");
        document.getElementById("shoppingTb11").removeChild(tid22);


        setTotal1()
    }

    function delTwo(obj) {
        obj.parentNode.parentNode.remove();
        console.log()


    }

    function addWork() {
        if (!dateOk()) {
            return;
        }
        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var lId = 'l' + trObj.id;
        var uId = lId + 'u';
        var cId = lId + 'c';
        var mId = lId + 'm';
        var pId = lId + 'p';
        var aId = lId + 'a';
        var goodsStatus = '${goodsStatusList}';
        // var gs = goodsStatus.parseJSON();
        // var obj = eval('(' + goodsStatus + ')');
        var gs = $.parseJSON(goodsStatus)

        var select = '<td><select style="width: 120px;padding-left: 40px;" class="form-control selectpicker" name="goodsStatus1">'
        for (var i = 0; i < gs.length; i++) {

            select += '<option value="' + gs[i].id + '">' + gs[i].name + '</option>'
        }
        select += '</select></td>'

        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time1" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td><input   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;" onclick="search(this)" id="' + lId + '" type="text" value=""  style="" name="loc1"  /></td>' +
            '<td style="display: none;"><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" id="' + uId + '" type="text" name="useArea1"  /></td>' +
            select +
            time +
            '<input type="hidden" name="cash1" id="' + cId + '">' +
            '<input type="hidden" name="money1" id="' + mId + '">' +
            '<input type="hidden" name="price1" id="' + pId + '">' +
            '<td nowrap="nowrap"><a id="' + aId + '" onclick="delWork(this)" style="color: #ff0000">删除</a></td>'


        trObj.innerHTML = line;
        document.getElementById("shoppingTb").appendChild(trObj);


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


    }


    function addWork11(tid, loc, floor, name) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;


        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + loc + '"  style="" name="loc11"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="floor11"  value="' + floor + '"/></td>' +
            '<td><input id="" onchange="dischange11(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="money11"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="name11"  value="' + name + '" /></td>'


        trObj.innerHTML = line;
        document.getElementById("shoppingTb11").appendChild(trObj);


    }

    function dischange11(obj) {
        setTotal1();
    }


    function delContact(obj) {
        obj.parentNode.parentNode.remove();

        delContactTotal();

        var cash1 = 0;
        // $("input[name='cash1']").each(function (index, item) {
        //
        //     cash1 += parseFloat($(this).val());
        // });
        $("input[name='money2']").each(function (index, item) {
            if ($(this).val() != '') {
                cash1 += parseFloat($(this).val());
            }

        });
        var total = $("#cashM").val();

        if (typeof(total) != "undefined" && total != '') {
            cash1 -= parseFloat(total);
        }
        addContactTotal("合计", cash1)
        setTotal1();

    }


    function dischange22(obj) {
        setTotal1();
    }


    function addContactOne() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var mId = trObj.id + 'm';

        var line = '<td><input     id="cashR" type="text" value=""  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="name2H"  /></td>' +

            '<td><input    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + mId + '" value="" type="number" onchange="changeMoney(this)" name="money2H"  /></td>' +
            '<td nowrap="nowrap"><a onclick="delContact(this)"  style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);
        setTotal1();


    }

    function changeMoney(obj) {

        setTotal1();
    }

    function addContactTotal(rent, money) {
        var trObj = document.createElement("tr");
        trObj.id = 'totalT';

        var line = '<td><input   style="border: 0;text-align: center;font-weight: 900"  id="cashR" type="text" value="' + rent + '"  align="center"   /></td>' +
            '<td><input  style="border: 0;text-align: center;font-weight: 900" id="cashM" value="' + money + '" type="text"  /></td>' +
            '<td nowrap="nowrap"><a  data-toggle="modal" data-target="#myModal" style="color: #1d4499;text-align: center;">详情</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);


    }

    function addContactRent(rent, money) {
        var trObj = document.createElement("tr");
        trObj.id = 'rentT';

        var line = '<td><input   style="border: 0;text-align: center;font-weight: 900"  id="name2" type="text" value="' + rent + '"  align="center"   /></td>' +
            '<td><input  style="border: 0;text-align: center;font-weight: 900" id="money2" value="' + money + '" type="text"  /></td>' +
            '<td nowrap="nowrap"><a  data-toggle="modal" data-target="#myModal" style="color: #1d4499;text-align: center;">详情</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);


    }


    function delContactTotal() {
        try {
            var obj = document.getElementById("totalT");
            console.log(obj)
            //obj.parentNode.parentNode.remove();
            document.getElementById("contactTb").removeChild(obj);
        } catch (e) {
            console.log(e)
        }

    }

    function delContactRent() {
        try {
            var obj = document.getElementById("rentT");
            console.log(obj)
            //obj.parentNode.parentNode.remove();
            document.getElementById("contactTb").removeChild(obj);
        } catch (e) {
            console.log(e)
        }

    }

    function delFree(obj) {

        obj.parentNode.parentNode.remove();

        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("regTb").removeChild(trObj);
    }


    function dateOk() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        if (startDate != '' && endDate != '') {
            return true;
        }
        mui.toast('请选择起止日期 ', {duration: 'short', type: 'div'})
        return false;
    }

    function addPay() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time33" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'

        var line = '<td><input     id="cashR" type="number" value=""  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="money33"  /></td>' +
            time +
            '<td><input   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="number" name="warn33"  /></td>' +
            '<td nowrap="nowrap"><a onclick="delPay(this)"  style="color: #ff0000">删除</a></td>'
        trObj.innerHTML = line;
        document.getElementById("payTb").appendChild(trObj);


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

    }

    function delPay(obj) {

        obj.parentNode.parentNode.remove();

        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("regTb").removeChild(trObj);
    }

    function back() {


        window.history.go(-1);
    }


    function confirm() {
        var flag1 = "@@";
        var flag2 = "=";
        var userName = $("#userName").text();
        var type = $("#type").val();
        var code_auto = $("#code_auto").val();
        var remark = $("#remark").val();
        var linkMan = $("#linkMan").val();
        var phone = $("#phone").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var warnDay = $("#warnDay").val();
        var code = $("#code").val();
        var explain = $("#explain").val();
        var customId = $("#customId").val();
        var cashM=$("#cashM").val();

        var main = code_auto + flag2 + remark + flag2 + linkMan + flag2 + phone + flag2 + startDate + flag2 + endDate + flag2 + warnDay + flag2 + code + flag2 + type + flag2 + userName + flag2 + explain + flag2 + customId+flag2+cashM;

        var table1 = '';
        var loc1 = '';
        var id1 = '';
        $("input[name='loc1']").each(function (index, item) {
            loc1 += $(this).val() + flag1;
            id1 += item.id + flag1;

        });
        var time1 = '';
        $("input[name='time1']").each(function (index, item) {
            time1 += $(this).val() + flag1;
        });
        var useArea1 = '';
        $("input[name='useArea1']").each(function (index, item) {
            useArea1 += $(this).val() + flag1;
        });
        var cash1 = '';
        $("input[name='cash1']").each(function (index, item) {
            cash1 += $(this).val() + flag1;
        });
        var money1 = '';
        $("input[name='money1']").each(function (index, item) {
            money1 += $(this).val() + flag1;
        });
        var price1 = '';
        $("input[name='price1']").each(function (index, item) {
            price1 += $(this).val() + flag1;
        });

        var goodsStatus1 = '';
        $("select[name='goodsStatus1']").each(function (index, item) {
            goodsStatus1 += $(this).val() + flag1;

        });

        table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1 + flag2 + goodsStatus1;


        var table2 = '';
        var name2 = '';

        $("input[name='name2']").each(function (index, item) {
            name2 += $(this).val() + flag1;

        });

        var money2 = '';
        $("input[name='money2']").each(function (index, item) {
            money2 += $(this).val() + flag1;
        });

        table2 = name2 + flag2 + money2;


        var table2H = '';
        var name2H = '';
        $("input[name='name2H']").each(function (index, item) {
            name2H += $(this).val() + flag1;
        });

        var money2H = '';
        $("input[name='money2H']").each(function (index, item) {
            money2H += $(this).val() + flag1;
        });
        table2H = name2H + flag2 + money2H;


        var loc11 = '';
        var table11 = '';
        $("input[name='loc11']").each(function (index, item) {
            loc11 += $(this).val() + flag1;
        });
        var floor11 = '';
        $("input[name='floor11']").each(function (index, item) {
            floor11 += $(this).val() + flag1;
        });
        var money11 = '';
        $("input[name='money11']").each(function (index, item) {
            money11 += $(this).val() + flag1;
        });
        var name11 = '';
        $("input[name='name11']").each(function (index, item) {
            name11 += $(this).val() + flag1;
        });


        table11 = loc11 + flag2 + floor11 + flag2 + money11 + flag2 + name11;


        var table33 = '';
        var time33 = '';
        $("input[name='time33']").each(function (index, item) {
            time33 += $(this).val() + flag1;
        });
        var money33 = '';
        $("input[name='money33']").each(function (index, item) {
            money33 += $(this).val() + flag1;
        });
        var warn33 = '';
        $("input[name='warn33']").each(function (index, item) {
            warn33 += $(this).val() + flag1;
        });
        table33 = time33 + flag2 + money33 + flag2 + warn33;


        table2 = table2.replace(/\//g, 'fantasy');
        table3 = 'ad';


        var type = '${type}';
        var uuid = '${contract.uuid}';
        console.log(main)

        if (code_auto == '') {
            mui.toast('请输入客户名称', {duration: 'short', type: 'div'})
            return;
        }
        if (loc1 == '') {
            mui.toast('请输入房源', {duration: 'short', type: 'div'})
            return;
        }
        var isOk = "${contract.isOk}";
        if (isOk == -1) {
            var url = "/seckill/contract_ad/" + uuid + "/" + main + "/" + table1
                + "/" + table2 + "/" + table2H + "/" + table3 + "/" + table11 + "/" + table33 + "/update";
            //console.log(url);
        } else {
            var url = "/seckill/contract_ad/" + main + "/" + table1
                + "/" + table2 + "/" + table2H + "/" + table3 + "/" + table11 + "/" + table33 + "/" + "/insert";

        }
        $.post(url, {}, function (result) {
            console.log("result:" + result + ',' + uuid)
            if (result >= 1) {

                sessionStorage.setItem("need-refresh", true);
                //window.history.back();
                //location.reload()
                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('添加失败', {duration: 'short', type: 'div'})
            }
        });
        //


    }
</script>
</html>