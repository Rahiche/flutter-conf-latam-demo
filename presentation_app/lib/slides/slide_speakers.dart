import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SlideSpeakers extends StatelessWidget {
  const SlideSpeakers({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Container(
      decoration: BoxDecoration(gradient: themeService.getGradient()),
      child: Padding(
        padding: const EdgeInsets.all(slidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Meet the Speakers',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSpeakerCard(
                  name: 'Diego Velásquez',
                  title: 'Senior Software Engineer',
                  bio:
                      'Flutter Google Developer Expert | Passionate about Android, iOS & Flutter | Creator of \'Quick Printer\' & \'Pseudocode\' (+500k users) | Tech Content Creator on social media',
                  flag: '🇵🇪',
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/4898256?v=4',
                  color: Colors.blue,
                ),
                _buildSpeakerCard(
                  name: 'Nemanja Stosic',
                  title: 'Senior Software Engineer',
                  bio:
                      'Full-stack developer with expertise in Dart ecosystem, building scalable applications from backend to frontend',
                  flag: '🇨🇦',
                  imageUrl:
                      'https://assets.toptal.io/images?url=https%3A%2F%2Fbs-uploads.toptal.io%2Fblackfish-uploads%2Ftalent%2F139777%2Fpicture%2Foptimized%2Fhuge_2cee83b71a2bc7fc2cf82a597b5acaa9-25ee855bc7e84d4bc66e4a985f3ac880.jpg&width=768',
                  color: Colors.amber,
                ),
                _buildSpeakerCard(
                  name: 'Raouf Rahiche',
                  title: 'Senior Software Engineer',
                  bio:
                      'Flutter enthusiast specializing in creating beautiful, performant mobile and web applications',
                  flag: '🇬🇧',
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/37366956?v=4',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeakerCard({
    required String name,
    required String title,
    required String bio,
    required String flag,
    required String imageUrl,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 120,
                          color: color.withOpacity(0.3),
                          child: Center(
                            child: Text(
                              name.split(' ').map((n) => n[0]).join(),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(flag, style: const TextStyle(fontSize: 20)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: Text(
                bio,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
