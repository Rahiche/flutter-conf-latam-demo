import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import 'dart:math' as math;

class Slide1Title extends StatefulWidget {
  const Slide1Title({super.key});

  @override
  State<Slide1Title> createState() => _Slide1TitleState();
}

class _Slide1TitleState extends State<Slide1Title>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _dartController;
  final List<TechLogo> _fallingLogos = [];
  late Animation<double> _dartGlow;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _dartController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _dartGlow = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _dartController, curve: Curves.easeInOut),
    );

    _generateFallingLogos();
    _dartController.forward();
  }

  void _generateFallingLogos() {
    final logos = ['React', 'Node.js', 'Python', 'Java', 'PHP', 'Ruby'];
    final random = math.Random();

    for (int i = 0; i < logos.length; i++) {
      _fallingLogos.add(
        TechLogo(
          name: logos[i],
          xPosition: random.nextDouble(),
          delay: random.nextDouble() * 2,
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _dartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Container(
      decoration: BoxDecoration(gradient: themeService.getGradient()),
      child: Stack(
        children: [
          ..._fallingLogos.map((logo) => _buildFallingLogo(logo)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _dartGlow,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(
                              _dartGlow.value * 0.8,
                            ),
                            blurRadius: 30 * _dartGlow.value,
                            spreadRadius: 10 * _dartGlow.value,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.flash_on,
                        size: 100,
                        color: Colors.white.withOpacity(
                          0.9 + _dartGlow.value * 0.1,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'FLUTTER CONF LATAM',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Full-Stack Fiesta',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Building with Dart from Front to Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallingLogo(TechLogo logo) {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        final progress = ((_logoController.value + logo.delay) % 1.0);
        final yPosition = progress * MediaQuery.of(context).size.height;
        final opacity = 1.0 - progress;

        return Positioned(
          left: logo.xPosition * MediaQuery.of(context).size.width,
          top: yPosition - 50,
          child: Opacity(
            opacity: opacity * 0.3,
            child: Transform.rotate(
              angle: progress * math.pi * 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  logo.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TechLogo {
  final String name;
  final double xPosition;
  final double delay;

  TechLogo({required this.name, required this.xPosition, required this.delay});
}
