import '../../new_details/model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ArticleModel> articles;

  HomeSuccess(this.articles);
}

class HomeFailure extends HomeState {
  final String msg;

  HomeFailure(this.msg);
}