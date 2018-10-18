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

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <c:if test="${type=='water'}">
        <h1 class="mui-title">水表数据导入</h1>
    </c:if>
    <c:if test="${type=='power'}">
        <h1 class="mui-title">电表数据导入</h1>
    </c:if>
    <c:if test="${type=='air'}">
        <h1 class="mui-title">空调表数据导入</h1>
    </c:if>


    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">

    <form class="form-horizontal" method="POST" action="/seckill/house/freeExport/add/${type}"
          enctype="multipart/form-data"
          role="form" style="margin-top: 5%;margin-left: 3%;margin-right: 3%;">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">

                <c:if test="${type=='water'}">
                    <h1 class="mui-title">水表数据导入</h1>
                </c:if>
                <c:if test="${type=='power'}">
                    <h1 class="mui-title">电表数据导入</h1>
                </c:if>
                <c:if test="${type=='air'}">
                    <h1 class="mui-title">空调表数据导入</h1>
                </c:if>

            </label>
            <div class="col-sm-6">

                <input type="file" class="form-control" id="uploadXls" name="uploadXls" value="${name}"/>

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-4">


                <button type="submit" class="mui-btn mui-btn-primary"> 确定</button>

            </div>

        </div>
    </form>
    <div style="height: 50px;"></div>
    <h3 style="margin-left: 5%;">导入历史</h3>
    <div class="table-responsive" id="table">
        <table class="table">

            <thead>
            <tr>
                <th>序号</th>
                <th>房号</th>
                <th>
                    <c:if test="${type=='water'}">水表号</c:if>
                    <c:if test="${type=='power'}">电表号</c:if>
                    <c:if test="${type=='air'}">空调表号</c:if>
                </th>
                <th>抄表时间</th>
                <th>本期度数</th>
                <th>个数</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${freeExportList}" var="list">
                <c:if test="${list.source=='auto'}">


                <tr>
                    <td>${list.id}</td>
                    <td>${list.loc}</td>
                    <td>${list.no}</td>
                    <td>${list.date}</td>
                    <td>${list.degree}</td>

                  <td>${list.count}</td>
                </tr>    </c:if>
            </c:forEach>

            </tbody>
        </table>
    </div>

</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init({

        beforeback: function () {


        }
    });

    function ok() {
        alert(1)
        window.history.go(-2)
    }

    function modify() {


        var name = $("#name").val();
        var car_id = $("#car_id").val();
        var url = "/seckill/car/" + car_id + "/" + name + "/modify"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
                // window.history.back()  ;              //location.reload()
                //  window.location.href=document.referrer;
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

        var url = "/seckill/house/freeExport/add"
        $.post(url, {}, function (result) {
            if (result == 1) {
                sessionStorage.setItem("need-refresh", true);
                location.href = document.referrer;
                window.history.back();
                // window.history.back()  ;              //location.reload()
                //  window.location.href=document.referrer;
                //window.history.back()  ;              //location.reload();
                // window.location.href=document.referrer;
                // location.replace(this.href);
                // event.returnValue = false;
                //parent.//location.reload();
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