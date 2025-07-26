// lib/features/github_calendar/presentation/view/commit_calendar/commit_calendar_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/features/github_calendar/domain/use_cases/get_user_commit_activity_use_case.dart';
import 'package:github_traker_app/features/github_calendar/presentation/components/day_cell.dart';
import 'package:github_traker_app/features/github_calendar/presentation/view/commit_calendar/commit_calendar_state.dart';
import 'package:github_traker_app/features/github_calendar/presentation/view/commit_calendar/commit_calendar_view_model.dart';
import 'package:github_traker_app/foundation/app_enums.dart';
import 'package:github_traker_app/foundation/constants/app_constants.dart';
import 'package:intl/intl.dart';

// ViewModelを監視するためのプロバイダをここで定義
final commitCalendarViewModelProvider = StateNotifierProvider.family<
    CommitCalendarViewModel, CommitCalendarState, String>((ref, username) {
  final getUserCommitActivityUseCase =
      ref.watch(getUserCommitActivityUseCaseProvider);
  return CommitCalendarViewModel(getUserCommitActivityUseCase);
});

/// GitHubコミットカレンダーを表示する View (Widget)
class CommitCalendarView extends ConsumerStatefulWidget {
  final String username;

  const CommitCalendarView({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<CommitCalendarView> createState() => _CommitCalendarViewState();
}

class _CommitCalendarViewState extends ConsumerState<CommitCalendarView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(commitCalendarViewModelProvider(widget.username).notifier)
          .fetchCommitData(widget.username);
    });
  }

  // コミット数に応じた色を決定 (GitHubのグラデーションに近づける)
  // テーマの明るさに応じて色を変えるように修正
  Color _getCommitColor(BuildContext context, int commitCount) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (commitCount == 0) {
      return isDarkMode
          ? const Color(0xFF161B22)
          : const Color(0xFFEBEDF0); // ダークモード用の0コミット色
    } else if (commitCount < 5) {
      return isDarkMode
          ? const Color(0xFF0E4429)
          : const Color(0xFF9BE9A8); // Light green
    } else if (commitCount < 10) {
      return isDarkMode
          ? const Color(0xFF006D32)
          : const Color(0xFF40C463); // Medium green
    } else if (commitCount < 20) {
      return isDarkMode
          ? const Color(0xFF26A641)
          : const Color(0xFF30A14E); // Darker green
    } else {
      return isDarkMode
          ? const Color(0xFF39D353)
          : const Color(0xFF216E39); // Darkest green
    }
  }

  @override
  Widget build(BuildContext context) {
    final commitCalendarState =
        ref.watch(commitCalendarViewModelProvider(widget.username));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Contributions'),
      ),
      body:
          _buildBody(commitCalendarState, textTheme, context), // ★context を渡す★
    );
  }

  Widget _buildBody(
      CommitCalendarState state, TextTheme textTheme, BuildContext context) {
    // ★context を引数に追加★
    switch (state.loadingState) {
      case LoadingState.initial:
      case LoadingState.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('コミット履歴を読み込み中...', style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      case LoadingState.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.redAccent, size: 60),
                const SizedBox(height: 16),
                Text(
                  'データの読み込みに失敗しました。\n\n${state.errorMessage ?? "不明なエラー"}',
                  textAlign: TextAlign.center,
                  style:
                      textTheme.titleMedium?.copyWith(color: Colors.redAccent),
                ),
                const SizedBox(height: 16),
                Text(
                  'ヒント: GitHubのAPI制限か、アクセストークンの設定を確認してください。公開イベントのみが表示されます。',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      case LoadingState.success:
        if (state.commitCounts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sentiment_dissatisfied,
                    color: Colors.grey, size: 60),
                const SizedBox(height: 16),
                Text(
                  '今月のコミットデータが見つかりませんでした。',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '別のユーザー名で試すか、後でもう一度確認してください。',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
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

        final List<String> weekdays = ['月', '火', '水', '木', '金', '土', '日'];

        List<Widget> calendarCells = [];
        final int firstDayWeekday = firstDayOfMonth.weekday;

        int leadingEmptyCells =
            (firstDayWeekday == DateTime.sunday) ? 6 : firstDayWeekday - 1;
        for (int i = 0; i < leadingEmptyCells; i++) {
          calendarCells.add(const SizedBox(
            width: 28,
            height: 28,
          ));
        }

        for (var date in currentMonthDates) {
          final commitCount =
              state.commitCounts[DateTime(date.year, date.month, date.day)] ??
                  0;
          calendarCells.add(
            DayCell(
              date: date,
              commitCount: commitCount,
              color: _getCommitColor(context, commitCount), // ★context を渡す★
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat('yyyy年MM月').format(now)} の貢献度',
                        style: textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ユーザー: ${widget.username}',
                        style: textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color), // 色をテーマから取得
                      ),
                      const SizedBox(height: 16),
                      // 曜日ヘッダー
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: weekdays
                            .map((day) => Expanded(
                                  child: Center(
                                    child: Text(
                                      day,
                                      style: textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.color), // 色をテーマから取得
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      // カレンダーグリッド
                      GridView.builder(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
