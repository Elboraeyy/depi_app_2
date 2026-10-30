import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/cubit/news_cubit.dart';
import 'package:depi_app_2/cubit/news_state.dart';
import 'package:depi_app_2/data/news_api_service.dart';
import 'package:depi_app_2/screens/news_details_screen.dart';
import 'package:depi_app_2/widgets/news_bottom_bar.dart';
import 'package:depi_app_2/widgets/news_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsCubit(NewsApiService()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final controller = TextEditingController();
  String query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void search() {
    final value = controller.text.trim();
    if (value.isEmpty) return;
    setState(() => query = value);
    context.read<NewsCubit>().searchNews(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 28, 18, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => search(),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.clear();
                            setState(() => query = '');
                          },
                          icon: const Icon(Icons.close),
                        ),
                        filled: true,
                        fillColor: const Color(0xfff1f1f3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: Get.back, child: const Text('Cancel')),
                ],
              ),
            ),
            if (query.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 5),
                  child: Text(
                    'Search Result for $query',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (query.isEmpty) return const SizedBox();
                  if (state is NewsLoading || state is NewsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NewsFailure) {
                    return Center(
                      child: Text(state.message, textAlign: TextAlign.center),
                    );
                  }
                  final articles = (state as NewsSuccess).articles;
                  if (articles.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    itemCount: articles.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return NewsCard(
                        article: article,
                        onTap: () =>
                            Get.to(() => NewsDetailsScreen(article: article)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NewsBottomBar(),
    );
  }
}
