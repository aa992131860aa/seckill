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
    <c:if test="${type=='water'}">
        <h1 class="mui-title">水表数据输入</h1>
    </c:if>
    <c:if test="${type=='power'}">
        <h1 class="mui-title">电表数据输入</h1>
    </c:if>
    <c:if test="${type=='air'}">
        <h1 class="mui-title">空调表数据输入</h1>
    </c:if>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <form class="form-horizontal" role="form" style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">
                房号

            </label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="loc" value="${name}">

            </div>
        </div>
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">
                <c:if test="${type=='water'}">
                    水表号
                </c:if>
                <c:if test="${type=='power'}">
                    电表号
                </c:if>
                <c:if test="${type=='air'}">
                    空调表
                </c:if>

            </label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="no" value="${name}">

            </div>
        </div>

        <div class="form-group">
            <label for="startDate" class="col-md-2 control-label">抄表时间</label>
            <div class="col-md-6 ">


                <div class="input-group date form_datetime col-md-12" data-date="1979-09-16T05:25:07Z"
                     data-link-field="startDate">
                    <input style="background-color: #fff" class="form-control" id="date"
                           style="" size="16" type="text" value="${contract.startDate}"
                           readonly
                    >
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon" style="display: none"><span
                            class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">
                本期度数

            </label>
            <div class="col-sm-6">

                <input type="number" class="form-control" id="degree" value="${name}">

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">


                <button type="button" class="mui-btn mui-btn-primary" onclick="confirm()"> 确定</button>

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

    function modify() {


        var name = $("#name").val();
        var ad_id = $("#ad_id").val();
        var url = "/seckill/ad/" + ad_id + "/" + name + "/modify"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
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
        var flag1 = "@@";
        var data = '';
        var loc = $("#loc").val();
        var no = $("#no").val();
        var date = $("#date").val();
        var degree = $("#degree").val();
        data = loc + flag1 + no + flag1 + date + flag1 + degree + flag1 + '${type}' + flag1;
        var url = "/seckill/house/freeExport/handle/add/" + data;
        $.post(url, {}, function (result) {
            if (result == 1) {

                // window.history.back()  ;
                //
                //  window.location.href=document.referrer;
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();

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