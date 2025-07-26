// lib/features/github_calendar/presentation/view/commit_calendar/commit_calendar_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/features/github_calendar/domain/use_cases/get_user_commit_activity_use_case.dart';
import 'package:github_traker_app/features/github_calendar/presentation/view/commit_calendar/commit_calendar_state.dart';
import 'package:github_traker_app/foundation/app_enums.dart';

/// CommitCalendarScreen の ViewModel
class CommitCalendarViewModel extends StateNotifier<CommitCalendarState> {
  final GetUserCommitActivityUseCase _getUserCommitActivityUseCase;

  CommitCalendarViewModel(this._getUserCommitActivityUseCase)
      : super(CommitCalendarState.initial());

  Future<void> fetchCommitData(String username) async {
    state =
        state.copyWith(loadingState: LoadingState.loading, errorMessage: null);
    try {
      final data = await _getUserCommitActivityUseCase.call(username);
      state = state.copyWith(
        commitCounts: data,
        loadingState: LoadingState.success,
      );
    } catch (e) {
      state = state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: e.toString(),
      );
    }
  }
}
