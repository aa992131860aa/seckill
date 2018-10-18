<%--
  Created by IntelliJ IDEA.
  User: 99213
  Date: 2018-07-04
  Time: 0:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>checkTree</title>
    <style type="text/css">
        div, p {
            margin: 0;
            padding: 0;
            line-height: 1.5;
        }

        .checks {
            padding-left: 20px;
        }
    </style>
</head>
<body>
<div class="J_CheckWrap">
    <p><input type="checkbox"/>一级</p>
    <div class="checks">
        <p><input type="checkbox"/>二级</p>
        <div class="checks">
            <p><input type="checkbox"/>三级</p>
            <p><input type="checkbox"/>三级</p>
            <p><input type="checkbox"/>三级</p>
            <div class="checks">
                <p><input type="checkbox"/>四级</p>
                <div class="checks">
                    <p><input type="checkbox"/>五级</p>
                    <p><input type="checkbox"/>五级</p>
                    <div class="checks">
                        <p><input type="checkbox"/>六级</p>
                        <p><input type="checkbox"/>六级</p>
                    </div>
                </div>
                <p><input type="checkbox"/>四级</p>
            </div>
        </div>
        <p><input type="checkbox"/>二级</p>
        <p><input type="checkbox"/>二级</p>
        <div class="checks">
            <p><input type="checkbox"/>三级</p>
            <div class="checks">
                <p><input type="checkbox"/>四级</p>
                <p><input type="checkbox"/>四级</p>
            </div>
            <p><input type="checkbox"/>三级</p>
            <p><input type="checkbox"/>三级</p>
        </div>
        <p><input type="checkbox"/>二级</p>
        <p><input type="checkbox"/>二级</p>
        <div class="checks">
            <p><input type="checkbox"/>三级</p>
            <p><input type="checkbox"/>三级</p>
            <div class="checks">
                <p><input type="checkbox"/>四级</p>
                <p><input type="checkbox"/>四级</p>
            </div>
            <p><input type="checkbox"/>三级</p>
        </div>
        <p><input type="checkbox"/>二级</p>
    </div>
</div>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<script type="text/javascript" src="jquery.checktree.js"></script>
<script>
    $(".J_CheckWrap").checktree();
</script>
</body>
<script type="text/javascript">
    (function (win, doc, $) {
        $.fn.extend({
            checktree : function () {
                this.click(function (evt) {
                    var evtEle = $(evt.target).closest("input:checkbox");
                    if (!evtEle[0]) {
                        return;
                    }
                    //check child all
                    evtEle.parent().next(".checks").find("input:checkbox").attr("checked", evtEle[0].checked);

                    //check parent
                    if (evtEle.is("input:checked")) {
                        evtEle.parents(".checks").each(function () {
                            !$(this).children("p").children("input:checkbox").filter(function () {
                                return !this.checked;
                            })[0] && $(this).prev().children("input:checkbox").attr("checked", "checked");
                        });
                    } else {
                        evtEle.parents(".checks").prev().children("input:checkbox").attr("checked", false);
                    }
                });
            }
        });
    })(window, document, jQuery);

</script>
</html>
