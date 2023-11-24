import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/di/dependency_injection_container.dart';
import 'package:pay_zilla/functional_utils/log_util.dart';

enum Flavor { development, production }

class AppEnvManager {
  AppEnvManager(this._flavor);
  final Flavor _flavor;

  static AppEnvManager get instance {
    return sl<AppEnvManager>();
  }

  Flavor getEnvironment() => _flavor;
}

extension AppConfig on Flavor {
  R fold<R>({
    required R Function(String) ifDevelopment,
    required R Function(String) ifProduction,
  }) {
    switch (this) {
      case Flavor.development:
        return ifDevelopment(Flavor.development.name);
      case Flavor.production:
        return ifProduction(Flavor.production.name);
      // ignore: no_default_cases
      default:
        throw InvalidArgOrDataException();
    }
  }

  static late Map<String, String> _constants;

  static void setEnvironment(Flavor environment) {
    switch (environment) {
      case Flavor.development:
        _constants = _Constants.developmentConstants;
        break;
      case Flavor.production:
        _constants = _Constants.prodConstants;
        break;
    }
  }

  static String get baseUrl {
    final val = _constants[_Constants.baseUrl]!;

    Log().debug('The val of base url is $val');
    return val;
  }

  static String get appName {
    return _constants[_Constants.appName]!;
  }

  static String get flavor {
    return _constants[_Constants.flavor]!;
  }

  static String get clientUrl {
    return _constants[_Constants.clientUrl]!;
  }
}

class _Constants {
  static const baseUrl = 'BASE_URL';
  static const appName = 'APP_NAME';
  static const flavor = 'FLAVOR_NAME';
  static const clientUrl = 'CLIENT_URL';
  static Map<String, String> developmentConstants = {
    baseUrl: throwIfUndefined('APP_DEV_URL'),
    appName: 'PayZilla Test',
    flavor: Flavor.development.name,
    clientUrl: throwIfUndefined('APP_DEV_URL'),
  };

  static Map<String, String> prodConstants = {
    baseUrl: throwIfUndefined('APP_PROD_URL'),
    appName: 'PayZilla',
    flavor: Flavor.production.name,
    clientUrl: throwIfUndefined('APP_PROD_URL'),
  };
}

/// Get a string value from .env file
/// dotenv.load() must be called before this method
/// [env] is the key of the value to be retrieved;
/// an exception will be thrown if the key is not found
String throwIfUndefined(String env) {
  final value = dotenv.get(env, fallback: '');
  if (value.isEmpty) {
    throw InvalidArgOrDataException('$env is undefined');
  }
  return value;
}
