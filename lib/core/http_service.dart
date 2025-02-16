import 'package:dio/dio.dart';

class HttpService {
  late Dio dio;

  HttpService() {
    dio = Dio(
      BaseOptions(
        //for android emulator use ip ex. http://192.168.1.2:8080
        baseUrl: "http://localhost:8080",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("📡 Request: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print("✅ Response: ${response.statusCode}");
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        print("❌ Error: ${error.message}");
        return handler.next(error);
      },
    ));
  }

  Exception handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Exception("Connection timed out. Please try again.");
      case DioExceptionType.sendTimeout:
        return Exception("Request send timed out. Please try again.");
      case DioExceptionType.receiveTimeout:
        return Exception("Response receive timed out. Please try again.");
      case DioExceptionType.badResponse:
        return Exception("Server error: ${error.response?.statusCode}");
      case DioExceptionType.cancel:
        return Exception("Request was cancelled.");
      case DioExceptionType.unknown:
        return Exception("Unknown error occurred.");
      default:
        return Exception("Something went wrong.");
    }
  }
}
