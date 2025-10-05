import 'dart:convert';
import 'package:basic_e_commerce_app/product/constants/network_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchCategories() async {
    final res = await http.get(
      Uri.parse("${NetworkConstants.baseUrl}/products/categories"),
    );
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final encodedCategory = Uri.encodeComponent(category);
    final res = await http.get(
      Uri.parse(
        "${NetworkConstants.baseUrl}/products/category/$encodedCategory",
      ),
    );
    return jsonDecode(res.body);
  }
}
