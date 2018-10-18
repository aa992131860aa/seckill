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

        .modal-dialog {
            width: 90%;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
        }

        .modal-content {
            /*overflow-y: scroll; */
            position: absolute;
            top: 0;
            bottom: 0;
            width: 100%;
        }

        .modal-body {
            overflow-y: scroll;
            position: absolute;
            top: 55px;
            bottom: 65px;
            width: 100%;
        }

        .modal-header .close {
            margin-right: 15px;
        }

        .modal-footer {
            position: absolute;
            width: 100%;
            bottom: 0;
        }

    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:choose>
        <c:when test="${id>-1}">
            <h1 class="mui-title">房源修改</h1>
        </c:when>
        <c:otherwise>
            <h1 class="mui-title">房源新增</h1>
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


        <div class="form-group">
            <label for="useArea" class="col-sm-2 control-label">使用面积</label>
            <div class="col-sm-6">

                <input type="text" pattern="^[0-9]+([.]{1}[0-9]+){0,1}$" required class="form-control" id="useArea"
                       value="${useArea}">

            </div>
        </div>

        <div class="form-group">
            <label for="buildArea" class="col-sm-2 control-label">建筑面积</label>
            <div class="col-sm-6">

                <input type="text" pattern="^[0-9]+([.]{1}[0-9]+){0,1}$" required class="form-control" id="buildArea"
                       value="${buildArea}">

            </div>
        </div>

        <div class="form-group">
            <label for="num" class="col-sm-2 control-label">数量</label>
            <div class="col-sm-6">

                <input type="text" pattern="^(-|\+)?\d+$" required class="form-control" id="num" value="${num}">

            </div>
        </div>

        <div class="form-group">
            <label for="linkHouse" class="col-sm-2 control-label">关联房号</label>
            <div class="col-sm-6">

                <input type="text" class="form-control" id="linkHouse" value="${linkHouse}">

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


            <select id="goodsStatusId" class="col-sm-6 selectpicker" disabled style="background-color: #FFFFFF;">
                <c:forEach items="${goodsStatusList}" var="d">
                    <option <c:if test="${d.id==goodsStatusId}"> selected="selected" </c:if>
                            value="${d.id}">${d.name} </option>
                </c:forEach>

            </select>


        </div>


        <div class="form-group">
            <label for="unit" class="col-sm-2 control-label">单价(元/平方米,天)</label>
            <div class="col-sm-6">

                <input type="text" pattern="^[0-9]+([.]{1}[0-9]+){0,1}$" required class="form-control" id="unit"
                       value="${unit}">

            </div>
        </div>


        <div class="form-group">
            <label for="cash" class="col-sm-2 control-label">保证金</label>
            <div class="col-sm-6">

                <input type="text" pattern="^[0-9]+([.]{1}[0-9]+){0,1}$" required class="form-control" id="cash"
                       value="${cash}">

            </div>
        </div>

        <div class="form-group">
            <label for="waterNo" class="col-sm-2 control-label">水表编号</label>
            <div class="col-sm-5">

                <input type="text" class="form-control" id="waterNo" value="${waterNo}">

            </div>
            <button type="button" data-toggle="modal" data-target="#myModal" onclick="degreeDetail('water')">度数详情
            </button>
        </div>

        <div class="form-group">
            <label for="powerNo" class="col-sm-2 control-label">电表编号</label>
            <div class="col-sm-5">

                <input type="text" class="form-control" id="powerNo" value="${powerNo}">

            </div>
            <button type="button" data-toggle="modal" data-target="#myModal" onclick="degreeDetail('power')">度数详情
            </button>
        </div>

        <div class="form-group">
            <label for="airNo" class="col-sm-2 control-label">空调编号</label>
            <div class="col-sm-5">

                <input type="text" class="form-control" id="airNo" value="${airNo}">

            </div>
            <button type="button" data-toggle="modal" data-target="#myModal" onclick="degreeDetail('air')">度数详情</button>
        </div>

        <div class="form-group">
            <label for="airNo" class="col-sm-2 control-label">是否带窗</label>
            <div class="col-sm-6">
                <div class="radio">
                    <label>
                        <input type="radio" style="width: 20px;height: 20px;" name="optionsRadios" id="isWindow1"
                               value="1" <c:if test="${house.isWindow==1}"> checked </c:if>>
                        带
                    </label>
                </div>
                <div class="radio">
                    <label>
                        <input type="radio" style="width: 20px;height: 20px;" name="optionsRadios" id="isWindow2"
                               value="0" <c:if test="${house.isWindow==0}"> checked </c:if>>
                        不带
                    </label>


                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="airNo" class="col-sm-2 control-label">备注栏</label>
            <div class="col-sm-6">

                <textarea rows="3" id="remark">${house.remark}</textarea>

            </div>
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
                    <input class="form-control" id="endTime" size="16" type="text" value="2018-07-10" readonly
                           required>
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
                    <th>租房类型</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${customList}" var="c">


                    <tr>
                        <td>${c.id}</td>
                        <td>
                                ${c.name}
                        </td>
                        <td>${c.contract.startDate}&nbsp;&nbsp; ${c.contract.endDate} </td>

                        <td>

                            <c:if test="${c.contract.house1=='true'}">
                                &nbsp;&nbsp;
                                房子租赁
                            </c:if>

                            <c:if test="${c.contract.house2=='true'}">
                                &nbsp;&nbsp;
                                注册租赁
                            </c:if>

                            <c:if test="${c.contract.house3=='true'}">
                                &nbsp;&nbsp;
                                虚拟租赁
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>


        <div class="form-group">
            <div class="col-xs-offset-4 col-sm-offset-6 col-sm-4">


                <c:choose>
                    <c:when test="${id>-1}">

                        <button type="button" class="mui-btn mui-btn-primary" onclick="modify()"> 修改用户</button>
                        <button type="button" class="mui-btn " onclick="back()" style="margin-left: 50px;">返回
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="mui-btn mui-btn-primary" onclick="confirm()"> 确定</button>
                        <button type="button" class="mui-btn " onclick="back()" style="margin-left: 50px;">返回
                        </button>
                    </c:otherwise>


                </c:choose>
            </div>

        </div>
    </form>
    <div style="height: 50px;"></div>

</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" style="text-align: center" id="myModalLabel">
                    度数详情
                </h4>
            </div>
            <div class="modal-body" style="overflow:auto;">

                <div class="form-group">
                    <div class="table-responsive col-md-12" id="free"
                         style="clear: both;margin-top: 30px">
                        <table class="table">

                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>抄表时间</th>
                                <th>抄表度数</th>
                                <th>使用度数</th>
                                <th>单价</th>
                                <th>总价(元)</th>
                                <th>来源</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="detailTb">

                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <%--<button type="button" class="btn btn-primary">--%>
                <%--提交更改--%>
                <%--</button>--%>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


</body>
<script type="text/javascript" charset="utf-8">
    mui.init({

        beforeback: function () {


        }
    });

    function degreeDetail(style) {
        var loc = $("#loctionL").val();
        var url = '/seckill/free_report_detail/' + loc + '/' + style;
        $.post(url, {}, function (result) {
            // var obj = JSON.stringify(result);
            var obj = result;

            $("#detailTb").html("");
            $.each(obj, function (n, value) {

                var trObj = document.createElement("tr");
                trObj.id = "detail";
                trObj.name = "detail";
                var source = '';
                if (value["source"] == 'auto') {
                    source = '数据导入';
                }
                if (value["source"] == 'handle') {
                    source = '手动输入';
                }
                if (value["source"] == 'contract') {
                    source = '合同抄表';
                }
                var time = ' <div     class="input-group date form_datetime" data-date="1979-09-16T05:25:07Z" data-link-field="startTime"> ' +
                    '<input style="background-color: #fff;margin-top: 15px;height: 35px;text-align: center" name="time66" id="da' + value["id"] + '" size="16" type="text" value="' + value["date"] + '" class="form-control"  readonly > ' +
                    '<span style="height: 30px;display: none;" class="input-group-addon">' +
                    '<span style="height: 30px;" class="glyphicon glyphicon-th"></span></span> </div>'
                var line = '<td><input   disabled style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" value="' + value["id"] + '" type="text"  name="name2H"  /></td>' +
                    '<td>' + time + '</td>' +
                    '<td><input  placeholder="输入度数" style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="de' + value["id"] + '" value="' + value["degree"] + '" type="number" name="price2H"  /></td>' +
                    '<td><input disabled style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + value["useDegree"] + '" type="text" name="unit2H"  /></td>' +
                    '<td><input disabled style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + value["price"] + '" type="text" name="unit2H"  /></td>' +
                    '<td><input disabled   style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + value["total"] + '" type="text" name="money2H"  /></td>' +
                    '<td><input  disabled  style="border-bottom: 1px solid #dbdbdb;border-top:0px;border-left:0px;border-right:0px;text-align: center;border-radius:0;" id="" value="' + source + '" type="text" name="money2H"  /></td>' +
                    '<td nowrap="nowrap"><a style="color: #1d4499;" onclick="saveFreeReport(' + value["id"] + ',\'' + value["type"] + '\',\'' + value["isOk"] + '\')" >保存</a> | <a style="color: #ff0000" onclick="delFreeReport(' + value["id"] + ',\'' + value["type"] + '\',\'' + value["isOk"] + '\')">删除</a> </td>'
                //trObj.innerHTML = "<td><input name='firstName'/></td><td><input name='lastName'/></td><td><input type='button' value='Add' onclick='add()'> <input type='button' value='Del' onclick='del(this)'></td>";
                trObj.innerHTML = line;
                var parent = document.getElementById("detailTb");
                parent.appendChild(trObj);

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


        });


    }

    function delFreeReport(id, style, isOk) {
        if (isOk == 1) {
            mui.toast('已复核成功,不可删除', {duration: 'short', type: 'div'})
        } else {
            var url = "/seckill/house/freeExport/" + id + "/del";
            $.post(url, {}, function (result) {
                //alert(result)
                //mui.toast('result:'+result, {duration: 'short', type: 'div'})


                if (result >= 1) {

                    mui.toast('已删除', {duration: 'short', type: 'div'})

                    degreeDetail(style)

                } else {
                    mui.toast('修改失败', {duration: 'short', type: 'div'})
                }
            });
        }
    }

    function saveFreeReport(id, style, isOk) {

        var date = $("#da" + id).val();
        var degree = $("#de" + id).val();
        if (date == '') {
            date = 'fantasy';
        }
        if (isOk == 1) {
            mui.toast('已复核成功,不可修改', {duration: 'short', type: 'div'})
        } else {
            var url = "/seckill/house/freeExport/update/" + date + "/" + degree + "/" + id;
            $.post(url, {}, function (result) {
                //alert(result)
                //mui.toast('result:'+result, {duration: 'short', type: 'div'})


                if (result >= 1) {
                    mui.toast('已修改', {duration: 'short', type: 'div'})
                    degreeDetail(style)
                } else {
                    mui.toast('修改失败', {duration: 'short', type: 'div'})
                }
            });
        }


    }

    function back() {
        window.history.go(-1);
    }

    function modify() {


        // $('#form').validator().on('submit', function (e) {
        //
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
        var buildArea = $("#buildArea").val();
        var num = $("#num").val();
        var linkHouse = $("#linkHouse").val();
        var unit = $("#unit").val();
        var cash = $("#cash").val();
        var waterNo = $("#waterNo").val();
        var powerNo = $("#powerNo").val();
        var airNo = $("#airNo").val();
        if (linkHouse == '') {
            linkHouse = 'fantasy';
        }
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var goodsStatusId = $("#goodsStatusId").val();
        var floor = $("#floor").val();
        var remark = $("#remark").val();
        var isWindow = 1;

        var chartLoc = $("#chartLoc").val();
        if (chartLoc == '') {
            chartLoc = 'fantasy';
        }

        if (waterNo == '') {
            waterNo = 'fantasy';
        }
        if (powerNo == '') {
            powerNo = 'fantasy';
        }
        if (airNo == '') {
            airNo = 'fantasy';
        }
        if (remark == '') {
            remark = 'fantasy';
        }
        if (document.getElementById("isWindow1").checked) {
            isWindow = 1;
        } else {
            isWindow = 0;
        }

        var url = "/seckill/house/" + houseId + "/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + buildArea
            + "/" + num + "/" + linkHouse + "/" + unit + "/" + cash + "/" + waterNo + "/" + powerNo + "/" + airNo + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + isWindow + "/" + remark + "/" + chartLoc + "/modify";
        //alert("come in")
        $.post(url, {}, function (result) {
            //alert(result)
            //mui.toast('result:'+result, {duration: 'short', type: 'div'})


            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
                //window.history.back()  ;              //location.reload()

            } else {
                mui.toast('修改失败', {duration: 'short', type: 'div'})
            }
        });
        console.log('this')

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
        var buildArea = $("#buildArea").val();
        var num = $("#num").val();
        var linkHouse = $("#linkHouse").val();
        if (linkHouse == '') {
            linkHouse = 'fantasy';
        }
        var unit = $("#unit").val();
        var cash = $("#cash").val();
        var waterNo = $("#waterNo").val();
        var powerNo = $("#powerNo").val();
        var airNo = $("#airNo").val();

        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        var goodsStatusId = $("#goodsStatusId").val();
        var floor = $("#floor").val();
        var remark = $("#remark").val();
        var isWindow = 1;
        var chartLoc = $("#chartLoc").val();
        if (chartLoc == '') {
            chartLoc = 'fantasy';
        }
        if (cash == '') {
            cash = '0';
        }


        if (waterNo == '') {
            waterNo = 'fantasy';
        }
        if (powerNo == '') {
            powerNo = 'fantasy';
        }
        if (airNo == '') {
            airNo = 'fantasy';
        }
        if (remark == '') {
            remark = 'fantasy';
        }
        if (document.getElementById("isWindow1").checked) {
            isWindow = 1;
        } else {
            isWindow = 0;
        }
        var url = "/seckill/house/" + userId + "/" + goodsNameId + "/" + loctionL + "/" + useArea + "/" + buildArea
            + "/" + num + "/" + linkHouse + "/" + unit + "/" + cash + "/" + waterNo + "/" + powerNo + "/" + airNo + "/" + startTime
            + "/" + endTime + "/" + goodsStatusId + "/" + floor + "/" + isWindow + "/" + remark + "/" + chartLoc + "/add";
        $.post(url, {}, function (result) {
            //alert(result);
            if (result >= 1) {
                // window.history.back()  ;
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