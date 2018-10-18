//javaScrip模块化
var seckill = {
    URL: {
        now: "/seckill/time/now",
        exposer: function (seckillId) {
            return "/seckill/" + seckillId + "/exposer";
        },
        execution: function (seckillId, md5) {
            return "/seckill/" + seckillId + "/" + md5 + "/execution";
        }

    },
    validatePhone: function (phone) {
        if (phone && phone.length == 11 && !isNaN(phone)) {
            return true;
        } else {
            return false;
        }
    },
    handlerSeckill: function (seckillId, node) {
        node.hide().html('<button class="btn btn-success" id="killBtn">秒杀开始</button>');
        $.post(seckill.URL.exposer(seckillId), {}, function (result) {
            if (result && result["success"]) {
                var exposer = result["data"];
                if (exposer["exposer"]) {
                    //开启秒杀
                    var md5 = exposer["md5"];
                    var killExecution = seckill.URL.execution(seckillId, md5);
                    $("#killBtn").one("click", function () {
                        $(this).addClass("disabled");
                        $.post(killExecution, {}, function (result) {
                            if (result && result["success"]) {
                                var killResult = result["data"];
                                var state = killResult["state"];
                                var stateInfo = killResult["stateInfo"];
                                node.html('<label class="label label-success">'+stateInfo+'</label>')
                            }
                        })
                    })
                }
            }
            node.show();
        });

    },
    countdown: function (seckillId, nowTime, startTime, endTime) {
        var seckill_box = $("#seckill_box");
        if (nowTime > endTime) {
            seckill_box.html("秒杀结束");
        } else if (nowTime < startTime) {

            // var newYear = new Date();
            // newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1);
            // $('#defaultCountdown').countdown({until: newYear});

            var killTime = new Date(startTime + 1000);
            seckill_box.countdown({until: killTime}, function (event) {
                var format = event.strftime("秒杀倒计时:%D 天%H 时%M 分%S 秒")
                seckill_box.html(format);
            })
        } else {
            //秒杀开始
            seckill.handlerSeckill(seckillId, seckill_box);
        }

    },
    detail: {
        init: function (params) {
            var killPhone = $.cookie("killPhone");
            var startTime = params['startTime'];
            var endTime = params['endTime'];
            var seckillId = params['seckillId'];
            //cookie没有值
            if (!seckill.validatePhone(killPhone)) {
                var killPhoneModal = $("#killPhoneModal");
                killPhoneModal.modal({
                    show: true,            //显示
                    backdrop: "static",    //禁止位置
                    keyboard: false       //关闭键盘事件
                });


                $("#killPhoneBtn").click(function () {
                    var killPhone = $("#killPhoneKey").val();
                    if (seckill.validatePhone(killPhone)) {
                        $.cookie("killPhone", killPhone, {expires: 7, path: "/seckill"});
                        window.location.reload();
                    } else {
                        $("#killPhoneMessage").hide().html("<label class='label label-danger'>手机号码错误</label>").show(300);
                    }
                });

            }
            //已经登录了
            else {
                $.get(seckill.URL.now, {}, function (result) {
                    if (result && result["success"]) {
                        var nowTime = result["data"];
                        seckill.countdown(seckillId, nowTime, startTime, endTime)
                    }
                });
            }
        }
    }
}