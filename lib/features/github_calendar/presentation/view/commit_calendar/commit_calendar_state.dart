// lib/features/github_calendar/presentation/view/commit_calendar/commit_calendar_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_traker_app/foundation/app_enums.dart';

part 'commit_calendar_state.freezed.dart';

@freezed
class CommitCalendarState with _$CommitCalendarState {
  const factory CommitCalendarState({
    required Map<DateTime, int> commitCounts,
    required LoadingState loadingState,
    String? errorMessage,
  }) = _CommitCalendarState;

  factory CommitCalendarState.initial() => const CommitCalendarState(
        commitCounts: {},
        loadingState: LoadingState.initial,
      );
}
