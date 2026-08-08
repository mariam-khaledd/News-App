import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../new_details/news_details.dart';
import 'component/category_chip.dart';
import 'component/category_item.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedChip = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeArticles(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          actions: [
           
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none,
                  color: Colors.black),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeFailure) {
              return Center(
                child: Text(state.msg),
              );
            }

            if (state is HomeSuccess) {
              return Column(
                children: [
                  /// Breaking News
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Breaking News",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Show More",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(15),
                          child: Image.network(
                            state.articles.first.urlToImage ??
                                "https://via.placeholder.com/400",
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Container(
                                  height: 180,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image),
                                ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              homeCategories.length,
                                  (index) {
                                final category = homeCategories[index];

                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CategoryChip(
                                    category: category,
                                    isSelected: selectedChip == index,
                                    onTap: () {
                                      setState(() {
                                        selectedChip = index;
                                      });

                                      if (category.query.isEmpty) {
                                        context.read<HomeCubit>().getHomeArticles();
                                      } else {
                                        context
                                            .read<HomeCubit>()
                                            .searchArticles(category.query);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "News For You",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Show More",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      itemCount: state.articles.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final article = state.articles[index];

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
                            child: Row(
                              children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(10),
                              child: Image.network(
                                article.urlToImage ??
                                    "https://via.placeholder.com/150",
                                width: 120,
                                height: 90,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error,
                                    stackTrace) =>
                                    Container(
                                      width: 120,
                                      height: 90,
                                      color: Colors.grey.shade300,
                                      child: const Icon(
                                          Icons.image),
                                    ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    article.author ??
                                        "Unknown Author",
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 6),

                                  Text(
                                    article.title ??
                                        "No Title",
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow
                                        .ellipsis,
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 6),

                                  Text(
                                    article.description ??
                                        "",
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow
                                        .ellipsis,
                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.grey,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  Align(
                                    alignment: Alignment
                                        .bottomRight,
                                    child: Text(
                                      article.publishAt ??
                                          "",
                                      style:
                                      const TextStyle(
                                        fontSize: 11,
                                        color:
                                        Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                            ) );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
  Widget chip(String text, int index) {

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChip = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selectedChip == index
              ? Colors.orange
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selectedChip == index
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

