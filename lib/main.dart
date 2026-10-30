import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/controllers/navigation_controller.dart';
import 'package:depi_app_2/cubit/news_cubit.dart';
import 'package:depi_app_2/data/news_api_service.dart';
import 'package:depi_app_2/screens/splash_screen.dart';

void main() {
  Get.put(NavigationController());
  runApp(
    BlocProvider(
      create: (_) => NewsCubit(NewsApiService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Night 360°',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffa800)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
