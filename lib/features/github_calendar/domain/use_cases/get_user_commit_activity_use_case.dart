// lib/features/github_calendar/domain/use_cases/get_user_commit_activity_use_case.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/features/github_calendar/data/repositories/github_repository.dart';
import 'package:github_traker_app/features/github_calendar/domain/entities/commit_activity.dart';
import 'package:github_traker_app/foundation/constants/app_constants.dart';

/// ユーザーのコミット履歴を取得するユースケースの抽象
abstract class GetUserCommitActivityUseCase {
  Future<Map<DateTime, int>> call(String username, {int? days});
}

/// GetUserCommitActivityUseCase の具体的な実装
class GetUserCommitActivityUseCaseImpl implements GetUserCommitActivityUseCase {
  final GitHubRepository repository;

  GetUserCommitActivityUseCaseImpl(this.repository);

  @override
  Future<Map<DateTime, int>> call(String username, {int? days}) async {
    final int actualDays = days ?? AppConstants.daysInCurrentMonth;

    final List<CommitActivity> activities =
        await repository.getUserCommitActivities(username, actualDays);

    final Map<DateTime, int> commitCounts = {};
    final now = DateTime.now();

    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    for (int i = 0; i < actualDays; i++) {
      final date = firstDayOfMonth.add(Duration(days: i));
      if (date.isAfter(now)) {
        break;
      }
      commitCounts[DateTime(date.year, date.month, date.day)] = 0;
    }

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

// GetUserCommitActivityUseCase の実装を提供するプロバイダ
final getUserCommitActivityUseCaseProvider =
    Provider<GetUserCommitActivityUseCase>((ref) {
  // ここでData層のRepositoryプロバイダを監視し、UseCaseの実装を提供します
  final githubRepository = ref.watch(
      githubRepositoryProvider); // data/repositories/github_repository.dart で定義されたプロバイダ
  return GetUserCommitActivityUseCaseImpl(githubRepository);
});
