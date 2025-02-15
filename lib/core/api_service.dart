import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:8080",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
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

  Future<dynamic> getRequest(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
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
