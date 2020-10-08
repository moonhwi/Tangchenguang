<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script crossorigin="anonymous" integrity="sha384-i+fXrQ+G3+h2478EWpSpIXivtKbbze+0SNOXJGizkAp6DVG/m2fE6hiWeDwskVvp"
        src="https://lib.baomitu.com/echarts/4.7.0/echarts.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.js"></script>
<html lang="en">
<link rel="stylesheet" href="https://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css">

<body>

<form action="/convo" method="post" id="params">

    <button type="button" onclick="doSubmitForm()">提交
        <button/>
</form>


<div id="main" style="width: 600px; height: 400px; "></div>
<script type="text/javascript">

    var array = [];
    var array1 = [];var array2 = [];
    var result = '';    // 先定义个值，方便下面赋值
    var x = [];

    function doSubmitForm() {
        $.ajax({
            async: false,    // 这个需要写上
            url: "http://localhost:8080/convo",
            type: 'get',
            success: function (callback) {
                result = callback;   // 赋值给刚才定义的值
                var results = result.split(",");
                var index=0;
                var find=false;
                for (var i = 0; i < results.length; i++) {
                    if (i < results.length / 3) {
                        array.push(results[i]);
                        x.push((0.01 * i - 2).toFixed(2));
                        if(results[i]!=0&&find==false)
                        {
                            index=i;
                            find=true;
                        }
                    } else if (i < results.length / 3 * 2)
                    {
                       break;
                    }
                    else {

                    }



                }
                console.log(index);
                for(var i=0;i<index+50;i++)
                {
                    array2.push(0);
                }
                array2.push(1);
                console.log(x);
                buildChart(x, array,array1,array2);
            }
        });
    }

    var idx = 0;

    function buildChart(x, array,array1,array2) {
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
                data: x,

            },
            yAxis: {},

            series: [{
                clickable: false,
                name: '卷积和',
                type: 'scatter',
                data: array,
                color: 'blue',
                symbolSize: 3
            }, {
                clickable: false,
                name: '!',
                type: 'bar',
                barWidth:'10000%',
                itemStyle:{
                    normal:{
                        color:'#fff',
                        barBorderColor:'#4876FF'
                    }
                },
                data: array2,
                color: 'red',
                symbolSize: 3
            },
                // {
                //     clickable: false,
                //     name: '?',
                //     type: 'bar',
                //     data: [1],
                //     barWidth:'10000%',
                //     itemStyle:{
                //         normal:{
                //             color:'#fff',
                //             barBorderColor:'#F876FF'
                //         }
                //     },
                //     animation:false
                // }
            ]

        };
        myChart.setOption(option);
        refreshData(myChart);
    }

    function refreshData(myChart) {
        if (idx > array.length)
            return;
        var option = myChart.getOption();
        option.series[0].data = array.slice(0, idx);
        var arrayTemp=[];
        for (var i=0;i<idx-1;i++)
        {
            arrayTemp.push(0);
        }
        arrayTemp.push(1);
        //option.series[1].data = arrayTemp;
        myChart.setOption(option);
        idx++;

        sleep(100).then(() => {
            refreshData(myChart)
        })
    }

    function sleep(time) {
        return new Promise((resolve) => setTimeout(resolve, time));
    }

</script>
<script src="https://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</body>

</html>
