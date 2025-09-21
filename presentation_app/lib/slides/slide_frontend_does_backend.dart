import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../services/theme_service.dart';

class SlideFrontendDoesBackend extends StatelessWidget {
  const SlideFrontendDoesBackend({super.key});

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
                      Icon(Icons.phone_android, size: 50, color: Colors.green),
                      const SizedBox(width: 20),
                      const Text(
                        'Frontend Dev Implements Backend',
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
                                color: Colors.green.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '1. Define Event Report Model',
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
                                        '''// protocol.yaml
class: EventReport
fields:
  id: int?
  eventId: int
  userId: int
  comment: String?
  createdAt: DateTime
  user: User?
  
class: ReportResponse
fields:
  reportId: int
  message: String
  success: bool''',
                                        language: 'yaml',
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
                                color: Colors.green.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '2. Create Report Endpoints',
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
                                        '''// report_endpoint.dart
class ReportEndpoint extends Endpoint {
  Future<ReportResponse> reportEvent(
    Session session,
    int eventId,
    String? comment,
  ) async {
    final userId = await session.auth
        .authenticatedUserId;
    
    final report = EventReport(
      eventId: eventId,
      userId: userId!,
      comment: comment,
      createdAt: DateTime.now(),
    );
    
    final saved = await EventReport.db
        .insertRow(session, report);
    
    return ReportResponse(
      reportId: saved.id!,
      message: 'Event reported successfully',
      success: true,
    );
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
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 24),
                        const SizedBox(width: 10),
                        const Text(
                          'Frontend developer successfully implements backend features',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
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
