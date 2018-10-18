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
    <c:choose>
        <c:when test="${id>-1}">
            <h1 class="mui-title">商品名称修改</h1>
        </c:when>
        <c:otherwise>
            <h1 class="mui-title">商品名称新增</h1>
        </c:otherwise>


    </c:choose>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <form class="form-horizontal" role="form" style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">商品名称</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="name" value="${name}" placeholder="请输入商品名称">
                <input type="hidden" value="${id}">
            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">


                <c:choose>
                    <c:when test="${id>-1}">
                        <input type="hidden" value="${id}" id="goods_name_id">
                        <button type="button" class="mui-btn mui-btn-primary" onclick="modify()"> 修改车位类型
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="mui-btn mui-btn-primary" onclick="confirm()"> 确定</button>
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

    function modify() {


        var name = $("#name").val();
        var goods_name_id = $("#goods_name_id").val();
        var url = "/seckill/goods_name/" + goods_name_id + "/" + name + "/modify"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
                // window.history.back()  ;              //location.reload()
                //  window.location.href=document.referrer;
            } else {
                mui.toast('修改失败', {duration: 'short', type: 'div'})
            }

            //

        });


        // window.location.href = document.referrer;                window.history.back();//返回上一页并刷新

        // mui.plusReady(function(){
        //     // 在这里调用plus api
        //     alert(1)
        // });

    }

    function confirm() {

        //$(window).attr('location', '/seckill/department');
        //window.location.href='/seckill/department'
        //  mui.back();
        // mui.openWindow({
        //     url:'department',
        //     id:'department_add'
        // })
        var name = $("#name").val();

        var url = "/seckill/goods_name/" + name + "/add"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
                // window.history.back()  ;              //location.reload()
                //  window.location.href=document.referrer;
            } else {
                mui.toast('添加失败', {duration: 'short', type: 'div'})
            }

            //

        });


        // window.location.href = document.referrer;                window.history.back();//返回上一页并刷新

        // mui.plusReady(function(){
        //     // 在这里调用plus api
        //     alert(1)
        // });

    }
</script>
</html>