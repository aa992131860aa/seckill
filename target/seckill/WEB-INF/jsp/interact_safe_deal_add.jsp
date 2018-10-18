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

        处理结果

    </h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>


</header>
<div class="mui-content">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 5%;margin-right: 5%;">

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">情况</label>

            正常
            <input value="0"
                   disabled
            <c:if test="${safe.isNormal==0}"> checked </c:if>

                   name="normal" type="radio"
                   style="width: 20px;height: 20px;margin-right: 30px"
                   onclick="srcId()"
            >
            异常
            <input
                    disabled
            <c:if test="${safe.isNormal==1}"> checked </c:if>

                    value="1" name="normal" type="radio"
                    style="width: 20px;height: 20px" onclick="srcId()"


            >


        </div>
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">详情描述</label>

            <%--<button <c:if test="${insert=='detail'}"> disabled </c:if> type="button" style="float: right;"--%>
            <%--class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"--%>
            <%--onclick="addContent()"> 新增内容--%>
            <%--</button>--%>

        </div>
        <div class="form-group">
            <div id="content" class="col-sm-offset-2">
                <c:forEach items="${safe.contentList}" var="list">

                    <div style="margin: 15px">
                        <textarea disabled style="float: left;width: 80%;margin-bottom: 10px"
                                  class=".content">${list}</textarea>
                            <%--<a style="float: right" onclick="delContent(this)">删除</a>--%>
                    </div>

                </c:forEach>


            </div>
        </div>

        <div class="form-group">
            <label for="sale" class="col-sm-2 control-label" style="font-size: 12px">签字拍照,问题拍照上传</label>
            <%--<button <c:if test="${insert=='detail'}"> disabled </c:if> type="button" style="float: right;"--%>
            <%--class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"--%>
            <%--onclick="uploadPhoto()"> 拍照上传--%>
            <%--</button>--%>
        </div>
        <div class="form-group">
            <div id="photolist" style="float: left" class="col-sm-offset-2">

                <c:forEach items="${safe.urlsList}" var="list">

                    <img onclick="delImg1(this)" class="img_photo" style="width: 33%;padding: 10px"
                         src="${list}"/>

                </c:forEach>

            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">处理意见</label>

            <button type="button" style="float: right;"
                    class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                    onclick="addContent()"> 新增内容
            </button>

        </div>
        <div class="form-group">
            <div id="dealContent" class="col-sm-offset-2">
                <div style="margin: 15px;clear: both">
                    <span style="float: left;width: 100px;"><strong>日期</strong></span>
                    <span style="float: left;width: 60%;margin-bottom: 10px"
                          class=".content"><strong>处理意见</strong></span>
                    <a style="float: right;"><strong>操作</strong></a>
                </div>
                <c:forEach items="${safeDealList}" var="list">

                    <div style="margin: 15px;clear: both">
                        <span class="dealDate" style="float: left;width: 100px;">${list.date}</span>
                        <textarea style="float: left;width: 60%;margin-bottom: 10px"
                                  class=".dealContent">${list.content}</textarea>
                        <a style="float: right;color: #ff0000" onclick="delContent(this)">删除</a>
                    </div>

                </c:forEach>


            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">是否处理完毕</label>

            完成
            <input id="isDeal"
                   <c:if test="${safe.isDeal==1}">checked</c:if>
                   name="normal" type="checkbox"
                   style="width: 20px;height: 20px;margin-right: 30px"

            >


        </div>
        <div class="form-group" style="margin-top: 3%;">
            <div class="">


                <button style="float: right" id="confirmId"
                        type="button"
                        class="mui-btn mui-btn-primary col-sm-offset-1"
                        onclick="confirm()"> 保存
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
    var usrName = $.cookie('name');

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

    function addContent() {

        var child = '     <div style="margin: 15px;clear: both">\n' +
            '                        <span class="dealDate" style="float: left;width: 100px;">${date}</span>\n' +
            '                        <textarea style="float: left;width: 60%;margin-bottom: 10px"\n' +
            '                                  class=".dealContent"></textarea>\n' +
            '                        <a style="float: right;color: #ff0000" onclick="delContent(this)">删除</a>\n' +
            '                    </div>';
        $("#dealContent").append(child);
    }

    function srcId() {
        $(".img_photo").each(function () {
            srcurl = $(this).attr('src');
            //alert(srcurl)

        })
    }


    function delImg(btn) {
        var insert = '${insert}';

        if (insert != 'detail') {
            btn.remove();
        }

    }

    function delContent(obj) {
        var insert = '${insert}';

        if (insert != 'detail') {
            obj.parentElement.remove();
        }
    }

    function confirm() {
        var flag1 = "@@";
        var deal = $("#isDeal").is(':checked');
        var safeId = '${safe.id}';
        var isDeal = 0;
        if (deal == true) {
            isDeal = 1
        }
        var userName = $.cookie('name');
        var contents = '';
        var dates = '';


        $("textarea").each(function () {
            if (!$(this).attr("disabled")) {
                contents += $(this).val() + flag1;
            }


        });
        $(".dealDate").each(function () {

            dates += $(this).html() + flag1;
        });

        if (contents == "") {
            contents = "fantasy";
        }
        if (dates == "") {
            dates = "fantasy";
        }
        var userName = $.cookie('name');


        ///interact_safe_deal/{safeId}/{contents}/{userName}/{dates}/{isDeal}/insert
        var url = "/seckill/interact_safe_deal/" + safeId + "/" + contents + "/" + userName + "/" + dates + "/" + isDeal + "/insert";

        $.post(url, {}, function (result) {

            if (result >= 1) {
                sessionStorage.setItem("need-refresh", true);
                window.location.href = document.referrer;
                window.history.back();
            } else {
                mui.toast('添加失败', {duration: 'short', type: 'div'})
            }

        });


    }

    wxConfig();

    function wxConfig() {
        var weixin = false;
        var timeC = $.cookie('time1');
        var signC = $.cookie('sign1');
        $.getJSON("/seckill/getJsapiTicket",
            {
                access_token: '${access_token}'  //获取的access_token
            },
            function (result) {
                console.log("result")
                console.log(result);
                var time = parseInt((new Date().getTime()) / 1000);
                $.get("/seckill/getJsSdkSign",
                    {
                        noncestr: "hssy",
                        jsapi_ticket: result.ticket,//获取的jsapi_ticket
                        timestamp: time,
                        url: location.href.split('#')[0]
                    },
                    function (sign) {
                        console.log("sign")
                        console.log(sign);
                        wx.config({
                            beta: true,// 必须这么写，否则wx.invoke调用形式的jsapi会有问题
                            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                            appId: 'ww3074360d47d2b7ed', // 必填，企业号的唯一标识，此处填写企业号corpid
                            timestamp: time, // 必填，生成签名的时间戳
                            nonceStr: 'hssy', // 必填，生成签名的随机串
                            signature: sign,// 必填，签名，见附录1
                            jsApiList: ['uploadImage', 'chooseImage', 'scanQRCode'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                        });
                        $.cookie('time', time, {expires: 1});
                        $.cookie('sign', sign, {expires: 1});
                    }
                );
            }
        );


        wx.ready(function () {
            weixin = true;


        });
        wx.error(function (res) {
            // config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
            console.log(res)


            // $.ajax({
            //     dataType: "json",
            //     url: "/seckill/getAccessToken",
            //     success: function (data) {
            //         console.log("data")
            //         console.log(data);
            //         alert(data)
            //         alert('token:' + data.access_token)
            //         $.cookie('access_token', data.access_token, {expires: 1});

            //     },
            //     error: function (XMLHttpRequest, textStatus, errorThrown) {
            //         console.log(textStatus + "," + errorThrown.toString())
            //     }
            // });

        });
    }


</script>
</html>