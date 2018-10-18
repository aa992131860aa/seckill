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
    <%--<link rel="stylesheet" type="text/css" href="/seckill/resources/css/my.css">--%>
    <style type="text/css">
        input[node-type=jsbridge] {
            display: none;
        }
    </style>
</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">用户反馈事项汇总表</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <div class="form-group-sm" style="margin-top: 30px;margin-left: 30px;">

        <label style="float: left;" class=" control-label">反馈人:<span id="userName"></span></label>

        <button class="mui-btn mui-btn-primary" style="margin-left: 30px;float: right;margin-right: 10px"
                onclick="scan()">
            新增反馈
        </button>
    </div>


    <div style="margin-top: 80px;" class="table-responsive" id="table">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>内容</th>
                <th>类别</th>
                <th>反馈时间</th>
                <th>详情</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${feedbackList}" var="list">
                <tr>
                    <td>${list.id}</td>
                    <td>${list.title}</td>
                    <td>
                        <c:if test="${list.type==0}">投诉类</c:if>
                        <c:if test="${list.type==1}">报修类</c:if>
                    </td>
                    <td>${list.date}</td>
                    <td><a onclick="modifyFree('${list.id}')">详情</a></td>

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

<script src="/seckill/resources/js/zepto.js"></script>
<script src="/seckill/resources/js/qrcode.min.js"></script>
<script src="/seckill/resources/js/qrcode.js"></script>

<script type="text/javascript" charset="utf-8">
    mui.init({
        swipeBack: true //启用右滑关闭功能
    });

    var userName = $.cookie('name');
    var userId = $.cookie('user_id');
    $("#userName").text(userName);
    var needRefresh = sessionStorage.getItem("need-refresh");
    if (needRefresh) {
        sessionStorage.removeItem("need-refresh");
        location.reload();
    }
    $(document).ready(function () {

        //初始化扫描二维码按钮，传入自定义的 node-type 属性

        Qrcode.init($('[node-type=qr-btn]'));

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
//   url: '/seckill/interact_feedback/' + userId + '/0/'+userName

            $(window).attr('location', '/seckill/interact_feedback/' + userId + '/' + (params.pageNum - 1) + '/' + userName);


        })


    });
    wxConfig();

    function wxConfig() {

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
                        //alert("sign:" + sign)
                        wx.config({  beta: true,// 必须这么写，否则wx.invoke调用形式的jsapi会有问题
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
            //         $.cookie('access_token', data.access_token, {expires: 1});

            //     },
            //     error: function (XMLHttpRequest, textStatus, errorThrown) {
            //         console.log(textStatus + "," + errorThrown.toString())
            //     }
            // });

        });
    }

    function scan() {
        mui.openWindow({
            url: '/seckill/interact_feedback/0/insert'

        })
    }

    function openPhoto() {
        wx.chooseImage({
            count: 1, // 默认9
            sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
            sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
            defaultCameraMode: "batch", //表示进入拍照界面的默认模式，目前有normal与batch两种选择，normal表示普通单拍模式，batch表示连拍模式，不传该参数则为normal模式。（注：用户进入拍照界面仍然可自由切换两种模式）
            success: function (res) {
                var localIds = res.localIds; // 返回选定照片的本地ID列表，
                // andriod中localId可以作为img标签的src属性显示图片；
                // 而在IOS中需通过上面的接口getLocalImgData获取图片base64数据，从而用于img标签的显示
            }
        });
    }

    function skip_free_add() {
        mui.openWindow({
            url: '/seckill/free_add'

        })

    }

    function modifyFree(id) {
        mui.openWindow({
            url: '/seckill/interact_feedback/' + id + '/update'

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