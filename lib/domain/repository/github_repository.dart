import 'package:github_traker_app/domain/entities/commit_activity.dart';

/// GitHub リポジトリの抽象インターフェース
abstract class GithubRepository {
  Future<List<CommitActivity>> getUserCommitActivities(
    String userName,
    int days,
  );
}
