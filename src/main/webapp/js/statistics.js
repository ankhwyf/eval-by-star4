/* global echarts */

function drawB(myChart, title, str1, str2, data) {
    option = {
        backgroundColor: '#aaaaaa',
        title: {
            text: title,
            // subtext: '纯属虚构',
            x: 'center',
            textStyle: {
                fontSize: '15',
            },
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: [str1, str2]
        },
        series: [
            {
                name: '访问来源',
                type: 'pie',
                radius: '40%',
                center: ['50%', '60%'],
                data: [
                    {value: data[0], name: str1},
                    {value: data[1], name: str2},
                ],
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            formatter: '{d}%\n{b}',
                            textStyle: {
                                fontSize: '12',
                                fontWeight: 'normal',
                            },
                        },

                        labelLine: {show: true}
                    }
                }
            }
        ]
    };
    myChart.setOption(option);
}

var myChart = echarts.init(document.getElementById('submitInformation'));
drawB(myChart, '教师提交信息', '待提交', '已提交', submit);
var myChart = echarts.init(document.getElementById('auditInformation'));
drawB(myChart, '审核信息', '待审核', '已审核', audit);
var myChart = echarts.init(document.getElementById('rankInformation'));
drawB(myChart, '等级信息', '不合格率', '合格率', rank);