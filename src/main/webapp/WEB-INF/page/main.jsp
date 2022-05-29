<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        .layui-card-body ul {
            list-style: none;
        }

        .layui-card-body ul li {
            float: left;
            padding: 5px;
        }

        .layui-card-body ul li:hover {
            background-color: #f0f0f0;
        }

        .layui-card-body ul li table {
            width: 150px;
        }

        .layui-card-body ul li table i {
            font-size: 36px;
            color: #1aa094
        }

        .layui-card-body ul li table .number {
            font-size: 24px;
            color: red
        }

        .layui-card-body ul li table .txt {
            color: #888888;
        }
        .main{
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15" style="margin-top: 10px;">
        <div class="layui-col-md12">
            <div class="layui-card" style="height: 125px">
                <div class="layui-card-header">系统概览</div>
                <div class="layui-card-body">
                    <ul>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-form"></i>
                                        </td>
                                        <td class="number" id="subject">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">专业数量</td>
                                    </tr>
                                </table>
                            </li>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-carousel"></i>
                                        </td>
                                        <td class="number" id="clazz">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">班级数量</td>
                                    </tr>
                                </table>
                            </li>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-file"></i>
                                        </td>
                                        <td class="number" id="course">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">课程数量</td>
                                    </tr>
                                </table>
                            </li>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-group"></i>
                                        </td>
                                        <td class="number" id="teacher">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">老师数量</td>
                                    </tr>
                                </table>
                            </li>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-menu-fill"></i>
                                        </td>
                                        <td class="number" id="section">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">开课数量</td>
                                    </tr>
                                </table>
                            </li>
                            <li>
                                <table>
                                    <tr>
                                        <td rowspan="2" align="center">
                                            <i class="layui-icon layui-icon-user"></i>
                                        </td>
                                        <td class="number" id="student">0</td>
                                    </tr>
                                    <tr>
                                        <td class="txt">学生数量</td>
                                    </tr>
                                </table>
                            </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

        <div class="main">
            <h1>欢迎使用学生成绩管理系统</h1>
        </div>
    </div>
</div>


<script>
    layui.use(['echarts'], function () {
        var echarts = layui.echarts,$ = layui.jquery;
        $.ajax({
            url:"${basePath}sum",
            type:"POST",
            dataType:'json',
            success:function(data){
                $('#student').html(data.data.studentCnt);
                $('#subject').html(data.data.subjectCnt);
                $('#clazz').html(data.data.clazzCnt);
                $('#course').html(data.data.courseCnt);
                $('#teacher').html(data.data.teacherCnt);
                $('#section').html(data.data.sectionCnt);
            }
        });
        //1、统计班级学生数量
        var echartsRecords = echarts.init(document.getElementById("container"));
        option = {
            xAxis: {
                type: 'category',
                data: [
                    <c:forEach items="${clazzList}" var="clazz">
                    '${clazz.name}',
                    </c:forEach>
                     ]
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [
                    <c:forEach items="${clazzList}" var="clazz">
                    ${clazz.cnt},
                    </c:forEach>
                ],
                type: 'line',
                showBackground: true,
                backgroundStyle: {
                    color: 'rgba(220, 220, 220, 0.8)'
                }
            }]
        };
        echartsRecords.setOption(option);

        //2、统计课程平均成绩
        var echartsRecords2 = echarts.init(document.getElementById("container2"));
        option2 = {
            xAxis: {
                type: 'category',
                data: [
                    <c:forEach items="${scoreList}" var="score">
                    '${score.clazzName}-${score.courseName}',
                    </c:forEach>
                ]
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [
                    <c:forEach items="${scoreList}" var="score">
                    ${score.avgscore},
                    </c:forEach>
                ],
                type: 'bar',
                showBackground: true,
                backgroundStyle: {
                    color: 'rgba(220, 220, 220, 0.8)'
                }
            }]
        };
        echartsRecords2.setOption(option2);

        //echarts 窗口缩放自适应
        window.onresize = function(){
            echartsRecords.resize();
        }
    });
</script>
</body>
</html>
