// lib/features/github_calendar/domain/entities/commit_activity.dart

/// 日付ごとのコミット数を表すエンティティ
class CommitActivity {
  final DateTime date;
  final int commitCount;

  CommitActivity({
    required this.date,
    required this.commitCount,
  });
}
