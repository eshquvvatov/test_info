import 'package:connectivity_plus/connectivity_plus.dart';


abstract class NetworkInfo {
  Future<bool> checkConnectivity();
}


class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> checkConnectivity() async {
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}