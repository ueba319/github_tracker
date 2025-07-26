// lib/ui/routes/app_route_paths.dart

// ルートパスの定数
class AppRoutePaths {
  static const String home = '/';
  // 他の機能のルートパスがあれば追加
  static const String githubCalendar = '/github-calendar';
}

// ページを識別するためのenum（GoRouterのextraなどでも利用可能）
enum AppRoutes {
  home,
  githubCalendar,
}

// AppRoutes に対応するパスを返すgetter (optional)
extension AppRoutesExtension on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.home:
        return AppRoutePaths.home;
      case AppRoutes.githubCalendar:
        return AppRoutePaths.githubCalendar;
    }
  }
}
