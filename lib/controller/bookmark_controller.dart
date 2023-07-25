import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news_data.dart';

class BookmarkController extends GetxController {
  var isLoading = false.obs;
  var errorTxt = "".obs;
  var articleList = <Articles>[].obs;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    getBookmarkData(true);
    super.onInit();
  }

  getBookmarkData(bool load) {
    isLoading(load);
    articleList.clear();
    firebaseDatabase
        .ref("articles")
        .child(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      for (var item in value.children) {
        Map data = item.value as Map;
        Source source = Source();
        source.name = data['source']['name'];
        source.id = data['source']['id'];
        Articles articles = Articles();
        articles.source = source;
        articles.author = data['author'];
        articles.title = data['title'];
        articles.description = data['description'];
        articles.url = data['url'];
        articles.urlToImage = data['urlToImage'];
        articles.publishedAt = data['publishedAt'];
        articles.content = data['content'];
        articleList.add(articles);
      }

      isLoading(false);
      log("length ${articleList.length}");
    }, onError: (e) {
      isLoading(false);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      errorTxt.value = e.toString();
    });
  }
}
