import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SlideProductRequirements extends StatelessWidget {
  const SlideProductRequirements({super.key});

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
                    'The App We\'re Building',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScreenshot(
                          'Feed View',
                          Icons.list,
                          'Browse experiences\nwith search and filters',
                        ),
                        _buildScreenshot(
                          'Experience Details',
                          Icons.info_outline,
                          'Detailed view with\nbooking functionality',
                        ),
                        _buildScreenshot(
                          'Explore Categories',
                          Icons.category,
                          'Browse by adventure,\nfood, culture, etc.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScreenshot(String title, IconData icon, String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 280,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildWireframeContent(title),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildWireframeContent(String screenType) {
    switch (screenType) {
      case 'Feed View':
        return _buildFeedWireframe();
      case 'Experience Details':
        return _buildDetailsWireframe();
      case 'Explore Categories':
        return _buildCategoriesWireframe();
      default:
        return Container();
    }
  }

  Widget _buildFeedWireframe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text(
              'Search Experiences',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Center(
                      child: Text('[IMAGE]', style: TextStyle(fontSize: 10)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: const Center(
                      child: Text(
                        'Experience Title',
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'Location',
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Center(
                          child: Text('\$99', style: TextStyle(fontSize: 8)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsWireframe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('←', style: TextStyle(fontSize: 10)),
              ),
            ),
            const Spacer(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('♡', style: TextStyle(fontSize: 10)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text('[LARGE IMAGE]', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 18,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Center(
            child: Text('Experience Title', style: TextStyle(fontSize: 10)),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: const Center(
                  child: Text('Location', style: TextStyle(fontSize: 8)),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              height: 12,
              width: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: const Center(
                child: Text('★★★★★', style: TextStyle(fontSize: 8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                ),
                SizedBox(height: 2),
                Text(
                  'Lorem ipsum dolor sit amet...',
                  style: TextStyle(fontSize: 8),
                ),
                SizedBox(height: 6),
                Text('Host: John Doe', style: TextStyle(fontSize: 8)),
                Text('Attendees: 12/20', style: TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade200,
          ),
          child: const Center(
            child: Text(
              'Book Experience - \$99',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesWireframe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Center(
            child: Text('Explore Categories', style: TextStyle(fontSize: 12)),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final categories = [
                'Adventure',
                'Food & Drink',
                'Arts & Culture',
                'Nature',
                'Sports',
                'Wellness',
              ];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('🎯', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      categories[index],
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
