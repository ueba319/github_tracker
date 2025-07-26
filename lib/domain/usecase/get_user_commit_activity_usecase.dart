import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/domain/entities/commit_activity.dart';
import 'package:github_traker_app/domain/repository/github_repository.dart';

/// ユーザーのコミット履歴を取得するユースケース
/// 特定のビジネスロジック（データの取得と変換）をカプセル化します。
class GetUserCommitActivityUseCase {
  final GithubRepository repository;

  GetUserCommitActivityUseCase(this.repository);

  /// 指定されたユーザーの過去`days`間のコミット活動を取得し、日付ごとのコミット数マップとして返します。
  /// 各PushEventを1コミットとしてカウントします。
  Future<Map<DateTime, int>> call(String username, {int? days}) async {
    // days が指定されなかった場合、今月の日数を使用する
    final int actualDays = days ?? AppConstants.daysInCurrentMonth;

    final List<CommitActivity> activities =
        await repository.getUserCommitActivities(username, actualDays);

    final Map<DateTime, int> commitCounts = {};
    final now = DateTime.now();

    // 今月の最初の日から今日までの日付を生成
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    for (int i = 0; i < actualDays; i++) {
      final date = firstDayOfMonth.add(Duration(days: i));
      // 今日以降の日付は含めない（未来のデータは不要なため）
      if (date.isAfter(now)) {
        break;
      }
      // 日付部分のみを比較するために、日付を正規化
      commitCounts[DateTime(date.year, date.month, date.day)] = 0;
    }

    // 取得したアクティビティに基づいてコミット数を更新
    for (var activity in activities) {
      final DateTime activityDate =
          DateTime(activity.date.year, activity.date.month, activity.date.day);
      if (commitCounts.containsKey(activityDate)) {
        commitCounts[activityDate] =
            (commitCounts[activityDate] ?? 0) + activity.commitCount;
      }
    }
    return commitCounts;
  }
}
