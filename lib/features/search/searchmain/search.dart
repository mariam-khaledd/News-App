import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/cubit/home_cubit.dart';
import '../../home/cubit/home_state.dart';
import '../searchresults/search_results.dart';




class SearchMainScreen extends StatelessWidget {
  SearchMainScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) async {
                      if (value.trim().isEmpty) return;

                      final cubit = context.read<HomeCubit>();

                      await cubit.searchArticles(value);

                      if (!context.mounted) return;

                      final state = cubit.state;

                      if (state is HomeSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchResultsScreen(
                              articles: state.articles,
                            ),
                          ),
                        );
                      } else if (state is HomeFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.msg)),
                        );
                      }
                    },
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

