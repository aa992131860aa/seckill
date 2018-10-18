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

</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">组合查询</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>

</header>
<div class="mui-content">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">


        <div class="form-group">
            <label for="goodsNameId" class="col-sm-2 control-label">商品名称</label>


            <select id="goodsNameId" class="col-sm-6 selectpicker">
                <c:forEach items="${goodsNameList}" var="d">
                    <option
                            value="${d.id}">${d.name}</option>
                </c:forEach>

            </select>


        </div>

        <div class="form-group">
            <label for="loctionL" class="col-sm-2 control-label">位置编号</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="loctionL" value="${locationL}">

            </div>
        </div>


        <div class="form-group">
            <label for="startTime" class="col-md-2 control-label">状态</label>
            <c:forEach items="${goodsStatusList}" var="d" varStatus="dd">
                <div class="col-md-2 ">


                    <div class="mui-input-row mui-checkbox mui-left">
                        <label>${d.name}</label>
                        <input name="status" value="${d.id}" id="status${dd.index}" checked type="checkbox">
                    </div>

                </div>
            </c:forEach>

        </div>

        <div class="form-group">
            <label for="floor" class="col-sm-2 control-label">楼层</label>
            <div class="col-sm-6">

                <input type="text" pattern="^(-|\+)?\d+$" class="form-control" value="${floor}" id="floor">

            </div>
        </div>


        <div class="form-group" style="display:
        <c:if test="${type==1 || type==2}">none;</c:if> ">
            <label for="startTime" class="col-md-2 control-label">是否带窗</label>
            <div class="col-md-2 ">


                <div class="mui-input-row mui-checkbox mui-left">
                    <label>带</label>
                    <input name="checkbox1" id="isWindow1" checked type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>不带</label>
                    <input name="checkbox1" id="isWindow2" checked type="checkbox">
                </div>

            </div>


        </div>


        <c:if test="${type==1}">

            <div class="form-group">
                <label for="startTime" class="col-md-2 control-label">类型</label>
                <c:forEach items="${adList}" var="d" varStatus="dd">
                    <div class="col-md-2 ">


                        <div class="mui-input-row mui-checkbox mui-left">
                            <label>${d.name}</label>
                            <input name="status" value="${d.id}" id="adType${dd.index}" checked type="checkbox">
                        </div>

                    </div>
                </c:forEach>

            </div>

            <%--<div class="form-group">--%>
            <%--<label for="type_id" class="col-sm-2 control-label">类型</label>--%>


            <%--<select id="type_id" class="col-sm-6 selectpicker">--%>
            <%--<c:forEach items="${adList}" var="d">--%>
            <%--<option--%>
            <%--value="${d.id}">${d.name}</option>--%>
            <%--</c:forEach>--%>

            <%--</select>--%>


            <%--</div>--%>
        </c:if>
        <c:if test="${type==2}">

            <div class="form-group">
                <label for="startTime" class="col-md-2 control-label">类型</label>
                <c:forEach items="${carList}" var="d" varStatus="dd">
                    <div class="col-md-2 ">


                        <div class="mui-input-row mui-checkbox mui-left">
                            <label>${d.name}</label>
                            <input name="status" value="${d.id}" id="carType${dd.index}" checked type="checkbox">
                        </div>

                    </div>
                </c:forEach>

            </div>


        </c:if>

        <div class="form-group" style="display:
        <c:if test="${type==1 || type==2}">none;</c:if> ">
            <label for="startTime" class="col-md-2 control-label">建筑分摊面积</label>
            <div class="col-md-3 ">


                <input class="form-control" id="startArea" size="16" type="text">

            </div>
            <div class="col-md-3 ">

                <input class="form-control" id="endArea" size="16" type="text">

            </div>

        </div>


        <div class="form-group">
            <label for="startTime" class="col-md-2 control-label">时间范围</label>
            <div class="col-md-3 ">


                <div class="input-group date form_datetime col-md-11" data-date="1979-09-16T05:25:07Z"
                     data-link-field="startTime">
                    <input class="form-control" id="startTime" size="16" type="text" value="${startTime}" readonly
                    >
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>

            <div class="col-md-3 ">

                <div class="input-group date form_datetime col-md-11" data-date="1979-09-16T05:25:07Z"
                     data-link-field="endTime">
                    <input class="form-control" id="endTime" size="16" type="text" value="${endTime}" readonly>
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <input type="hidden" id="dtp_input1" value=""/><br/>
        </div>


        <input type="hidden" id="type" value="${type}">


        <div class="form-group" style="display:
        <c:if test="${type==1 || type==2}">none;</c:if> ">
            <label for="startTime" class="col-md-2 control-label">租赁类型</label>
            <div class="col-md-2 ">


                <div class="mui-input-row mui-checkbox mui-left">
                    <label>房子租赁</label>
                    <input name="checkbox1" id="house1" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>注册租赁</label>
                    <input name="checkbox1" id="house2" type="checkbox">
                </div>

            </div>
            <div class="col-md-2 ">

                <div class="mui-input-row mui-checkbox mui-left">
                    <label>虚拟租赁</label>
                    <input name="checkbox1" id="house3" type="checkbox">
                </div>

            </div>

        </div>


        <div class="form-group">
            <div class="col-sm-offset-7">


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
     function  excelExport() {

     }

    function confirm() {

        var ri = 992961234;
        var userId = $.cookie('user_id');


        var page = 0;
        var type = $("#type").val();
        var typeId = ri;
        var goodsNameId = $("#goodsNameId").val();
        var loctionL = $("#loctionL").val();
        if (loctionL == '') {
            loctionL = ri;
        }
        var goodsStatusId = $("#goodsStatusId").val();

        goodsStatusId = ri;

        var floor = $("#floor").val();
        if (floor == '') {
            floor = ri;
        }
        var startTime = $("#startTime").val();
        if (startTime == '') {
            startTime = ri;
        }
        var endTime = $("#endTime").val();
        if (endTime == '') {
            endTime = ri;
        }
        var startArea = $("#startArea").val();
        if (startArea == '') {
            startArea = ri;
        }
        var endArea = $("#endArea").val();
        if (endArea == '') {
            endArea = ri;
        }


        var house1 = $("#house1").is(':checked')
        var house2 = $("#house2").is(':checked')
        var house3 = $("#house3").is(':checked')

        var isWindow1 = $("#isWindow1").is(':checked')
        var isWindow2 = $("#isWindow2").is(':checked')

        var status0 = $("#status0").is(':checked')
        var status1 = $("#status1").is(':checked')
        var status2 = $("#status2").is(':checked')

        var statusVal0 = $("#status0").val();
        var statusVal1 = $("#status1").val();
        var statusVal2 = $("#status2").val();

        var adType0 = $("#adType0").is(':checked')
        var adType1 = $("#adType1").is(':checked')

        var adTypeVal0 = $("#adType0").val();
        var adTypeVal1 = $("#adType1").val();

        var carType0 = $("#carType0").is(':checked')
        var carType1 = $("#carType1").is(':checked')

        var carTypeVal0 = $("#carType0").val();
        var carTypeVal1 = $("#carType1").val();

        if (type == 1) {
            typeId = $("#type_id").val();
            typeId = ri;

            carTypeVal0=ri;
            carTypeVal1=ri;
        }
        if (type == 2) {
            typeId = $("#car").val();
            typeId = ri;
            adTypeVal0=ri;
            adTypeVal1=ri;
        }


        ///house/{userId}/{page}/{type}/{typeId}/{goodsNameId}/{location}/{goodsStatusId}/{floor}/{startTime}/{endTime}/{startArea}/{endArea}
        var url = "/seckill/house/" + userId + "/" + page + "/" + type + "/" + typeId + "/" + goodsNameId
            + "/" + loctionL + "/" + goodsStatusId + "/" + floor + "/" + startTime + "/"
            + endTime + "/" + startArea + "/" + endArea + "/" + isWindow1 + "/" + isWindow2 + "/"
            + status0 + "/" + status1 + "/" + status2 + "/" + statusVal0 + "/" + statusVal1 + "/" + statusVal2
            + "/" + adType0 + "/" + adType1 + "/" + adTypeVal0 + "/" + adTypeVal1
            + "/" + carType0 + "/" + carType1 + "/" + carTypeVal0 + "/" + carTypeVal1
            + "/" + house1 + "/" + house2 + "/" + house3 + "/query/noExcept";
        console.log(url)
        mui.openWindow({
            url: url
        })


    }
</script>
</html>