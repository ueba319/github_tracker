// lib/foundation/constants/app_constants.dart

class AppConstants {
  static const String githubApiBaseUrl = 'https://api.github.com';
  static const String githubUsername =
      'ueba319'; // ★あなたのGitHubユーザー名に置き換えてください！★

  /// 現在の月の合計日数を計算します。
  static int get daysInCurrentMonth {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    return lastDayOfMonth.day;
  }
}
