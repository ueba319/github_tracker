import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/data/data_source/github_api_data_source.dart';
import 'package:github_traker_app/data/repository/github_repository_impl.dart';
import 'package:github_traker_app/domain/usecase/get_user_commit_activity_usecase.dart';

// 環境変数からアクセストークンを取得するヘルパー関数
// main.dart内で呼び出すことで、ビルド時に定義された変数を参照できます。
String? get _githubAccessToken =>
    const String.fromEnvironment('GITHUB_ACCESS_TOKEN');

// GitHubApiDatasource を提供するプロバイダ
final githubApiDatasourceProvider = Provider((ref) {
  return GithubApiDataSource(accessToken: _githubAccessToken);
});

// GitHubRepositoryImpl を提供するプロバイダ
final githubRepositoryProvider = Provider<GithubRepositoryImpl>((ref) {
  final apiDatasource = ref.watch(githubApiDatasourceProvider);
  return GithubRepositoryImpl(apiDatasource);
});

// GetUserCommitActivityUseCase を提供するプロバイダ
final getUserCommitActivityUseCaseProvider = Provider((ref) {
  final repository = ref.watch(githubRepositoryProvider);
  return GetUserCommitActivityUseCase(repository);
});

// ユーザー名と日数に基づいてコミットデータを取得する FutureProvider
final userCommitActivityProvider =
    FutureProvider.family<Map<DateTime, int>, String>((ref, username) async {
  final getUserCommitActivity = ref.watch(getUserCommitActivityUseCaseProvider);
  // days 引数を省略（または null を渡す）ことで、今月の日数が使われるようになる
  return getUserCommitActivity.call(username);
});
