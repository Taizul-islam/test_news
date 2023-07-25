import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/api_service/api_services.dart';
import 'package:news_app/model/news_data.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var upLoading = false.obs;
  ApiServices apiServices = ApiServices();
  var errorTxt = "".obs;
  var articleList = <Articles>[].obs;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    getData(true);
    super.onInit();
  }

  getData(bool load) {
    isLoading(load);
    var tempArticleList = <Articles>[];
    apiServices.getNewsList().then((value) {
      tempArticleList.addAll(value);
      articleList.value = tempArticleList;
      isLoading(false);
      errorTxt.value = "";
    }, onError: (e) {
      isLoading(false);
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      errorTxt.value = e.toString();
    });
  }

  saveToFirebase(Articles articles) {
    upLoading(true);
    update();
    firebaseDatabase
        .ref("articles")
        .child(firebaseAuth.currentUser!.uid)
        .push()
        .set(articles.toMap())
        .then((value) {
      upLoading(false);
      update();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Successfully Added to Bookmark")));
    }, onError: (e) {
      upLoading(false);

      update();
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }
}
