(function (exports) {

    var labelFormatter = function (label, series) {
        return "<div class='chart-label'>" + label + "</div>";
    };

    var options = {
        series: {
            pie: {
                show: true,
                radius: 1,
                stroke: {
                    width: 0
                },
                label: {
                    show: true,
                    radius: 0.65,
                    formatter: labelFormatter
                }
            }
        },
        legend: {
            show: false
        },
        colors: ['#c09853', '#428bca', '#b94a48', '#468847']
    };

//    $.plot('#income', exports['incomeData'], options);
//    $.plot('#proportion', exports['proportionData'], options);
//    $.plot('#expenditure', exports['expenditureData'], options);

    exports.lineChartIt = function (data) {
        var lineChartOptions = {
            series: {
                lines: {
                    show: true
                }
            },
            yaxis: {
                min: 0.0
            },
            xaxis: {
                mode: "time",
                minTickSize: [2, "day"],
                timeformat: "%d.%m."
            },
            grid: {
                backgroundColor: { colors: [ "#fff", "#eee" ] }
            },
            colors: ['#3b6670', '#428bca', '#b94a48', '#468847']
        };
        $.plot('#line', data, lineChartOptions);
    }

})(window);