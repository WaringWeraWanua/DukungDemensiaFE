// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:dukungan_demensia/models/news_models.dart";
import "package:dukungan_demensia/widgets/layout/text_layout.dart";
import "package:flutter/material.dart";

Widget NewsTile(Article article) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(article.urlToImage ?? ''),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
        ),
        SizedBox(height: 8.0,),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30.0)
          ),
          child: Text(article.source?.name ?? '', style: TextStyle(color: Colors.white),),
        ),
        SizedBox(height: 8.0,),
        Text(article.title ?? '', style: TextLayout.title18)
      ],
    )
  );
}