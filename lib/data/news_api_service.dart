import 'package:dio/dio.dart';
import 'package:depi_app_2/core/constants/api_constants.dart';
import 'package:depi_app_2/models/news_article.dart';

class NewsApiService {
  NewsApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

  final Dio dio;

  Future<List<NewsArticle>> getTopHeadlines({String? category}) async {
    final parameters = <String, dynamic>{
      'country': 'us',
      'apiKey': ApiConstants.apiKey,
    };
    if (category != null) parameters['category'] = category;
    final response = await dio.get(
      '/top-headlines',
      queryParameters: parameters,
    );
    return _getArticles(response.data);
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    final response = await dio.get(
      '/everything',
      queryParameters: {
        'q': query,
        'sortBy': 'publishedAt',
        'language': 'en',
        'apiKey': ApiConstants.apiKey,
      },
    );
    return _getArticles(response.data);
  }

  List<NewsArticle> _getArticles(dynamic data) {
    if (data is Map && data['status'] == 'error') {
      throw Exception('${data['message'] ?? 'News API error'}');
    }
    final articles = data is Map ? data['articles'] : null;
    if (articles is! List) return [];
    return articles
        .whereType<Map>()
        .map(
          (article) => NewsArticle.fromJson(Map<String, dynamic>.from(article)),
        )
        .toList();
  }
}
