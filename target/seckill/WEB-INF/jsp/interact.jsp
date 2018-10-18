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
    <h1 class="mui-title">互动模块</h1>
    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <ul class="mui-table-view">
        <li class="mui-table-view-cell mui-collapse mui-active"  <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('保安作业')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>安保作业</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">

                        <li class="mui-table-view-cell" onclick="skipSafe()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('保安巡更点采集')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            保安巡更点采集
                        </li>

                        <li class="mui-table-view-cell" onclick="skipSafeDeal()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('保安巡检汇总表')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            保安巡检汇总表
                        </li>


                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('保洁员作业')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>保洁员作业</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">

                        <li class="mui-table-view-cell" onclick="skipClean()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('保洁清洁点采集')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            保洁清洁点采集
                        </li>

                        <li class="mui-table-view-cell" onclick="skipCleanDeal()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('保洁清洁汇总表')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            保洁清洁汇总表
                        </li>


                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('售后服务')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>售后服务</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipFeedback()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('投诉(维修)反馈')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            投诉(维修)反馈
                        </li>
                        <li class="mui-table-view-cell" onclick="skipFeedbackDeal()" <c:choose> <c:when
                                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                                test="${!role3.contains('投诉(维修)反馈汇总表')}"> style="display: none" </c:if></c:otherwise></c:choose>>
                            投诉(维修)反馈汇总表
                        </li>
                        <%--<li onclick="no()" class="mui-table-view-cell" <c:choose> <c:when--%>
                        <%--test="${is_admin=='1'}"></c:when><c:otherwise><c:if--%>
                        <%--test="${!role3.contains('结果')}"> style="display: none" </c:if></c:otherwise></c:choose>>--%>
                        <%--结果--%>
                        <%--</li>--%>
                    </ul>
                </div>


            </div>
        </li>


        <li class="mui-table-view-cell mui-collapse mui-active" <c:choose> <c:when
                test="${is_admin=='1'}"></c:when><c:otherwise><c:if
                test="${!role2.contains('用户录入')}"> style="display: none" </c:if></c:otherwise></c:choose>>
            <a class="mui-navigate-right" href="#"><strong>用户录入</strong></a>
            <div class="mui-collapse-content">
                <%--<div>系统管理员</div>--%>
                <%--<div>工作日志</div>--%>
                <%--<div>数据备份</div>--%>
                <div class="mui-collapse-content" style="margin-top: -20px">
                    <ul class="mui-table-view">
                        <li class="mui-table-view-cell" onclick="skipFinance()">财务数据录入</li>

                    </ul>
                </div>


            </div>
        </li>


    </ul>
</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();
    var userId = $.cookie('user_id');
    var userName = $.cookie('name');
    var isAdmin = $.cookie('is_admin');
    // wx.config({
    //     beta: true,// 必须这么写，否则wx.invoke调用形式的jsapi会有问题
    //     debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    //     appId: 'ww3074360d47d2b7ed', // 必填，企业微信的corpID
    //     timestamp: , // 必填，生成签名的时间戳
    //     nonceStr: '', // 必填，生成签名的随机串
    //     signature: '',// 必填，签名，见附录1
    //     jsApiList: [] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    // });
    function skipDepartment() {
        mui.openWindow({
            url: 'department/0/query'

        })
    }

    function no() {
        mui.toast('微信中打开', {duration: 'short', type: 'div'})
    }


    function check() {

        wx.checkJsApi({
            jsApiList: ['chooseImage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
            success: function (res) {
                console.log("res")
                console.log(res)

                // 以键值对的形式返回，可用的api值true，不可用为false
                // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
            }
        });
    }

    function scan() {
        wx.scanQRCode({
            desc: 'scanQRCode desc',
            needResult: 1, // 默认为0，扫描结果由企业微信处理，1则直接返回扫描结果，
            scanType: ["qrCode", "barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var resultStr = res.resultStr;
                // 回调
                // alert(res)
            },
            error: function (res) {
                if (res.errMsg.indexOf('function_not_exist') > 0) {
                    alert('版本过低请升级')
                }
            }
        });
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

    function skipSafe() {
        mui.openWindow({
            url: '/seckill/interact_safe/' + userId + '/0/safe/safe'

        })
    }


    function skipSafeDeal() {
        mui.openWindow({
            url: '/seckill/interact_safe_deal/' + userId + '/0/safe/safe'

        })
    }

    function skipFeedback() {
        mui.openWindow({
            url: '/seckill/interact_feedback/' + userId + '/0/' + userName

        })
    }


    function skipFeedbackDeal() {
        mui.openWindow({
            url: '/seckill/interact_feedback/' + userId + '/0/deal'

        })
    }

    function skipClean() {
        mui.openWindow({
            url: '/seckill/interact_clean/' + userId + '/0/clean/clean'

        })
    }


    function skipCleanDeal() {
        mui.openWindow({
            url: '/seckill/interact_clean_deal/' + userId + '/0/clean/clean'

        })
    }

    function skipFinance() {
        mui.openWindow({
            url: '/seckill/interact/' + userId + '/0/' + isAdmin + '/noExport'
        })
    }

    function skipRole() {
        mui.openWindow({
            url: 'user/0/query'

        })
    }
</script>
</html>