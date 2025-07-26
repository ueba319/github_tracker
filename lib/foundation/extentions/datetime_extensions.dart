// lib/foundation/extensions/datetime_extensions.dart

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  /// 日付を 'YYYY-MM-DD' 形式でフォーマット
  String toYYYYMMDD() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// 指定された日付が今月かどうか
  bool isThisMonth() {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
}
