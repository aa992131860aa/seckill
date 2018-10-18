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
    <%--<link href="/seckill/resources/css/print_css.css" rel="stylesheet" type="text/css" media="print"/>--%>
</head>

<body>

<header class="mui-bar mui-bar-nav">
    <a onclick="back()" class="  mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">应收款汇总表</h1>


    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>

    <button type="button" style="float: right;margin-right: 50px"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="skipAll()"> 打印界面
    </button>
</header>
<div class="mui-content">

    <div id="a4" style="height: 297mm;width: 210mm;display: none">
        A4纸的尺寸是210*297mm
    </div>

    <div class="form-inline" style="margin-top: 20px">

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">
            <label for="code" style="display: inline" class="form-label">客户助记码查询</label>
            <input style="display: inline;height: 30px;" type="text" value="${code}" class="form-control input-sm"
                   id="code">

        </div>

        <div style="margin-left: 30px;margin-right: 30px;" class=" form-group">

            <label for="startDate" style="display: inline" class="form-label">时间区间查询</label>

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
                <%--<th>总金额</th>--%>
                <th>应收金额</th>
                <%--<th>应付金额</th>--%>
                <th>合同号</th>
                <th>合同创建时间</th>
                <%--<th>类型</th>--%>
                <th>详情</th>
                <%--<th style="color: #1d4499" onclick="printContract()">打印</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${contractList}" var="cList">
                <tr>

                    <td>${cList.id}</td>

                    <td>${cList.codeAuto} ${cList.remark}</td>
                        <%--<td>${list.payTotal}</td>--%>
                    <td>${cList.payTableMMinus}</td>
                        <%--<td>${-list.payTableMMinus}</td>--%>
                    <td>${cList.no}</td>
                    <td>${cList.createTime.split(' ')[0]}</td>
                        <%--<td>--%>

                        <%--<c:choose>--%>
                        <%--<c:when test="${list.isWater==1}">--%>
                        <%--物业水电费结算--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${list.isFinish==1}">--%>
                        <%--终止合同已核销--%>
                        <%--</c:when>--%>
                        <%--<c:when test="${list.isPay==1}">--%>
                        <%--终止合同结算--%>
                        <%--</c:when>--%>

                        <%--<c:otherwise>--%>
                        <%--正常合同--%>
                        <%--</c:otherwise>--%>
                        <%--</c:choose>--%>

                        <%--</td>--%>
                    <td>
                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('续签')}"> display: none </c:if>
                        </c:otherwise>
                        </c:choose>;color: #1d4499"
                           onclick="updateContract('${cList.codeAuto}','${cList.remark}','${cList.customId}')">详情 </a> |

                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('续签')}"> display: none </c:if>
                        </c:otherwise>
                        </c:choose>;color: #1d4499" onclick="preview(1,'p${cList.id}')"
                        >打印 </a>
                            <%--|--%>
                            <%--<a style="--%>
                            <%--<c:choose>--%>
                            <%--<c:when test="${is_admin=='1'}"></c:when>--%>
                            <%--<c:otherwise>--%>
                            <%--<c:if--%>
                            <%--test="${!role4.contains('续签')}"> display: none </c:if>--%>
                            <%--</c:otherwise>--%>
                            <%--</c:choose>;color: #1d4499"--%>
                            <%-->导出Excel </a>--%>


                    </td>
                        <%--<td>--%>

                        <%--<input style="width: 20px;height: 20px;" class="checkboxSelect" name="checkbox" id="house3" value="${list.id}"--%>
                        <%--type="checkbox">--%>


                        <%--</td>--%>
                </tr>


            </c:forEach>

            <tr>
                <td>总计</td>

                <td></td>
                <%--<td>${list.payTotal}</td>--%>
                <td>${payTableMinusTotal}</td>
                <%--<td>${-list.payTableMMinus}</td>--%>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    </div>
    <c:forEach items="${contractList}" var="cList">
        <table id="p${cList.id}" style="display: none">
            <tr>
                <td>
                    <div class="modal-body" style="overflow:auto;">
                        <h4 class="modal-title" style="text-align: center" id="myModalLabel">
                                ${cList.codeAuto}应收明细(对账单) &nbsp;&nbsp;&nbsp;&nbsp;单位:元 &nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${cList.remark!=''}">备注:${cList.remark}</c:if>
                        </h4>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                            <c:if test="${list.style=='house'}">

                                <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                    <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-租金').concat('fantasy'))}">

                                        <c:if test="${houseRent!=0}">
                                            <div class="form-group col-md-11 col-xs-11"
                                                 style="margin-top: 0%;margin-left: 2%;">
                                                <label for="name"
                                                       class="control-label">房源租金明细</label>

                                            </div>
                                            <c:set var="houseRent" value="0"></c:set>

                                        </c:if>

                                    </c:if>


                                </c:forEach>
                            </c:if>
                        </c:forEach>


                        <div class="form-group" id="house" >
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>
                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='house'}">

                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-租金').concat('fantasy'))}">

                                                    <c:if test="${houseRent!=0}">
                                                        <tr>
                                                            <th>合同号</th>
                                                            <th>位置编号</th>
                                                            <th>使用面积</th>
                                                            <th>天数</th>
                                                            <th>单价</th>

                                                                <%--<th>年总价</th>--%>
                                                            <th>折扣</th>
                                                                <%--<th>折扣总价</th>--%>
                                                                <%--<th>关联房号</th>--%>
                                                            <th>楼层</th>
                                                            <th>收费期间</th>
                                                            <th>合计总价</th>

                                                                <%--<th>本期收费金额合计</th>--%>
                                                        </tr>
                                                        <c:set var="houseRent" value="0"></c:set>

                                                    </c:if>


                                                </c:if>


                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='house'}">
                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">
                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-租金').concat('fantasy'))}">
                                                    <tr>


                                                        <td>
                                                                ${list.no}
                                                        </td>

                                                        <td>${t.table1}</td>
                                                        <td>${t.table3}</td>
                                                        <td> ${list.day}</td>
                                                        <td>${list.tableList1[loop.index].table6}</td>
                                                            <%--<td>${list.tableList11[loop.index].table1}</td>--%>
                                                        <td>${list.tableList11[loop.index].table2}</td>
                                                            <%--<td>${list.tableList11[loop.index].table3}</td>--%>


                                                        <td>${t.table1.split('-')[0]}</td>

                                                        <td>${list.startDate} ${list.endDate}</td>

                                                        <td>${list.tableList11[loop.index].table3}</td>


                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                            <c:if test="${list.style=='house'}">

                                <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                    <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业保证金').concat('fantasy'))}">

                                        <c:if test="${houseRent!=0}">
                                            <div class="form-group col-md-11 col-xs-11"
                                                 style="margin-top: -30px;margin-left: 2%;">
                                                <label for="name"
                                                       class="control-label">物业保证金</label>

                                            </div>
                                            <c:set var="houseRent" value="0"></c:set>

                                        </c:if>

                                    </c:if>


                                </c:forEach>
                            </c:if>
                        </c:forEach>

                        <div class="form-group" id="cash" >
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>
                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='house'}">

                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业保证金').concat('fantasy'))}">

                                                    <c:if test="${houseRent!=0}">
                                                        <tr>
                                                            <th>合同号</th>
                                                            <th>位置编号</th>
                                                                <%--<th>保证金年总价(元)</th>--%>
                                                            <th>折扣(%)</th>
                                                            <th>收费期间</th>
                                                            <th>合计总价</th>

                                                        </tr>
                                                        <c:set var="houseRent" value="0"></c:set>

                                                    </c:if>


                                                </c:if>


                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">
                                        <c:if test="${list.style=='house'}">
                                            <c:forEach items="${list.tableList22}" var="t" varStatus="loop">
                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业保证金').concat('fantasy'))}">
                                                    <tr>
                                                        <td> ${list.no}</td>
                                                        <td> ${t.table1}</td>
                                                            <%--<td>${t.table2}</td>--%>
                                                        <td>${t.table3}</td>
                                                        <td>${list.startDate} ${list.endDate}</td>
                                                        <td>${t.table5}</td>


                                                    </tr>
                                                </c:if>

                                            </c:forEach>


                                        </c:if>

                                    </c:forEach>

                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                            <c:if test="${list.style=='house'}">

                                <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                    <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业费').concat('fantasy'))}">

                                        <c:if test="${houseRent!=0}">
                                            <div class="form-group col-md-11 col-xs-11"
                                                 style="margin-top: -30px;margin-left: 2%;">
                                                <label for="name"
                                                       class="control-label">物业费明细</label>

                                            </div>
                                            <c:set var="houseRent" value="0"></c:set>

                                        </c:if>

                                    </c:if>


                                </c:forEach>
                            </c:if>
                        </c:forEach>


                        <div class="form-group" id="property">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>
                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='house'}">

                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业费').concat('fantasy'))}">

                                                    <c:if test="${houseRent!=0}">
                                                        <tr>
                                                            <th>合同号</th>
                                                            <th>位置编号</th>
                                                                <%--<th>年总价(元)</th>--%>
                                                            <th>天数</th>
                                                            <th>单价</th>
                                                            <th>优惠折扣(%)</th>
                                                            <th>收费期间</th>
                                                            <th>折后总价</th>
                                                        </tr>
                                                        <c:set var="houseRent" value="0"></c:set>

                                                    </c:if>


                                                </c:if>


                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">
                                        <c:if test="${list.style=='house'}">
                                            <c:forEach items="${list.tableList77}" var="t" varStatus="loop">
                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('房源-物业费').concat('fantasy'))}">
                                                    <tr>

                                                        <td>${list.no}</td>
                                                        <td>${list.tableList1[loop.index].table1}</td>
                                                        <td>${list.day}</td>
                                                        <td>${t.table10}</td>
                                                            <%--<td>${t.table2}</td>--%>
                                                        <td>${t.table3}</td>

                                                        <td>${list.startDate} ${list.endDate}</td>
                                                        <td>${t.table4}</td>

                                                    </tr>
                                                </c:if>

                                            </c:forEach>


                                        </c:if>

                                    </c:forEach>

                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list">

                            <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                <c:if test="${t.name=='水费'&&!cList.tableU.contains(''.concat(list.no).concat('水费').concat('fantasy'))}">

                                    <c:if test="${houseRent!=0}">
                                        <div class="form-group col-md-11 col-xs-11"
                                             style="margin-top: -30px;margin-left: 2%;">
                                            <label for="name"
                                                   class="control-label">水费明细</label>

                                        </div>
                                        <c:set var="houseRent" value="0"></c:set>

                                    </c:if>

                                </c:if>


                            </c:forEach>

                        </c:forEach>

                        <div class="form-group" id="water">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">

                                    <thead>

                                    <c:set var="houseRent" value="-1"></c:set>

                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='水费'&&!cList.tableU.contains(''.concat(list.no).concat('水费').concat('fantasy'))}">


                                                <c:if test="${houseRent!=0}">
                                                    <tr>
                                                        <th>合同号</th>
                                                        <th>水表编号</th>
                                                        <th>位置编号</th>
                                                        <th>上期抄表</th>
                                                        <th>本期抄表</th>
                                                        <th>度数</th>
                                                        <th>单价</th>
                                                        <th>金额小计</th>

                                                    </tr>
                                                    <c:set var="houseRent" value="0"></c:set>


                                                </c:if>

                                            </c:if>
                                        </c:forEach>

                                    </c:forEach>


                                    </thead>
                                    <tbody id="payTb">
                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='水费'&&!cList.tableU.contains(''.concat(list.no).concat('水费').concat('fantasy'))}">
                                                <tr>

                                                    <td>${list.no}</td>
                                                    <td>${t.no}</td>
                                                    <td>${t.loc}</td>
                                                    <td>${t.lastDegree}</td>
                                                    <td>${t.degree}</td>
                                                    <td>${t.useDegree}</td>
                                                    <td>${t.price}</td>
                                                    <td>${t.total}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>


                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list">

                            <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                <c:if test="${t.name=='电费'&&!cList.tableU.contains(''.concat(list.no).concat('电费').concat('fantasy'))}">

                                    <c:if test="${houseRent!=0}">
                                        <div class="form-group col-md-11 col-xs-11"
                                             style="margin-top: -30px;margin-left: 2%;">
                                            <label for="name"
                                                   class="control-label">电费明细</label>

                                        </div>
                                        <c:set var="houseRent" value="0"></c:set>

                                    </c:if>

                                </c:if>


                            </c:forEach>

                        </c:forEach>

                        <div class="form-group" id="power">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>

                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='电费'&&!cList.tableU.contains(''.concat(list.no).concat('电费').concat('fantasy'))}">


                                                <c:if test="${houseRent!=0}">
                                                    <tr>
                                                        <th>合同号</th>
                                                        <th>电表编号</th>
                                                        <th>位置编号</th>
                                                        <th>上期抄表</th>
                                                        <th>本期抄表</th>
                                                        <th>度数</th>
                                                        <th>单价</th>
                                                        <th>金额小计</th>

                                                    </tr>
                                                    <c:set var="houseRent" value="0"></c:set>


                                                </c:if>

                                            </c:if>
                                        </c:forEach>

                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='电费'&&!cList.tableU.contains(''.concat(list.no).concat('电费').concat('fantasy'))}">
                                                <tr>

                                                    <td>${list.no}</td>
                                                    <td>${t.no}</td>
                                                    <td>${t.loc}</td>
                                                    <td>${t.lastDegree}</td>
                                                    <td>${t.degree}</td>
                                                    <td>${t.useDegree}</td>
                                                    <td>${t.price}</td>
                                                    <td>${t.total}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>


                                    </c:forEach>

                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list">

                            <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                <c:if test="${t.name=='空调费'&&!cList.tableU.contains(''.concat(list.no).concat('空调费').concat('fantasy'))}">

                                    <c:if test="${houseRent!=0}">
                                        <div class="form-group col-md-11 col-xs-11"
                                             style="margin-top: -30px;margin-left: 2%;">
                                            <label for="name"
                                                   class="control-label">空调费明细</label>

                                        </div>
                                        <c:set var="houseRent" value="0"></c:set>

                                    </c:if>

                                </c:if>


                            </c:forEach>

                        </c:forEach>

                        <div class="form-group" id="air">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>

                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='空调费'&&!cList.tableU.contains(''.concat(list.no).concat('空调费').concat('fantasy'))}">


                                                <c:if test="${houseRent!=0}">
                                                    <tr>
                                                        <th>合同号</th>
                                                        <th>空调表编号</th>
                                                        <th>位置编号</th>
                                                        <th>上期抄表</th>
                                                        <th>本期抄表</th>
                                                        <th>度数</th>
                                                        <th>单价</th>
                                                        <th>金额小计</th>

                                                    </tr>
                                                    <c:set var="houseRent" value="0"></c:set>


                                                </c:if>

                                            </c:if>
                                        </c:forEach>

                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">

                                        <c:forEach items="${list.adTempList}" var="t" varStatus="loop">

                                            <c:if test="${t.name=='空调费'&&!cList.tableU.contains(''.concat(list.no).concat('空调费').concat('fantasy'))}">
                                                <tr>

                                                    <td>${list.no}</td>
                                                    <td>${t.no}</td>
                                                    <td>${t.loc}</td>
                                                    <td>${t.lastDegree}</td>
                                                    <td>${t.degree}</td>
                                                    <td>${t.useDegree}</td>
                                                    <td>${t.price}</td>
                                                    <td>${t.total}</td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>


                                    </c:forEach>

                                </table>
                            </div>
                        </div>


                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                            <c:if test="${list.style=='ad'}">

                                <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                    <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('广告-租金').concat('fantasy'))}">

                                        <c:if test="${houseRent!=0}">
                                            <div class="form-group col-md-11 col-xs-11"
                                                 style="margin-top: -30px;margin-left: 2%;">
                                                <label for="name"
                                                       class="control-label">广告费明细</label>

                                            </div>
                                            <c:set var="houseRent" value="0"></c:set>

                                        </c:if>

                                    </c:if>


                                </c:forEach>
                            </c:if>
                        </c:forEach>

                        <div class="form-group" id="ad">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 0px">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>
                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='ad'}">

                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('广告-租金').concat('fantasy'))}">

                                                    <c:if test="${houseRent!=0}">
                                                        <tr>
                                                            <th>合同号</th>
                                                            <th>位置编号</th>
                                                            <th>天数</th>
                                                                <%--<th>单价</th>--%>
                                                            <th>楼层</th>
                                                                <%--<th>年总价(元)</th>--%>
                                                            <th>广告位类型</th>
                                                            <th>收费期间</th>
                                                            <th>金额小计</th>

                                                        </tr>
                                                        <c:set var="houseRent" value="0"></c:set>

                                                    </c:if>


                                                </c:if>


                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">
                                        <c:if test="${list.style=='ad'}">
                                            <c:forEach items="${list.tableList11}" var="t" varStatus="loop">
                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('广告-租金').concat('fantasy'))}">
                                                    <tr>

                                                        <td>${list.no}</td>
                                                        <td>${t.table0}</td>
                                                        <td>${list.day}</td>
                                                            <%--<td>${list.tableList1[loop.index].table6}</td>--%>
                                                        <td>${t.table1}</td>
                                                            <%--<td>${t.table2}</td>--%>
                                                        <td>${t.table3}</td>

                                                        <td>${list.startDate} ${list.endDate}</td>
                                                        <td>${t.table2}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>


                                        </c:if>

                                    </c:forEach>

                                </table>
                            </div>
                        </div>

                        <c:set var="houseRent" value="-1"></c:set>
                        <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                            <c:if test="${list.style=='car'}">

                                <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                    <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('车位-租金').concat('fantasy'))}">

                                        <c:if test="${houseRent!=0}">
                                            <div class="form-group col-md-11 col-xs-11"
                                                 style="margin-top: -30px;margin-left: 2%;">
                                                <label for="name"
                                                       class="control-label">车位费明细</label>

                                            </div>
                                            <c:set var="houseRent" value="0"></c:set>

                                        </c:if>

                                    </c:if>


                                </c:forEach>
                            </c:if>
                        </c:forEach>

                        <div class="form-group" id="car">
                            <div class="table-responsive col-md-12" style="margin-top: 0px;">
                                <table class="table">


                                    <c:set var="houseRent" value="-1"></c:set>
                                    <c:forEach items="${cList.contractDetailList}" var="list" varStatus="pLoop">
                                        <c:if test="${list.style=='car'}">

                                            <c:forEach items="${list.tableList1}" var="t" varStatus="loop">

                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('车位-租金').concat('fantasy'))}">

                                                    <c:if test="${houseRent!=0}">
                                                        <tr>
                                                            <th>合同号</th>
                                                            <th>位置编号</th>
                                                            <th>天数</th>
                                                                <%--<th>年总价(元)</th>--%>
                                                            <th>车位类型</th>
                                                            <th>车牌</th>
                                                            <th>联系人</th>
                                                            <th>收费期间</th>
                                                            <th>金额小计</th>

                                                        </tr>
                                                        <c:set var="houseRent" value="0"></c:set>

                                                    </c:if>


                                                </c:if>


                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>


                                    <c:forEach items="${cList.contractDetailList}" var="list">
                                        <c:if test="${list.style=='car'}">
                                            <c:forEach items="${list.tableList11}" var="t" varStatus="loop">
                                                <c:if test="${!cList.tableU.contains(''.concat(list.no).concat('车位-租金').concat('fantasy'))}">
                                                    <tr>
                                                        <td>${list.no}</td>

                                                        <td>${t.table0}</td>
                                                        <td>${list.day}</td>
                                                            <%--<td>${t.table2}</td>--%>
                                                        <td>${t.table3}</td>

                                                        <td>${list.tableList1[loop.index].table11}</td>
                                                        <td>${list.tableList1[loop.index].table8}</td>
                                                        <td>${list.startDate} ${list.endDate}</td>
                                                        <td>${t.table2}</td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>


                                        </c:if>

                                    </c:forEach>

                                </table>
                            </div>
                        </div>

                        <c:if test="${cList.contractDetailList[0].tableList2H.size()>0}">


                            <div class="form-group col-md-11 col-xs-11"
                                 style="margin-top: 0%;margin-left: 2%;">
                                <label for="name" class="control-label">其他费用</label>

                            </div>

                            <div class="form-group">
                                <div class="table-responsive col-md-12"
                                     style="clear: both;margin-top: 0px;">
                                    <table class="table">

                                        <thead>
                                        <tr>
                                            <th>合同号</th>
                                            <th>名称</th>
                                            <th>金额</th>


                                        </tr>
                                        </thead>
                                        <tbody id="payTb">
                                        <c:forEach items="${cList.contractDetailList}" var="list">
                                            <c:if test="${list.style=='house'}">
                                                <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                                    <tr>
                                                        <td>${list.no}</td>

                                                        <td>房源-${t.table0}</td>
                                                        <td>${t.table5}</td>
                                                    </tr>

                                                </c:forEach>


                                            </c:if>

                                            <c:if test="${list.style=='ad'}">
                                                <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                                    <tr>
                                                        <td>${list.no}</td>

                                                        <td>广告-${t.table0}</td>
                                                        <td>${t.table5}</td>
                                                    </tr>

                                                </c:forEach>


                                            </c:if>

                                            <c:if test="${list.style=='car'}">
                                                <c:forEach items="${list.tableList2H}" var="t" varStatus="loop">

                                                    <tr>
                                                        <td>${list.no}</td>

                                                        <td>车位-${t.table0}</td>
                                                        <td>${t.table5}</td>
                                                    </tr>

                                                </c:forEach>


                                            </c:if>

                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>

                        <div class="form-group">
                                <%--<label class="control-lable ">本次应收金额:<span id="total1"--%>
                                <%--style="">${allTotal}</span>元</label>--%>
                                <%--&lt;%&ndash;<label class="control-lable col-sm-offset-1">截止日期:2018-09-09</label>&ndash;%&gt;--%>
                                <%--<label class="control-lable col-sm-offset-1">违约金:</label><input--%>
                                <%--style="width: 200px;" id="debt"--%>
                                <%--value="${debt}"--%>
                                <%--onchange="changeDebt()"--%>
                                <%--type="number">--%>
                            <label style="float: right"
                                   class="control-lable col-sm-offset-1">欠费合计:${cList.payTableMMinus}元</label>

                        </div>
                    </div>
                </td>
            </tr>


        </table>
    </c:forEach>

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

<!--startprint1-->

<!--打印内容开始-->
<div id="sty" style="display:none;">
    打印区域adasda
</div>
<!--打印内容结束-->

<!--endprint1-->

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

                $(window).attr('location', '/seckill/handle_receivable/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + startDate + '/' + endDate);

            } else {

                $(window).attr('location', '/seckill/handle_receivable/' + userId + '/' + (params.pageNum - 1));

            }


        })


    });

    function test() {
        var height = $("#a4").height();

    }

    function back() {
        var page = parseInt($("#page").val()) + 1;
        var p = -page;

        window.history.go(-1)

    }

    function skipAll() {
        //handle_receivable_all/{userId}/{page}/{houseCheck}/{cashCheck}/{propertyCheck}/{adCheck}/{carCheck}/{waterCheck}/{powerCheck}/{airCheck}/{allCheck}/{codeCheck}/{locCheck}
        var url = "/seckill/handle_receivable_all/0/0/false/false/false/false/false/false/false/false/true/true/false/false"
        mui.openWindow({
            url: url

        })
    }

    function preview(oper, pid) {


        var house = $("#house").html();
        if (house.indexOf("合同号") == -1) {
            $("#house").hide();
        }

        var cash = $("#cash").html();
        if (cash.indexOf("合同号") == -1) {
            $("#cash").hide();
        }
        var property = $("#property").html();
        if (property.indexOf("合同号") == -1) {
            $("#property").hide();
        }
        var water = $("#water").html();
        if (water.indexOf("合同号") == -1) {
            $("#water").hide();
        }
        var power = $("#power").html();
        if (power.indexOf("合同号") == -1) {
            $("#power").hide();
        }
        var air = $("#air").html();
        if (air.indexOf("合同号") == -1) {
            $("#air").hide();
        }
        var ad = $("#ad").html();
        if (ad.indexOf("合同号") == -1) {
            $("#ad").hide();
        }
        var car = $("#car").html();
        if (car.indexOf("合同号") == -1) {
            $("#car").hide();
        }


        if (oper < 10) {
            var bdhtml = window.document.body.innerHTML;//获取当前页的html代码

            window.document.body.innerHTML = $("#" + pid).html();
            window.print();
            window.document.body.innerHTML = bdhtml;


        } else {
            window.print();
        }
    }

    //设置网页打印的页眉页脚为空
    var hkey_root, hkey_path, hkey_key
    hkey_root = "HKEY_CURRENT_USER"
    hkey_path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"


    function pagesetup_null() {
        try {
            var RegWsh = new ActiveXObject("WScript.Shell")
            hkey_key = "header"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
            hkey_key = "footer"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "")
        } catch (e) {
        }
    }

    //设置网页打印的页眉页脚为默认值
    function pagesetup_default() {
        try {
            var RegWsh = new ActiveXObject("WScript.Shell")
            hkey_key = "header"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&w&b页码，&p/&P")
            hkey_key = "footer"
            RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "&u&b&d")
        } catch (e) {
        }
    }


    function updateContract(codeAuto, remark, id) {
        if (remark == '') {
            remark = 'fantasy';
        }
        var url = "/seckill/handle_receivable_detail/" + codeAuto + "/" + remark + "/" + userId + "/" + id + "/update";
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
        // if (code == '' && startDate == '' && endDate == '') {
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
        var url = "/seckill/handle_receivable/" + userId + '/0/' + code + '/' + startDate + '/' + endDate;
        mui.openWindow({
            url: url

        })
        // }
    }

    function printContract() {
        $.each($('input:checkbox'), function () {
            if (this.checked) {
                alert("暂未开放")
                // window.alert("你选了：" +
                //     $('input[type=checkbox]:checked').length + "个，其中有：" + $(this).val());
            }
        });
    }

    function allSelect() {
        var all = $("#all").is(':checked');
        var c2 = document.getElementsByClassName("checkboxSelect");

        if (all == true) {

            // $("input[name='checkbox']").attr("checked", true);
            for (var i = 0; i < c2.length; i++) {

                c2[i].checked = true;
            }
        } else {

            // $("input[name='checkbox']").removeAttr("checked");
            for (var i = 0; i < c2.length; i++) {
                c2[i].checked = false;
            }
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