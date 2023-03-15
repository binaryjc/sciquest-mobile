import 'package:sciquest_mobile/main/utils/AppConstant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  //staging env

  final String devmode = "staging";
  final String url_rel = "";
  final String BaseUrlAPI = "";

  Future<String> register_user(Map<String, String> formdata) async {
    //String apiLoginString = BaseUrlAPI + "mobile-api/register";
    /**
     * since we do not have yet a server, we will use jsonplaceholder
     * 
     */
    String apiLoginString = "https://jsonplaceholder.typicode.com/posts";

    final Uri url = Uri.parse(apiLoginString);
    final response = await http.post(url, body: formdata);
    print('data sent: $formdata');
    if (response.statusCode != 500) {
      return response.body;
    } else {
      throw Exception("Failed to Load Login API");
    }
  }
}
