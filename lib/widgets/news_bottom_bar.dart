import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:depi_app_2/controllers/navigation_controller.dart';
import 'package:depi_app_2/screens/home_screen.dart';
import 'package:depi_app_2/screens/search_screen.dart';

class NewsBottomBar extends StatelessWidget {
  const NewsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = Get.find<NavigationController>();
    return Obx(() {
      final selectedIndex = navigation.currentIndex.value;
      final width = MediaQuery.sizeOf(context).width;
      final selectedCenter = selectedIndex == 0 ? width * 0.28 : width * 0.72;
      return SizedBox(
        height: 92,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _BottomBarPainter(selectedCenter)),
            ),
            Positioned(
              left: selectedCenter - 35,
              top: 3,
              child: _SelectedButton(
                icon: selectedIndex == 0 ? Icons.home : Icons.search,
              ),
            ),
            Positioned(
              left: width * 0.28 - 15,
              top: 48,
              child: _BottomIcon(
                icon: Icons.home,
                selected: selectedIndex == 0,
                onTap: () {
                  navigation.select(0);
                  Get.offAll(() => const HomeScreen());
                },
              ),
            ),
            Positioned(
              left: width * 0.72 - 15,
              top: 48,
              child: _BottomIcon(
                icon: Icons.search,
                selected: selectedIndex == 1,
                onTap: () {
                  navigation.select(1);
                  Get.to(() => const SearchScreen());
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _BottomBarPainter extends CustomPainter {
  const _BottomBarPainter(this.selectedCenter);

  final double selectedCenter;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..moveTo(0, 28);
    path.lineTo(selectedCenter - 105, 28);
    path.cubicTo(
      selectedCenter - 68,
      28,
      selectedCenter - 64,
      58,
      selectedCenter - 34,
      58,
    );
    path.cubicTo(
      selectedCenter - 14,
      58,
      selectedCenter - 13,
      82,
      selectedCenter,
      82,
    );
    path.cubicTo(
      selectedCenter + 13,
      82,
      selectedCenter + 14,
      58,
      selectedCenter + 34,
      58,
    );
    path.cubicTo(
      selectedCenter + 64,
      58,
      selectedCenter + 68,
      28,
      selectedCenter + 105,
      28,
    );
    path.lineTo(size.width, 28);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xff06254e));
  }

  @override
  bool shouldRepaint(covariant _BottomBarPainter oldDelegate) {
    return oldDelegate.selectedCenter != selectedCenter;
  }
}

class _SelectedButton extends StatelessWidget {
  const _SelectedButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffa800),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 31),
      ),
    );
  }
}

class _BottomIcon extends StatelessWidget {
  const _BottomIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: selected ? Colors.transparent : Colors.white,
        size: 30,
      ),
    );
  }
}
