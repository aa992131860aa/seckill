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
    <style type="text/css">

        .table th, .table td {
            text-align: center;
            vertical-align: middle !important;
        }

        .form-control1 {
            border-bottom: 1px solid #dbdbdb;
            border-top: 0px;
            border-left: 0px;
            border-right: 0px;
        }

    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:choose>
        <c:when test="${id>-1}">
            <h1 class="mui-title">客户档案修改</h1>
        </c:when>
        <c:otherwise>
            <h1 class="mui-title">客户档案新增</h1>
        </c:otherwise>


    </c:choose>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

        <input type="hidden" value="${id}" id="houseId">

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">客户名称</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " required id="name" value="${custom.name}">
            </div>


            <c:choose>
                <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                    <c:forEach items="${custom.customList}" var="c">

                        <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">
                            <%--<span style="display: none">${cookie['selectUuid'].value=c.uuid}</span>--%>

                            <label for="code" class="col-sm-2 control-label">助记码</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control " id="code" value="${c.code}">

                            </div>

                        </c:if>

                    </c:forEach>
                </c:when>
                <c:otherwise>

                    <label for="code" class="col-sm-2 control-label">助记码</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control " id="code" value="${custom.code}">

                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <c:if test="${custom.c<=1}">

            <div class="form-group">
                <label for="remark" class="col-sm-2 control-label">备注</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="remark" value="${custom.remark}">
                </div>
                <label for="code" class="col-sm-2 control-label">企业注册信息</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control " id="registerInfo" value="${custom.registerInfo}">

                </div>
            </div>
        </c:if>

        <c:if test="${custom==null}">

            <div class="form-group">
                <label for="remark" class="col-sm-2 control-label">备注</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="remark" value="">
                </div>


                <label for="code" class="col-sm-2 control-label">企业注册信息</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control " id="registerInfo" value="${custom.registerInfo}">

                </div>

            </div>
        </c:if>

        <c:if test="${custom.c>1}">

            <div class="form-group " i style="">
                <label for="remarkList" class="col-sm-2 control-label">备注</label>
                <div id="remarkListOut">
                    <div id="remarkListA">
                        <select id="remarkList" onchange="remarkChange()" class="col-sm-2 selectpicker">
                            <c:forEach items="${custom.customList}" var="d">
                                <option <c:if
                                        test="${fn:contains(d.uuid,cookie['selectUuid'].value)}"> selected="selected" </c:if>
                                        value="${d.uuid}">${d.remark}</option>
                            </c:forEach>

                        </select>

                        <a type="button" id="updateRemark" onclick="updateRemark(this)" class="btn btn-default"
                           value="修改备注">修改备注</a>
                    </div>


                </div>
            </div>
        </c:if>


        <c:choose>
            <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                <c:forEach items="${custom.customList}" var="c">

                    <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class="col-sm-2 control-label">企业联系人</label>


                                    <button type="button"
                                            style="float: right;" class="  mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addWork()"> 添加企业联系人
                                    </button>

                                </div>
                                <div class="form-group">
                                    <div class="table-responsive col-md-12" id="table"
                                         style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>联系人</th>
                                                <th>联系电话</th>
                                                <th>职务</th>
                                                <th>微信/qq</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="workTb">

                                            <c:forEach items="${c.workerList}" var="w">
                                                <tr>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="nameW" value="${w.name}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="phoneW" value="${w.phone}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="dutyW" value="${w.duty}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            name="linkW" type="text" value="${w.link}"/></td>
                                                    <td nowrap="nowrap"><a onclick="delWork(this)"
                                                                           style="color: #ff0000">删除</a></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>

                <div style="height: 40px;"></div>
                <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                    <div class="panel-body">
                        <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                            <label for="name" class="col-sm-2 control-label">企业联系人</label>


                            <button type="button" style="float: right;"
                                    class="  mui-btn-outlined mui-btn mui-btn-primary"
                                    onclick="addWork()"> 添加企业联系人
                            </button>

                        </div>
                        <div class="form-group">
                            <div class="table-responsive col-md-12" id="table"
                                 style="clear: both;margin-top: 30px">
                                <table class="table">

                                    <thead>
                                    <tr>
                                        <th>联系人</th>
                                        <th>联系电话</th>
                                        <th>职务</th>
                                        <th>微信/qq</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="workTb">

                                    <c:forEach items="${custom.workerList}" var="w">
                                        <tr>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="nameW" value="${w.name}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="phoneW" value="${w.phone}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="dutyW" value="${w.duty}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    name="linkW" type="text" value="${w.link}"/></td>
                                            <td nowrap="nowrap"><a onclick="delWork(this)" style="color: #ff0000">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>


        <c:choose>
            <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                <c:forEach items="${custom.customList}" var="c">

                    <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class="col-sm-2 control-label">关联企业</label>


                                    <button type="button"
                                            style="float: right;" class="  mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addCompany()"> 添加企业
                                    </button>

                                </div>
                                <div class="form-group">
                                    <div class="table-responsive col-md-12"
                                         style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                    <%--<th>序号</th>--%>
                                                <th>企业名称</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="companyTb">

                                            <c:forEach items="${c.companyList}" var="c">
                                                <tr>
                                                        <%--<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;" type="text" name="noC" value="${c.no}" /></td>--%>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="nameC" value="${c.name}"/></td>
                                                    <td><a onclick="delCompany(this)" style="color: #ff0000">删除</a></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>

                <div style="height: 40px;"></div>
                <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                    <div class="panel-body">
                        <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                            <label for="name" class="col-sm-2 control-label">关联企业</label>


                            <button type="button" style="float: right;"
                                    class="  mui-btn-outlined mui-btn mui-btn-primary"
                                    onclick="addCompany()"> 添加企业
                            </button>

                        </div>
                        <div class="form-group">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                <table class="table">

                                    <thead>
                                    <tr>
                                            <%--<th>序号</th>--%>
                                        <th>企业名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="companyTb">

                                    <c:forEach items="${custom.companyList}" var="c">
                                        <tr>
                                                <%--<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;" type="text" name="noC" value="${c.no}" /></td>--%>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="nameC" value="${c.name}"/></td>
                                            <td><a onclick="delCompany(this)" style="color: #ff0000">删除</a></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>


        <c:choose>
            <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                <c:forEach items="${custom.customList}" var="c">

                    <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">
                        <div style="height: 40px;"></div>
                        <div class="panel panel-default col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group">
                                    <div class="table-responsive col-md-12"
                                         style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>租赁产品</th>
                                                <th>位置编号</th>
                                                <th>合同号</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${custom.contractList}" var="list">
                                                <c:forEach items="${list.tableList1}" var="t">
                                                    <tr>
                                                        <td><c:if test="${list.style=='house'}">房屋</c:if>
                                                            <c:if test="${list.style=='ad'}">广告</c:if>
                                                            <c:if test="${list.style=='car'}">车辆</c:if></td>
                                                        <td>${t.table1}</td>
                                                        <td>${list.no}</td>
                                                    </tr
                                                </c:forEach>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>

                <div style="height: 40px;"></div>
                <div class="panel panel-default col-sm-10 col-sm-offset-1">
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                <table class="table">

                                    <thead>
                                    <tr>
                                        <th>租赁产品</th>
                                        <th>位置编号</th>
                                        <th>合同号</th>
                                    </tr>
                                    </thead>
                                    <tbody id="contactTb">
                                    <c:forEach items="${custom.contractList}" var="list">
                                        <c:forEach items="${list.tableList1}" var="t">
                                            <tr>
                                                <td><c:if test="${list.style=='house'}">房屋</c:if>
                                                    <c:if test="${list.style=='ad'}">广告</c:if>
                                                    <c:if test="${list.style=='car'}">车辆</c:if></td>
                                                <td>${t.table1}</td>
                                                <td>${list.no}</td>
                                            </tr
                                        </c:forEach>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>


        <c:choose>
            <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                <c:forEach items="${custom.customList}" var="c">

                    <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">

                        <div style="height: 40px;"></div>
                        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class="col-sm-2 control-label">职员车辆登记</label>


                                    <button type="button"
                                            style="float: right;" class="  mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addReg()"> 添加职员
                                    </button>

                                </div>


                                <div class="form-group">
                                    <div class="table-responsive col-md-12"
                                         style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>车牌号登记</th>
                                                <th>联系人</th>
                                                <th>电话</th>
                                                <th>车位</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="regTb">
                                            <c:forEach items="${c.carRegList}" var="r">
                                                <tr>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="noR" value="${r.no}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="nameR" value="${r.name}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" name="phoneR" value="${r.phone}"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" readonly value="${r.loc}"/></td>
                                                    <td nowrap="nowrap"><a onclick="delReg(this)"
                                                                           style="color: #ff0000">删除</a></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>

                <div style="height: 40px;"></div>
                <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                    <div class="panel-body">
                        <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                            <label for="name" class="col-sm-2 control-label">职员车辆登记</label>


                            <button type="button" style="float: right;"
                                    class="  mui-btn-outlined mui-btn mui-btn-primary"
                                    onclick="addReg()"> 添加职员
                            </button>

                        </div>
                        <div class="form-group">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                <table class="table">

                                    <thead>
                                    <tr>
                                        <th>车牌号登记</th>
                                        <th>联系人</th>
                                        <th>电话</th>
                                        <th>车位</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="regTb">
                                    <c:forEach items="${custom.carRegList}" var="r">
                                        <tr>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="noR" value="${r.no}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="nameR" value="${r.name}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" name="phoneR" value="${r.phone}"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" readonly value="${r.loc}"/></td>
                                            <td nowrap="nowrap"><a onclick="delReg(this)" style="color: #ff0000">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>


        <c:choose>
            <c:when test="${fn:contains(custom.selectUuid,cookie['selectUuid'].value)}">


                <c:forEach items="${custom.customList}" var="c">

                    <c:if test="${c.uuid.equals(cookie['selectUuid'].value)}">

                        <div style="height: 40px;"></div>
                        <div class="panel panel-default    col-sm-10 col-sm-offset-1">
                            <div class="panel-body">
                                <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                                    <label for="name" class="col-sm-2 control-label">客户不良信誉登记</label>


                                    <button type="button"
                                            style="float: right;" class="  mui-btn-outlined mui-btn mui-btn-primary"
                                            onclick="addBad()"> 添加不良记录
                                    </button>

                                </div>


                                <div class="form-group">
                                    <div class="table-responsive col-md-12"
                                         style="clear: both;margin-top: 30px">
                                        <table class="table">

                                            <thead>
                                            <tr>
                                                <th>时间</th>
                                                <th>地点</th>
                                                <th>内容</th>

                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="badTb">
                                            <c:forEach items="${c.badList}" var="b">
                                                <tr>
                                                    <td>
                                                        <div style="margin-top: -15px;"
                                                             class="input-group date form_datetime"
                                                             data-date="1979-09-16T05:25:07Z"
                                                             data-link-field="startTime"><input
                                                                name="dateB" size="16" type="text" readonly
                                                                class="form-control"
                                                                value="${b.date}"> <span
                                                                class="input-group-addon"><span
                                                                class="glyphicon glyphicon-th"></span></span>
                                                        </div>
                                                    </td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" value="${b.place}" name="placeB"/></td>
                                                    <td><input
                                                            style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                            type="text" value="${b.content}" name="contentB"/>
                                                    </td>
                                                    <td nowrap="nowrap"><a onclick="delBad(this)"
                                                                           style="color: #ff0000">删除</a></td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>

                <div style="height: 40px;"></div>
                <div class="panel panel-default     col-sm-10 col-sm-offset-1">
                    <div class="panel-body">
                        <div class="form-group" style="margin-top: 0px;margin-bottom: 0px;">
                            <label for="name" class=" col-sm-2 control-label">客户不良信誉登记</label>


                            <button type="button" style="float: right;"
                                    class="  mui-btn-outlined mui-btn mui-btn-primary"
                                    onclick="addBad()"> 添加不良记录
                            </button>

                        </div>
                        <div class="form-group">
                            <div class="table-responsive col-md-12" style="clear: both;margin-top: 30px">
                                <table class="table">

                                    <thead>
                                    <tr>
                                        <th>时间</th>
                                        <th>地点</th>
                                        <th>内容</th>

                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="badTb">
                                    <c:forEach items="${custom.badList}" var="b">
                                        <tr>
                                            <td>
                                                <div style="margin-top: -15px;" class="input-group date form_datetime"
                                                     data-date="1979-09-16T05:25:07Z" data-link-field="startTime"><input
                                                        name="dateB" size="16" type="text" readonly class="form-control"
                                                        style="background-color: white;margin-left: 20px"
                                                        value="${b.date}"> <span style="display: none"
                                                                                 class="input-group-addon"><span
                                                        style="display: none"
                                                        class="glyphicon glyphicon-th"></span></span>
                                                </div>
                                            </td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" value="${b.place}" name="placeB"/></td>
                                            <td><input
                                                    style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"
                                                    type="text" value="${b.content}" name="contentB"/>
                                            </td>
                                            <td nowrap="nowrap"><a onclick="delBad(this)" style="color: #ff0000">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>


        <div class="form-group">
            <div class=" col-sm-11">


                <c:choose>
                    <c:when test="${count>0}">

                        <button type="button" class=" mui-btn mui-btn-primary" style="float: right" onclick="modify()">
                            修改客户
                        </button>
                        <button type="button" class="mui-btn " onclick="back()"
                                style="float: right;margin-right: 50px;">返回
                        </button>
                    </c:when>
                    <c:otherwise>

                        <button type="button" class="mui-btn mui-btn-primary" style="float: right" onclick="confirm()">
                            确定
                            <button type="button" class="mui-btn " onclick="back()"
                                    style="float: right;margin-right: 50px;">返回
                            </button>
                        </button>
                    </c:otherwise>


                </c:choose>
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

    $(function () {
        $("#updateRemark11").click(function () {
            var value = $("#updateRemark").val();
            var remarkList = $("#remarkList");
            var r = document.getElementById("remarkList");
            var remarkListA = document.getElementById("remarkListA");
            //s.parentNode.appendChild(ipt);
            //console.log(remarkList.parent())
            var input = '            <div class="form-group " style="">\n' +
                '                <label for="remarkList" class="col-sm-2 control-label">备注</label>\n' +
                '\n' +
                '\n' +
                '                <select id="remarkList1" onchange="remarkChange()" class="col-sm-2 selectpicker">\n' +
                '                    <c:forEach items="${custom.customList}" var="d">\n' +
                '                        <option <c:if test="${fn:contains(d.uuid,cookie[\'selectUuid\'].value)}"> selected="selected" </c:if>\n' +
                '                                value="${d.uuid}">${d.remark}</option>\n' +
                '                    </c:forEach>\n' +
                '\n' +
                '                </select>\n' +
                '\n' +
                '                <input type="button" id="updateRemark" class="btn btn-default"  value="取消修改">\n' +
                '\n' +
                '            </div>'
            // remarkList.parent().remove();
            //     console.log(remarkList.parent())
            // remarkList.parent().append(input);
            //  var ipt=document.createElement('input');
            //  ipt.type ='text' ;
            // // ipt.value =s.options[s.selectedIndex].value //要列表的文字就把value改为text
            //  r.parentNode.appendChild(ipt)
            //  r.parentNode.removeChild(r);

            remarkListA.removeChild(r);
        });

    });

    function remarkChange(obj) {


        var s = $("#remarkList").val();
        // $.cookie('selectUuid', s);
        $.cookie('selectUuid', s, {expires: 30, path: '/'});

        console.log("cookie:" + s + ",name:");
        console.log($("#remarkList").find("option:selected").text())

        window.location.reload()
    }

    function delWork(obj) {
        obj.parentNode.parentNode.remove();
        //$(this).parent('tr').remove()


        // var trId = obj.parentNode.parentNode.id;
        //
        // var trObj = document.getElementById(trId);
        //
        // document.getElementById("workTb").removeChild(trObj);
    }

    function addWork() {
        var job = "";
        var jobTemp = "";
        var dis = "";

        $("input[name='dutyW']").each(function (index, item) {
            jobTemp += $(this).val();
        });
        if (jobTemp.indexOf("法人") == -1) {
            job = "法人";

        } else if (jobTemp.indexOf("主要财务") == -1) {
            job = "主要财务";
        }

        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        if (job != "") {
            dis = " disabled";
        }
        var line = '<td><input type="text"  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" name="nameW"  /></td>' +
            '<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" type="text" name="phoneW"  /></td>' +
            '<td><input style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"  type="text" name="dutyW" ' + dis + ' value="' + job + '"  /></td>' +
            '<td><input style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"  name="linkW" type="text"  /></td>' +
            ' <td nowrap="nowrap"><a onclick="delWork(this)" style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("workTb").appendChild(trObj);
    }

    function delCompany(obj) {
        obj.parentNode.parentNode.remove();
        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("companyTb").removeChild(trObj);
    }

    function addCompany() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        //<td><input type="text" name="noC"  /></td>
        var line = '<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" type="text" name="nameC"  /></td> <td ><a onclick="delCompany(this)" style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("companyTb").appendChild(trObj);
    }

    function delReg(obj) {
        obj.parentNode.parentNode.remove();
        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("regTb").removeChild(trObj);
    }

    function addReg() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var line = '<td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" type="text" name="noR"  /></td><td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" type="text" name="nameR"  /></td><td><input style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"  type="text" name="phoneR"  /></td> <td><input  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center" type="text" name="no" readonly  /></td> <td nowrap="nowrap"><a onclick="delReg(this)" style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("regTb").appendChild(trObj);
    }

    function delBad(obj) {

        obj.parentNode.parentNode.remove();

        // var trId = obj.parentNode.parentNode.id;
        // var trObj = document.getElementById(trId);
        // document.getElementById("regTb").removeChild(trObj);
    }

    function addBad() {
        var trObj = document.createElement("tr");
        trObj.id = new Date().getTime();
        var time = ' <div    class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> <input  name="dateB" size="16" type="text" class="form-control"  readonly > <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span> </div>'
        var line = '<td>' + time + '</td><td><input style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"  type="text" name="placeB"  /></td><td><input style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center"  type="text" name="contentB"  /></td>  <td nowrap="nowrap"><a onclick="delBad(this)" style="color: #ff0000">删除</a></td>'
        //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
        trObj.innerHTML = line;
        document.getElementById("badTb").appendChild(trObj);


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
    // $('#datetimepicker').datetimepicker({
    //     language: "zh-CN",    //语言选择中文
    //     format: "yyyy-mm",    //格式化日期
    //     timepicker: true,     //关闭时间选项
    //     yearEnd: 2050,        //设置最大年份
    //     todayButton: false,    //关闭选择今天按钮
    //     autoclose: 1,        //选择完日期后，弹出框自动关闭
    //     startView: 3,         //打开弹出框时，显示到什么格式,3代表月
    //     minView: 3,          //能选择到的最小日期格式
    // });
    function back() {


        window.history.go(-1);
    }

    function modify() {


        var c = '${custom.c}';
        var customId = '${custom.id}';
        var aText = $("#updateRemark").text();
        var uuid;
        var remark;

        var worker;
        var nameW = '';
        var phoneW = '';
        var dutyW = '';
        var linkW = '';

        var company = '';
        var noC = '';
        var nameC = '';

        var carReg = '';
        var noR = '';
        var nameR = '';
        var phoneR = '';

        var bad = '';
        var dateB = '';
        var placeB = '';
        var contentB = '';

        var flag1 = ",";
        var flag2 = "=";

        //worker
        $("input[name='nameW']").each(function (index, item) {
            nameW += $(this).val() + flag1;
        });
        $("input[name='phoneW']").each(function (index, item) {
            phoneW += $(this).val() + flag1;
        });
        $("input[name='dutyW']").each(function (index, item) {
            dutyW += $(this).val() + flag1;
        });
        $("input[name='linkW']").each(function (index, item) {
            linkW += $(this).val() + flag1;
        });
        worker = nameW + flag2 + phoneW + flag2 + dutyW + flag2 + linkW;
        //company
        $("input[name='noC']").each(function (index, item) {
            noC += $(this).val() + flag1;
        });
        $("input[name='nameC']").each(function (index, item) {
            nameC += $(this).val() + flag1;
        });

        company = noC + flag2 + nameC;

        //carReg
        $("input[name='noR']").each(function (index, item) {
            noR += $(this).val() + flag1;
        });
        $("input[name='nameR']").each(function (index, item) {
            nameR += $(this).val() + flag1;
        });
        $("input[name='phoneR']").each(function (index, item) {
            phoneR += $(this).val() + flag1;
        });
        carReg = noR + flag2 + nameR + flag2 + phoneR;

        //bad
        $("input[name='dateB']").each(function (index, item) {
            dateB += $(this).val() + flag1;
        });
        $("input[name='placeB']").each(function (index, item) {
            placeB += $(this).val() + flag1;
        });
        $("input[name='contentB']").each(function (index, item) {
            contentB += $(this).val() + flag1;
        });
        bad = dateB + flag2 + placeB + flag2 + contentB;

        if (c > 1 && aText == '修改备注') {
            uuid = $("#remarkList").val();
            remark = $("#remarkList").find("option:selected").text()
        } else {
            remark = $("#remark").val();
            uuid = '${custom.uuid}';
        }
        var userId = $.cookie('user_id');
        var name = $("#name").val();


        var code = $("#code").val();
        var registerInfo = $("#registerInfo").val();
        if (registerInfo == '') {
            registerInfo = "fantasy";
        }
        var custom = name + flag2 + remark + flag2 + code;
        if (worker.indexOf("/") != -1) {
            worker = worker.split("/")[0] + "fantasy" + worker.split("/")[1];
        }

        var url = "/seckill/custom/" + custom + "/" + worker
            + "/" + company + "/" + carReg + "/" + bad + "/" + uuid + "/" + customId + "/" + registerInfo + "/update";
        console.log(url);
        $.post(url, {}, function (result) {
            //alert(result);
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

    function confirm() {


        var worker;
        var nameW = '';
        var phoneW = '';
        var dutyW = '';
        var linkW = '';

        var company = '';
        var noC = '';
        var nameC = '';

        var carReg = '';
        var noR = '';
        var nameR = '';
        var phoneR = '';

        var bad = '';
        var dateB = '';
        var placeB = '';
        var contentB = '';

        var flag1 = ",";
        var flag2 = "=";

        //worker
        $("input[name='nameW']").each(function (index, item) {
            nameW += $(this).val() + flag1;
        });
        $("input[name='phoneW']").each(function (index, item) {
            phoneW += $(this).val() + flag1;
        });
        $("input[name='dutyW']").each(function (index, item) {
            dutyW += $(this).val() + flag1;
        });
        $("input[name='linkW']").each(function (index, item) {
            linkW += $(this).val() + flag1;
        });
        worker = nameW + flag2 + phoneW + flag2 + dutyW + flag2 + linkW;
        //company
        $("input[name='noC']").each(function (index, item) {
            noC += $(this).val() + flag1;
        });
        $("input[name='nameC']").each(function (index, item) {
            nameC += $(this).val() + flag1;
        });

        company = noC + flag2 + nameC;

        //carReg
        $("input[name='noR']").each(function (index, item) {
            noR += $(this).val() + flag1;
        });
        $("input[name='nameR']").each(function (index, item) {
            nameR += $(this).val() + flag1;
        });
        $("input[name='phoneR']").each(function (index, item) {
            phoneR += $(this).val() + flag1;
        });
        carReg = noR + flag2 + nameR + flag2 + phoneR;

        //bad
        $("input[name='dateB']").each(function (index, item) {
            dateB += $(this).val() + flag1;
        });
        $("input[name='placeB']").each(function (index, item) {
            placeB += $(this).val() + flag1;
        });
        $("input[name='contentB']").each(function (index, item) {
            contentB += $(this).val() + flag1;
        });
        bad = dateB + flag2 + placeB + flag2 + contentB;


        var userId = $.cookie('user_id');
        var name = $("#name").val();

        var remark = $("#remark").val();
        var code = $("#code").val();
        var registerInfo = $("#registerInfo").val();
        if (registerInfo == '') {
            registerInfo = "fantasy";
        }
        var custom = name + flag2 + remark + flag2 + code;
        if (worker.indexOf("/") != -1) {
            worker = worker.split("/")[0] + "fantasy" + worker.split("/")[1];
        }

        var url = "/seckill/custom/" + custom + "/" + worker
            + "/" + company + "/" + carReg + "/" + bad + "/" + registerInfo + "/insert";
        console.log(url);
        $.post(url, {}, function (result) {
            //alert(result);
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