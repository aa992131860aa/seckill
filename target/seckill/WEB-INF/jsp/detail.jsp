<%--
  Created by IntelliJ IDEA.
  User: 99213
  Date: 2018/1/28
  Time: 21:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>详情界面</title>
    <%@include file="common/head.jsp" %>
    <%@include file="common/tag.jsp" %>
</head>
<body>

<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h2>${seckill.name}</h2>
        </div>
        <div class="panel-body">
            <h2 class="text-danger text-center">
                <span class="glyphicon glyphicon-time"></span>
                <span class="glyphicon" id="seckill_box"></span>
            </h2>


        </div>
    </div>
</div>

<!--弹出层对话框-->
<div id="killPhoneModal" class="modal fade">
       <div class="modal-dialog">
           <div class="modal-content">
               <div class="modal-header">
                   <h3 class="modal-title text-center">
                       <span class="glyphicon glyphicon-phone"></span>秒杀电话
                   </h3>
               </div>
               <div class="modal-body">
                   <div class="row">
                       <div class="col-xs-8 col-xs-offset-2">
                          <input type="text" id="killPhoneKey" placeholder="填写手机号" name="killPhone"  class="form-control">
                       </div>
                   </div>
               </div>
               <div class="modal-footer">
                   <span id="killPhoneMessage" class="glyphicon"></span>
                   <button type="button" id="killPhoneBtn" class="btn btn-success">
                       <span class="glyphicon glyphicon-phone"></span>
                       提交信息
                   </button>
               </div>
           </div>
       </div>
</div>
</body>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--cookie插件-->
<script src="https://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.js"></script>
<script src="https://cdn.bootcss.com/jquery-countdown/2.0.0/jquery.countdown.min.js"></script>
<script src="/resources/scripts/seckill.js" type="text/javascript"></script>
<script type="text/javascript">
       $(function(){
           seckill.detail.init({
               seckillId:${seckill.seckillId},
               startTime:${seckill.startTime.time},
               endTime:${seckill.endTime.time}
           });
       });
</script>

</html>
