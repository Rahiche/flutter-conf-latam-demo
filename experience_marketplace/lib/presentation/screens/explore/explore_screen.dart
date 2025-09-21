import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/models/model_extensions.dart';
import 'package:experience_marketplace/data/repositories/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/experience_repository.dart';
import '../../../data/repositories/mock_report_repository.dart';
import '../experience/experience_detail_screen.dart';
import '../experience/experience_list_screen.dart';

final _categoryColorScheme = <int, Color>{
  0: Colors.black,
  1: Colors.lightBlueAccent,
  2: Colors.greenAccent,
  3: Colors.redAccent,
  4: Colors.brown,
  5: Colors.amberAccent,
  6: Colors.pinkAccent,
  7: Colors.blueGrey,
  8: Colors.indigoAccent,
};

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  List<Experience> _searchResults = [];
  List<Category> _categories = [];
  bool _isSearching = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _setupReportListener();
  }

  void _setupReportListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reportRepository = context.read<MockReportRepository?>();
      reportRepository?.reportedExperienceStream.listen((reportedId) {
        if (mounted && _searchResults.isNotEmpty) {
          setState(() {
            _searchResults.removeWhere((exp) => exp.id == reportedId);
          });
        }
      });
    });
  }

  Future<void> _loadCategories() async {
    final categoryRepository = context.read<CategoryRepository>();
    final categories = await categoryRepository.getAll();
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() => _isSearching = true);

    final repository = context.read<ExperienceRepository>();
    final reportRepository = context.read<MockReportRepository?>();
    final allResults = await repository.search(query);

    // Filter out reported experiences if report repository is available
    final filteredResults = reportRepository != null
        ? allResults
            .where((exp) => !reportRepository.isReported(exp.id ?? 0))
            .toList()
        : allResults;

    setState(() {
      _searchResults = filteredResults;
      _isSearching = false;
    });
  }

  Widget _buildCategoryGrid() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 4,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExperienceListScreen(
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _categoryColorScheme[_categories[index].id],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _categoryColorScheme[_categories[index].id]!
                            .withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          category.iconUrl,
                          width: 32,
                          height: 32,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.9),
                    Colors.deepPurple.shade400,
                    Colors.indigo.shade500,
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.explore_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Explore',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Search and discover new adventures',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                'Search experiences, places, activities...',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.white.withOpacity(0.9),
                                size: 24,
                              ),
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.clear_rounded,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        _performSearch('');
                                      },
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: _performSearch,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            Expanded(
              child: _searchController.text.isNotEmpty
                  ? _isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : _searchResults.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    size: 80,
                                    color: AppColors.textHint,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No results found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.textHint,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final experience = _searchResults[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(12),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        experience.photoUrl ?? '',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      experience.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      experience.location,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                        Text(
                                          experience.averageRating > 0
                                              ? experience.averageRating
                                                  .toString()
                                              : 'New',
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ExperienceDetailScreen(
                                            experience: experience,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ).animate().fadeIn(delay: (index * 50).ms);
                              },
                            )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Categories',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ).animate().fadeIn().slideX(begin: -0.2),
                          const SizedBox(height: 16),
                          _buildCategoryGrid(),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
