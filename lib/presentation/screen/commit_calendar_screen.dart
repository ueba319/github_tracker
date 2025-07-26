import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/presentation/provider/commit_providers.dart';
import 'package:github_traker_app/presentation/widget/day_cell.dart';

/// GitHubコミットカレンダーを表示するスクリーン
/// GitHubコミットカレンダーを表示するスクリーン
class CommitCalendarScreen extends ConsumerWidget {
  final String username;

  const CommitCalendarScreen({
    super.key,
    required this.username,
  });

  Color _getCommitColor(int commitCount) {
    if (commitCount == 0) {
      return Colors.grey[200]!;
    } else if (commitCount < 5) {
      return Colors.green[100]!;
    } else if (commitCount < 10) {
      return Colors.green[300]!;
    } else if (commitCount < 20) {
      return Colors.green[500]!;
    } else {
      return Colors.green[700]!;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commitDataAsync = ref.watch(userCommitActivityProvider(username));

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Commit Calendar'),
      ),
      body: commitDataAsync.when(
        data: (commitData) {
          if (commitData.isEmpty) {
            return const Center(child: Text('コミットデータが見つかりませんでした。'));
          }

          final now = DateTime.now();
          final firstDayOfMonth = DateTime(now.year, now.month, 1);
          final List<DateTime> currentMonthDates = [];
          for (int i = 0; i < AppConstants.daysInCurrentMonth; i++) {
            final date = firstDayOfMonth.add(Duration(days: i));
            if (date.isAfter(now)) {
              break;
            }
            currentMonthDates.add(date);
          }
          currentMonthDates.sort((a, b) => a.compareTo(b));

          // 曜日ラベル（月～日）
          final List<String> weekdays = ['月', '火', '水', '木', '金', '土', '日'];

          List<Widget> calendarCells = [];
          final int firstDayWeekday = firstDayOfMonth.weekday; // 1 (月) - 7 (日)

          int leadingEmptyCells =
              (firstDayWeekday == 7) ? 6 : firstDayWeekday - 1;
          for (int i = 0; i < leadingEmptyCells; i++) {
            calendarCells.add(const SizedBox(
              width: 24,
              height: 24,
            ));
          }

          for (var date in currentMonthDates) {
            final commitCount =
                commitData[DateTime(date.year, date.month, date.day)] ?? 0;
            calendarCells.add(
              DayCell(
                date: date,
                commitCount: commitCount,
                color: _getCommitColor(commitCount),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: weekdays
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: calendarCells.length,
                    itemBuilder: (context, index) {
                      return calendarCells[index];
                    },
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('エラー: $err\n'
                'GitHubのAPI制限か、アクセストークンの設定を確認してください。\n'
                '公開イベントのみが表示される点に注意してください。'),
          ),
        ),
      ),
    );
  }
}
