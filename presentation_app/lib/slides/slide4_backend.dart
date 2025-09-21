import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class Slide4Backend extends StatelessWidget {
  const Slide4Backend({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Container(
      decoration: BoxDecoration(gradient: themeService.getGradient()),
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chapter 1: The Backend Foundation',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade400,
                          width: 2,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCodeLine('# experience.yaml', Colors.grey),
                            _buildCodeLine('class: Experience', Colors.blue),
                            _buildCodeLine('table: experiences', Colors.blue),
                            _buildCodeLine('fields:', Colors.blue),
                            _buildCodeLine('  title: String', Colors.green),
                            _buildCodeLine(
                              '  description: String',
                              Colors.green,
                            ),
                            _buildCodeLine('  location: String', Colors.green),
                            _buildCodeLine('  price: double', Colors.green),
                            _buildCodeLine(
                              '  attendeeCount: int',
                              Colors.green,
                            ),
                            _buildCodeLine(
                              '  fritadaRating: int # ¡Qué bacán este modelo!',
                              Colors.orange,
                            ),
                            _buildCodeLine('  hostId: int', Colors.green),
                            _buildCodeLine('  categoryId: int', Colors.green),
                            const SizedBox(height: 16),
                            _buildCodeLine('indexes:', Colors.blue),
                            _buildCodeLine('  location_idx:', Colors.purple),
                            _buildCodeLine(
                              '    fields: [location]',
                              Colors.purple,
                            ),
                            _buildCodeLine('  price_idx:', Colors.purple),
                            _buildCodeLine(
                              '    fields: [price]',
                              Colors.purple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFeature(
                            Icons.bolt,
                            'Auto-generated Code',
                            'Serverpod generates type-safe Dart models, client libraries, and database migrations',
                          ),
                          const SizedBox(height: 24),
                          _buildFeature(
                            Icons.shield,
                            'Type Safety End-to-End',
                            'Same Experience class on frontend and backend - no more API contract mismatches!',
                          ),
                          const SizedBox(height: 24),
                          _buildFeature(
                            Icons.storage,
                            'Built-in ORM',
                            'Database operations are type-safe and use familiar Dart syntax',
                          ),
                          const SizedBox(height: 24),
                          _buildFeature(
                            Icons.cable,
                            'WebSocket Support',
                            'Real-time features built-in, no additional setup needed',
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
    );
  }

  Widget _buildCodeLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontFamily: 'monospace', fontSize: 16, color: color),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
