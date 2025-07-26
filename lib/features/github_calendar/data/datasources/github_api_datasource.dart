// lib/features/github_calendar/data/datasources/github_api_datasource.dart

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/core/di/providers.dart';
import 'package:github_traker_app/features/github_calendar/domain/entities/commit_activity.dart';
import 'package:github_traker_app/foundation/constants/app_constants.dart';
import 'package:http/http.dart' as http;

/// GitHub REST API と通信するデータソースの抽象
abstract class GitHubApiDatasource {
  Future<List<CommitActivity>> fetchUserPublicEvents(String username, int days);
}

/// GitHubApiDatasource の具体的な実装
class GitHubApiDatasourceImpl implements GitHubApiDatasource {
  final String? accessToken;
  final http.Client client;

  GitHubApiDatasourceImpl({this.accessToken, required this.client});

  @override
  Future<List<CommitActivity>> fetchUserPublicEvents(
      String username, int days) async {
    final List<CommitActivity> commitActivities = [];
    final url =
        '${AppConstants.githubApiBaseUrl}/users/$username/events/public';
    final headers = {
      'Accept': 'application/vnd.github.v3+json',
      if (accessToken != null && accessToken!.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await client.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> events = json.decode(response.body);
        for (var event in events) {
          if (event['type'] == 'PushEvent') {
            final DateTime createdAt =
                DateTime.parse(event['created_at']).toLocal();
            // Assuming PushEvent corresponds to 1 commit activity
            commitActivities
                .add(CommitActivity(date: createdAt, commitCount: 1));
          }
        }
        return commitActivities;
      } else {
        throw Exception(
            'Failed to load GitHub events: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching GitHub events: $e');
    }
  }
}

// GitHubApiDatasource の実装を提供するプロバイダ
final githubApiDatasourceProvider = Provider<GitHubApiDatasource>((ref) {
  // core/di/providers.dart から httpClientProvider を監視します
  final httpClient = ref.watch(httpClientProvider);
  // 環境変数からGitHubアクセストークンを取得します
  const accessToken = String.fromEnvironment('GITHUB_ACCESS_TOKEN');
  return GitHubApiDatasourceImpl(accessToken: accessToken, client: httpClient);
});
