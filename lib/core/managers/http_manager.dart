import 'package:dio/dio.dart';
import 'package:pay_zilla/config/config.dart';
import 'package:pay_zilla/core/core.dart';
import 'package:pay_zilla/functional_utils/functional_utils.dart';
import 'package:requests_inspector/requests_inspector.dart';

enum RequestType { get, post, put, patch, delete }

const successCodes = [200, 201, 203, 204];

class HttpManager {
  HttpManager({
    Dio? dio1,
    required ILocalCache cache,
    required String baseUrl,
    required this.enableLogging,
  }) {
    _dio1 = dio1 ?? Dio();
    _dio1.options.baseUrl = '$baseUrl/api';
    _dio1.options.connectTimeout = 30000;
    _dio1.options.receiveTimeout = 30000;
    _dio1.interceptors.add(
      AuthAndRefreshTokenInterceptor(cache: cache, baseUrl: baseUrl),
    );
    _dio1.interceptors.add(
      RequestsInspectorInterceptor(),
    );
    Log().debug('The token cached.. ${cache.get(CacheKeys.token)}');
  }
  late Dio _dio1;
  bool enableLogging;

  Future get(String endpoint) async {
    return _makeRequest(
      RequestType.get,
      endpoint,
      {},
    );
  }

  Future post(
    String endpoint,
    Map<String, dynamic> data,
  ) {
    return _makeRequest(
      RequestType.post,
      endpoint,
      data,
    );
  }

  Future patch(
    String endpoint,
    dynamic data,
  ) {
    return _makeRequest(
      RequestType.patch,
      endpoint,
      data,
    );
  }

  Future put(
    String endpoint,
    Map<String, dynamic> data,
  ) {
    return _makeRequest(
      RequestType.put,
      endpoint,
      data,
    );
  }

  Future delete(String endpoint) {
    return _makeRequest(
      RequestType.delete,
      endpoint,
      {},
    );
  }

  //Data parameter should be dynamic because it may accept
  //other variables other than map
  Future _makeRequest(
    RequestType type,
    String endpoint,
    dynamic data,
  ) async {
    try {
      late Response response;
      switch (type) {
        case RequestType.get:
          response = await _dio1.get(endpoint);

          break;
        case RequestType.post:
          response = await _dio1.post(endpoint, data: data);
          break;
        case RequestType.put:
          response = await _dio1.put(endpoint, data: data);
          break;
        case RequestType.patch:
          response = await _dio1.patch(endpoint, data: data);
          break;
        case RequestType.delete:
          response = await _dio1.delete(endpoint);
          break;
        // ignore: no_default_cases
        default:
          throw InvalidArgOrDataException();
      }
      if (successCodes.contains(response.statusCode)) {
        if (enableLogging) {
          Log().jsonLog(
            '$endpoint JSON res ',
            response.data as Map<String, dynamic>,
          );
        }
        return response.data;
      }
      throw PZillaServerException(_handleException(response.data));
    } catch (e) {
      Log().debug(
        'the _makeRequest exception caught ${AppConfig.baseUrl}/api$endpoint',
        e.toString(),
      );
      if (e is ServerException) {
        rethrow;
      }
      if (e is DioError) {
        if (e.error is SessionExpiredServerException) {
          throw SessionExpiredServerException();
        }
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw TimeoutServerException();
        }
        if (e is FormatException) {
          throw InvalidArgOrDataException();
        }
        if (e.response != null) {
          throw PZillaServerException(_handleException(e.response?.data));
        }
      }
      throw UnexpectedServerException();
    }
  }

  String _handleException(dynamic err) {
    if (enableLogging) Log().error('Exception handler logger', err.toString());
    if (err != null && err.toString().isNotEmpty) {
      // ignore: avoid_dynamic_calls
      if (err['message'] != null) {
        // ignore: avoid_dynamic_calls
        return err['message'].toString();
      }
      // ignore: avoid_dynamic_calls
      if (err['error'] != null) {
        // ignore: avoid_dynamic_calls
        return err['error'].toString();
      }
    }
    // this colon at the end of the string is used to identify the error in the logs which means that
    // the server returned an error but we couldn't parse it.
    return 'An unexpected error occurred:';
  }
}
