<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script crossorigin="anonymous" integrity="sha384-i+fXrQ+G3+h2478EWpSpIXivtKbbze+0SNOXJGizkAp6DVG/m2fE6hiWeDwskVvp"
        src="https://lib.baomitu.com/echarts/4.7.0/echarts.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.js"></script>
<html lang="en">
<body>
<h1 style="text-align:center;"> 通信原理实验</h1>

<button type="button" onclick="doSubmitForm()">有用信号波形</button>

<div id="main" style="width: 600px; height: 400px;visibility: visible"></div>
<script type="text/javascript">
    var array1=[];
    var array2=[];
    var array3=[];
    var result = '';    // 先定义个值，方便下面赋值
    var x=[];
    function doSubmitForm() {
        $.ajax({
            async: false,    // 这个需要写上
            url: "http://localhost:8080/convo",
            type: 'get',
            success: function (callback) {
                result = callback;   // 赋值给刚才定义的值
                var results=result.split(",");
                console.log(results);
                for (var i=0;i<results.length;i++)
                {
                    if(i<=400){
                        array1.push(results[i]);
                        x.push(i);
                    }
                    if(401<=i<802){
                        array2.push(results[i]);
                    }
                    if(802<=i<=1202){
                        array3.push(results[i]);
                    }
                    buildChart(x,array1,array2,array3);
                }
            }
        })
        ;}

    let idx = 0;

    function buildChart(x,array1,array2,array3) {
        echarts.dispose(document.getElementById('main'))
        var myChart = echarts.init(document.getElementById('main'));

        var option = {
            title: {
                text: '第一个 ECharts 实例'
            },
            tooltip: {},

            xAxis: {
                data: x
            },
            yAxis: {},
            series: [{
                name: '方波',
                type: 'scatter',
                data: array1,
                color: 'blue',
                symbolSize:3
            },{
                name: '三角波',
                type: 'scatter',
                data: array2,
                color: 'red',
                symbolSize:3
            },{
                name: '原始信号',
                type: 'scatter',
                data: array3,
                color: 'green',
                symbolSize:3
            }]
        };
        myChart.setOption(option);
        refreshData(myChart);
    }
    function refreshData(myChart) {
        if (idx>array1.length)
            return;
        var option = myChart.getOption();
        option.series[0].data = array1.slice(0,idx);

        myChart.setOption(option);

        idx++;

        sleep(10).then(() => {
            refreshData(myChart)
        })
    }

    function sleep (time) {
        return new Promise((resolve) => setTimeout(resolve, time));
    }

</script>

</body>

</html>
