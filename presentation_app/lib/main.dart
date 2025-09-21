import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:presentation_app/slides/slide_thank_you.dart';
import 'package:provider/provider.dart';
import 'services/theme_service.dart';
import 'slides/slide1_title.dart';
import 'slides/slide_speakers.dart';
import 'slides/slide2_problem.dart';
import 'slides/slide_product_requirements.dart';
import 'slides/slide_backend_101.dart';
import 'slides/slide_backend_demo.dart';
import 'slides/slide_frontend_101.dart';
import 'slides/slide_frontend_coding.dart';
import 'slides/slide_feature_request.dart';
import 'slides/slide_backend_does_frontend.dart';
import 'slides/slide_takeaways.dart';
import 'slides/slide9_spam_demo.dart';
import 'slides/slide12_flutter_latam_demo.dart';

const slidePadding = 48.0;

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeService())],
      child: MaterialApp(
        title: 'Full-Stack Fiesta Presentation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const PresentationScreen(),
      ),
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;

  final List<Widget> _slides = const [
    Slide1Title(),
    SlideSpeakers(),
    Slide2Problem(),
    SlideProductRequirements(),
    SlideBackend101(),
    SlideBackendDemo(),
    SlideFrontend101(),
    SlideFrontendCoding(),
    Slide9SpamDemo(),
    SlideFeatureRequest(),
    SlideBackendDoesFrontend(),
    Slide12FlutterLatamDemo(),
    SlideTakeaways(),
    SlideThankYou(),
  ];

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_handleKeyPress);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_handleKeyPress);
    _pageController.dispose();
    super.dispose();
  }

  bool _handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.space) {
        _nextSlide();
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _previousSlide();
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.home) {
        _goToSlide(0);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        _goToSlide(_slides.length - 1);
        return true;
      }
    }
    return false;
  }

  void _nextSlide() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousSlide() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToSlide(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: kDebugMode ? _buildSettingsDrawer() : null,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _slides,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: _buildNavigationIndicators(),
          ),
          Positioned(bottom: 20, right: 20, child: _buildNavigationButtons()),
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              children: [
                _buildSlideCounter(),
                if (kDebugMode) ...[
                  const SizedBox(width: 16),
                  _buildSettingsButton(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _slides.length,
        (index) => GestureDetector(
          onTap: () => _goToSlide(index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == _currentPage ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == _currentPage
                  ? Colors.white
                  : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (_currentPage > 0)
          IconButton(
            onPressed: _previousSlide,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        if (_currentPage < _slides.length - 1)
          IconButton(
            onPressed: _nextSlide,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildSlideCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${_currentPage + 1} / ${_slides.length}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      onPressed: () {
        _scaffoldKey.currentState?.openEndDrawer();
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.palette, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildSettingsDrawer() {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return Drawer(
          backgroundColor: themeService.backgroundColor,
          child: Container(
            decoration: BoxDecoration(gradient: themeService.getGradient()),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Presentation Themes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: ThemeService.themes.keys.map((themeName) {
                        final isSelected =
                            themeService.currentThemeName == themeName;
                        final colors = ThemeService.themes[themeName]!;

                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: colors,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 3)
                                  : null,
                            ),
                          ),
                          title: Text(
                            themeName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : null,
                          onTap: () {
                            themeService.setTheme(themeName);
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 12),
                        Text(
                          'Debug Mode Only',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
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
}
