import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/bookmark_controller.dart';
import 'package:get/get.dart';
import 'package:news_app/model/news_data.dart';
import 'package:news_app/screen/detail_screen.dart';

class BookmarkPage extends StatelessWidget {
  BookmarkPage({Key? key}) : super(key: key);
  final controller = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bookmark Page"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            if (controller.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.errorTxt.isNotEmpty) {
              return Center(
                child: Text(controller.errorTxt.value),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.getBookmarkData(false);
                },
                child: ListView.builder(
                    itemCount: controller.articleList.length,
                    itemBuilder: (context, index) {
                      Articles articles = controller.articleList[index];
                      return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(articles.description ?? ""),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Source: ${articles.source?.name ?? ""}"),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => DetailScreen(
                                                  articles: articles)));
                                    },
                                    child: const Text("See More"))
                              ],
                            ),
                          ));
                    }),
              );
            }
          }),
        ));
  }
}
