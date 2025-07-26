// lib/ui/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/features/github_calendar/presentation/view/commit_calendar/commit_calendar_view.dart';
import 'package:github_traker_app/foundation/constants/app_constants.dart';
import 'package:github_traker_app/ui/routes/app_route_paths.dart';
import 'package:go_router/go_router.dart';

// GoRouter インスタンスを提供するプロバイダ
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutePaths.githubCalendar, // 最初に表示するルート
    routes: [
      GoRoute(
        path: AppRoutePaths.githubCalendar,
        name: AppRoutes.githubCalendar.name, // ルート名をenumから取得
        builder: (context, state) => const CommitCalendarView(
          username: AppConstants.githubUsername, // ここでユーザー名を渡す
        ),
      ),
      // 他のルートがあればここに追加
    ],
    // エラーページのハンドリングなど
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text('Error: ${state.error}')),
    ),
  );
});
