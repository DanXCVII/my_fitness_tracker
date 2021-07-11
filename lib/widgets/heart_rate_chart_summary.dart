import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class HeartRateChartSummary extends StatelessWidget {
  final double width;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final Tuple2<List<DateTime>, List<int>> heartRateData;

  HeartRateChartSummary(
    this.width,
    this.heartRateData, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 206,
      decoration: BoxDecoration(
        color: Color(0xff1D1D1D),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            spreadRadius: 0.5,
            color: Colors.black26,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 22, 32, 16),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          int iVal = value.floor();
          double linewidth = 24;
          double opacity = 0.4;
          if (iVal == ((118 + 98) / 2).floor() - 1) {
            return FlLine(
              color: Colors.grey.withOpacity(opacity),
              strokeWidth: linewidth,
            );
          } else if (iVal == ((137 + 118) / 2).floor()) {
            return FlLine(
              color: Colors.blueAccent.withOpacity(opacity),
              strokeWidth: linewidth,
            );
          } else if (iVal == ((157 + 137) / 2).floor()) {
            return FlLine(
              color: Colors.greenAccent.withOpacity(opacity),
              strokeWidth: linewidth,
            );
          } else if (iVal == ((176 + 157) / 2).floor() + 1) {
            return FlLine(
              color: Colors.yellowAccent.withOpacity(opacity),
              strokeWidth: linewidth,
            );
          } else if (iVal == ((196 + 176) / 2).floor() + 1) {
            return FlLine(
              color: Colors.redAccent.withOpacity(0.5),
              strokeWidth: linewidth,
            );
          }

          return FlLine(
            strokeWidth: 0,
          );
        },
        verticalInterval: heartRateData.item1.length / 4,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            int iVal = value.toInt();
            int trackedLength = heartRateData.item1.length;
            if (iVal == 0) {
              return "00:00";
            }
            if (iVal == (trackedLength / 4) - ((trackedLength / 4) % 50)) {
              Duration currentDuration = heartRateData
                  .item1[(trackedLength / 4).round()]
                  .difference(heartRateData.item1.first);
              return createTimeString(currentDuration);
            } else if (iVal ==
                (trackedLength / 2) - ((trackedLength / 2) % 50)) {
              Duration currentDuration = heartRateData
                  .item1[(trackedLength / 2).round()]
                  .difference(heartRateData.item1.first);
              return createTimeString(currentDuration);
            } else if (iVal ==
                (trackedLength / 4 * 3) - ((trackedLength / 4 * 3) % 50)) {
              Duration currentDuration = heartRateData
                  .item1[(trackedLength / 4 * 3).round()]
                  .difference(heartRateData.item1.first);
              return createTimeString(currentDuration);
            } else if (iVal == trackedLength - (trackedLength % 50)) {
              Duration currentDuration = heartRateData
                  .item1[(trackedLength - 1).round()]
                  .difference(heartRateData.item1.first);
              return createTimeString(currentDuration);
            }

            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 100:
                return '98';
              case 120:
                return '118';
              case 140:
                return '137';
              case 160:
                return '157';
              case 180:
                return '176';
              case 200:
                return '196';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: heartRateData.item1.length.toDouble(),
      minY: (heartRateData.item2).reduce(min).toDouble() - 10,
      maxY: 200,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
              heartRateData.item1.length,
              (index) => FlSpot(
                  index.toDouble(), heartRateData.item2[index].toDouble())),
          isCurved: false,
          colors: [Colors.red],
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          // belowBarData: BarAreaData(
          //   show: true,
          //   colors:
          //       gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          // ),
        ),
      ],
    );
  }

  String createTimeString(Duration duration) {
    String hours = duration.inHours < 10
        ? "0" + duration.inHours.toString()
        : duration.inHours.toString();
    String minutes = duration.inMinutes < 10
        ? "0" + duration.inMinutes.toString()
        : duration.inMinutes.toString();

    return hours + ":" + minutes;
  }
}
