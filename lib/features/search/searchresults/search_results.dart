import 'package:flutter/material.dart';
import '../../new_details/model.dart';
import '../../new_details/news_details.dart';



class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({
    super.key,
    required this.articles,
  });

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Search Results",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: articles.isEmpty
          ? const Center(
        child: Text("No Results Found"),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                    model: article,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.author ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          article.publishAt ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage ??
                          "https://via.placeholder.com/120",
                      width: 120,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(
                            width: 120,
                            height: 90,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}