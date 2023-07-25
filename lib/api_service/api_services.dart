import 'dart:convert';

import 'package:news_app/model/news_data.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/const.dart';

class ApiServices {

  Future<List<Articles>> getNewsList() async {
    try {
      var response = await http.get(Uri.parse(
          "${ConstRes.apiBaseUrl}/everything?domains=wsj.com&apiKey=${ConstRes.apiKey}"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var articleList = data['articles'] as List;
        return articleList.map((e) => Articles.fromJson(e)).toList();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
