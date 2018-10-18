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

<body style="background-color: #fff">
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">能耗费详情</h1>

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
                <input type="number" class="form-control " id="warnDay" style="background-color: #fff" disabled
                       value="${contract.warnDay}">
            </div>


        </div>
        <div class="form-group">
            <label for="startTime" class="col-md-2 control-label">租赁类型</label>
            <div class="col-md-2 ">


                <div class="mui-input-row mui-checkbox mui-left">
                    <label>房子租赁</label>
                    <input name="checkbox1" disabled id="house1" value="" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>注册租赁</label>
                    <input name="checkbox1" disabled id="house2" value="" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>虚拟租赁</label>
                    <input name="checkbox1" disabled id="house3" value="true" type="checkbox">
                </div>

            </div>

        </div>


        <div class="form-group">
            <label for="explain" class="col-sm-2 control-label">备注栏</label>
            <div class="col-sm-6">

                <textarea rows="3"
                          <c:if test="${approval=='normal'}">disabled</c:if> id="explain"
                          placeholder="审批说明或意见">${contract.explain}</textarea>

            </div>
        </div>

        <div style="height: 40px;"></div>
        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">商品名称:房源</label>


                </div>

                <div class="form-group">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default  col-sm-12">
                        <div class="panel-body">
                            <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                <label for="name" class=" control-label">水费抄表</label>


                            </div>

                            <div class="form-group">
                                <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                    <table class="table">

                                        <thead>
                                        <tr>
                                            <th>水表编号</th>
                                            <th>位置编号</th>
                                            <th>抄表度数</th>
                                            <th>抄表时间</th>
                                            <th width="200">抄表类型</th>
                                            <th>金额</th>
                                        </tr>
                                        </thead>
                                        <tbody id="waterTb44">
                                        <c:forEach items="${contract.tableList44}" var="b">
                                            <tr id="${b.table5}t44">


                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           type="text" value="${b.table1}" style="" name="no44"/>
                                                </td>
                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           type="text" name="loc44" value="${b.table2}"/></td>

                                                <td>
                                                    <input disabled
                                                           value="${b.freeExport.degree}"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           type="number" name="degree44"/></td>


                                                <td>
                                                    <div class="input-group date form_datetime"
                                                         data-date="1979-09-16T05:25:07Z"
                                                         data-link-field="startTime">
                                                        <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                               name="time44" value="${b.freeExport.createTime}"
                                                               size="16"
                                                               type="text" class="form-control" readonly>
                                                        <span style="height: 30px;display: none;"
                                                              class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                </td>

                                                <td>

                                                    <c:if test="${b.freeExport.source=='auto'}">导入</c:if>
                                                    <c:if test="${b.freeExport.source=='handle'}">手动输入</c:if>
                                                    <c:if test="${b.freeExport.source=='contract'}">合同录入</c:if>

                                                </td>
                                                <td>${b.freeExport.total}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>


                    </div>
                </div>

                <div class="form-group">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default     col-sm-12">
                        <div class="panel-body">
                            <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                <label for="name" class=" control-label">电费抄表</label>


                            </div>

                            <div class="form-group">
                                <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                    <table class="table">

                                        <thead>
                                        <tr>
                                            <th>电表编号</th>
                                            <th>位置编号</th>
                                            <th>抄表度数</th>
                                            <th>抄表时间</th>
                                            <th width="200">抄表类型</th>
                                            <th>金额</th>

                                        </tr>
                                        </thead>
                                        <tbody id="powerTb55">
                                        <c:forEach items="${contract.tableList55}" var="b">
                                            <tr id="${b.table5}t55">


                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           type="text" value="${b.table1}" style="" name="no55"/>
                                                </td>
                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           type="text" name="loc55" value="${b.table2}"/></td>

                                                <td><input name="useArea55" type="hidden" value="  useArea  "><input
                                                        value="${b.freeExport.degree}" disabled
                                                        style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                        type="number" name="degree55"/></td>
                                                <td>
                                                    <div class="input-group date form_datetime"
                                                         data-date="1979-09-16T05:25:07Z"
                                                         data-link-field="startTime">
                                                        <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                               name="time55" value="${b.freeExport.createTime}"
                                                               size="16"
                                                               type="text" class="form-control" readonly>
                                                        <span style="height: 30px;display: none;"
                                                              class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                </td>
                                                <td>

                                                    <c:if test="${b.freeExport.source=='auto'}">导入</c:if>
                                                    <c:if test="${b.freeExport.source=='handle'}">手动输入</c:if>
                                                    <c:if test="${b.freeExport.source=='contract'}">合同录入</c:if>

                                                </td>
                                                <td>${b.freeExport.total}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>


                    </div>
                </div>


                <div class="form-group">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default     col-sm-12">
                        <div class="panel-body">
                            <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                <label for="name" class=" control-label">空调费抄表</label>


                            </div>

                            <div class="form-group">
                                <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                    <table class="table">

                                        <thead>
                                        <tr>
                                            <th>电费表编号</th>
                                            <th>位置编号</th>
                                            <th>抄表度数</th>
                                            <th>抄表时间</th>
                                            <th width="200">抄表类型</th>
                                            <th>金额</th>

                                        </tr>
                                        </thead>
                                        <tbody id="airTb66">
                                        <c:forEach items="${contract.tableList66}" var="b">
                                            <tr id="${b.table5}t66">


                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           type="text" value="${b.table1}" style="" name="no66"/>
                                                </td>
                                                <td><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           type="text" name="loc66" value="${b.table2}"/></td>

                                                <td><input name="useArea44" type="hidden" value="  useArea  "><input
                                                        value="${b.freeExport.degree}" disabled
                                                        style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                        type="number" name="degree66"/></td>
                                                <td>
                                                    <div class="input-group date form_datetime"
                                                         data-date="1979-09-16T05:25:07Z"
                                                         data-link-field="startTime">
                                                        <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                               name="time66" value="${b.freeExport.createTime}"
                                                               size="16"
                                                               type="text" class="form-control" readonly>
                                                        <span style="height: 30px;display: none;"
                                                              class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                </td>
                                                <td>

                                                    <c:if test="${b.freeExport.source=='auto'}">导入</c:if>
                                                    <c:if test="${b.freeExport.source=='handle'}">手动输入</c:if>
                                                    <c:if test="${b.freeExport.source=='contract'}">合同录入</c:if>

                                                </td>
                                                <td>${b.freeExport.total}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>


                    </div>
                </div>


                <div class="form-group">
                    <div style="height: 40px;"></div>
                    <div class="panel panel-default     col-sm-12">
                        <div class="panel-body">
                            <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                <label for="name" class=" control-label">物业费(金额单位:元)</label>


                            </div>

                            <div class="form-group">
                                <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                    <table class="table">

                                        <thead>
                                        <tr>
                                            <th>起始时间</th>
                                            <th>截止时间</th>
                                            <th>总价</th>
                                            <th>优惠折扣(%)</th>
                                            <th>折后总价</th>

                                            <th>选择报销的物业费</th>
                                        </tr>
                                        </thead>
                                        <tbody id="freeTb77">
                                        <c:forEach items="${contract.tableList77}" var="b">
                                            <tr>


                                                <td>
                                                    <div class="input-group date form_datetime"
                                                         data-date="1979-09-16T05:25:07Z"
                                                         data-link-field="startTime">
                                                        <input onchange="changeDate(this,'s77')" value="${b.table0}"
                                                               style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                               id="${b.table5}s77" name="start77" size="16"
                                                               type="text" class="form-control" readonly>
                                                        <span style="height: 30px;display: none;"
                                                              class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                </td>
                                                <td>
                                                    <div class="input-group date form_datetime"
                                                         data-date="1979-09-16T05:25:07Z"
                                                         data-link-field="startTime">
                                                        <input value="${b.table1}" onchange="changeDate(this,'e77')"
                                                               style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                               id="${b.table5}e77" name="end77" size="16"
                                                               type="text" class="form-control" readonly>
                                                        <span style="height: 30px;display: none;"
                                                              class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                </td>
                                                <td><input disabled
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           id="${b.table5}m77" type="number" value="${b.table2}"
                                                           style="" name="money77"/></td>
                                                <td><input onchange="changeMoneyFree(this)" disabled
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           id="${b.table5}d77" type="number" value="${b.table3}"
                                                           style="" name="discount77"/></td>
                                                <td><input disabled
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                           id="${b.table5}md77" type="number" value="${b.table4}"
                                                           style="" name="moneyDis77"/></td>
                                                <th>
                                                    <label class="control-lable col-sm-offset-1"> </label> <input
                                                        style="width: 20px;height: 20px;" type="checkbox">

                                                </th>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                        </div>


                    </div>
                </div>

            </div>


        </div>


        <div class="form-group">
            <div class=" col-sm-10 col-sm-offset-1">


                <c:if test="${approval=='confirm'}">


                    <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="back()"> 返回
                        <button style="float: right;margin-left: 3%;margin-right: 3%" type="button"
                                class="mui-btn mui-btn-primary " onclick="deal(1)"> 确定审核
                        </button>
                        <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="deal(-1)">
                            驳回审核
                        </button>
                        <label style="float: right;margin-right: 3%" class="control-label">审核人:<span
                                id="userName"></span></label>
                    </button>
                </c:if>


                <c:if test="${approval=='cancel'}">

                    <button style="float: right" type="button" class="mui-btn mui-btn-primary " onclick="back()"> 返回
                    </button>
                    <button style="float: right;margin-left: 3%;margin-right: 3%;" type="button"
                            class="mui-btn mui-btn-primary " onclick="deal(-1)"> 撤销审核
                    </button>


                    <label style="float: right;margin-right: 3%" class="control-label">审核人:<span
                            id="userName"></span></label>
                </c:if>

                <c:if test="${approval=='normal'}">


                    <button style="float: right;margin-left: 3%" type="button" class="mui-btn mui-btn-primary "
                            onclick="back()"> 返回
                    </button>
                    <label style="float: right;" class="control-label">制单人:<span
                            id="userName1">${contract.userName}</span></label>

                </c:if>


            </div>

        </div>
    </form>


</div>


</body>
<script type="text/javascript" charset="utf-8">

    mui.init({

        beforeback: function () {


        }
    });

    function initToatal() {

        //复选框
        var house1 = '${contract.house1}';
        if (house1 == 'true') {
            $('#house1').attr("checked", 'checked');
        }
        var house2 = '${contract.house2}';
        if (house2 == 'true') {
            $('#house2').attr("checked", 'checked');
        }
        var house3 = '${contract.house3}';
        if (house3 == 'true') {
            $('#house3').attr("checked", 'checked');
        }

        //签订天数
        dateTotal();

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
        // var total = $("#cashM").val();
        //
        // if (typeof(total) != "undefined" && total != '') {
        //     cash1 -= parseFloat(total);
        // }
        addContactTotal("合计", cash1)

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
        var total1 = 0;
        $("input[name='useArea1']").each(function (index, item) {
            if ($(this).val() != '') {
                total1 += parseFloat($(this).val());
            }

        });

        $("#total1").text(total1.toFixed(2));

        //模态框
        var d11 = 0;
        var discount11 = [];
        $("input[name='discount11']").each(function (index, item) {
            if ($(this).val() != '') {
                d11 = parseFloat($(this).val());
            } else {
                d11 = 0;
            }
            discount11.push(d11);

        });
        var total11 = 0;
        $("input[name='money11']").each(function (index, item) {
            if ($(this).val() != '') {
                total11 += parseFloat($(this).val()) - parseFloat($(this).val()) * discount11[index] / 100;
            }

        });
        $("#total11").text(total11.toFixed(2));

        var d22 = 0;
        var discount22 = [];
        $("input[name='discount22']").each(function (index, item) {
            if ($(this).val() != '') {
                d22 = parseFloat($(this).val());
            } else {
                d22 = 0;
            }
            discount22.push(d22);

        });
        var total22 = 0;
        $("input[name='money22']").each(function (index, item) {
            if ($(this).val() != '') {
                total22 += parseFloat($(this).val()) - parseFloat($(this).val()) * discount22[index] / 100;
            }

        });
        $("#total22").text(total22.toFixed(2));

        var cash1 = 0;
        $("input[name='money2H']").each(function (index, item) {
            if ($(this).val() != '') {
                cash1 += parseFloat($(this).val());
            }

        });
        console.log("t1:" + total11 + ',t2:' + total22)
        $("#total33").text(total11 + total22)
        $("#cashM").val(cash1 + total11 + total22)


    }

    setTotal1();
    setFreeTotal();

    function setFreeTotal() {
        var cash1 = 0;
        $("input[name='moneyDis77']").each(function (index, item) {
            if ($(this).val() != '') {
                cash1 += parseFloat($(this).val());
            }

        });
        $("#total44").text(cash1)
    }

    function dateTotal() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var sDate = new Date(startDate.replace(/-/g, "/"));
        var eDate = new Date(endDate.replace(/-/g, "/"));
        var days = eDate - sDate;
        var day = parseFloat(days / (1000 * 60 * 60 * 24));
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
                                remark: item.remark


                            }
                        }));
                })
            },
            minLength: 1,  // 输入框字符个等于2时开始查询
            select: function (event, ui) { // 选中某项时执行的操作
                // 存放选中选项的信息
                $("#remark").val(ui.item.remark);
                $("#code").val(ui.item.code);
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


    });

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
                var url = '/seckill/contract_house/' + request.term + '/loc';
                console.log(url)

                $.get(url, function (res) {
                    console.log(res)
                    response(
                        $.map(res, function (item) { // 此处是将返回数据转换为 JSON对象，并给每个下拉项补充对应参数
                            return {
                                // 设置item信息
                                label: item.location + "    " + item.linkHouse, // 下拉项显示内容
                                value: item.location,   // 下拉项对应数值
                                useArea: item.useArea, // 其他参数， 可以自定义
                                cash: item.cash,
                                // price:item.price,
                                unit: item.unit,
                                linkHouse: item.linkHouse,
                                floor: item.floor,
                                waterNo: item.waterNo,
                                powerNo: item.powerNo,
                                airNo: item.airNo


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
                var rentId = obj.id + 'r';
                var rentId22 = obj.id + 'r22';
                // var priceId = obj.id + 'p';
                // var unitId = obj.id + 'u';
                // var cashId = obj.id + 'c';
                // var locId = obj.id + 'l';
                var dId11 = obj.id + 'd11';
                var mdId11 = obj.id + 'md11';
                var mId11 = obj.id + 'm11';
                var mId2 = obj.id + 'm2';

                var dId22 = obj.id + 'd22';
                var mdId22 = obj.id + 'md22';

                var tid = obj.id + 't';
                var tid11 = obj.id + 't11';
                var tid44 = obj.id + 't44';
                var tid55 = obj.id + 't55';
                var tid66 = obj.id + 't66';
                var money = ui.item.unit * ui.item.useArea * parseFloat($("#totalDay").text())

                $("#" + mid).val(money)
                //delContactTwo()

                addContact("租金", ui.item.useArea, ui.item.value, ui.item.unit, '元/平方米', money, rentId, mId2)


                addContactTwo("物业保证金", ui.item.value, ui.item.cash, tid, mId2)

                delContactTotal()
                var cash1 = 0;
                // $("input[name='cash1']").each(function (index, item) {
                //     console.log($(this).id + ',' + index + ',' + item.id)
                //     console.log(item)
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


                //加载模态框
                addWork11(tid11, dId11, mdId11, mId11, ui.item.useArea, money, '', money, ui.item.linkHouse, ui.item.floor);
                addContact22(rentId22, dId22, mdId22, ui.item.value, ui.item.cash);

                //物业费和电费
                addFree44(tid44, ui.item.waterNo, ui.item.value, ui.item.useArea);
                addFree55(tid55, ui.item.powerNo, ui.item.value, ui.item.useArea);
                addFree66(tid66, ui.item.airNo, ui.item.value, ui.item.useArea);

                setTotal1()
            }

        });
    }

    function delWork(obj) {
        obj.parentNode.parentNode.remove();
        console.log(obj)
        var id = obj.id;
        //删除total
        var totalT = document.getElementById("totalT");

        //obj.parentNode.parentNode.remove();
        document.getElementById("contactTb").removeChild(totalT);
        //增加total


        //删除租金和押金
        var rid = document.getElementById(id.split('a')[0] + "r");
        console.log('rid:' + rid)
        document.getElementById("contactTb").removeChild(rid);

        var tid = document.getElementById(id.split('a')[0] + "t");
        document.getElementById("contactTb").removeChild(tid);


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


        //模态框
        var tid22 = document.getElementById(id.split('a')[0] + "t11");
        document.getElementById("shoppingTb11").removeChild(tid22);

        var rid22 = document.getElementById(id.split('a')[0] + "r22");
        document.getElementById("contactTb22").removeChild(rid22);

        //水电费,物业费
        var tid44 = document.getElementById(id.split('a')[0] + "t44");
        document.getElementById("waterTb44").removeChild(tid44);

        var tid55 = document.getElementById(id.split('a')[0] + "t55");
        document.getElementById("powerTb55").removeChild(tid55);

        var tid66 = document.getElementById(id.split('a')[0] + "t66");
        document.getElementById("airTb66").removeChild(tid66);

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
            '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" id="' + uId + '" type="text" name="useArea1"  /></td>' +
            select +
            time +
            '<input type="hidden" name="cash1" id="' + cId + '">' +
            '<input type="hidden" name="money1" id="' + mId + '">' +
            '<input type="hidden" name="price1" id="' + pId + '">' +
            '<td nowrap="nowrap"><a id="' + aId + '" onclick="delWork(this)" style="color: #ff0000">删除</a></td>'


        trObj.innerHTML = line;
        document.getElementById("shoppingTb").appendChild(trObj);


    }

    function dischange11(obj) {
        console.log(obj.value);
        var discount = parseFloat(obj.value);
        var id = obj.id.split('d11')[0];
        var m = parseFloat($("#" + id + 'm11').val());
        var tempTotal = m - m * discount / 100;
        $("#" + id + 'md11').val(tempTotal.toFixed(2));

        setTotal1();


    }

    function addWork11(tid, did, mdid, mid, userArea, money, discount, moneyDis, linkHouse, floor) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;


        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + userArea + '"  style="" name="useArea11"  /></td>' +
            '<td><input id="' + mid + '" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="money11"  value="' + money + '"/></td>' +
            '<td><input id="' + did + '" onchange="dischange11(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="discount11"  /></td>' +
            '<td><input id="' + mdid + '" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="moneyDis11"  value="' + moneyDis + '" /></td>' +
            '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="linkHouse11" value="' + linkHouse + '"  /></td>' +
            '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="floor11" value="' + floor + '"  /></td>'


        trObj.innerHTML = line;
        document.getElementById("shoppingTb11").appendChild(trObj);


    }

    function addFree44(tid, no, loc, useArea) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;

        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time44" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + no + '"  style="" name="no44"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="loc44"  value="' + loc + '"/></td>' +

            '<td><input name="useArea44" type="hidden" value="' + useArea + '" ><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="degree44"  /></td>'
            + '<td>' + time + '</td>';


        trObj.innerHTML = line;
        document.getElementById("waterTb44").appendChild(trObj);


    }

    function addFree55(tid, no, loc, useArea) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;

        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time55" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + no + '"  style="" name="no55"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="loc55"  value="' + loc + '"/></td>' +

            '<td><input name="useArea55" type="hidden" value="' + useArea + '" ><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="degree55"  /></td>'
            + '<td>' + time + '</td>';


        trObj.innerHTML = line;
        document.getElementById("powerTb55").appendChild(trObj);


    }

    function addFree66(tid, no, loc, useArea) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;

        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time66" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + no + '"  style="" name="no66"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="loc66"  value="' + loc + '"/></td>' +

            '<td><input name="useArea66" type="hidden" value="' + useArea + '" ><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="degree66"  /></td>'
            + '<td>' + time + '</td>';


        trObj.innerHTML = line;
        document.getElementById("airTb66").appendChild(trObj);


    }

    function changeDate(obj, se77) {
        try {


            var s77Val = obj.value;

            console.log(obj)
            var e77Val = $("#" + obj.id.split(se77)[0] + 'e77').val()

            if (se77 = 'e77') {
                s77Val = $("#" + obj.id.split(se77)[0] + 's77').val();
                e77Val = obj.value;
            }

            var m77 = obj.id.split(se77)[0] + 'm77';
            var d77 = obj.id.split(se77)[0] + 'd77';
            var md77 = obj.id.split(se77)[0] + 'md77';
            console.log(e77Val + s77Val)

            var sDate = new Date(s77Val.replace(/-/g, "/"));
            var eDate = new Date(e77Val.replace(/-/g, "/"));
            var days = eDate - sDate;
            var day = parseFloat(days / (1000 * 60 * 60 * 24));
            var money = 0;
            var discount = 0;
            var moneyDis = 0;
            var price = parseFloat('${free}');
            if ($("#" + d77).val() != '') {
                discount = parseFloat($("#" + d77).val())
            }

            var useArea = 0;
            $("input[name='useArea1']").each(function (index, item) {
                if ($(this).val() != '') {
                    useArea += parseFloat($(this).val());
                }

            });
            console.log('day:' + day + "," + useArea * price * day + "," + useArea + ',' + price)
            if (!isNaN(day)) {
                var tempTotal1 = useArea * price * day;
                $("#" + m77).val(tempTotal1.toFixed(2));
                var tempTotal2 = useArea * price * day - useArea * price * day * discount / 100;
                $("#" + md77).val(tempTotal2.toFixed(2));

            }
            setFreeTotal();
        } catch (e) {
            console.log(e)
        }
    }

    function changeMoneyFree(obj) {
        var money = $("#" + obj.id.split('d77')[0] + 'm77').val();
        var discount = obj.value;
        $("#" + obj.id.split('d77')[0] + 'md77').val(parseFloat(money) - parseFloat(money) * parseFloat(discount) / 100);

        setFreeTotal();
    }

    function addFree77() {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var s77 = trObj.id + 's77';
        var e77 = trObj.id + 'e77';
        var m77 = trObj.id + 'm77';
        var d77 = trObj.id + 'd77';
        var md77 = trObj.id + 'md77';
        var start = 's77';
        var end = 'e77';

        var start77 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input  onchange="changeDate(this,\'s77\')" style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" id="' + s77 + '" name="start77" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var end77 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input onchange="changeDate(this,\'e77\')" style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" id="' + e77 + '"  name="end77" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line =
            '<td>' + start77 + '</td>' +
            '<td>' + end77 + '</td>' +
            '<td><input disabled  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + m77 + '" type="number" value=""  style="" name="money77"  /></td>' +
            '<td><input  onchange="changeMoneyFree(this)"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + d77 + '" type="number" value=""  style="" name="discount77"  /></td>' +
            '<td><input disabled  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + md77 + '" type="number" value=""  style="" name="moneyDis77"  /></td>' +
            '<td nowrap="nowrap"><a   onclick="delFree(this)" style="color: #ff0000">删除</a></td>'

        trObj.innerHTML = line;
        document.getElementById("freeTb77").appendChild(trObj);


    }


    function addFree88() {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();


        var start88 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="start88" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var end88 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="end88" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line =
            '<td>' + start88 + '</td>' +
            '<td>' + end88 + '</td>' +
            '<td><input   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="number" value=""  style="" name="warn88"  /></td>' +
            '<td nowrap="nowrap"><a   onclick="delFree(this)" style="color: #ff0000">删除</a></td>'

        trObj.innerHTML = line;
        document.getElementById("freeTb88").appendChild(trObj);


    }


    function loadStyle(url) {
        var link = document.createElement('link');
        link.type = 'text/css';
        link.rel = 'stylesheet';
        link.href = url;
        var head = document.getElementsByTagName('head')[0];
        head.appendChild(link);
        console.log(link)
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

    function addContact(rent, useArea, loc, price, unit, money, rentId, mId) {
        var trObj = document.createElement("tr");
        trObj.id = rentId;

        var line = '<td><input  disabled="disabled"   id="" type="text" value="' + rent + '"  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="name2"  /></td>' +
            '<input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + useArea + '" type="hidden" name="useArea2"  />' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + loc + '" type="text" name="loc2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + price + '" type="text" name="price2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + unit + '" type="text" name="unit2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + mId + '" value="' + money + '" type="text" name="money2"  /></td>' +
            '<td nowrap="nowrap"><a    data-toggle="modal" data-target="#myModal"  style="color: #1d4499">详情</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);


    }

    function addContact22(rentId, did, mdid, loc, money) {
        var trObj = document.createElement("tr");
        trObj.id = rentId;
        var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time22" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td><input  disabled="disabled"   id="" type="text" value="' + loc + '"  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"  name="loc22"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + money + '" type="text" name="money22"  /></td>' +
            '<td><input  onchange="dischange22(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + did + '" value="" type="number" name="discount22"  /></td>' +
            '<td>' + time + '</td>'


        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb22").appendChild(trObj);


    }

    function dischange22(obj) {
        setTotal1();
    }

    function addContactTwo(rent, loc, money, tid, mid2) {
        var trObj = document.createElement("tr");
        trObj.id = tid;

        var line = '<td><input   disabled="disabled"  id="cashR" type="text" value="' + rent + '"  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="name2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + loc + '" type="text" name="loc2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="price2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="unit2"  /></td>' +
            '<td><input  disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + mid2 + '" value="' + money + '" type="text" name="money2"  /></td>' +
            '<td nowrap="nowrap"><a    data-toggle="modal" data-target="#myModal"  style="color: #1d4499">详情</a></td>'

        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);


    }

    function addContactOne() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var mId = trObj.id + 'm';

        var line = '<td><input     id="cashR" type="text" value=""  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="name2H"  /></td>' +
            '<td><input    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="loc2H"  /></td>' +
            '<td><input   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="price2H"  /></td>' +
            '<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="unit2H"  /></td>' +
            '<td><input    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + mId + '" value="" type="number" onchange="changeMoney(this)" name="money2H"  /></td>' +
            '<td nowrap="nowrap"><a onclick="delContact(this)"  style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);

        delContactTotal()

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

    }

    function changeMoney(obj) {
        // var cash1 = 0;
        //
        // $("input[name='money2']").each(function (index, item) {
        //     if ($(this).val() != '') {
        //         cash1 += parseFloat($(this).val());
        //     }
        //
        // });
        // $("input[name='money2H']").each(function (index, item) {
        //     if ($(this).val() != '') {
        //         cash1 += parseFloat($(this).val());
        //     }
        //
        // });
        // var total = $("#cashM").val();
        //
        // if (typeof(total) != "undefined" && total != '') {
        //     cash1 -= parseFloat(total);
        // }
        // $("#cashM").val(cash1)
        setTotal1();
    }

    function addContactTotal(rent, money) {
        var trObj = document.createElement("tr");
        trObj.id = 'totalT';

        var line = '<td><input   style="border: 0;text-align: center;font-weight: 900"  id="cashR" type="text" value="' + rent + '"  align="center"   /></td>' +
            '<td><input  style="border: 0;" id="" value="" type="text"   /></td>' +
            '<td><input  style="border: 0;" id="" value="" type="text"  /></td>' +
            '<td><input  style="border: 0;" id="" value="" type="text"   /></td>' +
            '<td><input  style="border: 0;text-align: center;font-weight: 900" id="cashM" value="' + money + '" type="text"  /></td>' +
            '<td nowrap="nowrap"><a  data-toggle="modal" data-target="#myModal" style="color: #1d4499;text-align: center;">详情</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb").appendChild(trObj);


    }

    function skipDetail() {
        var url = '/seckill/contract_house_add_detail'
        mui.openWindow({
            url: url


        })
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

    function delFree(obj) {

        obj.parentNode.parentNode.remove();

        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("regTb").removeChild(trObj);
    }

    function skipFreeDetail() {

    }

    function addFree() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();


        var line = '<td><input     id="cashR" type="text" value=""  align="center" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" name="name3"  /></td>' +
            '<td><input     style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="number" name="price3"  /></td>' +
            '<td><input   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="" type="text" name="unit3"  /></td>' +
            '<td nowrap="nowrap"><a onclick="delFree(this)"  style="color: #ff0000">删除</a>|<a data-toggle="modal" data-target="#freeModal"style="color: #1d4499">详情</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("freeTb").appendChild(trObj);


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

    function modify() {


    }


    function deal(isOk) {
        var userName = $.cookie('account');
        var explain = $("#explain").val();
        var uuid = '${contract.uuid}';

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
</script>
</html>