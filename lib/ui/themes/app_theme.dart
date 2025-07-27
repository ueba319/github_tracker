// lib/ui/themes/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: const Color(0xFF2196F3),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF24292E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(color: Colors.black87),
      // 必要に応じて他のテキストスタイルも定義
    ),
    cardTheme: CardTheme(
      // ★ここを CardThemeData に修正！★
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    // よりモダンなインプットデコレーション
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // 明るさをダークに設定
    primarySwatch: Colors.green, // プライマリカラーはライトテーマと同じ緑系で統一
    primaryColor: const Color(0xFF4CAF50), // ダークモードでのアクセントカラー
    scaffoldBackgroundColor: const Color(0xFF121212), // 暗い背景色
    cardColor: const Color(0xFF1E1E1E), // カードの背景色
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E), // AppBarも暗く
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white), // テキストを明るく
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white),
      // 必要に応じて他のテキストスタイルも定義
    ),
    cardTheme: CardTheme(
      // CardThemeDataを使用
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[800], // 入力フィールドの背景色
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // 必要に応じて、アイコンの色やボタンの色なども調整
    iconTheme: const IconThemeData(color: Colors.white70),
    dividerColor: Colors.white12,
  );
}
