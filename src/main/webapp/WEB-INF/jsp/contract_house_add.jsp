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

    <h1 class="mui-title">合同管理</h1>
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
            <label for="explain" class="col-sm-2 control-label">备注栏</label>
            <div class="col-sm-6">

                <textarea rows="3" disabled id="explain" placeholder="审批说明或意见">${contract.explain}</textarea>

            </div>
        </div>

        <div class="form-group">
            <label for="startTime" class="col-md-2 control-label">租赁类型</label>
            <div class="col-md-2 ">


                <div class="mui-input-row mui-checkbox mui-left">
                    <label>房子租赁</label>
                    <input name="checkbox1" id="house1" value="" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>注册租赁</label>
                    <input name="checkbox1" id="house2" value="" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>虚拟租赁</label>
                    <input name="checkbox1" id="house3" value="true" type="checkbox">
                </div>

            </div>

        </div>

        <div style="height: 40px;"></div>
        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-11" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">商品名称:房源</label>


                    <button type="button" style="float: right;"
                            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                            onclick="addWork()"> 添加房源
                    </button>

                </div>

                <div class="form-group">
                    <div class="table-responsive col-md-10 col-md-offset-1" style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>位置编号</th>
                                <th>建筑面积</th>
                                <th>是否带窗</th>
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
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                               id="uId " type="text" value="${b.table3}" name="useArea1"/></td>
                                    <td>
                                        <c:if test="${b.table8==1}"> 是 </c:if>
                                        <c:if test="${b.table8==0}"> 否 </c:if>
                                    </td>
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
                <div class="form-group">
                    <label class="control-lable col-sm-offset-1">合计(平方米):<span id="total1"
                                                                               style="color: #f00">0</span></label>
                </div>

            </div>


        </div>


        <div style="height: 40px;"></div>
        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-11" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">租赁费用</label>


                    <button type="button" style="float: right;"
                            class="mui-btn mui-btn-outlined   mui-btn mui-btn-primary"
                            onclick="addContactOne()"> 添加租赁费用
                    </button>

                </div>
                <div class="form-group">
                    <div class="table-responsive col-md-10 col-md-offset-1" id="free"
                         style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>名称</th>
                                <th>位置编号</th>
                                <th>单价</th>
                                <th>单位</th>
                                <th>金额</th>
                                <th nowrap="nowrap">详情</th>
                            </tr>
                            </thead>
                            <tbody id="contactTb">
                            <%--<c:if test="${contract==null}">--%>
                            <%--<tr>--%>
                            <%--<td><input disabled="disabled" type="text" value="违约金" align="center"--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--name="name2H"/></td>--%>
                            <%--<input--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--type="hidden" name="useArea2H"/>--%>
                            <%--<td><input--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--type="text" name="loc2H"/></td>--%>
                            <%--<td><input--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--type="text" name="price2H"/></td>--%>
                            <%--<td><input--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--type="text" name="unit2H"/></td>--%>
                            <%--<td><input onchange="changeMoney(this)"--%>
                            <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"--%>
                            <%--value="0"--%>
                            <%--type="text" name="money2H"/></td>--%>
                            <%--<td nowrap="nowrap"><a data-toggle="modal" data-target="#myModal"--%>
                            <%--style="color: #1d4499">详情</a></td>--%>
                            <%--</tr>--%>

                            <%--</c:if>--%>

                            <c:forEach items="${contract.tableList2}" var="t">

                                <tr id="${t.table0}<c:if test="${t.table1=='租金'}">r</c:if><c:if test="${t.table1=='物业保证金'}">t</c:if>">
                                    <td><input disabled="disabled" type="text" value="${t.table1}" align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               name="name2"/>

                                        <input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table2}" type="hidden" name="useArea2"/>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table3}" type="text" name="loc2"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table4}" type="text" name="price2"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table5}" type="text" name="unit2"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               id="${t.table0}" value="${t.table6}" type="text" name="money2"/></td>
                                    <td nowrap="nowrap"><a data-toggle="modal" data-target="#myModal"
                                                           style="color: #1d4499">详情</a></td>
                                </tr>
                            </c:forEach>

                            <c:forEach items="${contract.tableList2H}" var="t">
                                <tr>
                                    <td><input disabled="disabled" type="text" value="${t.table0}" align="center"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               name="name2H"/></td>
                                    <input disabled="disabled"
                                           style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                           value="${t.table1}" type="hidden" name="useArea2H"/>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table2}" type="text" name="loc2H"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table3}" type="text" name="price2H"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               value="${t.table4}" type="text" name="unit2H"/></td>
                                    <td><input disabled="disabled"
                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                               onchange="changeMoney(this)"
                                               value="${t.table5}" type="text" name="money2H"/></td>
                                    <td nowrap="nowrap"><a data-toggle="modal" data-target="#myModal"
                                                           style="color: #1d4499">详情</a></td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div style="height: 40px;"></div>
        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
            <div class="panel-body">
                <div class="form-group col-md-11" style="margin-top: 0px;margin-bottom: 0px;">
                    <label for="name" class="col-md-offset-1 control-label">物业费能耗费组成</label>


                    <button type="button" style="float: right;"
                            class="mui-btn  mui-btn-outlined mui-btn mui-btn-primary"
                            onclick="addFree()"> 添加费用
                    </button>

                </div>
                <div class="form-group">
                    <div class="table-responsive col-md-10 col-md-offset-1" id="table"
                         style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <%--<th>序号</th>--%>
                                <th>名称</th>
                                <th>单价</th>
                                <th>单位</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="freeTb">

                            <c:forEach items="${freeList}" var="f">
                                <tr>
                                        <%--<td><input--%>
                                        <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"--%>
                                        <%--type="text" name="nameW" value="${f.id}"/></td>--%>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            type="text" name="name3" value="${f.name}"/></td>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            type="text" name="price3" value="${f.price}"/></td>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            name="unit3" type="text" value="${f.unit}"/></td>
                                    <td nowrap="nowrap">
                                            <%--<a onclick="delFree(this)" style="color: #ff0000">删除</a>--%>
                                            <%--|--%>
                                        <a data-toggle="modal" data-target="#freeModal" style="color: #1d4499">详情</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:forEach items="${contract.tableList3}" var="f">
                                <tr>
                                        <%--<td><input--%>
                                        <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"--%>
                                        <%--type="text" name="nameW" value="${f.id}"/></td>--%>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            type="text" name="name3" value="${f.table0}"/></td>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            type="text" name="price3" value="${f.table1}"/></td>
                                    <td><input
                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                            name="unit3" type="text" value="${f.table2}"/></td>
                                    <td nowrap="nowrap"><a onclick="delFree(this)" style="color: #ff0000;display: none">删除</a>
                                        <a data-toggle="modal" data-target="#freeModal" style="color: #1d4499">详情</a>
                                    </td>
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
                        <button id="confirmId" type="button" class="mui-btn mui-btn-primary col-sm-offset-1"
                                onclick="confirm()"> 审批
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
                    房源租金
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
                                                <th>建筑面积</th>
                                                <th>年总价</th>
                                                <th>折扣(%)</th>
                                                <th>折后总价</th>
                                                <th>关联房号</th>
                                                <th>楼层</th>
                                            </tr>
                                            </thead>
                                            <tbody id="shoppingTb11">
                                            <c:forEach items="${contract.tableList11}" var="b">
                                                <tr id="${b.table7}t11">

                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                               id="" type="text" value="${b.table0}" style=""
                                                               name="useArea11"/></td>
                                                    <td><input id="${b.table7}m11" disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="money11" value="${b.table1}"/></td>
                                                    <td><input id="${b.table7}d11" onchange="dischange11(this)"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               value="${b.table2}" type="number" name="discount11"/>
                                                    </td>
                                                    <td><input id="${b.table7}md11" disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="moneyDis11" value="${b.table3}"/></td>
                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="linkHouse11" value="${b.table4}"/></td>
                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                               type="text" name="floor11" value="${b.table5}"/></td>
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
                                    <label for="name" class=" control-label">物业保证金</label>


                                </div>

                                <div class="form-group">
                                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>位置编号</th>
                                                <th>保证金年总价</th>
                                                <th>优惠折扣(%)</th>
                                                <th>退费时间(起)</th>

                                            </tr>
                                            </thead>
                                            <tbody id="contactTb22">
                                            <c:forEach items="${contract.tableList22}" var="b">
                                                <tr id="${b.table4}r22">


                                                    <td><input disabled="disabled" type="text" value="${b.table1}"
                                                               align="center"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                                               name="loc22"/></td>
                                                    <td><input disabled="disabled"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                                               value="${b.table2}" type="text" name="money22"/></td>
                                                    <td><input onchange="dischange22(this)"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;"
                                                               id="${b.table4}d22" value="${b.table3}" type="number"
                                                               name="discount22"/>
                                                    </td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="time22" size="16" type="text"
                                                                   value="${b.table0}"
                                                                   class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-lable col-sm-offset-1">折后总价合计:<span id="total22"
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
                                    <label for="name" class=" control-label">物业费(金额单位:元)</label>

                                    <button type="button" style="float: right;display: none"
                                            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addFree77()"> 添加物业费
                                    </button>
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
                                                <th style="display:none;">操作</th>

                                            </tr>
                                            </thead>
                                            <c:forEach items="${contract.tableList77}" var="b">
                                                <input type="hidden" value="${b.table3}" id="discount77">
                                            </c:forEach>
                                            <c:if test="${contract.tableList77==null}">
                                                <input type="hidden" value="${b.table3}" id="discount77">
                                            </c:if>

                                            <tbody id="freeTb77">
                                            <c:forEach items="${contract.tableList77}" var="b">
                                                <tr>


                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input onchange="changeDate(this,'s77')" value="${b.table0}"
                                                                   style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   id="free77s77" name="start77" size="16"
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
                                                                   id="free77e77" name="end77" size="16"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>
                                                    <td><input disabled
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                               id="$free77m77" type="number" value="${b.table2}"
                                                               style="" name="money77"/></td>
                                                    <td><input onchange="changeMoneyFree(this)"
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                               id="free77d77" type="number" value="${b.table3}"
                                                               style="" name="discount77"/>

                                                    </td>
                                                    <td><input disabled
                                                               style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                               id="free77md77" type="number" value="${b.table4}"
                                                               style="" name="moneyDis77"/></td>
                                                    <td style="display: none" nowrap="nowrap"><a onclick="delFree(this)"
                                                                                                 style="color: #ff0000">删除</a>
                                                    </td>
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
                        <label style="font-size: 20px;display: none" class="col-md-4 control-label">租赁费用合计:<span
                                id="total33">0</span>元</label>
                    </div>

                    <div class="form-group">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class=" control-label">付款比例(金额单位:元;时间单位:年月日)</label>

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


<!--各种费用的模态框-->
<div class="modal fade" id="freeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="freeModalLabel">
                    物业费、能耗费
                </h4>
            </div>
            <div class="modal-body" style="overflow:auto;">
                <form id="form" data-toggle="validator" class="form-horizontal" role="form"
                      style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

                    <div class="form-group">
                        <label for="code_auto" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                                   placeholder="请输入助记码" id="code_auto33"
                                   value="${contract.codeAuto}">
                        </div>


                        <label for="remark" class="col-sm-2 control-label">备注</label>
                        <div class="col-sm-3">
                            <input type="text" class="form-control " style="background-color: #fff" disabled="disabled"
                                   id="remark33"
                                   value="${contract.remark}">

                        </div>
                    </div>

                    <div class="form-group">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
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

                                                    <td><input name="useArea44" type="hidden" value="  useArea  "><input
                                                            value="${b.table3}"
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                            type="number" name="degree44"/></td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="time44" value="${b.table0}" size="16"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>

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
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
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
                                                            value="${b.table3}"
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                            type="number" name="degree55"/></td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="time55" value="${b.table0}" size="16"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>

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
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
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
                                                            value="${b.table3}"
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center"
                                                            type="number" name="degree66"/></td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="time66" value="${b.table0}" size="16"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                            </div>


                        </div>
                    </div>


                    <%--<div class="form-group">--%>
                    <%--<div style="height: 40px;"></div>--%>
                    <%--<div class="panel panel-default     col-sm-10 col-sm-offset-1">--%>
                    <%--<div class="panel-body">--%>
                    <%--<div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">--%>
                    <%--<label for="name" class=" control-label">物业费(金额单位:元)</label>--%>

                    <%--<button type="button" style="float: right;"--%>
                    <%--class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"--%>
                    <%--onclick="addFree77()"> 添加物业费--%>
                    <%--</button>--%>
                    <%--</div>--%>

                    <%--<div class="form-group">--%>
                    <%--<div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">--%>
                    <%--<table class="table">--%>

                    <%--<thead>--%>
                    <%--<tr>--%>
                    <%--<th>起始时间</th>--%>
                    <%--<th>截止时间</th>--%>
                    <%--<th>总价</th>--%>
                    <%--<th>优惠折扣(%)</th>--%>
                    <%--<th>折后总价</th>--%>
                    <%--<th>操作</th>--%>

                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody id="freeTb77">--%>
                    <%--<c:forEach items="${contract.tableList77}" var="b">--%>
                    <%--<tr>--%>


                    <%--<td>--%>
                    <%--<div class="input-group date form_datetime"--%>
                    <%--data-date="1979-09-16T05:25:07Z"--%>
                    <%--data-link-field="startTime">--%>
                    <%--<input onchange="changeDate(this,'s77')" value="${b.table0}"--%>
                    <%--style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"--%>
                    <%--id="${b.table5}s77" name="start77" size="16"--%>
                    <%--type="text" class="form-control" readonly>--%>
                    <%--<span style="height: 30px;display: none;"--%>
                    <%--class="input-group-addon">--%>
                    <%--<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>--%>
                    <%--</td>--%>
                    <%--<td>--%>
                    <%--<div class="input-group date form_datetime"--%>
                    <%--data-date="1979-09-16T05:25:07Z"--%>
                    <%--data-link-field="startTime">--%>
                    <%--<input value="${b.table1}" onchange="changeDate(this,'e77')"--%>
                    <%--style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"--%>
                    <%--id="${b.table5}e77" name="end77" size="16"--%>
                    <%--type="text" class="form-control" readonly>--%>
                    <%--<span style="height: 30px;display: none;"--%>
                    <%--class="input-group-addon">--%>
                    <%--<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>--%>
                    <%--</td>--%>
                    <%--<td><input disabled--%>
                    <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"--%>
                    <%--id="${b.table5}m77" type="number" value="${b.table2}"--%>
                    <%--style="" name="money77"/></td>--%>
                    <%--<td><input onchange="changeMoneyFree(this)"--%>
                    <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"--%>
                    <%--id="${b.table5}d77" type="number" value="${b.table3}"--%>
                    <%--style="" name="discount77"/></td>--%>
                    <%--<td><input disabled--%>
                    <%--style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"--%>
                    <%--id="${b.table5}md77" type="number" value="${b.table4}"--%>
                    <%--style="" name="moneyDis77"/></td>--%>
                    <%--<td nowrap="nowrap"><a onclick="delFree(this)"--%>
                    <%--style="color: #ff0000">删除</a></td>--%>
                    <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--</tbody>--%>
                    <%--</table>--%>
                    <%--</div>--%>
                    <%--</div>--%>


                    <%--</div>--%>


                    <%--</div>--%>
                    <%--</div>--%>

                    <div class="form-group ">
                        <label style="font-size: 20px;" class="col-sm-offset-1 control-label">合计:<span
                                id="total44">0</span>元</label>
                    </div>


                    <div class="form-group">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class=" control-label">催款时间(时间单位:天)</label>

                                    <button type="button" style="float: right;"
                                            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addFree88()"> 添加催款时间
                                    </button>
                                </div>

                                <div class="form-group">
                                    <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>催款起始时间</th>
                                                <th>催款截止时间</th>
                                                <th>提前预警(天)</th>
                                                <th>操作</th>


                                            </tr>
                                            </thead>
                                            <tbody id="freeTb88">
                                            <c:forEach items="${contract.tableList88}" var="b">
                                                <tr>


                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   value="${b.table0}" name="start88" size="16"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>
                                                    <td>
                                                        <div class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime">
                                                            <input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center"
                                                                   name="end88" size="16" value="${b.table1}"
                                                                   type="text" class="form-control" readonly>
                                                            <span style="height: 30px;display: none;"
                                                                  class="input-group-addon">
            <span style="height: 30px;" class="glyphicon glyphicon-th"></span></span></div>
                                                    </td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"
                                                            type="number" value="${b.table2}" style="" name="warn88"/>
                                                    </td>
                                                    <td nowrap="nowrap"><a onclick="delFree(this)"
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
                //- parseFloat($(this).val())
                //f* discount11[index] / 100;
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

        $("input[name='moneyDis77']").each(function (index, item) {
            if ($(this).val() != '') {
                cash1 += parseFloat($(this).val());
            }

        });


        $("#total33").text((parseFloat(total11) + parseFloat(total22)).toFixed(2))
        //$("#cashM").val((parseFloat(cash1) + parseFloat(total11) + parseFloat(total22)).toFixed(2))
        var temp77 = $("#free77md77").val();
        if (temp77 == '') {
            temp77 = 0;
        }

        var money2H = 0;
        $("input[name='money2H']").each(function (index, item) {
            if ($(this).val() != '') {
                money2H += parseFloat($(this).val());
            }

        });

        $("#cashM").val((parseFloat($("#total11").text()) + parseFloat($("#total22").text()) + parseFloat(temp77) + money2H).toFixed(2))


        addFree77();
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

        cash1 = cash1.toFixed(2);
        $("#total44").text(cash1)
    }

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
                $("#customId").val(ui.item.id);
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

    function search(obj) {
        var uid = obj.id + 'u';
        var cid = obj.id + 'c';
        var mid = obj.id + 'm';
        var pid = obj.id + 'p';
        var wid = obj.id + 'w';
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
                                useArea: item.buildArea, // 其他参数， 可以自定义
                                cash: item.cash,
                                // price:item.price,
                                unit: item.unit,
                                linkHouse: item.linkHouse,
                                floor: item.floor,
                                waterNo: item.waterNo,
                                powerNo: item.powerNo,
                                airNo: item.airNo,
                                isWindow: item.isWindow


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
                $("#" + pid).val(ui.item.unit);
                if (ui.item.isWindow == '1') {
                    $("#" + wid).val('是');
                } else {
                    $("#" + wid).val('否');
                }

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
                var mId3 = obj.id + 'm3';

                var dId22 = obj.id + 'd22';
                var mdId22 = obj.id + 'md22';

                var tid = obj.id + 't';
                var tid3 = obj.id + 't3';
                var tid11 = obj.id + 't11';
                var tid44 = obj.id + 't44';
                var tid55 = obj.id + 't55';
                var tid66 = obj.id + 't66';
                var money = ui.item.unit * ui.item.useArea * parseFloat($("#totalDay").text())
                //money = money.toFixed(2);
                $("#" + mid).val(money.toFixed(2))
                //delContactTwo()

                addContact("租金", ui.item.useArea, ui.item.value, ui.item.unit, '元/平方米', money.toFixed(2), rentId, mId2)


                addContactTwo("物业保证金", ui.item.value, ui.item.cash, tid, mId2)

                delContactTotal()
                delFree77();

                addFree77();
                //物业费


                var temp3 = $("#free77md77").val();
                addContactThree("物业费", '', temp3, tid3, mId3);

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
                addWork11(tid11, dId11, mdId11, mId11, ui.item.useArea, money.toFixed(2), '', money.toFixed(2), ui.item.linkHouse, ui.item.floor);
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

        var position = id.lastIndexOf('l');
        var oldId = id;
        id = id.substr(position, id.length);

        //删除租金和押金 物业费
        try {
            var rid = document.getElementById(id.split('a')[0] + "r");
            document.getElementById("contactTb").removeChild(rid);
            var tid = document.getElementById(id.split('a')[0] + "t");
            document.getElementById("contactTb").removeChild(tid);
            var tid3 = document.getElementById(id.split('a')[0] + "t3");
            document.getElementById("contactTb").removeChild(tid3);
        } catch (e) {
            var rid = document.getElementById(oldId.split('a')[0] + "r");
            document.getElementById("contactTb").removeChild(rid);
            var tid = document.getElementById(oldId.split('a')[0] + "t");
            document.getElementById("contactTb").removeChild(tid);
            var tid3 = document.getElementById(oldId.split('a')[0] + "t3");
            document.getElementById("contactTb").removeChild(tid3);
        }
        delFree77();


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
        try {
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
        } catch (e) {
            var tid22 = document.getElementById(oldId.split('a')[0] + "t11");
            document.getElementById("shoppingTb11").removeChild(tid22);

            var rid22 = document.getElementById(oldId.split('a')[0] + "r22");
            document.getElementById("contactTb22").removeChild(rid22);

            //水电费,物业费
            var tid44 = document.getElementById(oldId.split('a')[0] + "t44");
            document.getElementById("waterTb44").removeChild(tid44);

            var tid55 = document.getElementById(oldId.split('a')[0] + "t55");
            document.getElementById("powerTb55").removeChild(tid55);

            var tid66 = document.getElementById(oldId.split('a')[0] + "t66");
            document.getElementById("airTb66").removeChild(tid66);
        }


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
        var wId = lId + 'w';
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
            '<td> <input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" id="' + wId + '" type="text" name="isWindow1"  /></td>' +
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

    function dischange11(obj) {
        console.log(obj.value);
        var discount = parseFloat(obj.value);
        var id = obj.id.split('d11')[0];
        var m = parseFloat($("#" + id + 'm11').val());
        var money = m - m * discount / 100;
        $("#" + id + 'md11').val(money.toFixed(2));

        setTotal1();


    }

    function addWork11(tid, did, mdid, mid, userArea, money, discount, moneyDis, linkHouse, floor) {

        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = tid;


        var line = '<td><input disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="" type="text" value="' + userArea + '"  style="" name="useArea11"  /></td>' +
            '<td><input id="' + mid + '" disabled="disabled"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="text" name="money11"  value="' + money + '"/></td>' +
            '<td><input id="' + did + '"  onchange="dischange11(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center" type="number" name="discount11"  /></td>' +
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
                var t1 = useArea * price * day;
                var t2 = useArea * price * day - useArea * price * day * discount / 100;
                $("#" + m77).val(t1.toFixed(2));
                $("#" + md77).val(t2.toFixed(2));

            }
            setFreeTotal();
        } catch (e) {
            console.log(e)
        }
    }

    function changeDateNew(start77, end77) {
        try {


            var s77Val = $("#" + start77).val();

            var e77Val = $("#" + end77).val();
            var se77 = 's77';

            // if (se77 = 'e77') {
            //     s77Val = $("#" + obj.id.split(se77)[0] + 's77').val();
            //     e77Val = obj.value;
            // }

            var m77 = start77.split(se77)[0] + 'm77';
            var d77 = start77.split(se77)[0] + 'd77';
            var md77 = start77.split(se77)[0] + 'md77';


            var sDate = new Date(s77Val.replace(/-/g, "/"));
            var eDate = new Date(e77Val.replace(/-/g, "/"));
            var days = eDate - sDate;
            var day = parseFloat(days / (1000 * 60 * 60 * 24)+1);

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

            if (!isNaN(day)) {
                var t1 = useArea * price * day;
                var t2 = useArea * price * day - useArea * price * day * discount / 100;
                $("#" + m77).val(t1.toFixed(2));
                $("#" + md77).val(t2.toFixed(2));

            }
            console.log('day:' + day + "," + useArea * price * day + "," + useArea + ',' + price)

            setFreeTotal();
        } catch (e) {
            console.log(e)
        }
    }

    function changeMoneyFree(obj) {
        var money = $("#" + obj.id.split('d77')[0] + 'm77').val();
        var discount = obj.value;
        $("#discount77").val(discount)
        var totalTemp = parseFloat(money) - parseFloat(money) * parseFloat(discount) / 100;

        $("#" + obj.id.split('d77')[0] + 'md77').val(totalTemp.toFixed(2));
        $("#" + obj.id).val(discount);

        // $("#free77md77").val(totalTemp.toFixed(2));
        setTotal1();
        setFreeTotal();

    }

    function addFree77() {
        $("#freeTb77").html('');
        //loadStyle('https://cdn.bootcss.com/bootstrap-datepicker/1.8.0/css/bootstrap-datepicker3.min.css')
        var trObj = document.createElement("tr");
        trObj.id = 'free77';
        var s77 = trObj.id + 's77';
        var e77 = trObj.id + 'e77';
        var m77 = trObj.id + 'm77';
        var d77 = trObj.id + 'd77';
        var md77 = trObj.id + 'md77';
        var start = 's77';
        var end = 'e77';
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();

        var start77 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input disabled value="' + startDate + '"  onchange="changeDate(this,\'s77\')" style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" id="' + s77 + '" name="start77" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var end77 = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
            '<input disabled value="' + endDate + '" onchange="changeDate(this,\'e77\')" style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" id="' + e77 + '"  name="end77" size="16" type="text" class="form-control"  readonly > ' +
            '<span style="height: 30px;display: none;" class="input-group-addon">' +
            '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
        var line =
            '<td>' + start77 + '</td>' +
            '<td>' + end77 + '</td>' +
            '<td><input disabled  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + m77 + '" type="number" value=""  style="" name="money77"  /></td>' +
            '<td><input  onchange="changeMoneyFree(this)"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + d77 + '" type="number" value=""  style="" name="discount77"  /></td>' +
            '<td><input disabled  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;border-radius:0;text-align:center;"  id="' + md77 + '" type="number" value=""  style="" name="moneyDis77"  /></td>' +
            '<td style="display: none" nowrap="nowrap"><a   onclick="delFree(this)" style="color: #ff0000">删除</a></td>'

        trObj.innerHTML = line;
        document.getElementById("freeTb77").appendChild(trObj);
        $("#" + d77).val($("#discount77").val());

        changeDateNew(s77, e77);
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
            '<td><input   onchange="dischange22(this)"   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="' + did + '" value="" type="number" name="discount22"  /></td>' +
            '<td>' + time + '</td>'


        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("contactTb22").appendChild(trObj);

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

    function addContactThree(rent, loc, money, tid, mid2) {
        var trObj = document.createElement("tr");
        trObj.id = 'free773';

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

    function delFree77() {
        try {
            var obj = document.getElementById("free773");
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

    function modify() {


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
        var house1 = $("#house1").is(':checked')
        var house2 = $("#house2").is(':checked')
        var house3 = $("#house3").is(':checked')
        var explain = $("#explain").val();
        var customId = $("#customId").val();
        var cashM = $("#cashM").val();
        var main = code_auto + flag2 + remark + flag2 + linkMan + flag2 + phone + flag2 + startDate + flag2 + endDate + flag2 + warnDay + flag2 + code + flag2 + type + flag2 + house1 + flag2 + house2 + flag2 + house3 + flag2 + userName + flag2 + explain + flag2 + customId + flag2 + cashM;

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
        var isWindow1 = "";
        $("select[name='isWindow1']").each(function (index, item) {
            var temp = '';
            if ($(this).val() == '是') {
                temp = '1';
            } else {
                temp = '0';
            }
            isWindow1 += temp + flag1;

        });

        table1 = id1 + flag2 + loc1 + flag2 + time1 + flag2 + useArea1 + flag2 + cash1 + flag2 + money1 + flag2 + price1 + flag2 + goodsStatus1 + flag2 + isWindow1;


        var table2 = '';
        var name2 = '';
        var id2 = '';
        $("input[name='name2']").each(function (index, item) {
            name2 += $(this).val() + flag1;

        });
        var useArea2 = '';
        $("input[name='useArea2']").each(function (index, item) {
            useArea2 += $(this).val() + flag1;
        });
        var loc2 = '';
        $("input[name='loc2']").each(function (index, item) {
            loc2 += $(this).val() + flag1;
        });
        var price2 = '';
        $("input[name='price2']").each(function (index, item) {
            price2 += $(this).val() + flag1;
        });
        var unit2 = '';
        $("input[name='unit2']").each(function (index, item) {
            unit2 += $(this).val() + flag1;
        });
        var money2 = '';
        $("input[name='money2']").each(function (index, item) {
            money2 += $(this).val() + flag1;
            id2 += item.id + flag1;
        });
        table2 = id2 + flag2 + name2 + flag2 + useArea2 + flag2 + loc2 + flag2 + price2 + flag2 + unit2 + flag2 + money2;

        var table3 = '';
        var name3 = '';
        $("input[name='name3']").each(function (index, item) {
            name3 += $(this).val() + flag1;
        });
        var price3 = '';
        $("input[name='price3']").each(function (index, item) {
            price3 += $(this).val() + flag1;
        });
        var unit3 = '';
        $("input[name='unit3']").each(function (index, item) {
            unit3 += $(this).val() + flag1;
        });
        table3 = name3 + flag2 + price3 + flag2 + unit3;

        var table2H = '';
        var name2H = '';
        $("input[name='name2H']").each(function (index, item) {
            name2H += $(this).val() + flag1;
        });
        var useArea2H = '';
        $("input[name='useArea2H']").each(function (index, item) {
            useArea2H += $(this).val() + flag1;
        });
        var loc2H = '';
        $("input[name='loc2H']").each(function (index, item) {
            loc2H += $(this).val() + flag1;
        });
        var price2H = '';
        $("input[name='price2H']").each(function (index, item) {
            price2H += $(this).val() + flag1;
        });
        var unit2H = '';
        $("input[name='unit2H']").each(function (index, item) {
            unit2H += $(this).val() + flag1;
        });
        var money2H = '';
        $("input[name='money2H']").each(function (index, item) {
            money2H += $(this).val() + flag1;
        });
        table2H = name2H + flag2 + unit2H + flag2 + loc2H + flag2 + price2H + flag2 + unit2H + flag2 + money2H;


        var useArea11 = '';
        var table11 = '';
        $("input[name='useArea11']").each(function (index, item) {
            useArea11 += $(this).val() + flag1;
        });
        var money11 = '';
        $("input[name='money11']").each(function (index, item) {
            money11 += $(this).val() + flag1;
        });
        var discount11 = '';
        $("input[name='discount11']").each(function (index, item) {
            discount11 += $(this).val() + flag1;
        });
        var moneyDis11 = '';
        $("input[name='moneyDis11']").each(function (index, item) {
            moneyDis11 += $(this).val() + flag1;
        });
        var linkHouse11 = '';
        $("input[name='linkHouse11']").each(function (index, item) {
            linkHouse11 += $(this).val() + flag1;
        });
        var floor11 = '';
        $("input[name='floor11']").each(function (index, item) {
            floor11 += $(this).val() + flag1;
        });
        table11 = useArea11 + flag2 + money11 + flag2 + discount11 + flag2 + moneyDis11 + flag2 + linkHouse11 + flag2 + floor11;

        var table22 = '';
        var time22 = '';
        $("input[name='time22']").each(function (index, item) {
            time22 += $(this).val() + flag1;
        });
        var loc22 = '';
        $("input[name='loc22']").each(function (index, item) {
            loc22 += $(this).val() + flag1;
        });
        var money22 = '';
        $("input[name='money22']").each(function (index, item) {
            money22 += $(this).val() + flag1;
        });
        var discount22 = '';
        $("input[name='discount22']").each(function (index, item) {
            discount22 += $(this).val() + flag1;
        });
        table22 = time22 + flag2 + loc22 + flag2 + money22 + flag2 + discount22;


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

        var table44 = '';
        var time44 = '';
        $("input[name='time44']").each(function (index, item) {
            time44 += $(this).val() + flag1;
        });
        var no44 = '';
        $("input[name='no44']").each(function (index, item) {
            no44 += $(this).val() + flag1;
        });
        var loc44 = '';
        $("input[name='loc44']").each(function (index, item) {
            loc44 += $(this).val() + flag1;
        });
        var degree44 = '';
        $("input[name='degree44']").each(function (index, item) {
            degree44 += $(this).val() + flag1;
        });
        table44 = time44 + flag2 + no44 + flag2 + loc44 + flag2 + degree44;

        var table55 = '';
        var time55 = '';
        $("input[name='time55']").each(function (index, item) {
            time55 += $(this).val() + flag1;
        });
        var no55 = '';
        $("input[name='no55']").each(function (index, item) {
            no55 += $(this).val() + flag1;
        });
        var loc55 = '';
        $("input[name='loc55']").each(function (index, item) {
            loc55 += $(this).val() + flag1;
        });
        var degree55 = '';
        $("input[name='degree55']").each(function (index, item) {
            degree55 += $(this).val() + flag1;
        });
        table55 = time55 + flag2 + no55 + flag2 + loc55 + flag2 + degree55;

        var table66 = '';
        var time66 = '';
        $("input[name='time66']").each(function (index, item) {
            time66 += $(this).val() + flag1;
        });
        var no66 = '';
        $("input[name='no66']").each(function (index, item) {
            no66 += $(this).val() + flag1;
        });
        var loc66 = '';
        $("input[name='loc66']").each(function (index, item) {
            loc66 += $(this).val() + flag1;
        });
        var degree66 = '';
        $("input[name='degree66']").each(function (index, item) {
            degree66 += $(this).val() + flag1;
        });
        table66 = time66 + flag2 + no66 + flag2 + loc66 + flag2 + degree66;


        var table77 = '';
        var start77 = '';
        $("input[name='start77']").each(function (index, item) {
            start77 += $(this).val() + flag1;
        });
        var end77 = '';
        $("input[name='end77']").each(function (index, item) {
            end77 += $(this).val() + flag1;
        });
        var money77 = '';
        $("input[name='money77']").each(function (index, item) {
            money77 += $(this).val() + flag1;
        });
        var discount77 = '';
        $("input[name='discount77']").each(function (index, item) {
            discount77 += $(this).val() + flag1;
        });
        var moneyDis77 = '';
        $("input[name='moneyDis77']").each(function (index, item) {
            moneyDis77 += $(this).val() + flag1;
        });
        table77 = start77 + flag2 + end77 + flag2 + money77 + flag2 + discount77 + flag2 + moneyDis77;


        var table88 = '';
        var start88 = '';
        $("input[name='start88']").each(function (index, item) {
            start88 += $(this).val() + flag1;
        });
        var end88 = '';
        $("input[name='end88']").each(function (index, item) {
            end88 += $(this).val() + flag1;
        });
        var warn88 = '';
        $("input[name='warn88']").each(function (index, item) {
            warn88 += $(this).val() + flag1;
        });
        table88 = start88 + flag2 + end88 + flag2 + warn88;
        //worker

        table2 = table2.replace(/\//g, 'fantasy');
        table3 = table3.replace(/\//g, 'fantasy');

        console.log('table3' + table3)
        var type = '${type}';
        var uuid = '${contract.uuid}';


        if (code_auto == '') {
            mui.toast('请输入客户名称', {duration: 'short', type: 'div'})
            return;
        }
        if (loc1 == '') {
            mui.toast('请输入房源', {duration: 'short', type: 'div'})
            return;
        }
        var isOk = '${contract.isOk}';
        var isPay = '${contract.isPay}';
        if (isOk == -1 && isPay == 0) {
            $("#confirmId").attr("disabled", "disabled");
            var url = "/seckill/contract_house/" + uuid + "/" + main + "/" + table1
                + "/" + table2 + "/" + table2H + "/" + table3 + "/" + table11 + "/" + table22 + "/" + table33 + "/" + table44 + "/" + table55 + "/" + table66 + "/" + table77 + "/" + table88 + "/update";

        } else {
            var url = "/seckill/contract_house/" + main + "/" + table1
                + "/" + table2 + "/" + table2H + "/" + table3 + "/" + table11 + "/" + table22 + "/" + table33 + "/" + table44 + "/" + table55 + "/" + table66 + "/" + table77 + "/" + table88 + "/insert";

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
            $("#confirmId").removeAttr("disabled");
        });


    }
</script>
</html>