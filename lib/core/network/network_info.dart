/// مراقب حالة الاتصال بالإنترنت
library;

import 'package:connectivity_plus/connectivity_plus.dart';

/// خدمة مراقبة حالة الشبكة
class NetworkInfo {
  const NetworkInfo({required Connectivity connectivity})
      : _connectivity = connectivity;

  final Connectivity _connectivity;

  /// هل يوجد اتصال بالإنترنت حالياً؟
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _isOnline(result);
  }

  /// بث مستمر لتغييرات حالة الاتصال
  Stream<bool> get onConnectivityChanged => _connectivity.onConnectivityChanged
      .map((results) => _isOnline(results));

  bool _isOnline(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
