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
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:choose>
        <c:when test="${id>-1}">
            <h1 class="mui-title">收费修改</h1>
        </c:when>
        <c:otherwise>
            <h1 class="mui-title">收费新增</h1>
        </c:otherwise>


    </c:choose>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <form class="form-horizontal" role="form" style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">
        <input type="hidden" value="${id}">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">收费名称</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="name" value="${name}" placeholder="请输入收费名称">

            </div>
        </div>

        <div class="form-group">
            <label for="price" class="col-sm-2 control-label">单价</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="price" value="${price}" placeholder="请输入单价">

            </div>
        </div>

        <div class="form-group">
            <label for="unit" class="col-sm-2 control-label">单位</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="unit" value="${unit}" placeholder="请输入单位">

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">


                <c:choose>
                    <c:when test="${id>-1}">
                        <input type="hidden" value="${id}" id="free_id">
                        <button type="button" class="mui-btn mui-btn-primary" onclick="modify()"> 修改收费</button>
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
        var free_id = $("#free_id").val();
        var price = $("#price").val();
        var unit = $("#unit").val();
        if(unit.indexOf("/") != -1 ){
            unit = unit.split("/")[0] + "fantasy" + unit.split("/")[1];
        }
        var url = "/seckill/free/" + free_id + "/" + name+'/'+price+'/'+unit + "/modify"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;                window.history.back();
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


        var name = $("#name").val();
        var price = $("#price").val();
        var unit = $("#unit").val();
        if(unit.indexOf("/") != -1 ){
            unit = unit.split("/")[0] + "fantasy" + unit.split("/")[1];
        }
        var url = "/seckill/free/" + name +'/'+price+'/'+unit +  "/add"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;                window.history.back();
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