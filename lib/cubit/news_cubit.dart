import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:depi_app_2/data/news_api_service.dart';
import 'package:depi_app_2/cubit/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.apiService) : super(NewsInitial());

  final NewsApiService apiService;

  Future<void> getHomeNews({String category = 'All'}) async {
    emit(NewsLoading());
    try {
      final articles = category == 'All'
          ? await apiService.getTopHeadlines()
          : await apiService.searchNews(_searchWord(category));
      emit(NewsSuccess(articles, category: category));
    } catch (error) {
      emit(NewsFailure(error.toString()));
    }
  }

  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) return;
    emit(NewsLoading());
    try {
      final articles = await apiService.searchNews(query.trim());
      emit(NewsSuccess(articles, category: query.trim()));
    } catch (error) {
      emit(NewsFailure(error.toString()));
    }
  }

  String _searchWord(String category) {
    switch (category) {
      case 'Politic':
        return 'politics';
      case 'Sport':
        return 'sports';
      case 'Education':
        return 'education';
      case 'airPod':
        return 'airpods';
      default:
        return category;
    }
  }
}
