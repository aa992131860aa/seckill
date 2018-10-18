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
    <%@include file="common/jquery_ui.jsp" %>
    <style type="text/css">

        .table th, .table td {
            text-align: center;
            vertical-align: middle !important;
        }


    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">
        <c:if test="${type=='insert'}">点位码新增</c:if>
        <c:if test="${type=='update'}">点位码修改</c:if>
    </h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>


</header>
<div class="mui-content">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">


        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">点位码</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " placeholder="请输入点位码" required id="no"
                       value="${dot.no}">
            </div>


        </div>

        <div class="form-group">
            <label for="sale" class="col-sm-2 control-label">描述</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" id="content"
                       value="${dot.content}">
            </div>


        </div>

        <div class="form-group">
            <label for="profit" class="col-sm-2 control-label">备注</label>
            <div class="col-sm-3">
                <input type="text" class="form-control " style="background-color: #fff" id="remark"
                       value="${dot.remark}">
            </div>


        </div>


        <div class="form-group">
            <div class=" col-sm-5">


                <button style="float: right" id="confirmId" type="button"
                        class="mui-btn mui-btn-primary col-sm-offset-1"
                        onclick="confirm()"> 确认
                </button>

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

    var userId = $.cookie('user_id');


    $(function () {



        //更新上个页面传递的值


        $("#name").autocomplete({
            // searchStreedRoad_auto 输入框id
            source: function (request, response) {
                var url = '/seckill/contract_house/' + request.term + '/code';


                $.get(url, function (res) {
                    console.log(res)
                    response(
                        $.map(res, function (item) { // 此处是将返回数据转换为 JSON对象，并给每个下拉项补充对应参数
                            return {
                                // 设置item信息
                                label: item.name + "       " + item.remark, // 下拉项显示内容
                                value: item.name,   // 下拉项对应数值
                                code: item.code, // 其他参数， 可以自定义
                                companyList: item.companyList,  // 其他参数， 可以自定义</span>
                                workerList: item.workerList,
                                remark: item.remark,
                                id: item.id


                            }
                        }));
                })
            },
            minLength: 1,  // 输入框字符个等于2时开始查询
            select: function (event, ui) { // 选中某项时执行的操作
                // 存放选中选项的信息

                $("#code").val(ui.item.code);
                $("#customId").val(ui.item.id);


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
    });


    function confirm() {
        var type = '${type}';

        var no = $("#no").val();
        var content = $("#content").val();
        var remark = $("#remark").val();


        var id = '${dot.id}';

        var fantasy = "fantasy";
        if (id == '') {
            id = 0;
        }
        if (no == '') {
            no = fantasy;
        }
        if (content == '') {
            content = fantasy;
        }
        if (remark == '') {
            remark = 0;
        }


        if (no == '') {
            mui.toast('请输入点位码', {duration: 'short', type: 'div'})
            return;
        }
        //"/interact/{id}/{name}/{code}/{customId}/{sale}/{profit}/{tax}/{userId}/{date}/{type}"
        var url = "/seckill/interact_dot/" + id + "/" + no + "/" + content + "/" + remark + "/" + type;

        $.post(url, {}, function (result) {

            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                //window.history.back();
                //location.reload()
                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('添加失败', {duration: 'short', type: 'div'})
            }
            $("#confirmId").removeAttr("disabled");
        });


    }
</script>
</html>