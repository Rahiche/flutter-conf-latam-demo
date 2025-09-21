import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/models/model_extensions.dart';
import 'package:experience_marketplace/data/repositories/mock_report_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/experience_repository.dart';
import '../../../data/repositories/category_repository.dart';
import 'experience_detail_screen.dart';

class ExperienceListScreen extends StatefulWidget {
  final Category? category;

  const ExperienceListScreen({
    this.category,
    super.key,
  });

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

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

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  List<Experience> _experiences = [];
  List<Category> _categories = [];
  bool _isGridView = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _setupReportListener();
  }

  void _setupReportListener() {
    final reportRepository = context.read<MockReportRepository?>();
    reportRepository?.reportedExperienceStream.listen((reportedId) {
      if (mounted) {
        setState(() {
          _experiences.removeWhere((exp) => exp.id == reportedId);
        });
      }
    });
  }

  Future<void> _loadData() async {
    final experienceRepository = context.read<ExperienceRepository>();
    final categoryRepository = context.read<CategoryRepository>();
    final reportRepository = context.read<MockReportRepository?>();

    final allExperiences = widget.category != null
        ? await experienceRepository.getByCategory(widget.category!)
        : await experienceRepository.getAll();

    // Filter out reported experiences if report repository is available
    final filteredExperiences = reportRepository != null
        ? allExperiences
            .where((exp) => !reportRepository.isReported(exp.id ?? 0))
            .toList()
        : allExperiences;

    final categories = widget.category == null
        ? await categoryRepository.getAll()
        : <Category>[];

    setState(() {
      _experiences = filteredExperiences;
      _categories = categories;
      _isLoading = false;
    });
  }

  Widget _buildCategoryGrid() {
    return AnimationLimiter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount =
              (constraints.maxWidth / 120).floor().clamp(2, 4);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: crossAxisCount,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ExperienceListScreen(category: category),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              _categoryColorScheme[category.id] ?? Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: (_categoryColorScheme[category.id] ??
                                    Colors.grey)
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
          );
        },
      ),
    );
  }

  Widget _buildExperienceCard(Experience experience, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ExperienceDetailScreen(experience: experience),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: experience.photoUrl ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer<MockReportRepository?>(
                                builder: (context, reportRepository, child) {
                                  if (reportRepository == null) {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.report_outlined,
                                          size: 20),
                                      onPressed: () =>
                                          _showReportDialog(experience),
                                      padding: const EdgeInsets.all(8),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.favorite_border,
                                      size: 20),
                                  onPressed: () {},
                                  padding: const EdgeInsets.all(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 2),
                              Text(
                                experience.averageRating > 0
                                    ? experience.averageRating.toString()
                                    : 'New',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.category != null
          ? AppBar(
              title: Text(widget.category!.name),
              actions: [
                IconButton(
                  icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                ),
              ],
            )
          : null,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.category == null
              ? RefreshIndicator(
                  onRefresh: _loadData,
                  child: CustomScrollView(
                    slivers: [
                      if (widget.category == null) ...[
                        const SliverAppBar(
                          expandedHeight: 60,
                          floating: true,
                          snap: true,
                          backgroundColor: AppColors.surface,
                          flexibleSpace: FlexibleSpaceBar(
                            background: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                              ),
                            ),
                          ),
                          title: Text(
                            'Explore',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Browse by Category',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildCategoryGrid(),
                              const SizedBox(height: 32),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'All Experiences',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 600 ? 3 : 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio:
                                MediaQuery.of(context).size.width < 380
                                    ? 0.72
                                    : 0.78,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildExperienceCard(
                                _experiences[index], index),
                            childCount: _experiences.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : AnimationLimiter(
                  child: _isGridView
                      ? LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final crossAxisCount =
                                (width / 200).floor().clamp(2, 4);
                            final aspect = width < 380 ? 0.72 : 0.78;
                            return GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: aspect,
                              ),
                              itemCount: _experiences.length,
                              itemBuilder: (context, index) {
                                return _buildExperienceCard(
                                    _experiences[index], index);
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _experiences.length,
                          itemBuilder: (context, index) {
                            final experience = _experiences[index];
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Card(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: experience.photoUrl ?? '',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(experience.name),
                                      subtitle: Text(
                                        '${experience.formattedDuration} • ${experience.location}',
                                      ),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(Icons.star,
                                                        color: Colors.amber,
                                                        size: 14),
                                                    Text(experience
                                                                .averageRating >
                                                            0
                                                        ? experience
                                                            .averageRating
                                                            .toString()
                                                        : 'New'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Consumer<MockReportRepository?>(
                                              builder: (context,
                                                  reportRepository, child) {
                                                if (reportRepository == null) {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                return IconButton(
                                                  icon: const Icon(
                                                      Icons.report_outlined,
                                                      size: 18),
                                                  onPressed: () =>
                                                      _showReportDialog(
                                                          experience),
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 24,
                                                    minHeight: 24,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
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
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
    );
  }

  Future<void> _reportExperience(Experience experience) async {
    final reportRepository = context.read<MockReportRepository?>();

    if (reportRepository == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report feature not available'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (reportRepository.isReported(experience.id ?? 0)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This experience has already been reported'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      final success =
          await reportRepository.reportExperience(experience.id ?? 0);

      if (success && mounted) {
        setState(() {
          _experiences.removeWhere((e) => e.id == experience.id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Experience reported successfully'),
            backgroundColor: Colors.orange,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to report experience'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showReportDialog(Experience experience) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(
              Icons.report_outlined,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Report Experience',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to report "${experience.name}"?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This will remove the experience from the marketplace and flag it for review.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _reportExperience(experience);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Report'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
