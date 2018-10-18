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
    <h1 class="mui-title">费用类别管理</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <button style="margin-left: 30px;margin-top: 30px;" type="button" class="mui-btn mui-btn-primary" onclick="skip_free_add()">
        新增费用
    </button>
    <div class="table-responsive" id="table">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>收费名称</th>
                <th>单价</th>
                <th>单位</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${freeList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.name}</td>
                    <td>${list.price}</td>
                    <td>${list.unit}</td>
                    <td><a onclick="modifyFree('${list.id}','${list.name}','${list.price}','${list.unit}')">修改</a> | <a
                            onclick="deleteFree(${list.id})" style="color: #f00;">删除</a></td>

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



                $(window).attr('location', '/seckill/free/'+ (params.pageNum - 1) + '/query');




        })


    });


    function skip_free_add() {
        mui.openWindow({
            url: '/seckill/free_add'

        })

    }

    function modifyFree(id, name,price,unit) {
        if(unit.indexOf("/") != -1 ){
            unit = unit.split("/")[0] + "fantasy" + unit.split("/")[1];
        }
        mui.openWindow({
            url: '/seckill/free/'+id+'/'+name+'/'+price+'/'+unit+'/modify'


        })

    }

    function deleteFree(id) {

        mui.confirm('真的要删除吗？', '', new Array('取消', '确定'), function (e) {
            if (e.index == 0) {
                mui.toast('您已取消');
            } else {
                var url = "/seckill/free/" + id + "/delete";
                $.post(url, {}, function (res) {
                    window.location.reload()
                })
            }
        });
    }
</script>
</html>