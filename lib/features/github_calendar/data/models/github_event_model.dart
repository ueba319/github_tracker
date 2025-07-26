// lib/features/github_calendar/data/models/github_event_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_traker_app/features/github_calendar/domain/entities/commit_activity.dart';

part 'github_event_model.freezed.dart';
part 'github_event_model.g.dart';

@freezed
class GitHubEventModel with _$GitHubEventModel {
  const GitHubEventModel._();
  const factory GitHubEventModel({
    required String type,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _GitHubEventModel;

  factory GitHubEventModel.fromJson(Map<String, dynamic> json) =>
      _$GitHubEventModelFromJson(json);

  // ★この toEntity() メソッドが完全に記述されているか確認してください★
  CommitActivity toEntity() {
    return CommitActivity(
      date: createdAt,
      commitCount: 1, // ここではPushEvent 1つを1コミットとして扱う
    );
  }
}
