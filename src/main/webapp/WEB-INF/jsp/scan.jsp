<%--
  Created by IntelliJ IDEA.
  User: 99213
  Date: 2018-08-23
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="common/head.jsp" %>
    <script type="text/javascript" src="/seckill/resources/js/html5-qrcode.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/grid.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/version.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/detector.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/formatinf.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/errorlevel.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/bitmat.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/datablock.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/bmparser.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/datamask.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/rsdecoder.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/gf256poly.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/gf256.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/decoder.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/qrcode.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/findpat.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/alignpat.js"></script>
    <script type="text/javascript" src="/seckill/resources/js/qrcode/databr.js"></script>
    <title>Title</title>
    <script type="text/javascript">
        function readeQR() {
            alert(1)
            // $('#reader').html5_qrcode(function (data) {
            //         $('#read').html(data);
            //         alert('parsing success!')
            //         alert(data);//打印解析到的数据
            //         $('#number').val(data);
            //     },
            //     function (error) {
            //         $('#read_error').html(error);
            //     }, function (videoError) {
            //         $('#vid_error').html(videoError);
            //     }
            // );

            $('#reader').html5_qrcode(function(data){
                    // do something when code is read
                    alert(3)
                },
                function(error){
                    //show read errors
                    alert(4)
                }, function(videoError){
                    //the video stream could be opened
                    alert(5)
                }
            );
            alert(2)

        }
        $(document).ready(function(){
            $('#reader').html5_qrcode(function(data){
                    // do something when code is read
                },
                function(error){
                    //show read errors
                }, function(videoError){
                    //the video stream could be opened
                }
            );
        });

    </script>
</head>
<body >
<div onclick="readeQR()" style="padding: 10px">scan</div>
<div class="center" id="reader" style="width:300px;height:250px; background:grey;color: #1d4499; position: absolute;display:block">
    <video id="html5_qrcode_video" height="250px" width="300px"></video>
    <canvas id="qr-canvas" width="298px" height="248px" style="display:block;"></canvas>
</div>
</body>
</html>
