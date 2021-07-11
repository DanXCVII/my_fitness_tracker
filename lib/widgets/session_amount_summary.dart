import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SessionAmountSummary extends StatefulWidget {
  final double width;

  SessionAmountSummary(this.width, {Key? key}) : super(key: key);

  @override
  _SessionAmountSummaryState createState() => _SessionAmountSummaryState();
}

class _SessionAmountSummaryState extends State<SessionAmountSummary> {
  int touchedIndex = -1;
  final double rodWidth = 8;
  // calendarWeek and amount of workouts
  final List<Tuple2<int, int>> weekWorkout = [
    Tuple2(26, 3),
    Tuple2(27, 2),
    Tuple2(28, 4),
    Tuple2(30, 3),
    Tuple2(31, 3),
    Tuple2(32, 2),
    Tuple2(33, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: weekWorkout
                    .map((e) => e.item2)
                    .toList()
                    .reduce(max)
                    .toDouble() +
                1,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  int iVal = value.toInt();

                  return "KW" + weekWorkout[iVal].item1.toString();
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: weekWorkout
                .map(
                  (e) => BarChartGroupData(
                    x: weekWorkout.indexOf(e),
                    barRods: [
                      BarChartRodData(
                          width: rodWidth,
                          y: e.item2.toDouble(),
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
