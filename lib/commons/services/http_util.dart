
import 'package:dio/dio.dart';
import 'package:learning_app/commons/utils/constants.dart';
import 'package:learning_app/global.dart';

class HttpUtil {
  late Dio dio;
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }
  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      followRedirects: false, // Don't follow redirects automatically
      validateStatus: (status) {
        return status != null && status < 400; // Accept 200-399, reject 400+
      },
      headers: {},
      contentType: "application/json",
      responseType: ResponseType.json,
    );
    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // print("app request data ${options.data} ");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("app response data ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("app error data: $e");
          // return handler.next(error);
          ErrorEntity eInfo = createErrorEntity(e);
          onError(eInfo);
        },
      ),
    );
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    print(headers);
    return headers;
  }

  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    
    // Add headers to indicate this is an API request, not a browser request
    requestOptions.headers!['Accept'] = 'application/json';
    requestOptions.headers!['X-Requested-With'] = 'XMLHttpRequest';
    
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";

    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Sending timed out");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receiving timed out");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad ssl certificate");

    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Syntax Error");
        case 401:
          return ErrorEntity(code: 401, message: "Permission denied");
        default:
          return ErrorEntity(code: -1, message: "Bad response");
      }

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server cancelled");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {

  print("error.code-> ${eInfo.code}, error.message-> ${eInfo.message}");
  switch (eInfo.code) {
    case 400:
      print("Server sytax error");
      break;
    case 401:
      print("You are denied to continue");
      break;
    case 500:
      print("Internal server error");
      break;
    default:
      print("Unknown error");
      break;
  }
}
