import 'package:dio/dio.dart';
import 'package:shopping_cart/core/http_service.dart';
import 'package:shopping_cart/models/product_info.dart';

class ProductService {
  final HttpService httpService = HttpService();
  final Dio _dio = HttpService().dio;

  Future<List<ProductInfo>> getRecommendedProducts() async {
    try {
      Response response = await _dio.get("/recommended-products");
      List<ProductInfo> products = (response.data as List)
          .map((product) => ProductInfo.fromJson(product))
          .toList();
      return products;
    } on DioException catch (e) {
      throw httpService.handleError(e);
    }
  }
}
