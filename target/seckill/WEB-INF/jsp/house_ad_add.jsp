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
    <c:choose>
        <c:when test="${id>-1}">
            <h1 class="mui-title">广告修改</h1>
        </c:when>
        <c:otherwise>
            <h1 class="mui-title">广告新增</h1>
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
            <label for="goodsNameId" class="col-sm-2 control-label">商品名称</label>


            <select id="goodsNameId" class="col-sm-6 selectpicker">
                <c:forEach items="${goodsNameList}" var="d">
                    <option <c:if test="${d.id==goodsNameId}"> selected="selected" </c:if>
                            value="${d.id}">${d.name}</option>
                </c:forEach>

            </select>


        </div>

        <div class="form-group">
            <label for="loctionL" class="col-sm-2 control-label">位置编号</label>
            <div class="col-sm-6">

                <input type="text" required class="form-control" id="loctionL" value="${locationL}">

            </div>
        </div>

        <div class="form-group">
            <label for="loctionL" class="col-sm-2 control-label">销控图位置</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="chartLoc" value="${chartLoc}"
                       placeholder="请输入销控图位置,示例 3,3">

            </div>
        </div>

        <div class="form-group" style="display: none;">
            <label for="useArea" class="col-sm-2 control-label">使用面积</label>
            <div class="col-sm-6">

                <input type="text" pattern="^[0-9]+([.]{1}[0-9]+){0,1}$" required class="form-control" id="useArea"
                       value="${useArea}">

            </div>
        </div>


        <div class="form-group">
            <label for="num" class="col-sm-2 control-label">数量</label>
            <div class="col-sm-6">

                <input type="text" pattern="^(-|\+)?\d+$" required class="form-control" id="num" value="${num}">

            </div>
        </div>


        <div class="form-group">
            <label for="floor" class="col-sm-2 control-label">楼层</label>
            <div class="col-sm-6">

                <input type="text" pattern="^(-|\+)?\d+$" required class="form-control" value="${floor}" id="floor">

            </div>
        </div>

        <div class="form-group">
            <label for="goodsStatusId" class="col-sm-2 control-label">状态</label>


            <select id="goodsStatusId" class="col-sm-6 selectpicker" disabled style="background-color: #fff;">
                <c:forEach items="${goodsStatusList}" var="d">
                    <option <c:if test="${d.id==goodsStatusId}"> selected="selected" </c:if>
                            value="${d.id}">${d.name}</option>
                </c:forEach>

            </select>


        </div>

        <div class="form-group">
            <label for="goodsStatusId" class="col-sm-2 control-label">类型</label>


            <select id="adType" class="col-sm-6 selectpicker">
                <c:forEach items="${adList}" var="d">
                    <option <c:if test="${d.name==adName}"> selected="selected" </c:if>
                            value="${d.id}">${d.name}</option>
                </c:forEach>

            </select>


        </div>


        <div class="form-group" style="display: none">
            <label for="startTime" class="col-md-2 control-label">起止日期</label>
            <div class="col-md-3 ">


                <label for="startTime" class="col-md-4 control-label">起始</label>
                <div class="input-group date form_datetime col-md-8" data-date="1979-09-16T05:25:07Z"
                     data-link-field="startTime">
                    <input class="form-control" id="startTime" size="16" type="text" value="2018-07-09" readonly
                           required>
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <div class="col-md-3 ">
                <label for="endTime" class="col-md-4  control-label">终止</label>
                <div class="input-group date form_datetime col-md-8" data-date="1979-09-16T05:25:07Z"
                     data-link-field="endTime">
                    <input class="form-control" id="endTime" size="16" type="text" value="2018-07-10" readonly required>
                    <%--<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>--%>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <input type="hidden" id="dtp_input1" value=""/><br/>
        </div>

        <!--//modify-->


        <div class="table-responsive col-md-7 col-md-offset-1" id="table" style="clear: both;margin-top: 30px">
            <table class="table">

                <thead>
                <tr>
                    <th>序号</th>
                    <th>客户名称</th>
                    <th>起止时间</th>

                </tr>
                </thead>
                <tbody>

                <c:forEach items="${customList}" var="c">


                    <tr>
                        <td>${c.id}</td>
                        <td>${c.name}</td>
                        <td>${c.contract.startDate}&nbsp;&nbsp; ${c.contract.endDate} </td>

                    </tr>
                </c:forEach>


                </tbody>
            </table>
        </div>


        <div class="form-group">
            <div class="col-xs-offset-4 col-sm-offset-6 col-sm-4">


                <c:choose>
                    <c:when test="${id>-1}">

                        <button type="button" class="mui-btn mui-btn-primary" onclick="modify()"> 修改广告</button>
                        <button type="button" class="mui-btn " onclick="back()" style="margin-left: 50px;">返回</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="mui-btn mui-btn-primary" onclick="confirm()"> 确定</button>
                        <button type="button" class="mui-btn " onclick="back()" style="margin-left: 50px;">返回</button>
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

        // $('#form').validator().on('submit', function (e) {
        //     if (e.isDefaultPrevented()) {
        //         //var useArea = $("#useArea").val();
        //         //alert(useArea)
        //         mui.toast('请填写完内容', {duration: 'short', type: 'div'})
        //
        //     } else {
        var houseId = $("#houseId").val();
        var userId = $.cookie('user_id');
        var goodsNameId = $("#goodsNameId").val();
        var loctionL = $("#loctionL").val();
        var useArea = $("#useArea").val();

        var num = $("#num").val();


        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var goodsStatusId = $("#goodsStatusId").val();
        var floor = $("#floor").val();
        var adType = $("#adType").val();
        var chartLoc = $("#chartLoc").val();
        if(chartLoc==''){
            chartLoc='fantasy';
        }
        var url = "/seckill/house_ad/" + houseId + "/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea
            + "/" + num + "/" + startTime + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + adType +"/"+chartLoc+ "/modify";
        // alert("come in")
        $.post(url, {}, function (result) {
            // alert(result)
            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('修改失败', {duration: 'short', type: 'div'})
            }
        });
        //
        //     }
        //
        // })


    }

    function confirm() {
        // $('#form').validator().on('submit', function (e) {
        //     if (e.isDefaultPrevented()) {
        //         //var useArea = $("#useArea").val();
        //         //alert(useArea)
        //         mui.toast('请填写完内容', {duration: 'short', type: 'div'})
        //
        //     } else {
        var userId = $.cookie('user_id');
        var goodsNameId = $("#goodsNameId").val();
        var loctionL = $("#loctionL").val();
        var useArea = $("#useArea").val();

        var num = $("#num").val();


        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var goodsStatusId = $("#goodsStatusId").val();
        var floor = $("#floor").val();
        var adType = $("#adType").val();
        var chartLoc = $("#chartLoc").val();
        if(chartLoc==''){
            chartLoc='fantasy';
        }
        if(useArea==''){
            useArea=0;
        }


        var url = "/seckill/house_ad/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + num + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + adType +"/"+chartLoc+ "/add";
        $.post(url, {}, function (result) {
            //alert(result);
            if (result >= 1) {

                // window.history.back();
                // location.reload()
                sessionStorage.setItem("need-refresh", true);

                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('添加失败', {duration: 'short', type: 'div'})
            }
        });
        //
        //     }
        //
        // })


    }
</script>
</html>