import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://fakestoreapi.com";

  Future<List<dynamic>> fetchCategories() async {
    final res = await http.get(Uri.parse("$baseUrl/products/categories"));
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> fetchProductsByCategory(String category) async {
    final res = await http.get(Uri.parse("$baseUrl/products/category/$category"));
    return jsonDecode(res.body);
  }

 
}
