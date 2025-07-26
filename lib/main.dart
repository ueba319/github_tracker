// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/ui/routes/app_router.dart';
import 'package:github_traker_app/ui/themes/app_theme.dart';

// 環境変数からアクセストークンを取得するヘルパー関数
String? get githubAccessToken =>
    const String.fromEnvironment('GITHUB_ACCESS_TOKEN');

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // GoRouter インスタンスをRiverpodから取得
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'GitHub Commit Calendar',
      theme: AppTheme.darkTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
