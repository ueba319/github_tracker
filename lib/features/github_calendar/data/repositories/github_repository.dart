// lib/features/github_calendar/data/repositories/github_repository.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/features/github_calendar/data/datasources/github_api_datasource.dart';
import 'package:github_traker_app/features/github_calendar/domain/entities/commit_activity.dart';

/// GitHubRepository の抽象インターフェース
abstract class GitHubRepository {
  Future<List<CommitActivity>> getUserCommitActivities(
      String username, int days);
}

/// GitHubRepository の具体的な実装
/// データソースからデータを取得し、ドメイン層のエンティティに変換します。
class GitHubRepositoryImpl implements GitHubRepository {
  final GitHubApiDatasource apiDatasource;

  GitHubRepositoryImpl(this.apiDatasource);

  @override
  Future<List<CommitActivity>> getUserCommitActivities(
      String username, int days) async {
    final List<CommitActivity> activities =
        await apiDatasource.fetchUserPublicEvents(username, days);
    // 必要であればここでデータ変換や追加ロジックを行う
    return activities;
  }
}

// GitHubRepository の実装を提供するプロバイダ
final githubRepositoryProvider = Provider<GitHubRepository>((ref) {
  // DataLayerのDatasourceプロバイダを監視し、Repositoryの実装を提供します
  final apiDatasource = ref.watch(
      githubApiDatasourceProvider); // data/datasources/github_api_datasource.dart で定義されたプロバイダ
  return GitHubRepositoryImpl(apiDatasource);
});
