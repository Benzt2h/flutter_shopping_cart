import 'package:dio/dio.dart';
import 'package:shopping_cart/core/http_service.dart';

class OrderService {
  final HttpService httpService = HttpService();
  final Dio _dio = HttpService().dio;

  Future<void> postCheckout(List<int> products) async {
    try {
      await _dio.post("/orders/checkout", data: {"products": products});
    } on DioException catch (e) {
      throw httpService.handleError(e);
    }
  }
}
