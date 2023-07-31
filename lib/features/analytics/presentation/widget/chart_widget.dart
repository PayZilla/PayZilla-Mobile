import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pay_zilla/config/config.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData => LineChartData(
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: [lineChartBarData],
        minX: 1,
        maxX: 11,
        maxY: 5,
        minY: 0,
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(sideTitles: bottomTitles),
        rightTitles: titleAxis,
        topTitles: titleAxis,
        leftTitles: titleAxis,
      );

  AxisTitles get titleAxis =>
      AxisTitles(sideTitles: SideTitles(showTitles: false));
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.textBodyColor,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('S', style: style);
        break;
      case 3:
        text = const Text('M', style: style);
        break;
      case 5:
        text = const Text('T', style: style);
        break;
      case 7:
        text = const Text('W', style: style);
        break;
      case 8:
        text = const Text('TH', style: style);
        break;
      case 10:
        text = const Text('F', style: style);
        break;
      case 11:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(show: false);

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        color: const Color(0xff1DAB87),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff1DAB87),
              const Color(0xff2FA2B9).withOpacity(0.2),
            ],
          ),
          color: Colors.green.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(0, 3.5),
          FlSpot(2, 1.2),
          FlSpot(4, 3.6),
          FlSpot(6, 1.8),
          FlSpot(8, 2.9),
          FlSpot(10, 1.1),
          FlSpot(12, 4.3),
        ],
      );
}
