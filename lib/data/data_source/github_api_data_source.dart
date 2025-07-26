import 'dart:convert';

import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/domain/entities/commit_activity.dart';
import 'package:http/http.dart' as http;

/// GitHub REST APIと通信するDataSource
class GithubApiDataSource {
  final String? accessToken;

  GithubApiDataSource({this.accessToken});

  /// GitHub ユーザーの公開イベントを取得
  Future<List<CommitActivity>> fetchUserPublicEvents(
    String username,
    int days,
  ) async {
    final List<CommitActivity> commitActivities = [];
    final url =
        '${AppConstants.githubApiBaseUrl}/users/$username/events/public';

    final headers = {
      'Accept': 'application/vnd.github.v3+json',
      if (accessToken != null && accessToken!.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> events = json.decode(response.body);

        for (var event in events) {
          if (event['type'] == 'PushEvent') {
            final DateTime createdAt =
                DateTime.parse(event['created_at']).toLocal();

            commitActivities
                .add(CommitActivity(date: createdAt, commitCount: 1));
          }
        }
        return commitActivities;
      } else {
        print('Failed to load GitHub events: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load GitHub events');
      }
    } catch (e) {
      print('Error fetching GitHub events: $e');
      throw Exception('Error fetching GitHub events');
    }
  }
}
