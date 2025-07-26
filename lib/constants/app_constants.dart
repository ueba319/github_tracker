class AppConstants {
  static const String githubApiBaseUrl = 'https://api.github.com';
  // static const int commitCalendarDays = 365; // 過去1年間を表示する場合はこちら
  static const String githubUsername =
      'ueba319'; // アプリケーションでデフォルトで使用するGitHubユーザー名

  /// 現在の月の合計日数を計算します。
  static int get daysInCurrentMonth {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0); // 現在の月の最終日
    return lastDayOfMonth.day;
  }
}
