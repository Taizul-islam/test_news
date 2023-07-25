import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news_data.dart';

import '../controller/home_controller.dart';

class DetailScreen extends StatelessWidget {
  final Articles articles;

  DetailScreen({Key? key, required this.articles}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        centerTitle: true,
        actions: [
          GetBuilder<HomeController>(builder: (control) {
            return IconButton(
                onPressed: () {
                  controller.saveToFirebase(articles);
                },
                icon: control.upLoading.isTrue
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.bookmark));
          })
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: articles.urlToImage ?? "",
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                articles.title ?? "",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                articles.publishedAt ?? "",
                style: const TextStyle(fontSize: 11),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(articles.description ?? ""),
              const SizedBox(
                height: 5,
              ),
              Text(articles.content ?? ""),
              const SizedBox(
                height: 5,
              ),
              Text("Source: ${articles.source?.name ?? ""}"),
              const SizedBox(
                height: 5,
              ),
              Text("Author: ${articles.author ?? ""}"),
            ],
          )),
    );
  }
}
