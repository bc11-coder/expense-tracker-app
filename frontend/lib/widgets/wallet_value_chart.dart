import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/item.dart';
import 'package:frontend/utils/app_gradients.dart';
import 'package:frontend/utils/wallet_chart_data_utils.dart';
import 'package:intl/intl.dart';
import 'package:frontend/utils/wallet_chart_range.dart';

class WalletValueChart extends StatefulWidget {
  final List<Item> items;

  const WalletValueChart({super.key, required this.items});

  @override
  State<WalletValueChart> createState() => _WalletValueChartState();
}

class _WalletValueChartState extends State<WalletValueChart> {
  WalletChartRange _range = WalletChartRange.week;
  DateTime _focus = DateTime.now();

  double _scaleX = 1.0;
  double _scaleY = 1.0;
  double _offsetX = 0.0;
  double _offsetY = 0.0;

  static const Color _orange = Color.fromARGB(255, 215, 75, 0);
  static const Color _buttonBackground = Color.fromARGB(180, 53, 79, 136);

  @override
  Widget build(BuildContext context) {
    final points = WalletChartDataUtils.generateChartPoints(
      widget.items,
      _range,
      _focus,
    );

    if (points.isEmpty) {
      return const SizedBox(height: 260);
    }

    final minDataY = points.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxDataY = points.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    final rangeY = (maxDataY - minDataY).abs();
    final basePadding = rangeY == 0 ? 5 : rangeY * 0.2;

    final rawMinY = (minDataY - basePadding) / _scaleY + _offsetY;
    final rawMaxY = (maxDataY + basePadding) / _scaleY + _offsetY;

    final niceInterval = _calculateNiceInterval(rawMinY, rawMaxY);
    final niceMinY = (rawMinY / niceInterval).floor() * niceInterval;
    final niceMaxY = niceMinY + niceInterval * 10; // 11 Labels => 10 Abstände

    return Column(
      children: [
        GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _scaleX *= details.horizontalScale;
              _scaleY *= details.verticalScale;

              _offsetX -= details.focalPointDelta.dx * 0.02;
              _offsetY += details.focalPointDelta.dy * 0.02;

              _scaleX = _scaleX.clamp(0.5, 5.0);
              _scaleY = _scaleY.clamp(0.5, 5.0);
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            height: 260,
            decoration: BoxDecoration(
              gradient: WalletScreenGradients.mainVertical,
              borderRadius: BorderRadius.circular(20),
            ),
            child: LineChart(
              LineChartData(
                minX: 0 + _offsetX,
                maxX: (points.length - 1) / _scaleX + _offsetX,
                minY: niceMinY,
                maxY: niceMaxY,
                clipData: FlClipData.all(),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: niceInterval,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: Colors.white.withAlpha(30), strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      interval: niceInterval,
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "${value.round()}€",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.round();
                        if (index < 0 || index >= points.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            _formatLabel(points[index].date),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: points.map((e) => FlSpot(e.x, e.y)).toList(),
                    isCurved: false,
                    color: _orange,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [_orange.withAlpha(80), _orange.withAlpha(10)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildRangeButtons(),
      ],
    );
  }

  Widget _buildRangeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...WalletChartRange.values.map((range) {
          final selected = _range == range;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              label: Text(
                range.name.toUpperCase(),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                ),
              ),
              selected: selected,
              selectedColor: _orange,
              backgroundColor: _buttonBackground,
              onSelected: (_) {
                setState(() {
                  _range = range;
                  _scaleX = 1;
                  _scaleY = 1;
                  _offsetX = 0;
                  _offsetY = 0;
                });
              },
            ),
          );
        }),
        const SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 7, 36, 111),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withAlpha(40)),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                color: const Color.fromARGB(255, 255, 255, 255),
                splashRadius: 20,
                onPressed: _goBack,
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.white.withAlpha(40),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                color: const Color.fromARGB(255, 255, 255, 255),
                splashRadius: 20,
                onPressed: _goForward,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _goBack() {
    setState(() {
      if (_range == WalletChartRange.week) {
        _focus = _focus.subtract(const Duration(days: 7));
      } else if (_range == WalletChartRange.month) {
        _focus = DateTime(_focus.year, _focus.month - 1, 1);
      } else {
        _focus = DateTime(_focus.year - 1, 1, 1);
      }
    });
  }

  void _goForward() {
    setState(() {
      if (_range == WalletChartRange.week) {
        _focus = _focus.add(const Duration(days: 7));
      } else if (_range == WalletChartRange.month) {
        _focus = DateTime(_focus.year, _focus.month + 1, 1);
      } else {
        _focus = DateTime(_focus.year + 1, 1, 1);
      }
    });
  }

  String _formatLabel(DateTime date) {
    if (_range == WalletChartRange.week) {
      return DateFormat('dd.MM').format(date);
    }
    if (_range == WalletChartRange.month) {
      return "KW ${WalletChartDataUtils.isoWeek(date)}";
    }
    return DateFormat('MMM').format(date);
  }

  double _calculateNiceInterval(double min, double max) {
    final range = (max - min).abs();
    if (range == 0) return 1;

    final rawInterval = range / 10; // 10 Abstände => 11 Labels
    final magnitude = pow(10, (log(rawInterval) / ln10).floor());
    final normalized = rawInterval / magnitude;

    double niceNormalized;
    if (normalized <= 1) {
      niceNormalized = 1;
    } else if (normalized <= 2) {
      niceNormalized = 2;
    } else if (normalized <= 5) {
      niceNormalized = 5;
    } else {
      niceNormalized = 10;
    }

    return niceNormalized * magnitude;
  }
}