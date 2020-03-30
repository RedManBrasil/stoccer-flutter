import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinearChart extends StatefulWidget {
  @override
  _LinearChartState createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart> {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: 'Half yearly sales analysis'),
        // Enable legend
        legend: Legend(isVisible: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]);
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
