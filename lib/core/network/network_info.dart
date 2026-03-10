import 'package:connectivity_plus/connectivity_plus.dart';

/// واجهة التحقق من الاتصال بالإنترنت
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectivityStream;
}

/// تطبيق NetworkInfo باستخدام connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return _isConnectedFromResult(result);
  }

  @override
  Stream<bool> get connectivityStream =>
      _connectivity.onConnectivityChanged.map(
        (results) => _isConnectedFromResult(results),
      );

  bool _isConnectedFromResult(List<ConnectivityResult> results) {
    return results.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet,
    );
  }
}
