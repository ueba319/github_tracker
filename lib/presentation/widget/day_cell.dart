// lib/features/github_calendar/presentation/widgets/day_cell.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// カレンダーの各日付を表す小さな四角いセル
class DayCell extends StatelessWidget {
  final DateTime date;
  final int commitCount;
  final Color color;

  const DayCell({
    super.key,
    required this.date,
    required this.commitCount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${DateFormat('yyyy-MM-dd').format(date)}: $commitCount コミット',
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
