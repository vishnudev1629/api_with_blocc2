import 'dart:convert';
import 'package:api_with_blocc/Model/Product1.dart';
import 'package:http/http.dart';
import 'Model/Products.dart';


class productRepositort{
  Future<List<Products>?> fetchData() async {

    var response = await get(Uri.parse("https://dummyjson.com/products"));
    var jsondata = jsonDecode(response.body.toString());
    var resp = Product1.fromJson(jsondata);
    var list = resp.products;
    return list;
  }
}
