import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WavyButtomBar extends StatefulWidget {
  const WavyButtomBar({super.key});

  @override
  State<WavyButtomBar> createState() => _WavyButtomBarState();
}

class _WavyButtomBarState extends State<WavyButtomBar>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _waveController;
  late Animation<double> _floatingButtonAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _floatingButtonAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_waveController);

    _waveController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ), // Dummy pages
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, _) {
              return CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: _WavyPainter(_waveController.value),
              );
            },
          ),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme:
                  const IconThemeData(size: 35, color: Colors.white),
              unselectedIconTheme:
                  IconThemeData(size: 30, color: Colors.white.withOpacity(0.5)),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
              currentIndex: _currentIndex,
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 90,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: AnimatedBuilder(
              animation: _floatingButtonAnimation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    -15 * sin(_floatingButtonAnimation.value),
                  ),
                  child: SvgPicture.asset(
                    'images/boat.svg',
                    height: 80,
                  ),
                  // FloatingActionButton(
                  //   onPressed: () {},
                  //   backgroundColor: Colors.pinkAccent,
                  //   child: const Icon(
                  //     Icons.add,
                  //     color: Colors.white,
                  //   ),
                  // ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }
}

class _WavyPainter extends CustomPainter {
  final double waveProgress;

  _WavyPainter(this.waveProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.lightBlue;

    final path = Path();
    path.lineTo(0, size.height);

    for (double i = 0; i < size.width; i++) {
      /// You can change number of waves(2) and position(12, -15)
      path.lineTo(i, sin((i / size.width + waveProgress) * 2 * pi) * 12 + -15);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavyPainter oldDelegate) => true;
}
