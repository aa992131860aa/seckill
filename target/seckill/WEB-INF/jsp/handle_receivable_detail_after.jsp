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
    <%--<%@include file="common/jquery_ui.jsp" %>--%>
    <style type="text/css">

        .table th, .table td {
            text-align: center;
            vertical-align: middle !important;
        }

        .modal-dialog {
            width: 98%;
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

    <h1 class="mui-title">核销费用</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">
    <input type="hidden" id="free" value="${free}">
    <input type="hidden" id="customId" value="${customId}">
    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">


        <div class="form-group">
            <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                       placeholder="请输入助记码" required id="code_auto"
                       value="${codeAuto}">
            </div>


            <label for="remark" class="col-sm-2 control-label">备注</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" disabled="disabled" id="remark"
                       value="${remark}">

            </div>
        </div>


        <%--<div style="height: 40px;"></div>--%>
        <div style="display: none" class="panel panel-default     col-sm-12  ">
            <div class="panel-body">
                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">应收费用组成(单位:元)</label>


                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>序号</th>
                                <th colspan="2">费用名称</th>
                                <th>位置编号</th>
                                <th>合同号</th>
                                <th>应收费用</th>
                                <th>应收时间</th>
                                <th>违约金</th>
                                <th>详情</th>
                            </tr>
                            </thead>
                            <tbody id="shoppingTb">
                            <c:forEach items="${contractList}" var="list">

                                <%--table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1;--%>


                                <c:forEach items="${list.adTempList}" var="ad" varStatus="loop">
                                    <tr>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${list.id}" name="useArea1"/></td>
                                        <td colspan="2"><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               id="uId " type="text" value="${ad.name}"
                                                               name="useArea1"/></td>
                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${ad.loc}" name="useArea1"/></td>
                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${list.no}" name="useArea1"/></td>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${ad.total}" name="useArea1"/></td>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${ad.date}" name="useArea1"/></td>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="" name="useArea1"/></td>
                                        <td nowrap="nowrap"><a id="${b.table0}a" data-toggle="modal"
                                                               data-target="#myModal"
                                                               style="color: #1d4499">详情</a></td>
                                    </tr>

                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-lable col-sm-offset-1">应收金额合计:<span id="total"
                                                                              style="color: #f00">${allTotal}</span>元</label>
                </div>

            </div>


        </div>


        <%--<h4>--%>
        <%--<center>收款(预收)汇总表</center>--%>
        <%--</h4>--%>
        <div style="display:none;" class="panel panel-default    col-sm-12 ">
            <div class="panel-body">

                <div class="form-group">
                    <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                               placeholder="请输入助记码" required id="code_auto"
                               value="${codeAuto}">
                    </div>


                    <label for="remark" class="col-sm-2 control-label">备注</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                               id="remark"
                               value="${remark}">

                    </div>
                </div>


                <div class="form-group col-md-10" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">实收款累计(单位:元)</label>


                    <button type="button" style="float: right"
                            class="mui-btn mui-btn-outlined   mui-btn mui-btn-primary"
                            data-toggle="modal"
                            data-target="#addModal"> 添加收款
                    </button>

                </div>
                <div class="form-group">
                    <div class="table-responsive col-md-9 col-md-offset-1" id="free"
                         style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>预收金额</th>
                                <th>收款日期</th>
                                <th>备注</th>
                                <th nowrap="nowrap">操作</th>
                            </tr>
                            </thead>
                            <tbody id="contactTb">

                            <c:forEach items="${tableMList}" var="t">
                                <tr>
                                    <td><input disabled type="text" value="${t.moneyM}"
                                               align="center"
                                               style="border:0px;text-align: center;border-radius:0;"
                                               name="moneyM"/></td>
                                    <td><input disabled type="text" value="${t.dateM}"
                                               align="center"
                                               style="border:0px;text-align: center;border-radius:0;"
                                               name="contentM"/></td>
                                    <td><input disabled type="text" value="${t.remarkM}"
                                               align="center"
                                               style="border:0px;text-align: center;border-radius:0;"
                                               name="remarkM"/></td>
                                    <td nowrap="nowrap"><a onclick="delTableM('${t.uuid}')"
                                                           style="color: #ff0000">删除</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-lable col-sm-offset-1">累计收款合计:<span id="total2"
                                                                              style="color: #f00"></span>元</label>
                </div>
            </div>
        </div>


        <div class="form-group" style="display: none">
            <div class="col-xs-12  col-sm-12">


                <button type="button" class="mui-btn mui-btn-primary " data-toggle="modal"
                        data-target="#confirmModal" style="float: right"> 转费用结算单
                </button>

            </div>

        </div>

        <div class="panel panel-default    col-sm-12 ">
            <div class="panel-body">
                <div class="form-group">
                    <div class="table-responsive col-md-10 col-md-offset-1" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th nowrap="nowarp">选择</th>
                                <%--<th>序号</th>--%>
                                <th colspan="2">费用名称</th>
                                <%--<th>位置编号</th>--%>
                                <th>合同号</th>
                                <th>应收费用</th>
                                <th>应收时间</th>
                                <th style="display:none;">违约金</th>
                                <%--<th>详情</th>--%>
                            </tr>
                            </thead>
                            <tbody id="shoppingTb">
                            <c:forEach items="${contractFreeList}" var="list">
                                <tr>
                                    <td>  <input
                                        <%--<c:if test="${fn:contains(tableU, list.id+pLoop.index+loop.index+ad.loc)}"> checked="checked" </c:if>--%>
                                                 onclick="selectMoney(this)"
                                                 style="width: 20px;height: 20px;"  checked disabled
                                                 type="checkbox"/>

                                    </td>
                                    <td colspan="2"><input disabled="disabled"
                                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                           id="uId " type="text" value="${list.name}"
                                                           name="useArea1"/></td>
                                        <%--<td><input disabled="disabled"--%>
                                        <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                        <%--id="uId " type="text" value="${ad.loc}" name="useArea1"/></td>--%>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="${list.no}" name="useArea1"/></td>

                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="${list.money}" name="useArea1"/>

                                    </td>

                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="" name="useArea1"/></td>

                                    <td style="display: none"><input disabled="disabled"
                                                                     style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                                     id="uId " type="text" value=""
                                                                     name="useArea1"/></td>
                                </tr>
                            </c:forEach>
                            <c:forEach items="${contractList}" var="list" varStatus="pLoop">

                                <%--table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1;--%>


                                <c:forEach items="${list.adTempList}" var="ad" varStatus="loop">
                                    <tr>
                                        <td>


                                            <input id="${list.no}${ad.name}"
                                                <%--<c:if test="${fn:contains(tableU, list.id+pLoop.index+loop.index+ad.loc)}"> checked="checked" </c:if>--%>
                                                   onclick="selectMoney(this)" value="${ad.total}"
                                                   style="width: 20px;height: 20px;" name="use"
                                                   type="checkbox"/>


                                        </td>
                                            <%--<td><input disabled="disabled"--%>
                                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                            <%--id="uId " type="text" value="${list.id}" name="useArea1"/></td>--%>
                                        <td colspan="2"><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               id="uId " type="text" value="${ad.name}"
                                                               name="useArea1"/></td>
                                            <%--<td><input disabled="disabled"--%>
                                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                            <%--id="uId " type="text" value="${ad.loc}" name="useArea1"/></td>--%>
                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${list.no}" name="useArea1"/></td>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${ad.total}" name="useArea1"/>

                                        </td>

                                        <td><input disabled="disabled"
                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                   id="uId " type="text" value="${ad.date}" name="useArea1"/></td>

                                        <td style="display: none"><input disabled="disabled"
                                                                         style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                                         id="uId " type="text" value=""
                                                                         name="useArea1"/></td>
                                            <%--<td nowrap="nowrap"><a id="${b.table0}a" data-toggle="modal"--%>
                                            <%--data-target="#myModal"--%>
                                            <%--style="color: #1d4499">详情</a></td>--%>
                                    </tr>

                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>


    </form>
    <div style="height: 50px;"></div>

</div>

<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="myModalLabel2">
                    收款(实收)录入单
                </h4>
            </div>

            <div class="modal-body" style="overflow:auto;">

                <form id="form" data-toggle="validator" class="form-horizontal" role="form"
                      style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-3">
                            <input disabled type="text" class="form-control" style="background-color: #fff"
                                   placeholder="请输入助记码" required

                                   value="${codeAuto}">
                        </div>


                        <label for="remark" class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled

                                   value="${remark}">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">收款时间</label>
                        <div class="input-group date form_datetime col-md-3" data-date="1979-09-16T05:25:07Z"
                             data-link-field="startDate">
                            <input style="background-color: #fff" class="form-control" id="dateM"
                                   style="" size="16" type="text"
                                   readonly
                            >
                            <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                            <span class="input-group-addon" style="display: none"><span
                                    class="glyphicon glyphicon-th"></span></span>
                        </div>

                    </div>

                    <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                        <label for="name" class="control-label">应收费用组成(元)</label>

                    </div>

                    <div class="form-group">
                        <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                            <table class="table">

                                <thead>
                                <tr>

                                    <th>预收金额</th>
                                    <th>费用内容</th>
                                    <th>备注</th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><input type="number"
                                               align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               id="moneyM"/></td>
                                    <td><input type="text"
                                               align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               id="contentM"/></td>
                                    <td><input type="text"
                                               align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               id="remarkM"/></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <%--<div class="form-group">--%>
                    <%--<label class="control-lable col-sm-offset-1">收款(实收)金额合计:<span>100</span>元</label>--%>
                    <%--</div>--%>

                    <div class="form-group">
                        <label for="startTime" class="col-md-2 control-label">支付方式</label>
                        <div class="col-md-2 ">


                            <div class="mui-input-row mui-checkbox mui-left">
                                <label>现金</label>
                                <input name="checkbox1" id="pay1" value="" type="checkbox">
                            </div>

                        </div>
                        <div class="col-md-2 ">

                            <div class="mui-input-row mui-checkbox mui-left">
                                <label>微信</label>
                                <input name="checkbox1" id="pay2" value="" type="checkbox">
                            </div>

                        </div>
                        <div class="col-md-2 ">

                            <div class="mui-input-row mui-checkbox mui-left">
                                <label>支付宝</label>
                                <input name="checkbox1" id="pay3" value="true" type="checkbox">
                            </div>

                        </div>

                        <div class="col-md-2 ">

                            <div class="mui-input-row mui-checkbox mui-left">
                                <label>转账</label>
                                <input name="checkbox1" id="pay4" value="true" type="checkbox">
                            </div>

                        </div>
                        <div class="col-md-2 ">

                            <div class="mui-input-row mui-checkbox mui-left">
                                <label>申免</label>
                                <input name="checkbox1" id="pay5" value="true" type="checkbox">
                            </div>

                        </div>

                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" onclick="confirmTableM()" data-dismiss="modal" class="btn btn-primary">
                    提交添加
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3"
     aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="myModalLabel3">
                    费用结算单
                </h4>
            </div>

            <div class="modal-body" style="overflow:auto;">

                <form id="form" data-toggle="validator" class="form-horizontal" role="form"
                      style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-3">
                            <input disabled type="text" class="form-control" style="background-color: #fff"
                                   placeholder="请输入助记码" required

                                   value="${codeAuto}">
                        </div>


                        <label for="remark" class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled

                                   value="${remark}">

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">结算日期</label>
                        <div class="input-group date form_datetime col-md-3" data-date="1979-09-16T05:25:07Z"
                             data-link-field="startDate">
                            <input style="background-color: #fff" class="form-control" id="dateM"
                                   style="" size="16" type="text"
                                   readonly
                            >
                            <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                            <span class="input-group-addon" style="display: none"><span
                                    class="glyphicon glyphicon-th"></span></span>
                        </div>

                        <%--<label for="remark" style="float: right;" class="col-sm-2 control-label">单位:元</label>--%>
                    </div>

                    <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                        <label for="name" class="control-label">应收费用组成(元)</label>

                    </div>

                    <div class="form-group">
                        <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                            <table class="table">

                                <thead>
                                <tr>

                                    <th>预收金额</th>
                                    <th>抵充应收</th>
                                    <th>可用余额</th>

                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><input type="number"
                                               align="center"
                                               disabled
                                               style="border: 0;text-align: center;border-radius:0;"
                                               id="moneyTotal"/></td>
                                    <td><input type="text"
                                               align="center"
                                               disabled
                                               style="border: 0;text-align: center;border-radius:0;"
                                               id="useTotal"/></td>
                                    <td>

                                        <span id="total3" style="color: #f00">0</span>
                                    </td>
                                    <%--<td><input--%>
                                    <%--style="width: 20px;height: 20px;" name="checkbox1" value=""--%>
                                    <%--type="checkbox"></td>--%>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>


                    <div class="form-group">
                        <div class="table-responsive col-md-10 col-md-offset-1" style="clear: both;margin-top: 30px">
                            <table class="table">

                                <thead>
                                <tr>
                                    <th nowrap="nowarp">选择</th>
                                    <%--<th>序号</th>--%>
                                    <th colspan="2">费用名称</th>
                                    <%--<th>位置编号</th>--%>
                                    <th>合同号</th>
                                    <th>应收费用</th>
                                    <th>应收时间</th>
                                    <th style="display:none;">违约金</th>
                                    <%--<th>详情</th>--%>
                                </tr>
                                </thead>
                                <tbody id="shoppingTb">
                                <c:forEach items="${contractList}" var="list" varStatus="pLoop">

                                    <%--table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1;--%>


                                    <c:forEach items="${list.adTempList}" var="ad" varStatus="loop">
                                        <tr>
                                            <td>


                                                <input id="${list.id}${pLoop.index}${loop.index}${ad.loc}"
                                                    <%--<c:if test="${fn:contains(tableU, list.id+pLoop.index+loop.index+ad.loc)}"> checked="checked" </c:if>--%>
                                                       onclick="selectMoney(this)" value="${ad.total}"
                                                       style="width: 20px;height: 20px;" name="use"
                                                       type="checkbox"/>


                                            </td>
                                                <%--<td><input disabled="disabled"--%>
                                                <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                                <%--id="uId " type="text" value="${list.id}" name="useArea1"/></td>--%>
                                            <td colspan="2"><input disabled="disabled"
                                                                   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                                   id="uId " type="text" value="${ad.name}"
                                                                   name="useArea1"/></td>
                                                <%--<td><input disabled="disabled"--%>
                                                <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"--%>
                                                <%--id="uId " type="text" value="${ad.loc}" name="useArea1"/></td>--%>
                                            <td><input disabled="disabled"
                                                       style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                       id="uId " type="text" value="${list.no}" name="useArea1"/></td>

                                            <td><input disabled="disabled"
                                                       style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                       id="uId " type="text" value="${ad.total}" name="useArea1"/>

                                            </td>

                                            <td><input disabled="disabled"
                                                       style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                       id="uId " type="text" value="${ad.date}" name="useArea1"/></td>

                                            <td style="display: none"><input disabled="disabled"
                                                                             style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                                             id="uId " type="text" value=""
                                                                             name="useArea1"/></td>
                                                <%--<td nowrap="nowrap"><a id="${b.table0}a" data-toggle="modal"--%>
                                                <%--data-target="#myModal"--%>
                                                <%--style="color: #1d4499">详情</a></td>--%>
                                        </tr>

                                    </c:forEach>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>


                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" data-dismiss="modal" onclick="confirm()" class="btn btn-primary">
                    冲销
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
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
                    ${codeAuto}应收明细(对账单) &nbsp;&nbsp;&nbsp;&nbsp;单位:元 &nbsp;&nbsp;&nbsp;&nbsp;备注:${remark}
                </h4>
            </div>

            <div class="modal-body" style="overflow:auto;">

                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">房源租金明细(租金计算:使用面积*单价*天数)</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno1"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>位置编号</th>
                                <th>使用面积</th>
                                <th>年总价</th>
                                <th>折扣</th>
                                <th>折扣总价</th>
                                <th>关联房号</th>
                                <th>楼层</th>
                                <th>合计总价</th>
                                <th>收费期间</th>
                                <th>本期收费金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no1" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table4}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table5}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList11[loop.index].table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">物业保证金</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno2"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>位置编号</th>
                                <th>保证金年总价(元)</th>
                                <th>折扣(%)</th>
                                <th>收费期间</th>
                                <th>合计总价</th>
                                <th>本期收费金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList22}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no2" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table5}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table5}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">物业费明细(物业费计算:单价*面积*月份)</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno3"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>位置编号</th>
                                <th>年总价(元)</th>
                                <th>优惠折扣(%)</th>
                                <th>折后总价</th>
                                <th>收费期间</th>
                                <th>本期收费金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList77}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no3" value="${list.no}"/>

                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table4}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table0}   ${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table4}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">水费明细</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno4"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>水表编号</th>
                                <th>位置编号</th>
                                <th>上期抄表</th>
                                <th>本期抄表</th>
                                <th>度数</th>
                                <th>单价</th>
                                <th>金额小计</th>
                                <th>收费期间</th>
                                <th>金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList44}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no4" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table4}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">电费明细</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno5"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>电表编号</th>
                                <th>位置编号</th>
                                <th>上期抄表</th>
                                <th>本期抄表</th>
                                <th>度数</th>
                                <th>单价</th>
                                <th>金额小计</th>
                                <th>收费期间</th>
                                <th>金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList55}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no5" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">空调费明细</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno6"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>电表编号</th>
                                <th>位置编号</th>
                                <th>上期抄表</th>
                                <th>本期抄表</th>
                                <th>度数</th>
                                <th>单价</th>
                                <th>金额小计</th>
                                <th>收费期间</th>
                                <th>金额合计</th>
                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList66}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no6" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value=""
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">广告费</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno7"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>位置编号</th>
                                <th>楼层</th>
                                <th>年总价(元)</th>
                                <th>广告位类型</th>
                                <th>收费期间</th>
                                <th>本期收费金额合计</th>

                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='ad'}">
                                    <c:forEach items="${list.tableList11}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no7" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>

                                            <td><input disabled type="text"
                                                       value="${list.tableList1[loop.index].table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">车位费</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno8"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>位置编号</th>
                                <th>年总价(元)</th>
                                <th>车位类型</th>
                                <th>车牌</th>
                                <th>联系人</th>
                                <th>收费期间</th>
                                <th>本期收费金额合计</th>

                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='car'}">
                                    <c:forEach items="${list.tableList11}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no8" value="${list.no}"/>

                                            <td><input disabled type="text" value="${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table3}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table4}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table5}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text"
                                                       value="${list.tableList1[loop.index].table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table2}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group col-md-11 col-xs-11" style="margin-top: 2%;margin-left: 2%;">
                    <label for="name" class="control-label">其他费用</label>
                    <label for="name" style="float: right;" class="control-label">合同号:<span id="tno9"></span></label>
                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                        <table class="table">

                            <thead>
                            <tr>

                                <th>名称</th>
                                <th>金额</th>


                            </tr>
                            </thead>
                            <tbody id="payTb">
                            <c:forEach items="${contractList}" var="list">
                                <c:if test="${list.style=='house'}">
                                    <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no91" value="${list.no}"/>

                                            <td><input disabled type="text" value="房源-${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table5}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                                <c:if test="${list.style=='ad'}">
                                    <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no92" value="${list.no}"/>

                                            <td><input disabled type="text" value="广告-${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                                <c:if test="${list.style=='car'}">
                                    <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                        <tr>
                                            <input type="hidden" id="no93" value="${list.no}"/>

                                            <td><input disabled type="text" value="广告-${t.table0}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                            <td><input disabled type="text" value="${t.table1}"
                                                       align="center"
                                                       style="border:0px;text-align: center;border-radius:0;"
                                                       name="money33"/></td>
                                        </tr>

                                    </c:forEach>


                                </c:if>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="form-group">
                    <label class="control-lable ">本次应收金额:<span id="total1"
                                                               style="">${allTotal}</span>元</label>
                    <%--<label class="control-lable col-sm-offset-1">截止日期:2018-09-09</label>--%>
                    <label class="control-lable col-sm-offset-1">违约金:</label><input style="width: 200px;" id="debt"
                                                                                    value="${debt}"
                                                                                    onchange="changeDebt()"
                                                                                    type="number">
                    <label class="control-lable col-sm-offset-1">本期费用合计:${allTotal}元</label>

                </div>
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

<input type="hidden" id="linkMan11">
<input type="hidden" id="car11">
</body>
<script type="text/javascript" charset="utf-8">

    mui.init({

        beforeback: function () {


        }
    });

    function selectMoney(obj) {

        var tableU = '';
        var flag1 = "@@";
        var codeAuto = '${codeAuto}';
        var remark = '${remark}';
        var customId = '${customId}'
        if (remark == '') {
            remark = 'fantasy';
        }
        var tableUU = '${tableU}';
        $("input[name='use']").each(function (index, item) {
            if (item.checked) {

                var fantasy = "";
                var tableUs = tableUU.split('@@');
                for (var i = 0; i < tableUs.length; i++) {
                    if (tableUs[i].indexOf(item.id) != -1 && tableUs[i].indexOf('fantasy') != -1) {

                        fantasy = "fantasy";
                        break;
                    }
                }

                tableU += item.id + fantasy + flag1;

            } else {
                tableU += '' + flag1;
            }

        })


        var url = '/seckill/handle_receivable_detail/' + codeAuto + '/' + remark + '/' + tableU + '/' + customId + '/tableU';
        $.post(url, {}, function (res) {
            // if (res > 0) {
            //     mui.toast('修改违约金成功', {duration: 'short', type: 'div'})
            // }
            setTotal()
        })

    }

    function setTotal() {
        var total = 0;
        //可用余额
        $("input[name='moneyM']").each(function (value, item) {

            if ($(this).val() != '') {
                total += parseFloat($(this).val())
            }
        })
        $("#moneyTotal").val(total.toFixed(2))
        $("#total2").text(total.toFixed(2))

        var use = 0;
        //抵充
        $("input[name='use']:checked").each(function (index, item) {
            console.log(item)
            console.log('true' + item.checked)
            if (item.checked) {

                if (item.value != '') {
                    use += parseFloat(item.value)
                }


            }

        })
        $("#useTotal").val(use.toFixed(2))
        console.log("use:" + use);
        //余额
        $("#total3").text((total - use).toFixed(2))
    }

    function initToatal() {
        //赋值合同号
        var no1 = $("#no1").val();
        var no2 = $("#no2").val();
        var no3 = $("#no3").val();
        var no4 = $("#no4").val();
        var no5 = $("#no5").val();
        var no6 = $("#no6").val();
        var no7 = $("#no7").val();
        var no8 = $("#no8").val();
        var no91 = $("#no91").val();
        var no92 = $("#no92").val();
        var no93 = $("#no93").val();
        if (typeof(no91) == 'undefined') {
            no91 = '';
        }
        if (typeof(no92) == 'undefined') {
            no92 = '';
        }
        if (typeof(no93) == 'undefined') {
            no93 = '';
        }

        $("#tno1").text(no1);
        $("#tno2").text(no2);
        $("#tno3").text(no3);
        $("#tno4").text(no4);
        $("#tno5").text(no5);
        $("#tno6").text(no6);
        $("#tno7").text(no7);
        $("#tno8").text(no8);
        $("#tno9").text(no91 + ',' + no92 + ',' + no93);


        var tableU = '${tableU}';

        $("input[name='use']").each(function (index, item) {

            $(this).attr('disabled', 'disabled');
            if (tableU.indexOf(item.id) != -1) {
                $(this).attr('checked', true);

                var tableUs = tableU.split('@@');

                for (var i = 0; i < tableUs.length; i++) {
                    if (tableUs[i].indexOf(item.id) != -1 && tableUs[i].indexOf('fantasy') != -1) {
                        // $(this).attr('disabled', 'disabled');
                        break;
                    }
                }

            }

        })
        setTotal();

    }


    $(function () {
        initToatal();
        //制单人
        var userName = $.cookie('account');
        $("#userName").text(userName)


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


    function delTwo(obj) {
        obj.parentNode.parentNode.remove();
        console.log()


    }


    function addWork11(tid, loc, floor, name, car, linkMan) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;


        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + loc + '"  style="" name="loc11"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="floor11"  value="' + floor + '"/></td>' +
            '<td><input id="" onchange="dischange11(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="money11"  /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="name11"  value="' + name + '" /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="car11"  value="' + car + '" /></td>' +
            '<td><input id="" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="linkMan11"  value="' + linkMan + '" /></td>'

        trObj.innerHTML = line;
        document.getElementById("shoppingTb11").appendChild(trObj);


    }


    function back() {


        window.history.go(-1);
    }

    function delTableM(uuid) {
        var url = '/seckill/handle_receivable_detail/' + uuid + '/tableM';
        $.post(url, {}, function (res) {
            if (res > 0) {
                mui.toast('删除成功', {duration: 'short', type: 'div'})
                location.reload(true)

            }
        })
    }

    function changeDebt() {
        var codeAuto = '${codeAuto}';
        var remark = '${remark}';
        var customId = $("#customId").val();
        if (remark == '') {
            remark = 'fantasy';
        }
        var debt = $("#debt").val();
        var url = '/seckill/handle_receivable_detail/' + codeAuto + '/' + remark + '/' + debt + '/' + customId + '/debt';
        $.post(url, {}, function (res) {
            if (res > 0) {
                mui.toast('修改违约金成功', {duration: 'short', type: 'div'})
            }
        })
    }

    function confirmTableM() {
        var customId = '${customId}'
        var flag1 = "@@";
        var codeAuto = '${codeAuto}';
        var remark = '${remark}';
        var dateM = $("#dateM").val();
        var moneyM = $("#moneyM").val();
        var contentM = $("#contentM").val();
        var remarkM = $("#remarkM").val();

        var pay1 = $("#pay1").is(':checked')
        var pay2 = $("#pay2").is(':checked')
        var pay3 = $("#pay3").is(':checked')
        var pay4 = $("#pay4").is(':checked')
        var pay5 = $("#pay5").is(':checked')
        if (remark == '') {
            remark = 'fantasy';
        }
        //判断是否预收金额大于实收的  total moneyTotal
        var total = $("#total").text();
        var moneyTotal = $("#moneyTotal").val();
        if (parseFloat(moneyTotal) + parseFloat(moneyM) > parseFloat(total)) {
            mui.toast('预收金额大于应收合计,请重新输入金额', {duration: 'short', type: 'div'})
            return;
        }
        var tableM = dateM + flag1 + moneyM + flag1 + contentM + flag1 + remarkM + flag1 + pay1 + flag1 + pay2 + flag1 + pay3 + flag1 + pay4 + flag1 + pay5;

        var url = '/seckill/handle_receivable_detail/' + codeAuto + '/' + remark + '/' + tableM + '/' + customId + '/tableM';
        $.post(url, {}, function (res) {
            if (res > 0) {
                mui.toast('添加成功', {duration: 'short', type: 'div'})
                location.reload(true);
                //history.go(0)
                $("#dateM").val('');
                $("#moneyM").val('');
                $("#contentM").val('');
                $("#remarkM").val('');
            }
        })

    }

    function confirm() {
        var total1 = $("#total1").text();
        var total2 = $("#total2").text();
        var total3 = $("#total3").text();
        var useTotal = $("#useTotal").val();
        var t = total1 - useTotal;
        var codeAuto = '${codeAuto}';
        var remark = '${remark}';
        var isConfirm = 1;
        var customId = $("#customId").val();
        if (remark == '') {
            remark = 'fantasy';
        }

        console.log("total1:" + total1 + ",total2:" + total2 + ",total3:" + total3 + ",useTotal:" + useTotal)
        // if (t == 0 && total3 < 0) {
        //     mui.confirm('实收小于应收,确定冲销?', '', new Array('取消', '确定'), function (e) {
        //         if (e.index == 0) {
        //             mui.toast('您已取消');
        //         } else {
        //
        //             var url = "/seckill/handle_receivable_detail/" + codeAuto + "/" + remark + "/" + isConfirm + "/" + customId + "/isConfirm";
        //             //alert(url)
        //             $.post(url, {}, function (res) {
        //                 //window.location.reload()
        //                 sessionStorage.setItem("need-refresh", true);
        //                 //window.history.back();
        //                 //location.reload()
        //                 window.location.href = document.referrer;
        //                 window.history.back();
        //             })
        //         }
        //     });
        // } else
        if (t == 0 && total3 == 0) {

            var url = "/seckill/handle_receivable_detail/" + codeAuto + "/" + remark + "/" + isConfirm + "/" + customId + "/isConfirm";

            $.post(url, {}, function (res) {
                mui.toast('已冲销完毕');
                //window.location.reload()
                sessionStorage.setItem("need-refresh", true);
                //window.history.back();
                //location.reload()
                //window.location.href = document.referrer;
                window.history.back();
            })
        }

        else {


            sessionStorage.setItem("need-refresh", true);
            // window.location.href = document.referrer;
            window.history.back();
        }
        // var url = '';
        // $.post(url, {}, function (result) {
        //     console.log("result:" + result + ',' + uuid)
        //     if (result >= 1) {
        //         sessionStorage.setItem("need-refresh", true);
        //         //window.history.back();
        //         //location.reload()
        //         window.location.href = document.referrer;
        //         window.history.back();
        //     } else {
        //         mui.toast('添加失败', {duration: 'short', type: 'div'})
        //     }
        // });
        //


    }
</script>
</html>