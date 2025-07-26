import 'package:github_traker_app/data/data_source/github_api_data_source.dart';
import 'package:github_traker_app/domain/entities/commit_activity.dart';
import 'package:github_traker_app/domain/repository/github_repository.dart';

/// GitHubRepository の実装クラス

class GithubRepositoryImpl implements GithubRepository {
  final GithubApiDataSource apiDataSource;

  GithubRepositoryImpl(this.apiDataSource);

  @override
  Future<List<CommitActivity>> getUserCommitActivities(
    String userName,
    int days,
  ) {
    return apiDataSource.fetchUserPublicEvents(userName, days);
  }
}
