import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:isa_project/model/news_model.dart';

class NewsController extends GetxController {
  Future<Articles?> getData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1ff62a1e8ef942da8158564eb5bf81db");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
        return null; // Return null in case of error
      }
    } else {
      // Handle non-200 status code
      Get.snackbar("Error", "Failed to fetch data. Status code: ${response.statusCode}");
    }
    return null;
  }
}
