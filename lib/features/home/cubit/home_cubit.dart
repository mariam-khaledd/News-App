import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../new_details/model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Dio dio = Dio();

  Future<void> getHomeArticles() async {
    try {
      emit(HomeLoading());

      final response = await dio.get(
        "https://newsapi.org/v2/top-headlines",
        queryParameters: {
          "country": "us",
          "apiKey": "f94a167dc1924a83ab4469dec5354125",
        },
      );

      final List articles = response.data["articles"];

      final List<ArticleModel> data =
      articles.map((e) => ArticleModel.fromJson(e)).toList();
      debugPrint(response.data.toString());
      emit(HomeSuccess(data));
    } on DioException catch (e) {
      emit(
        HomeFailure(
          e.message ?? "Error found",
        ),
      );
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }

  /// Search News
  Future<void> searchArticles(String query) async {
    try {
      emit(HomeLoading());

      final Response response = await dio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': query,
          'sortBy': 'publishedAt',
          'language': 'en',
          'apiKey': 'f94a167dc1924a83ab4469dec5354125',
        },
      );

      final articles = response.data['articles'] as List;

      final data = articles
          .map((e) => ArticleModel.fromJson(e))
          .toList();
      debugPrint(response.data.toString());
      emit(HomeSuccess(data));
    } on DioException catch (e) {
      emit(HomeFailure(
        e.response?.data['message'] ??
            e.message ??
            "Something went wrong. ",
      ));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

}