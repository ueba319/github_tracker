import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/domain/entities/commit_activity.dart';
import 'package:github_traker_app/domain/repository/github_repository.dart';

/// コミット履歴を取得するUseCase
class GetUserCommitActivityUsecase {
  final GithubRepository repository;
  GetUserCommitActivityUsecase(this.repository);

  /// 指定されたユーザーの過去の日数のコミット履歴を取得し、日付ごとのコミット数Mapとして返却する
  Future<Map<DateTime, int>> call(String username,
      {int days = AppConstants.commitCalendarDays}) async {
    final List<CommitActivity> activities =
        await repository.getUserCommitActivities(
      username,
      days,
    );

    final Map<DateTime, int> commitCounts = {};
    final now = DateTime.now();

    // 過去N日間の日付を生成し、初期値を0に設定
    for (int i = 0; i < days; i++) {
      final date = now.subtract(Duration(days: i));

      commitCounts[DateTime(date.year, date.month, date.day)] = 0;
    }

    for (var activity in activities) {
      final DateTime activityDate =
          DateTime(activity.date.year, activity.date.month, activity.date.day);

      if (commitCounts.containsKey(activityDate)) {
        // 既に存在する日付のコミット数を加算
        commitCounts[activityDate] =
            commitCounts[activityDate]! + activity.commitCount;
      } else {
        // 新しい日付の場合はそのまま設定
        commitCounts[activityDate] = activity.commitCount;
      }
    }

    return commitCounts;
  }
}
