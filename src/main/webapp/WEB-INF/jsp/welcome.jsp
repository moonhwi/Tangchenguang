<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script crossorigin="anonymous" integrity="sha384-i+fXrQ+G3+h2478EWpSpIXivtKbbze+0SNOXJGizkAp6DVG/m2fE6hiWeDwskVvp"
        src="https://lib.baomitu.com/echarts/4.7.0/echarts.js"></script>
<script
        src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
        crossorigin="anonymous"></script>
<html lang="en">

<body>

<form action="/convo" method="post" id="params">
    <input type="text" name="paramA" value="" />
    <input type="text" name="paramB" value="" />
    <button type="button" onclick="doSubmitForm()">提交<button/>
</form>


<div id="main" style="width: 600px; height: 400px;"></div>
<script type="text/javascript">
    var array=[];
    var result = '';    // 先定义个值，方便下面赋值
    var x=[];
    function doSubmitForm() {
        var form = document.getElementById('params');
        $.ajax({
            async: false,    // 这个需要写上
            url: "http://localhost:8080/convo",
            type: 'post',
            data:[form.paramA,form.paramB],
            success: function (callback) {
                result = callback;   // 赋值给刚才定义的值
                var results=result.split(",");

                for (var i=0;i<results.length;i++)
                {
                    array.push(results[i]);
                    x.push(i);
                }
                buildChart(x,array);
            }
        });
    }
    var idx=0;
    function buildChart(x,array) {
        var myChart = echarts.init(document.getElementById('main'));

        var option = {
            title: {
                text: '第一个 ECharts 实例'
            },
            tooltip: {},
            legend: {
                data: ['卷积和']
            },
            xAxis: {
                data: x
            },
            yAxis: {},
            series: [{
                name: '卷积和',
                type: 'scatter',
                data: array,
                color: 'blue',
                symbolSize:3
            }]
        };
        myChart.setOption(option);
        refreshData(myChart);
    }
    function refreshData(myChart) {
        if (idx>array.length)
            return;
        var option = myChart.getOption();
        option.series[0].data = array.slice(0,idx);
        myChart.setOption(option);
        idx++;

        sleep(100).then(() => {
            refreshData(myChart)
        })
    }

    function sleep (time) {
        return new Promise((resolve) => setTimeout(resolve, time));
    }

</script>

</body>

</html>
