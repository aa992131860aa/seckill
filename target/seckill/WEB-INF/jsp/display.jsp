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
    <style type="text/css">

        .green {
            padding-left: 5px;
            padding-top: 5px;
            width: 70px;
            height: 70px;
            background-color: green;
            border: black solid 1px;
            margin: 5px;
            font-size: 13px;
            float: left;

        }

        .red {
            padding-left: 5px;
            padding-top: 5px;
            width: 70px;
            height: 70px;
            background-color: red;
            border: black solid 1px;
            margin: 5px;
            font-size: 13px;
            float: left;

        }

        .yellow {
            padding-left: 5px;
            padding-top: 5px;
            width: 70px;
            height: 70px;
            background-color: yellow;
            border: black solid 1px;
            margin: 5px;
            font-size: 13px;
            float: left;

        }

        .white {
            padding-left: 5px;
            padding-top: 5px;
            width: 70px;
            height: 70px;
            background-color: white;
            border: black solid 1px;
            margin: 5px;
            font-size: 13px;
            float: left;

        }

        body {
            width: 100%;
            background-color: #757376;
        }
    </style>
</head>

<body>
<%@include file="common/common.jsp" %>
<header class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
    <h1 class="mui-title">销控图</h1>

    <button type="button" style="float: right;"
            class="mui-btn mui-btn-outlined mui-btn mui-btn-primary"
            onclick="backMain()"> 返回首页
    </button>
</header>
<div class="mui-content">
    <div style="padding: 10px">
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(-2)"> 负二楼
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(-1)"> 负一楼
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(1)"> 一楼
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(2)"> 二楼
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(3)"> 三楼
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(4)"> 四楼
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(5)"> 五楼
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(6)"> 六楼
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(7)"> 七楼
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="skipFloor(8)"> 八楼
        </button>

        <button type="button"
                style="margin-left: 30px"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="deal('addColumn')"> 增加一列
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="deal('minusColumn')"> 减少一列
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="deal('addRow')"> 增加一行
        </button>
        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
                onclick="deal('minusRow')"> 减少一行
        </button>

        <button type="button"  style="margin-left: 30px"
                class="mui-btn  mui-btn mui-btn-primary"
        > ${houseSite.row}行${houseSite.column}列
        </button>

        <button type="button"
                class="mui-btn  mui-btn mui-btn-primary"
        > 当前${floor}楼
        </button>
    </div>
    <c:forEach items="${houseListList}" varStatus="row" var="house1">
        <c:forEach items="${houseListList.get(row.index)}" varStatus="column" var="house2">
            <c:if test="${houseSite.column>column.index&&houseSite.row>row.index}">
                <!--意向-->
                <c:if test="${house1.get(column.index).goodsStatusId==7}">
                    <div class="yellow">
                            ${house1.get(column.index).location}<br>
                            ${house1.get(column.index).linkHouse} <br>
                            ${house1.get(column.index).buildArea} m<sup>2</sup>
                    </div>
                </c:if>
                <!--闲置-->
                <c:if test="${house1.get(column.index).goodsStatusId==8}">
                    <div class="red">
                            ${house1.get(column.index).location}<br>
                            ${house1.get(column.index).linkHouse} <br>
                            ${house1.get(column.index).buildArea} m<sup>2</sup>
                    </div>
                </c:if>
                <!--租赁-->
                <c:if test="${house1.get(column.index).goodsStatusId==9}">
                    <div class="green">
                            ${house1.get(column.index).location}<br>
                            ${house1.get(column.index).linkHouse} <br>
                            ${house1.get(column.index).buildArea} m<sup>2</sup>
                    </div>
                </c:if>
                <!--租赁-->
                <c:if test="${house1.get(column.index).goodsStatusId==0}">
                    <div class="white">
                        暂无<br>
                        <br>

                    </div>
                </c:if>
            </c:if>

        </c:forEach>
        <div style="clear: both"></div>
    </c:forEach>


</div>
</body>
<script type="text/javascript" charset="utf-8">
    mui.init();
    var needRefresh = sessionStorage.getItem("need-refresh");
    if (needRefresh) {
        sessionStorage.removeItem("need-refresh");
        location.reload();
    }
    var width = document.body.clientWidth;
    var realWidth = '${houseSite.column*80}';
    if (realWidth < width) {
        realWidth = width;
    }
    $("body").width(realWidth)
    $(document).ready(function () {


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


            $(window).attr('location', '/seckill/car/' + (params.pageNum - 1) + '/query');


        })


    });


    function skip_car_add() {
        mui.openWindow({
            url: '/seckill/car_add',
            id: 'department'
        })

    }

    function deal(type) {
        var column = '${houseSite.column}';
        var row = '${houseSite.row}';
        var floor = '${floor}';
        var style = '${style}';

        mui.openWindow({
            url: '/seckill/display/' + column + '/' + row + '/' + floor + '/' + type+'/'+style

        })
    }

    function skipFloor(floor) {
        var style = '${style}';
        mui.openWindow({
            url: '/seckill/display/' + floor + '/' + style

        })

    }


</script>
</html>