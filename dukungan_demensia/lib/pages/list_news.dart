// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dukungan_demensia/components/news_tile.dart';
import 'package:dukungan_demensia/models/news_models.dart';
import 'package:dukungan_demensia/services/news_api.dart';
import 'package:flutter/material.dart';

class ListNewsPage extends StatefulWidget {
  const ListNewsPage({Key? key}) : super(key: key);

  @override
  State<ListNewsPage> createState() => _ListNewsPageState();
}

class _ListNewsPageState extends State<ListNewsPage> {

  NewsApi client = NewsApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: client.getArticle(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data as List<Article>; 
            return ListView.builder(
              itemBuilder: (context, index) => NewsTile(
                articles[index],
              ),
              itemCount: articles.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}