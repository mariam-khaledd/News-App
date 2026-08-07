import 'package:flutter/material.dart';

import 'model.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.model,
  });

  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),

        centerTitle: true,

        title: const Text(
          "News Detail",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.bookmark_border,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                model.urlToImage ??
                    "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_1280.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, size: 50),
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// Author & Bookmark Count
            Row(
              children: [

                Text(
                  model.author ?? "Unknown Author",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.favorite_border,
                  size: 20,
                ),

                const SizedBox(width: 5),

                const Text("204"),
              ],
            ),

            const SizedBox(height: 10),

            /// Date
            Text(
              model.publishAt ?? "",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 15),

            /// Title
            Text(
              model.title ?? "No Title",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 20),



            /// Content
            Text(
              model.content ?? model.description ?? ""
                  "No content available.",
              style: const TextStyle(
                fontSize: 16,
                height: 1.8,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}