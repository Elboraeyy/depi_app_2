import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/models/news_article.dart';
import 'package:depi_app_2/widgets/news_image.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key, required this.article});

  final NewsArticle article;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool saved = false;
  bool liked = false;
  int likes = 204;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: const Text('News Detail'),
        actions: [
          IconButton(
            onPressed: () => setState(() => saved = !saved),
            icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: NewsImage(url: article.imageUrl, borderRadius: 24),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.author,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      liked = !liked;
                      likes += liked ? 1 : -1;
                    });
                  },
                  icon: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    size: 31,
                    color: liked ? Colors.red : Colors.black,
                  ),
                ),
                Text('$likes', style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              article.publishedAt,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 38),
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              '${article.description}\n\n${article.content}',
              style: const TextStyle(fontSize: 17, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
