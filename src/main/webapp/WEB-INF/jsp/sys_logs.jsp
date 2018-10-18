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
<%@include file="common/common.jsp"%>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">工作日志</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <div class="table-responsive" id="table" style="margin-top: 30px;">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>部门名称</th>
                <th>账号</th>
                <th>姓名</th>
                <th>操作</th>
                <th>时间</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sysLogsList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.departmentName}</td>
                    <td>${list.account}</td>
                    <td>${list.name}</td>
                    <td>${list.type}</td>
                    <td>${list.createTime}</td>


                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

    <%--<c:if test="${total>0}">--%>
    <div>
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

    $(document).ready(function () {

        var total = $("#total").val();
        var page = $("#page").val();
        var pageSize = $("#pageSize").val();

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



                $(window).attr('location', '/seckill/sys_logs/'+ (params.pageNum - 1) + '/query');




        })


    });


    function skip_sys_logs_add() {
        mui.openWindow({
            url: '/seckill/sys_logs_add',
            id: 'department'
        })

    }

    function modifySys_logs(id, name) {

        mui.openWindow({
            url: '/seckill/sys_logs/' + id + '/' + name + '/modify',
            id: 'department',

        })

    }

    function deleteSys_logs(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/sys_logs/" + id + "/delete";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>