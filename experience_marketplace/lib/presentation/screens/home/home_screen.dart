import 'dart:math';
import 'dart:ui';
import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/models/model_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/repositories/experience_repository.dart';
import '../../../data/providers/feature_flag_provider.dart';
import '../experience/experience_detail_screen.dart';
import '../profile/profile_screen.dart';
import '../explore/explore_screen.dart';

enum SortDirection { none, ascending, descending }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;
  late AnimationController _gradientAnimationController;
  late AnimationController _blurAnimationController;
  late Animation<double> _blurAnimation;
  List<Experience> _experiences = [];
  List<Experience> _sortedExperiences = [];
  bool _isLoading = true;
  bool _isHovering = false;
  SortDirection _sortDirection = SortDirection.none;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _gradientAnimationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _blurAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _blurAnimation = Tween<double>(
      begin: 8.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _blurAnimationController,
      curve: Curves.easeInOut,
    ));
    _fabAnimationController.forward();
    _gradientAnimationController.repeat();
    _loadData();
  }

  Future<void> _loadData() async {
    final experienceRepository = context.read<ExperienceRepository>();
    final experiences = await experienceRepository.getAll();
    setState(() {
      _experiences = experiences;
      _sortExperiences();
      _isLoading = false;
    });
  }

  void _sortExperiences() {
    final featureFlags = context.read<FeatureFlagProvider>();
    if (!featureFlags.enableTimeSorting) {
      _sortedExperiences = List<Experience>.from(_experiences);
      return;
    }

    _sortedExperiences = List<Experience>.from(_experiences);

    switch (_sortDirection) {
      case SortDirection.ascending:
        _sortedExperiences.sort((a, b) => a.startsAt.compareTo(b.startsAt));
        break;
      case SortDirection.descending:
        _sortedExperiences.sort((a, b) => b.startsAt.compareTo(a.startsAt));
        break;
      case SortDirection.none:
        _sortedExperiences.sort((a, b) => b.startsAt.compareTo(a.startsAt));
        break;
    }
  }

  void _setSortDirection(SortDirection? newDirection) {
    if (newDirection == null) return;
    setState(() {
      _sortDirection = newDirection;
      _sortExperiences();
    });
  }

  String _getSortDisplayText(SortDirection direction) {
    switch (direction) {
      case SortDirection.ascending:
        return 'Earliest First';
      case SortDirection.descending:
        return 'Latest First';
      case SortDirection.none:
        return 'No Sort';
    }
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _gradientAnimationController.dispose();
    _blurAnimationController.dispose();
    super.dispose();
  }

  Widget _buildExperienceCard(Experience experience, int index) {
    final now = DateTime.now();
    final isCurrentlyHappening = index == 0 &&
        experience.startsAt.isBefore(now) &&
        experience.endsAt.isAfter(now);

    return MouseRegion(
      onEnter: (_) {
        if (isCurrentlyHappening) {
          setState(() => _isHovering = true);
          _gradientAnimationController.duration = const Duration(seconds: 2);
          _fabAnimationController.duration = const Duration(milliseconds: 150);
          _blurAnimationController.forward();
        }
      },
      onExit: (_) {
        if (isCurrentlyHappening) {
          setState(() => _isHovering = false);
          _gradientAnimationController.duration = const Duration(seconds: 6);
          _fabAnimationController.duration = const Duration(milliseconds: 300);
          _blurAnimationController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation:
            Listenable.merge([_gradientAnimationController, _blurAnimation]),
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: isCurrentlyHappening
                  ? LinearGradient(
                      begin: Alignment(
                          -1 + 2 * _gradientAnimationController.value, -1),
                      end: Alignment(
                          1 - 2 * _gradientAnimationController.value, 1),
                      colors: [
                        Colors.orange.shade600,
                        Colors.red.shade600,
                        Colors.pink.shade600,
                        Colors.purple.shade600,
                        Colors.blue.shade600,
                        Colors.orange.shade600,
                      ],
                      stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: isCurrentlyHappening
                      ? Colors.orange.withOpacity(_isHovering ? 0.6 : 0.4)
                      : Colors.black.withOpacity(0.1),
                  blurRadius:
                      isCurrentlyHappening ? (_isHovering ? 30 : 20) : 10,
                  offset: const Offset(0, 5),
                  spreadRadius:
                      isCurrentlyHappening ? (_isHovering ? 3 : 1) : 0,
                ),
                if (isCurrentlyHappening)
                  BoxShadow(
                    color: Colors.pink.withOpacity(_isHovering ? 0.4 : 0.2),
                    blurRadius: _isHovering ? 40 : 25,
                    offset: const Offset(0, 8),
                    spreadRadius: _isHovering ? 2 : 0,
                  ),
              ],
            ),
            child: Container(
              padding: isCurrentlyHappening
                  ? const EdgeInsets.all(4)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: isCurrentlyHappening
                    ? LinearGradient(
                        begin: Alignment(
                            cos(_gradientAnimationController.value * 4 * pi),
                            sin(_gradientAnimationController.value * 4 * pi)),
                        end: Alignment(
                            -cos(_gradientAnimationController.value * 4 * pi),
                            -sin(_gradientAnimationController.value * 4 * pi)),
                        colors: [
                          Colors.orange.shade400,
                          Colors.red.shade500,
                          Colors.pink.shade500,
                          Colors.purple.shade500,
                          Colors.indigo.shade500,
                          Colors.orange.shade400,
                        ],
                        stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: isCurrentlyHappening
                      ? Colors.black.withOpacity(0.2)
                      : Colors.transparent,
                ),
                child: Stack(
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      color: isCurrentlyHappening
                          ? Colors.transparent
                          : Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExperienceDetailScreen(
                                  experience: experience),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ImageFiltered(
                                  imageFilter: isCurrentlyHappening
                                      ? ImageFilter.blur(
                                          sigmaX: _blurAnimation.value,
                                          sigmaY: _blurAnimation.value,
                                        )
                                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: experience.photoUrl ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(color: Colors.white),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: AppColors.primary
                                              .withOpacity(0.1),
                                          child: const Icon(
                                              Icons.image_not_supported,
                                              size: 50),
                                        ),
                                      ),
                                      if (isCurrentlyHappening)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                                0.3 *
                                                    (_blurAnimation.value /
                                                        8.0)),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Show event name with smooth blur transition
                                  ImageFiltered(
                                    imageFilter: isCurrentlyHappening
                                        ? ImageFilter.blur(
                                            sigmaX: _blurAnimation.value,
                                            sigmaY: _blurAnimation.value,
                                          )
                                        : ImageFilter.blur(
                                            sigmaX: 0, sigmaY: 0),
                                    child: Text(
                                      experience.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrentlyHappening
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Show experience description with smooth blur transition
                                  ImageFiltered(
                                    imageFilter: isCurrentlyHappening
                                        ? ImageFilter.blur(
                                            sigmaX: _blurAnimation.value,
                                            sigmaY: _blurAnimation.value,
                                          )
                                        : ImageFilter.blur(
                                            sigmaX: 0, sigmaY: 0),
                                    child: Text(
                                      'Experience in ${experience.location}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isCurrentlyHappening
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Always show location and rating (essential info)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: isCurrentlyHappening
                                            ? Colors.white.withOpacity(0.9)
                                            : Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        experience.location,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isCurrentlyHappening
                                              ? Colors.white.withOpacity(0.9)
                                              : Colors.grey[600],
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 16),
                                          const SizedBox(width: 4),
                                          Text(
                                            experience.averageRating > 0
                                                ? experience.averageRating
                                                    .toStringAsFixed(1)
                                                : 'New',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: isCurrentlyHappening
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  // Always show "HAPPENING NOW" badge
                                  if (isCurrentlyHappening)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Text(
                                        '🔥 HAPPENING NOW 🔥',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                        .animate(
                                            onPlay: (controller) =>
                                                controller.repeat())
                                        .shimmer(duration: 2000.ms),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isCurrentlyHappening) ..._buildFireEmojis(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.3);
  }

  List<Widget> _buildFireEmojis() {
    return List.generate(8, (index) {
      return Positioned(
        bottom: 10,
        left: 20.0 + (index * 40.0),
        child: const Text(
          '🔥',
          style: TextStyle(fontSize: 24),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .slideY(
              begin: 0,
              end: -3,
              duration: Duration(milliseconds: 1500 + (index * 100)),
            )
            .fadeOut(
              begin: 0.8,
              duration: Duration(milliseconds: 1000 + (index * 100)),
            ),
      );
    });
  }

  Widget _buildHomeContent() {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            floating: true,
            snap: true,
            pinned: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                child: Column(
                  children: [
                    Expanded(
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      'ExploreX',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.5,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Discover amazing experiences around the world',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Discover Amazing Experiences',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),
                const SizedBox(height: 16),
                Consumer<FeatureFlagProvider>(
                  builder: (context, flags, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButton<SortDirection>(
                          isDense: true,
                          value: _sortDirection,
                          onChanged: _setSortDirection,
                          underline: const SizedBox.shrink(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey[600],
                          ),
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          items: SortDirection.values
                              .map((SortDirection direction) {
                            return DropdownMenuItem<SortDirection>(
                              value: direction,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    direction == SortDirection.ascending
                                        ? Icons.arrow_upward
                                        : direction == SortDirection.descending
                                            ? Icons.arrow_downward
                                            : Icons.sort,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getSortDisplayText(direction),
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          _isLoading
              ? SliverFillRemaining(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        height: 300,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= _sortedExperiences.length) return null;
                      return _buildExperienceCard(
                          _sortedExperiences[index], index);
                    },
                    childCount: _sortedExperiences.length,
                  ),
                ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }

  Widget _buildAnimatedBottomBar() {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildNavItem(Icons.home_rounded, 'Home', 0)),
            Expanded(child: _buildNavItem(Icons.explore_rounded, 'Explore', 1)),
            Expanded(child: _buildNavItem(Icons.person_rounded, 'Profile', 2)),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 1);
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _fabAnimationController.reset();
        _fabAnimationController.forward();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey[600],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      const ExploreScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: _buildAnimatedBottomBar(),
    );
  }
}
