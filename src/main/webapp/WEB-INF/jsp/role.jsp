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
<style type="text/css">

</style>
<%--<link rel="stylesheet" href="/seckill/resources/css/demo.css" type="text/css">--%>
<link rel="stylesheet" href="/seckill/resources/css/zTreeStyle.css" type="text/css">
<%--<script type="text/javascript" src="../../../js/jquery-1.4.4.min.js"></script>--%>
<script type="text/javascript" src="/seckill/resources/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="/seckill/resources/js/jquery.ztree.excheck.js"></script>
<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>

    <h1 class="mui-title">权限分配</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">


    <div class="content_wrap">
        <div class="zTreeDemoBackground left">
            <ul id="treeDemo" class="ztree"></ul>
        </div>

    </div>
    <button onclick="onCheck()" style="margin-left: 40px;margin-top: 20px;" class="mui-btn mui-btn-primary"
            type="button">确定
    </button>


    <form class="form-horizontal" role="form" style="margin-top: 5%;margin-left: 3%;margin-right: 3%;display: none">
        <c:forEach items="${role1List}" var="r1">

            <div class="form-group">
                <h4>${r1.name}</h4>
                <c:forEach items="${r1.role2}" var="r2">


                    <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4">
                        <label>${r2.name}</label>
                        <input name="checkbox1" value="Item 1" type="checkbox" checked>
                    </div>
                    <c:forEach items="${r2.role3}" var="r3">

                        <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                            <label>${r3.name}</label>
                            <input name="checkbox1" value="Item 1" type="checkbox" checked>
                        </div>

                        <c:forEach items="${r3.role4}" var="r4">

                            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                                <label>${r4.name}</label>
                                <input name="checkbox1" value="Item 1" type="checkbox" checked>
                            </div>
                        </c:forEach>

                    </c:forEach>


                </c:forEach>


            </div>
        </c:forEach>


        <div class="form-group" style="display: none;">
            <h4>基础设置</h4>

            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4">
                <label>系统设置</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>

            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>系统管理员</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>

            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>


            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>工作日志</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>系统备份</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>


            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4">
                <label>费用类别</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>

            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>各种类别</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>


            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4">
                <label>合同类型</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>意向合同</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>广告合同</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>房源合同</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-2 col-sm-offset-1 col-md-offset-1">
                <label>车位合同</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
            </div>
            <div class="mui-input-row mui-checkbox mui-left col-xs-8 col-sm-4 col-md-4 col-xs-offset-4 col-sm-offset-2 col-md-offset-2">
                <label>新增录入、编辑/保存、删除</label>
                <input name="checkbox1" value="Item 1" type="checkbox" checked>
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
    var setting = {
        check: {
            enable: true
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };
    $(document).ready(function () {
        // var list = JSON.parse(${checkList});
        var list = ${checkList};

        $.fn.zTree.init($("#treeDemo"), setting, ${checkList});

    });

    function onCheck() {

        var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
            nodes = treeObj.getCheckedNodes(true),
            v = "";
        var role1 = "1,";
        var role2 = "2,";
        var role3 = "3,";
        var role4 = "4,";
        for (var i = 0; i < nodes.length; i++) {

            v = nodes[i].name + ",";
            if (nodes[i].level == 0) {
                role1 += nodes[i].id + ",";
            } else if (nodes[i].level == 1) {
                role2 += nodes[i].id + ",";
            }
            else if (nodes[i].level == 2) {
                role3 += nodes[i].id + ",";
            }
            else if (nodes[i].level == 3) {
                role4 += nodes[i].id + ",";
            }
            console.log("节点id:" + nodes[i].id + "节点名称" + v); //获取选中节点的值
        }
        if (nodes.length == 0) {
            mui.toast('请选择权限', {duration: 'short', type: 'div'})

        } else {
            var userId =  ${userId};
            var url = "/seckill/role/" + userId +"/"+role1+"/"+role2+"/"+role3+"/"+role4+"/modify"
            $.post(url, {}, function (result) {
                if (result == 1) {
                    location.href = document.referrer;                window.history.back();
                } else {
                    mui.toast('添加失败', {duration: 'short', type: 'div'})
                }

                //

            });
        }
    }

    function modify() {


        var name = $("#name").val();
        var department_id = $("#department_id").val();
        var url = "/seckill/department/" + department_id + "/" + name + "/modify"
        $.post(url, {}, function (result) {
            if (result == 1) {
                window.history.go(-1);
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
        var name = $("#name").val();
        var url = "/seckill/department/" + name + "/add"
        $.post(url, {}, function (result) {
            if (result == 1) {
                window.history.go(-1);
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