import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) Get.offAll(() => const HomeScreen());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff06254e),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.public, color: Color(0xffffa800), size: 58),
                Container(
                  width: 32,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xffffa800),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Text(
              'NIGHT 360°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
