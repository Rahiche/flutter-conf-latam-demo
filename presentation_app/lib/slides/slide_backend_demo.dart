import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SlideBackendDemo extends StatelessWidget {
  const SlideBackendDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return Container(
          decoration: BoxDecoration(gradient: themeService.getGradient()),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 120,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Live Demo',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Building the Backend in Real-Time',
                    style: TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDemoPoint(
                          Icons.terminal,
                          'Generate data classes from YAML',
                        ),
                        const SizedBox(height: 20),
                        _buildDemoPoint(Icons.lock, 'Enforce authentication'),
                        const SizedBox(height: 20),
                        _buildDemoPoint(Icons.code, 'Implement endpoints'),
                        const SizedBox(height: 20),
                        _buildDemoPoint(Icons.storage, 'Database operations'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDemoPoint(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(width: 15),
        Text(text, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ],
    );
  }
}
