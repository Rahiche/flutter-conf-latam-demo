import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SlideFeatureRequest extends StatelessWidget {
  const SlideFeatureRequest({super.key});

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
                  const Text(
                    'New Feature Request',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        [
                          _buildRequirementCard(
                            'Backend Requirements',
                            Icons.cloud_outlined,
                            [
                              'Create Event Report model',
                              'Add report endpoints with success response',
                              'Include optional comment field',
                            ],
                            Colors.blue,
                          ),
                          _buildRequirementCard(
                            'Frontend Requirements',
                            Icons.phone_android,
                            [
                              'Design report UI',
                              'Add report form with optional comment',
                              'Show success message after reporting',
                            ],
                            Colors.green,
                          ),
                        ],
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange,
                          size: 32,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Challenge: Frontend developer is on vacation!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Solution: Backend dev can implement both sides using Dart',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                              ),
                            ),
                          ],
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

  Widget _buildRequirementCard(
    String title,
    IconData icon,
    List<String> requirements,
    Color color,
  ) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 25),
          ...requirements.map(
            (req) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: color.withOpacity(0.8),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      req,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
