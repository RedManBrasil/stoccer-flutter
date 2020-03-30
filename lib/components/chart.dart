import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

double maxYValue =
    10.0; //altura minima do grafico, pode ser alterado pela função generateChart()

List<FlSpot> generateChart() {
  //funcao que gera um grafico aleatorio
  maxYValue = 10.0;
  double i = 0;
  double startPoint = 5;
  double volatility = 0.18;

  List<FlSpot> temp2 = [
    FlSpot(0, startPoint) //starting point em (0,0.2)
  ];

  double helper; //variable usada para ajudar o while a fazer o chart
  double helper2 = startPoint; //outra variable criada com o mesmo intuito
  double changePercent;

  while (i < 10) {
    //vai adcionando novos pontos até chegarmos a x=10, com 99 pontos criados
    helper = ((Random().nextInt(101)) / 100);
    changePercent = 2 * volatility * helper;
    if (changePercent > volatility) {
      changePercent -= (2 * volatility);
    }
    helper = helper2 * changePercent;
    if ((helper2 + helper) > maxYValue) {
      //statement para fazer com que o grafico nao estoure o limite do grafico
      maxYValue = helper2 +
          helper +
          0.3; //coloca 0.3 a mais para ter um respiro entre o limite do grafico e o ponto máximo
    }
    helper2 = double.parse((helper2 + helper).toStringAsFixed(2));
    temp2.add(FlSpot(i, helper2));
    i = i + 0.1;
  }

  return temp2;
}

class LineChartSample2 extends StatefulWidget {
  LineChartSample2({@required this.primaryClubColor});

  final List<Color> primaryClubColor;

  @override
  _LineChartSample2State createState() =>
      _LineChartSample2State(primaryClubColor: this.primaryClubColor);
}

class _LineChartSample2State extends State<LineChartSample2> {
  _LineChartSample2State({this.primaryClubColor});

  final List<Color> primaryClubColor;

  List<Color> gradientColors = [
    Colors.black,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.white), //Cor do fundo do chart
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '1D';
              case 2:
                return '1S';
              case 4:
                return '1M';
              case 6:
                return '3M';
              case 8:
                return '6M';
              case 10:
                return '1Y';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: [
        LineChartBarData(
          spots: generateChart(),
          isCurved: false,
          colors: primaryClubColor,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors: primaryClubColor
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: maxYValue,
    );
  }
}
