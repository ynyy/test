<!DOCTYPE html>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
   </head>
   <body style="height: 100%; margin: 0">
       <div id="container" style="height: 100%"></div>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/echarts.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-gl/echarts-gl.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts-stat/ecStat.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script>
       <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
       <script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
       <script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);
var app = {};
option = null;
function fetchData(cb) {
	 // 通过 setTimeout 模拟异步加载
    setTimeout(function () {
        cb({
            categories: ["A","B","C","D","E","F"],
            data: [5, 20, 36, 10, 10, 20]
        });
    }, 1000);
}

// 鍒濆 option
option = {
    title: {
        text:'asychro test'
    },
    tooltip: {},
    legend: {
        data:['sales']
    },
    xAxis: {
        data: []
    },
    yAxis: {},
    series: [{
        name: 'sales',
        type: 'bar',
        data: []
    }]
};

fetchData(function (data) {
    myChart.setOption({
        xAxis: {
            data: data.categories
        },
        series: [{
        	 // 根据名字对应到相应的系列
            name: 'sales',
            data: data.data
        }]
    });
});;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
       </script>
   </body>
</html>