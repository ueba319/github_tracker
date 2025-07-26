// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_traker_app/constants/app_constants.dart';
import 'package:github_traker_app/presentation/screen/commit_calendar_screen.dart';

// 環境変数からアクセストークンを取得するヘルパー関数
// ビルド時に --dart-define=GITHUB_ACCESS_TOKEN=YOUR_TOKEN のように渡される値を参照します。
String? get githubAccessToken =>
    const String.fromEnvironment('GITHUB_ACCESS_TOKEN');

void main() {
  // アプリケーション起動時にアクセストークンが読み込まれているか確認（デバッグ用）
  // print('GitHub Access Token loaded: $githubAccessToken');

  runApp(
    // Riverpod を使用するために ProviderScope でアプリをラップします。
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Commit Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const CommitCalendarScreen(
        username: AppConstants.githubUsername, // AppConstantsからユーザー名を取得
      ),
    );
  }
}
