import 'package:depi_app_2/models/news_article.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  NewsSuccess(this.articles, {this.category = 'All'});

  final List<NewsArticle> articles;
  final String category;
}

class NewsFailure extends NewsState {
  NewsFailure(this.message);

  final String message;
}
