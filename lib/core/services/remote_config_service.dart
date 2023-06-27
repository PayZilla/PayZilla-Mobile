import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';

abstract class RemoteConfigService {
  Future<void> init();
  String getString(String key);
  double getDouble(String key);
  int getInt(String key);
  bool getBool(String key);
}

class RemoteConfigServiceImpl implements RemoteConfigService {
  late FirebaseRemoteConfig remoteConfig;

  @override
  Future<void> init() async {
    // create a remote config object
    remoteConfig = FirebaseRemoteConfig.instance;

    // set remote config settings
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: 1.minutes,
        minimumFetchInterval: 1.seconds,
      ),
    );

    // fetch remote values and activate the fetched values
    await remoteConfig.fetchAndActivate();
  }

  @override
  bool getBool(String key) {
    return remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return remoteConfig.getInt(key);
  }

  @override
  String getString(String key) {
    return remoteConfig.getString(key);
  }
}
