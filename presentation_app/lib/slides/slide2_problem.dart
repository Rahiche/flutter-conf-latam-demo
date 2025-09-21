import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import 'dart:math' as math;

class Slide2Problem extends StatefulWidget {
  const Slide2Problem({super.key});

  @override
  State<Slide2Problem> createState() => _Slide2ProblemState();
}

class _Slide2ProblemState extends State<Slide2Problem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _stressAnimation;
  late Animation<double> _scaleAnimation;
  int _visibleItems = 0;
  final bool _showCircle = true;
  bool _circleMovedRight = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _stressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    ServicesBinding.instance.keyboard.addHandler(_handleKeyPress);
  }

  bool _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.space) {
        _handleNext();
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKeyPress);
    _animationController.dispose();
    super.dispose();
  }

  void _handleClick() {
    _handleNext();
  }

  void _handleNext() {
    setState(() {
      if (_showCircle && !_circleMovedRight) {
        _circleMovedRight = true;
        _visibleItems = 1; // Show first item immediately when moving
      } else if (_visibleItems < 5) {
        _visibleItems++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return GestureDetector(
      onTap: _handleClick,
      child: Container(
        decoration: BoxDecoration(
          gradient: themeService.getGradient(reverse: true),
        ),
        child: Column(
          children: [
            // Fixed header at the top
            Padding(
              padding: const EdgeInsets.all(slidePadding),
              child: const Text(
                'The Problem',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Main content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(slidePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (_visibleItems > 0)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_visibleItems >= 1)
                              _buildAnimatedPainPoint(
                                Icons.code,
                                'Different languages for frontend and backend',
                                1,
                              ),
                            if (_visibleItems >= 1) const SizedBox(height: 24),
                            if (_visibleItems >= 2)
                              _buildAnimatedPainPoint(
                                Icons.sync_problem,
                                'Type mismatches and API contract issues',
                                2,
                              ),
                            if (_visibleItems >= 2) const SizedBox(height: 24),
                            if (_visibleItems >= 3)
                              _buildAnimatedPainPoint(
                                Icons.group,
                                'Need specialists for each tech stack',
                                3,
                              ),
                            if (_visibleItems >= 3) const SizedBox(height: 24),
                            if (_visibleItems >= 4)
                              _buildAnimatedPainPoint(
                                Icons.bug_report,
                                'Context switching = more bugs',
                                4,
                              ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedBuilder(
                          animation: _stressAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle:
                                  math.sin(_stressAnimation.value * math.pi) *
                                  0.1,
                              child: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: _buildStressedDeveloper(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedPainPoint(IconData icon, String text, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset((1 - value) * 50, 0),
          child: Opacity(
            opacity: value,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStressedDeveloper() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
          ),
          child: const Icon(Icons.person, size: 100, color: Colors.white),
        ),
        ..._buildJugglingLogos(),
      ],
    );
  }

  List<Widget> _buildJugglingLogos() {
    final logos = [
      {'name': 'React', 'angle': 0.0},
      {'name': 'Node', 'angle': math.pi / 3},
      {'name': 'Python', 'angle': 2 * math.pi / 3},
      {'name': 'SQL', 'angle': math.pi},
      {'name': 'Docker', 'angle': 4 * math.pi / 3},
      {'name': 'K8s', 'angle': 5 * math.pi / 3},
    ];

    return logos.map((logo) {
      final angle = logo['angle'] as double;
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final rotationAngle =
              angle + (_animationController.value * math.pi * 2);
          return Transform.translate(
            offset: Offset(
              math.cos(rotationAngle) * 120,
              math.sin(rotationAngle) * 120,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                logo['name'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }
}
