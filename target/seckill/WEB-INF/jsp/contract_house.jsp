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

    <h1 class="mui-title">房子租赁合同</h1>
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
        <label for="startDate" style="float: left;" class=" control-label">联系人</label>
        <div class="col-md-1">
            <input type="text" class="form-control input-sm" placeholder="" id="linkMan"
                   value="${linkMan}">
        </div>
        <label for="startDate" style="float: left;" class=" control-label">合同号</label>
        <div class="col-md-2">
            <input type="text" class="form-control input-sm" placeholder="" id="no"
                   value="${no}">
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


        <button style="margin-left: 30px;" type="button" onclick="queryContract()" class="mui-btn mui-btn-warning">查询
        </button>
        <button style="margin-left: 30px;float: right;margin-right: 50px;
        <c:choose>
        <c:when test="${role4=='fantasy'}">display: none;</c:when>
            <c:when test="${is_admin=='1'}"></c:when>
        <c:otherwise>
        <c:if test="${!role4.contains('新增')}"> display: none; </c:if></c:otherwise></c:choose>" type="button"
                class="mui-btn mui-btn-primary"
                onclick="skipContractHouse()">
            新增
        </button>
    </div>


    <%--// 新增 复核 审批/退回 删除--%>

    <div class="table-responsive" id="table" style="clear: both;margin-top: 30px">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>审批时间</th>
                <th>客户名称</th>
                <th>联系人</th>
                <th>联系电话</th>
                <th>合同号</th>
                <th>审批状态</th>
                <th>数量</th>
                <th>金额</th>
                <th>经办人</th>
                <th>操作
                </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${contractList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.approvalDate}</td>
                    <td>${list.codeAuto}</td>
                    <td>${list.linkMan}</td>
                    <td>${list.phone}</td>
                    <td>${list.no}</td>
                    <td>
                        <c:if test="${list.isOk==0}">审批中</c:if>
                        <c:if test="${list.isOk==1}">已审批</c:if>
                        <c:if test="${list.isOk==-1}">已驳回</c:if>
                        <c:if test="${list.isFinish==1}">已完成</c:if>
                    </td>
                    <td>
                        1
                    </td>
                    <td>${list.payTotal}</td>
                    <td>${list.approval}</td>
                    <td>
                        <a
                                onclick="updateContractDetaill('${list.uuid}')">详情 | </a>
                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('续签')}"> display: none </c:if>
                        </c:otherwise>
                        </c:choose>;color: #1d4499"
                           onclick="updateContract('${list.uuid}')"><c:if test="${list.isOk==-1&&list.isPay==0}">重新审批</c:if><c:if
                                test="${list.isOk==0||list.isOk==1||list.isPay==1}">续签</c:if> | </a>
                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('退回')}"> display: none </c:if>
                        </c:otherwise>
                        </c:choose>;color: #1d4499"
                           onclick="updateCustom('${list.uuid}')">终止 | </a>

                        <a style="
                        <c:choose>
                            <c:when test="${is_admin=='1'}"></c:when>
                        <c:otherwise>
                        <c:if
                                test="${!role4.contains('删除')}">display: none; </c:if>
                        </c:otherwise>
                        </c:choose> color: #f00;"
                           onclick="deleteCustom('${list.uuid}')">删除</a>

                    </td>
                </tr>
            </c:forEach>

            <tr>
                <td>合计</td>
                <td></td>
                <td></td>

                <td></td>
                <td></td>
                <td></td>
                <td>

                </td>
                <td>
                    ${contractList.size()}
                </td>
                <td>${payTotalAll}</td>
                <td></td>
                <td>

                </td>
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
    $.cookie('selectUuid', "fantasy_9921", {expires: 30, path: '/'});

    $(document).ready(function () {

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
                var no = $("#no").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();

                var rs = "fantasy";
                if (code == '') {
                    code = rs;
                }
                if (linkMan == '') {
                    linkMan = rs;
                }
                if (no == '') {
                    no = rs;
                }
                if (startDate == '') {
                    startDate = rs;
                }
                if (endDate == '') {
                    endDate = rs;
                }
                $(window).attr('location', '/seckill/contract_house/' + userId + '/' + (params.pageNum - 1) + '/' + code + '/' + linkMan + '/' + no + '/' + startDate + '/' + endDate + '/query/noExport');

            } else {

                $(window).attr('location', '/seckill/contract_house/' + userId + '/' + (params.pageNum - 1) + '/noExport');

            }


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

    function excelExport() {

        var query = $("#query").val();
        var page = $("#page").val();
        if (query == 'query') {

            var code = $("#code").val();
            var linkMan = $("#linkMan").val();
            var no = $("#no").val();
            var startDate = $("#startDate").val();
            var endDate = $("#endDate").val();

            var rs = "fantasy";
            if (code == '') {
                code = rs;
            }
            if (linkMan == '') {
                linkMan = rs;
            }
            if (no == '') {
                no = rs;
            }
            if (startDate == '') {
                startDate = rs;
            }
            if (endDate == '') {
                endDate = rs;
            }
            var url = '/seckill/contract_house/' + userId + '/' + page + '/' + code + '/' + linkMan + '/' + no + '/' + startDate + '/' + endDate + '/query/export';


            mui.openWindow({
                url: url

            })
        } else {

            var url = '/seckill/contract_house/' + userId + '/' + page + '/export';
            mui.openWindow({
                url: url

            })
        }

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


    function updateContractDetaill(uuid) {
        var url = "/seckill/contract_house/" + uuid + "/normal/detail";
        mui.openWindow({
            url: url

        })
    }

    function updateContract(uuid) {
        var url = "/seckill/contract_house/" + uuid + "/update";
        mui.openWindow({
            url: url

        })
    }

    function updateCustom(uuid) {
        var date = crtTimeFtt(new Date());

        var url = "/seckill/contract_house/" + uuid + "/0/del/" + date+"/0";
        mui.openWindow({
            url: url

        })
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
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var rs = "fantasy";
        if (code == '' && linkMan == '' && no == '' && startDate == '' && endDate == '') {
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
            if (startDate == '') {
                startDate = rs;
            }
            if (endDate == '') {
                endDate = rs;
            }
            var url = "/seckill/contract_house/" + userId + '/0/' + code + '/' + linkMan + '/' + no + '/' + startDate + '/' + endDate + "/query/noExport";
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