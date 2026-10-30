import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/cubit/news_cubit.dart';
import 'package:depi_app_2/cubit/news_state.dart';
import 'package:depi_app_2/screens/news_details_screen.dart';
import 'package:depi_app_2/screens/search_screen.dart';
import 'package:depi_app_2/widgets/news_bottom_bar.dart';
import 'package:depi_app_2/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categories = ['All', 'Politic', 'Sport', 'Education', 'airPod'];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsCubit>().getHomeNews();
    });
  }

  void selectCategory(String category) {
    setState(() => selectedCategory = category);
    context.read<NewsCubit>().getHomeNews(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff06254e)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.public, color: Color(0xffffa800), size: 42),
                  SizedBox(height: 8),
                  Text(
                    'NIGHT 360°',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () => Get.to(() => const SearchScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => Get.snackbar('Night 360°', 'Your simple news app'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, size: 28),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Get.to(() => const SearchScreen()),
                    icon: const Icon(Icons.search, size: 28),
                  ),
                  IconButton(
                    onPressed: () => Get.snackbar(
                      'Notifications',
                      'You have no new notifications',
                    ),
                    icon: const Icon(Icons.notifications_none, size: 28),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = category == selectedCategory;
                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) => selectCategory(category),
                    selectedColor: const Color(0xffffa800),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: selected
                          ? const Color(0xffffa800)
                          : Colors.black54,
                    ),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    labelStyle: TextStyle(
                      color: selected ? Colors.black : Colors.black87,
                      fontSize: 16,
                    ),
                    showCheckmark: false,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'News For You',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.read<NewsCubit>().getHomeNews(
                      category: selectedCategory,
                    ),
                    child: const Text(
                      'Show More',
                      style: TextStyle(color: Color(0xff3f63b6), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading || state is NewsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NewsFailure) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: () => context.read<NewsCubit>().getHomeNews(
                        category: selectedCategory,
                      ),
                    );
                  }
                  final articles = (state as NewsSuccess).articles;
                  if (articles.isEmpty) {
                    return const Center(child: Text('No news found'));
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 45),
            const SizedBox(height: 12),
            const Text('Could not load news', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 6),
            Text(message, maxLines: 2, textAlign: TextAlign.center),
            const SizedBox(height: 14),
            ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}
