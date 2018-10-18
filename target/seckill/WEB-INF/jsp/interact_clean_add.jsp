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

        <c:if test="${insert=='insert'}">清洁新增</c:if>
        <c:if test="${insert=='update'}">清洁修改</c:if>
        <c:if test="${insert=='detail'}">清洁详情</c:if>
    </h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>


</header>
<div class="mui-content">

    <form id="form" data-toggle="validator" class="form-horizontal" role="form"
          style="margin-top: 5%;margin-left: 5%;margin-right: 5%;">

        <%--<div class="form-group">--%>
        <%--<label for="name" class="col-sm-2 control-label">情况</label>--%>

        <%--正常--%>
        <%--<input value="0"--%>
        <%--<c:if test="${insert=='insert'}"> checked</c:if>--%>
        <%--<c:if test="${safe.isNormal==0 && insert=='detail'}"> checked disabled</c:if>--%>
        <%--<c:if test="${safe.isNormal==0 && insert=='update'}"> checked </c:if>--%>
        <%--name="normal" type="radio"--%>
        <%--style="width: 20px;height: 20px;margin-right: 30px"--%>
        <%--onclick="srcId()"--%>
        <%-->--%>
        <%--异常--%>
        <%--<input--%>
        <%--<c:if test="${safe.isNormal==1 && insert=='detail'}"> checked disabled</c:if>--%>
        <%--<c:if test="${safe.isNormal==1 && insert=='update'}"> checked </c:if>--%>
        <%--value="1" name="normal" type="radio"--%>
        <%--style="width: 20px;height: 20px" onclick="srcId()"--%>


        <%-->--%>


        <%--</div>--%>
        <%--<div class="form-group">--%>
        <%--<label for="name" class="col-sm-2 control-label">详情描述</label>--%>

        <%--<button <c:if test="${insert=='detail'}"> disabled </c:if> type="button" style="float: right;"--%>
        <%--class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"--%>
        <%--onclick="addContent()"> 新增内容--%>
        <%--</button>--%>

        <%--</div>--%>
        <%--<div class="form-group">--%>
        <%--<div id="content">--%>
        <%--<c:forEach items="${safe.contentList}" var="list">--%>

        <%--<div style="margin: 15px">--%>
        <%--<textarea style="float: left;width: 80%;margin-bottom: 10px" class=".content">${list}</textarea>--%>
        <%--<a style="float: right" onclick="delContent(this)">删除</a>--%>
        <%--</div>--%>

        <%--</c:forEach>--%>


        <%--</div>--%>
        <%--</div>--%>

        <div class="form-group">
            <label for="sale" class="control-label" style="font-size: 12px">保洁签字照,效果拍照上传(点击图片删除)</label>
            <button <c:if test="${insert=='detail'}"> disabled </c:if> type="button" style="float: right;"
                                                                       class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
                                                                       onclick="uploadPhoto()"> 拍照上传
            </button>
        </div>


        <div class="form-group">
            <div id="photolist" style="float: left">

                <c:forEach items="${safe.urlsList}" var="list">

                    <img alt="${list}" class="new_photo" style="display: none" id="ios9${c.index}" src="${list}"> <img
                        id="img9${c.index}" onclick="delImg(this)" class="img_photo" style="width: 30%;padding: 10px"
                        src="${list}"/>


                </c:forEach>

            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">是否保洁完成</label>

            完成
            <input id="isNormal"
                   <c:if test="${safe.isNormal==1}">checked</c:if>
            <c:if test="${insert=='detail'}"> disabled </c:if>
                   name="normal" type="checkbox"
                   style="width: 20px;height: 20px;margin-right: 30px"

            >


        </div>

        <div class="form-group">
            <div class="">


                <button <c:if test="${insert=='detail'}"> disabled </c:if> style="float: right" id="confirmId"
                                                                           type="button"
                                                                           class="mui-btn mui-btn-primary col-sm-offset-1"
                                                                           onclick="confirm()"> 保存
                </button>


            </div>

        </div>

        <%--<div class="form-group">--%>
        <%--<label for="name" class="col-sm-2 control-label">处理意见</label>--%>

        <%--&lt;%&ndash;<button type="button" style="float: right;"&ndash;%&gt;--%>
        <%--&lt;%&ndash;class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"&ndash;%&gt;--%>
        <%--&lt;%&ndash;onclick="addContent()"> 新增内容&ndash;%&gt;--%>
        <%--&lt;%&ndash;</button>&ndash;%&gt;--%>

        <%--</div>--%>
        <%--<div class="form-group">--%>
        <%--<div id="dealContent" class="col-sm-offset-2">--%>
        <%--<div style="margin: 15px;clear: both">--%>
        <%--<span style="float: left;width: 100px;"><strong>日期</strong></span>--%>
        <%--<span style="float: left;width: 60%;margin-bottom: 10px"--%>
        <%--class=".content"><strong>处理意见</strong></span>--%>
        <%--<a style="float: right;"><strong>操作</strong></a>--%>
        <%--</div>--%>
        <%--<c:forEach items="${safeDealList}" var="list">--%>

        <%--<div style="margin: 15px;clear: both">--%>
        <%--<span class="dealDate" style="float: left;width: 100px;">${list.date}</span>--%>
        <%--<textarea disabled style="float: left;width: 60%;margin-bottom: 10px"--%>
        <%--class=".dealContent">${list.content}</textarea>--%>
        <%--&lt;%&ndash;<a style="float: right;color: #ff0000" onclick="delContent(this)">删除</a>&ndash;%&gt;--%>
        <%--</div>--%>

        <%--</c:forEach>--%>


        <%--</div>--%>
        <%--</div>--%>

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

        var child = '         <div style="margin: 15px">\n' +
            '                    <textarea style="float: left;width: 80%;margin-bottom: 10px" class=".content"></textarea>\n' +
            '                    <a style="float: right" onclick="delContent(this)">删除</a>\n' +
            '                </div>';
        $("#content").append(child);
    }

    function srcId() {
        $(".img_photo").each(function () {
            srcurl = $(this).attr('src');
            //alert(srcurl)

        })
    }

    function uploadPhoto() {
        var images = {
            localId: []
        };
        var rows = "";

        wx.chooseImage({
            count: 9, // 默认9 计算还可以选择几张图片 我这默认是8
            sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
            sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
            success: function (res) {

                //$("#photolist").html("");//每次选择图片完成后都清空之前已经添加的html节点


                rows = "";//声明一个空字符串用于保存循环出来的html
                images.localId = images.localId.concat(res.localIds); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片

                if (window.__wxjs_is_wkwebview) {  //判断ios是不是用的 wkwebview 内核


                    for (var i = 0; i < images.localId.length; i++) {
                        var oldLocalId = images.localId[i];

                        wx.getLocalImgData({  //循环调用  getLocalImgData

                            localId: res.localIds[i], // 图片的localID
                            success: function (res) {
                                var ioslocId = [];

                                var localData = res.localData; // localData是图片的base64数据，可以用img标签显示
                                localData = localData.replace('jgp', 'jpeg');//iOS 系统里面得到的数据，类型为 image/jgp,因此需要替换一下
                                ioslocId.push(localData)  //把base64格式的图片添加到ioslocId数组里 这样该数组里的元素都是base64格式的

                                rows = "";
                                for (var j = 0; j < ioslocId.length; j++) {
                                    //  rows += '<div class="z_file" style="background-image: url(' + ioslocId[j] + ')"><div class="delete" id="w' + j + '"></div></div>';

                                    rows += '<img class="new_photo" style="display: none" alt="' + oldLocalId + '" id="ios' + i + '" src="' + oldLocalId + '" > <img id="img' + i + '" onclick="delImg(this)" class="img_photo" style="width: 30%;padding: 10px" src="' + ioslocId[j] + '"/>'

                                }


                                var oldPhotoList = $("#photolist").html();

                                $("#photolist").html(oldPhotoList + rows);

                            }, fail: function (res) {
                                alert("res:" + res);
                            }
                        });
                    }

                }
                else {  //如果不是用的wkwebview 内核 或者是用的安卓系统 执行下面的xunh


                    $.each(images.localId, function (index, el) {

                        //上传图片测试
                        // wx.uploadImage({
                        //     localId: el, // 需要上传的图片的本地ID，由chooseImage接口获得
                        //     isShowProgressTips: 1, // 默认为1，显示进度提示
                        //     success: function (res) {
                        //         var serverId = res.serverId; // 返回图片的服务器端ID
                        //         ///interact_safe/{mediaId}/{access_token}/{type}/upload
                        //         var access_token = 'access_token';
                        //         var url = "/seckill/interact_safe/" + serverId + "/" + access_token + "/type/upload";
                        //
                        //         $.post(url, {}, function (result) {
                        //
                        //         });
                        //     }
                        // });
                        //  rows += '<div class="z_file" style="background-image: url(' + el + ')"><div class="delete" id="w' + index + '"></div></div>'
                        rows += '<img style="display: none" id="ios' + index + '" class="new_photo" src="' + el + '" alt="' + el + '"> <img id="img' + index + '" onclick="delImg(this)" class="img_photo" style="width: 33%;padding: 10px" src="' + el + '"/>'

                    });
                    var oldPhotoList = $("#photolist").html();

                    $("#photolist").html(oldPhotoList + rows);

                }


            }, fail: function (res) {
                alert("res");
            }
        });
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
            $("#" + obj.id.replace('img', 'ios')).remove();
        }
    }

    function confirm() {
        var flag1 = "@@";

        var normal = $("#isNormal").is(':checked');
        var isNormal = 0;
        if (normal == true) {
            isNormal = 1
        }

        var dot = '${dot}';
        var content = "";
        var srcUrls = "";
        var insert = '${insert}';
        var id = '${safe.id}';
        if (id == '') {
            id = 0;
        }
        $("textarea").each(function () {
            if (!$(this).attr("disabled")) {
                content += $(this).val() + flag1;
            }
        });

        $(".new_photo").each(function (index) {
            srcurl = $(this).attr('alt');

            var len = $(".new_photo").length - index - 1;

            if (srcurl.indexOf("/download/") != -1) {
                if(content==''){
                    content="fantasy";
                }
                srcurl = srcurl.split("/download/")[1];
                srcUrls += srcurl + flag1;
                if (len == 0) {
                    var url = "/seckill/interact_clean/" + id + "/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/" + usrName + "/" + insert;

                    // return;
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
            } else {
                //上传图片测试
                wx.uploadImage({
                    localId: srcurl, // 需要上传的图片的本地ID，由chooseImage接口获得
                    isShowProgressTips: 1, // 默认为1，显示进度提示
                    success: function (res) {
                        var serverId = res.serverId; // 返回图片的服务器端ID
                        srcUrls += serverId + flag1;
                        if (len == 0) {

                            var url = "/seckill/interact_clean/" + id + "/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/" + usrName + "/" + insert;

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
                    }
                });
            }


        })
        if (content == "") {
            content = "fantasy";
        }

        var userName = $.cookie('name');

        if ($(".new_photo").length == 0) {

            if (srcUrls == "") {
                srcUrls = "fantasy";
            }
            if(content==''){
                content="fantasy";
            }
            var url = "/seckill/interact_clean/" + id + "/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/" + userName + "/" + insert;

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

        //"/interact/{id}/{name}/{code}/{customId}/{sale}/{profit}/{tax}/{userId}/{date}/{type}"


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