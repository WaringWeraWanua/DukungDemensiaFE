import 'dart:convert';
import 'package:dukungan_demensia/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsApi{
  Future<List<Article>> getArticle() async {
    final endPointUrl = Uri.parse("https://newsapi.org/v2/everything?q=dementia&apiKey=75360416e97b4a95bc489e98eb323e5f");
    final res = await http.get(endPointUrl);
    print(res.statusCode);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Error Articles");
    }
  }
}