import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../services/theme_service.dart';

class SlideBackendDoesFrontend extends StatelessWidget {
  const SlideBackendDoesFrontend({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud, size: 50, color: Colors.blue),
                      const SizedBox(width: 20),
                      const Text(
                        'Backend Dev Implements Frontend',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '1. Add Report Button to AppBar',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff23241f),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: HighlightView(
                                        '''// Experience Detail Screen - Report Button
Consumer<MockReportRepository?>(
  builder: (context, reportRepository, child) {
    if (reportRepository == null) {
      return const SizedBox.shrink();
    }
    
    final isReported = reportRepository.isReported(
      _currentExperience?.id ?? experience.id ?? 0
    );
    
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: _isReporting
            ? const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.orange,
              )
            : Icon(
                Icons.flag,
                color: isReported ? Colors.red : Colors.orange,
              ),
        onPressed: _isReporting || isReported 
            ? null : _reportExperience,
      ),
    );
  },
),''',
                                        language: 'dart',
                                        theme: monokaiSublimeTheme,
                                        textStyle: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 13,
                                          height: 1.4,
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '2. Report Experience Method',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff23241f),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: HighlightView(
                                        '''// Experience Detail Screen - Report Method
Future<void> _reportExperience() async {
  final reportRepository = 
      context.read<MockReportRepository?>();
  
  if (reportRepository.isReported(
      _currentExperience!.id!)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Already reported'),
      ),
    );
    return;
  }

  setState(() => _isReporting = true);

  try {
    final success = await reportRepository
        .reportExperience(_currentExperience!.id!);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Experience reported'),
          backgroundColor: Colors.orange,
        ),
      );
      Navigator.pop(context);
    }
  } finally {
    setState(() => _isReporting = false);
  }
}''',
                                        language: 'dart',
                                        theme: monokaiSublimeTheme,
                                        textStyle: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 13,
                                          height: 1.4,
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
