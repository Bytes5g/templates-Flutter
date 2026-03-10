/// Cubit إدارة حالة الشبكة (Online/Offline)
library;

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/network_info.dart';

/// حالة الشبكة
enum NetworkStatus { online, offline }

/// Cubit مراقبة الشبكة
class NetworkCubit extends Cubit<NetworkStatus> {
  NetworkCubit({required NetworkInfo networkInfo})
      : _networkInfo = networkInfo,
        super(NetworkStatus.online) {
    _init();
  }

  final NetworkInfo _networkInfo;
  StreamSubscription<bool>? _subscription;

  void _init() {
    _subscription = _networkInfo.onConnectivityChanged.listen((isOnline) {
      emit(isOnline ? NetworkStatus.online : NetworkStatus.offline);
    });

    // التحقق من الحالة الحالية عند البدء
    _networkInfo.isConnected.then((isOnline) {
      emit(isOnline ? NetworkStatus.online : NetworkStatus.offline);
    });
  }

  bool get isOnline  => state == NetworkStatus.online;
  bool get isOffline => state == NetworkStatus.offline;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
