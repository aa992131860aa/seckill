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
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">权限分配</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">
    <%--<h4 style="margin-left: 30px;"><strong>上级机构公司:</strong>浙江恒山实业集团</h4>--%>

    <div class="table-responsive" id="table">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>部门</th>
                <th>姓名</th>
                <th>账号</th>
                <th>密码</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.departmentName}</td>
                    <td>${list.name}</td>
                    <td>${list.account}</td>
                    <td>${list.pwd}</td>


                    <td>
                        <a onclick="skipRole('${list.id}')">权限</a> |
                        <%--<a--%>
                            <%--onclick="modifyUser('${list.id}','${list.account}','${list.name}','${list.pwd}','${list.departmentId}','${list.departmentName}')">编辑</a>--%>
                        <%--|--%>
                        <c:if test="${list.forbid==0}">
                          <a onclick="unForbidUser(${list.id})" style="color: #5e5e5e;">解禁</a>
                       </c:if>
                       <c:if test="${list.forbid==1}">
                          <a onclick="forbidUser(${list.id})" style="color: blue;">禁用</a>
                       </c:if>

                    |
                        <a onclick="deleteUser(${list.id})" style="color: #f00;">删除</a></td>

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
    var needRefresh = sessionStorage.getItem("need-refresh");
    if(needRefresh){
        sessionStorage.removeItem("need-refresh");
        location.reload();
    }
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


            $(window).attr('location', '/seckill/department/' + (params.pageNum - 1) + '/query');


        })


    });

    function skipRole(id) {
        mui.openWindow({
            url: '/seckill/role/' + id + '/user',
            id: 'department'
        })

    }

    function skipUserAdd() {
        mui.openWindow({
            url: '/seckill/user_add'

        })
    }

    function skip_department_add() {
        mui.openWindow({
            url: '/seckill/department_add',
            id: 'department'
        })

    }


    function modifyUser(id, account, name, pwd, department_id) {

        mui.openWindow({
            url: '/seckill/user/' + id + '/' + account +'/'+name+'/'+pwd+'/'+department_id+ '/modify',
            id: 'department',

        })

    }

    function forbidUser(id) {

        mui.confirm('真的要禁用吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/user/" + id + "/forbid";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }

    function unForbidUser(id) {

        mui.confirm('真的要解禁吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/user/" + id + "/unForbid";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }

    function deleteUser(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/user/" + id + "/delete";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>