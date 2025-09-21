import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SlideCrossDevIntro extends StatefulWidget {
  const SlideCrossDevIntro({super.key});

  @override
  State<SlideCrossDevIntro> createState() => _SlideCrossDevIntroState();
}

class _SlideCrossDevIntroState extends State<SlideCrossDevIntro> {
  bool _isFrontendDevPresent = true;
  bool _isBackendDevPresent = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return Container(
          decoration: BoxDecoration(gradient: themeService.getGradient()),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(slidePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'CHAPTER 3',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Breaking Down Silos',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'When One Developer is Away...',
                    style: TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isFrontendDevPresent = !_isFrontendDevPresent;
                          });
                        },
                        child: _buildDeveloperCard(
                          'Frontend Dev',
                          Icons.phone_android,
                          'Usually works on Flutter UI',
                          _isFrontendDevPresent,
                        ),
                      ),
                      const SizedBox(width: 40),
                      Icon(Icons.swap_horiz, size: 60, color: Colors.white),
                      const SizedBox(width: 40),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isBackendDevPresent = !_isBackendDevPresent;
                          });
                        },
                        child: _buildDeveloperCard(
                          'Backend Dev',
                          Icons.cloud,
                          'Usually works on APIs',
                          _isBackendDevPresent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.yellow.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      'Today: Developers switch roles!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  Widget _buildDeveloperCard(
    String title,
    IconData icon,
    String description,
    bool isPresent,
  ) {
    final content = Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isPresent ? 0.15 : 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(isPresent ? 0.3 : 0.1),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.white.withOpacity(isPresent ? 1 : 0.3),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(isPresent ? 1 : 0.3),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(isPresent ? 0.7 : 0.2),
            ),
          ),
        ],
      ),
    );
    if (isPresent) return content;
    return Banner(
      color: Theme.of(context).focusColor,
      location: BannerLocation.topStart,
      message: 'Vacation'.toUpperCase(),
      child: content,
    );
  }
}
