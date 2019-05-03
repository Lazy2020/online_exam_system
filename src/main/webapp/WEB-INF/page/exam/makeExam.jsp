<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="../common/include-header.jsp" %>
<style>
    .exam-bar {
        background: #fff9ec none repeat scroll 0% 0%;
        height: 40px;
        font-size: 16px;
        margin-bottom: 0;
        padding-top: 10px;
    }
</style>
<body class="gray-bg">

<div class="container-div">
    <input type="hidden" id="examId" value="${exam.examId}">
    <nav class="navbar navbar-fixed-top exam-bar" role="navigation">
        <div class="col-lg-4 text-right">
            当前试卷为【${exam.examName}】，考试用户为【${sessionScope.user.nickName}】
        </div>
        <div class="col-lg-4 text-center">考试时长：${exam.lastTime} 分钟
        </div>
        <div class="col-lg-4 text-left">
            <button type="button" class="btn btn-info" onclick="doPaper(false)">交卷</button>
            <button type="button" class="btn btn-info" onclick="javascript:history.back(-1);">返回</button>
            &nbsp;&nbsp;
        </div>
    </nav>

    <div class="text-center" style="margin-top: 100px">
        <h1 class="h1 text-center text-warning ">${exam.examName} </h1>
        <span class="text-right">试卷满分：${exam.score}</span>
    </div>


    <c:if test="${exam.radioQuestion!=null && exam.radioQuestion.size()!=0}">
        <div class="form-content radio-box-exam">
            <h1 class="form-header">单选题</h1>
            <c:forEach items="${exam.radioQuestion}" varStatus="varStat" var="radio">
                <div class="form-group">
                    <label class=" control-label">${varStat.index+1}: ${radio.title}</label><span
                        class="text-info h6">本题${radio.score}分</span>
                    <div class="col-sm-12">
                        <label class="radio-box">
                            <input class="form-control" type="radio" name="${radio.id}" mtype="single" value="A"
                                   <c:if test="${radio.optionACheckedStu eq 'A'}">checked</c:if>
                            > <c:out
                                value="${radio.optionA}"
                                escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="radio" name="${radio.id}" mtype="single" value="B"
                                   <c:if test="${radio.optionBCheckedStu eq 'B'}">checked</c:if>
                            > <c:out value="${radio.optionB}"
                                     escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="radio" mtype="single" name="${radio.id}"
                                   value="C"
                                   <c:if test="${radio.optionCCheckedStu eq 'C'}">checked</c:if>
                            > <c:out value="${radio.optionC}"
                                     escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="radio" mtype="single" name="${radio.id}"
                                   value="D"
                                   <c:if test="${radio.optionDCheckedStu eq 'D'}">checked</c:if>
                            > <c:out value="${radio.optionD}"
                                     escapeXml='false'/>
                        </label>
                        <br>
                    </div>
                </div>
                <br>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${exam.checkboxQuestion!=null && exam.checkboxQuestion.size()!=0}">
        <div class=" form-content">
            <h1 class="form-header">多选题</h1>
            <c:forEach items="${exam.checkboxQuestion}" varStatus="varStat" var="checkbox">
                <div class="form-group">
                    <label class=" control-label">${varStat.index+1}: ${checkbox.title}</label><span
                        class="text-info h6">  本题${checkbox.score}分</span>
                    <div class="col-sm-12">
                        <label class="check-box">
                            <input class="form-control" type="checkbox" mtype="Multiple" value="A"
                                   <c:if test="${checkbox.optionACheckedStu=='A'}">checked</c:if>
                                   name="${checkbox.id}">
                            <c:out
                                    value="${checkbox.optionA}"
                                    escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="checkbox" mtype="Multiple" value="B"
                                   <c:if test="${checkbox.optionBCheckedStu=='B'}">checked</c:if>
                                   name="${checkbox.id}">
                            <c:out
                                    value="${checkbox.optionB}"
                                    escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="checkbox" mtype="Multiple" value="C"
                                   <c:if test="${checkbox.optionCCheckedStu=='C'}">checked</c:if>
                                   name="${checkbox.id}">
                            <c:out
                                    value="${checkbox.optionC}"
                                    escapeXml='false'/>
                        </label>
                        <br>
                        <label class="radio-box">
                            <input class="form-control" type="checkbox" mtype="Multiple" value="D"
                                   <c:if test="${checkbox.optionDCheckedStu=='D'}">checked</c:if>
                                   name="${checkbox.id}">
                            <c:out
                                    value="${checkbox.optionD}"
                                    escapeXml='false'/>
                        </label>
                        <br>
                    </div>
                </div>
                <br>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${exam.balckQuestion!=null && exam.balckQuestion.size()!=0}">
        <div class="form-content">
            <h1 class="form-header">填空题</h1>
            <c:forEach items="${exam.balckQuestion}" varStatus="varStat" var="black">
                <div class="form-group">
                    <label class=" control-label">${varStat.index+1}: ${black.title}:
                        <input type="text" name="${black.id}" onblur="updateTextAnswer('${black.id}')"
                               value="${black.textAnswerStu}"
                               class="form-control"></label>
                    <span class="text-info h6">  本题${black.score}分</span>
                </div>
            </c:forEach>

        </div>
    </c:if>

    <c:if test="${exam.judgeQuestion!=null && exam.judgeQuestion.size()!=0}">
        <div class="form-content">
            <h1 class="form-header">判断题</h1>
            <c:forEach items="${exam.judgeQuestion}" varStatus="varStat" var="judge">
                <div class="form-group">
                    <label class=" control-label">${varStat.index+1}: ${judge.title}</label><span
                        class="text-info h6">  本题${judge.score}分</span>
                    <br>
                    <label class="radio-box">
                        <input class="form-control" type="radio" mtype="judge" value="1" name="${judge.id}"
                               <c:if test="${judge.judgeAnswer1Stu == '1'}">checked</c:if>
                        >正确
                    </label>
                    <label class="radio-box">
                        <input class="form-control" type="radio" mtype="judge" value="0" name="${judge.id}"
                               <c:if test="${judge.judgeAnswer0Stu == '0'}">checked</c:if>
                        >错误
                    </label>
                </div>
                <br>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${exam.shortQuestion!=null && exam.shortQuestion.size()!=0}">
        <div class="form-content">
            <h1 class="form-header">简答</h1>
            <c:forEach items="${exam.shortQuestion}" varStatus="varStat" var="shorta">
                <div class="form-group">
                    <label class=" control-label">${varStat.index+1}: ${shorta.title}</label><span
                        class="text-info h6">  本题${shorta.score}分</span>
                    <textarea name="${shorta.id}" autocomplete="off" maxlength="500" id="shortAnswer"
                              class="form-control"
                              onblur="updateTextAnswer('${shorta.id }')"
                              rows="3">${shorta.textAnswerStu}</textarea>
                    <br>
                </div>
            </c:forEach>
        </div>
    </c:if>

</div>
<%@include file="../common/include-footer.jsp" %>
<script src="/static/plugin/select/select2.js"></script>

<script>

    $("input[mtype='Multiple']").on('ifChecked ifUnchecked', function (event) {
        var multipleValue = "";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            multipleValue += $(this).val() + ",";
        });
        if (multipleValue.length > 0) {
            multipleValue = multipleValue.substring(0, multipleValue.length - 1);
        }
        sendData($(this).attr("name"), multipleValue);
    });


    $("input[mtype='single']").on('ifChecked', function (event) {
        var singleValue = "";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            singleValue = $(this).val();
        });
        sendData($(this).attr("name"), singleValue)
    });


    $("input[mtype='judge']").on('ifChecked', function (event) {
        var judgeValue = "";
        $('input[name="' + $(this).attr("name") + '"]:checked').each(function () {
            judgeValue = $(this).val();
        });
        sendData($(this).attr("name"), judgeValue)
    });

    function sendData(questionId, answer) {
        $.ajax({
            data: {"questionId": questionId, "answer": answer, "examId": $("#examId").val()},
            url: "/exam/student/record",
            async: true, //异步提交
            type: "post",
            success: function (result) {
                if (result.code != 0) {
                    $.modal.error(result.msg);
                }
            }
        });
    }

    function updateTextAnswer(name) {
        var answer = $("[name='" + name + "']").val();
        sendData(name, answer);
    }

    /**
     * 交卷
     */
    function doPaper() {
        $.ajax({
            url: "/exam/student/finish",
            data: {examId: $("#examId").val()},
            async: true,
            type: "post",
            success: function (result) {
                if (result.code == 0) {
                    $.modal.alertSuccess("交卷成功");
                    location.href = "/index";
                } else {
                    $.modal.alertError("交卷失败")
                }
            }
        })
    }

</script>

</body>
</html>
