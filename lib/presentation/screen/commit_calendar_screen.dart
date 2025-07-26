import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/presentation/provider/commit_providers.dart';
import 'package:github_traker_app/presentation/widget/day_cell.dart';
import 'package:intl/intl.dart';

/// GitHubコミットカレンダーを表示するスクリーン
class CommitCalendarScreen extends ConsumerWidget {
  final String username;

  const CommitCalendarScreen({
    super.key,
    required this.username,
  });

  // コミット数に応じた色を決定
  Color _getCommitColor(int commitCount) {
    if (commitCount == 0) {
      return Colors.grey[200]!; // コミットなし
    } else if (commitCount < 5) {
      return Colors.green[100]!; // 少ないコミット
    } else if (commitCount < 10) {
      return Colors.green[300]!; // 中程度のコミット
    } else if (commitCount < 20) {
      return Colors.green[500]!; // 多めのコミット
    } else {
      return Colors.green[700]!; // 非常に多いコミット
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userCommitActivityProvider を watch してコミットデータを取得
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

          // 最新の日付から過去へソート
          final sortedDates = commitData.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          // 日付を週ごとにグループ化するためのロジック
          // 週の開始日（月曜日を基準）
          final Map<int, List<DateTime>> weeks = {};
          for (var date in sortedDates) {
            // Dartの曜日（月:1, 火:2, ... 日:7）
            // ISO 8601 週の初めは月曜日 (1)
            int weekday = date.weekday;
            // その週の月曜日を取得
            DateTime startOfWeek = date.subtract(Duration(days: weekday - 1));
            // 週の開始日をキーとしてグループ化
            weeks
                .putIfAbsent(startOfWeek.millisecondsSinceEpoch, () => [])
                .add(date);
          }

          // 週のリストをソート (最も古い週から最も新しい週へ)
          final sortedWeeksKeys = weeks.keys.toList()..sort();
          final List<List<DateTime>> sortedWeeks = sortedWeeksKeys.map((key) {
            final weekDates = weeks[key]!;
            // 各週内の日付もソート (月曜から日曜へ)
            weekDates.sort((a, b) => a.compareTo(b));
            return weekDates;
          }).toList();

          // 月のラベルを作成するための準備
          final List<String> monthLabels = [];
          final Set<int> displayedMonths = {}; // 表示された月を追跡

          // カレンダーの表示順序と月のラベルの調整
          // ここでの月ラベルの配置は、厳密なGitHubの草カレンダーのレイアウトとは異なる場合があります。
          // シンプルに、各週の開始月を基準にラベルを生成します。
          for (var week in sortedWeeks) {
            if (week.isNotEmpty) {
              final firstDayInWeek = week.first;
              // 月が変わった場合のみラベルを追加
              if (!displayedMonths.contains(firstDayInWeek.month)) {
                monthLabels.add(DateFormat('MMM').format(firstDayInWeek));
                displayedMonths.add(firstDayInWeek.month);
              }
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'ユーザー: $username の過去 ${AppConstants.commitCalendarDays} 日間のコミット',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // 曜日ラベル（月～日）
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const SizedBox(width: 24), // 月ラベルのスペース
                    for (var day in ['月', '火', '水', '木', '金', '土', '日'])
                      Expanded(
                        child: Center(
                          child: Text(day,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 横スクロール可能にする
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 月のラベル列
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var month in monthLabels)
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 24.0, right: 8.0), // 各週の高さに合わせる
                                child: Text(month,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                          ],
                        ),
                        // コミットカレンダー本体
                        // Column が週を表し、その中に7つの DayCell が入る
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: sortedWeeks.map((week) {
                            return Column(
                              children: week.map((date) {
                                final commitCount = commitData[date] ?? 0;
                                return DayCell(
                                  date: date,
                                  commitCount: commitCount,
                                  color: _getCommitColor(commitCount),
                                );
                              }).toList(),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // 凡例 (必要であれば追加)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('凡例:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Container(
                            width: 20, height: 20, color: Colors.grey[200]),
                        const SizedBox(width: 8),
                        const Text('0 コミット'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 20, height: 20, color: Colors.green[100]),
                        const SizedBox(width: 8),
                        const Text('1-4 コミット'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 20, height: 20, color: Colors.green[300]),
                        const SizedBox(width: 8),
                        const Text('5-9 コミット'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 20, height: 20, color: Colors.green[500]),
                        const SizedBox(width: 8),
                        const Text('10-19 コミット'),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            width: 20, height: 20, color: Colors.green[700]),
                        const SizedBox(width: 8),
                        const Text('20+ コミット'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
