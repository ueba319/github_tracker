// lib/features/github_calendar/presentation/components/day_cell.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// カレンダーの各日を表すセルウィジェット
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
      message: '${DateFormat('yyyy年MM月dd日').format(date)}: $commitCount コミット',
      child: Container(
        width: 28, // 少し大きくする
        height: 28, // 少し大きくする
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4), // 少し角を丸める
          border: Border.all(
            color: Colors.black.withAlpha((255 * 0.1).round()), // 軽いボーダーを追加
            width: 0.5,
          ),
        ),
        child: Center(
          // 日付の数字を表示する（オプション）
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color:
                  commitCount == 0 ? Colors.grey[700] : Colors.white, // 文字色を調整
              fontSize: 12, // フォントサイズを調整
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
