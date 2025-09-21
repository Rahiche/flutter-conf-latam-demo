import 'package:experience_common/experience_client.dart';
import 'package:experience_marketplace/data/models/model_extensions.dart';
import 'package:experience_marketplace/data/repositories/experience_repository.dart';
import 'package:experience_marketplace/data/repositories/user_repository.dart';
import 'package:experience_marketplace/data/repositories/mock_report_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';

class ExperienceDetailScreen extends StatefulWidget {
  final Experience experience;

  const ExperienceDetailScreen({
    required this.experience,
    super.key,
  });

  @override
  State<ExperienceDetailScreen> createState() => _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState extends State<ExperienceDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _heartAnimationController;
  bool _isFavorite = false;
  bool _isRegistered = false;
  bool _isLoading = false;
  bool _isReporting = false;
  String? _currentUserId;
  Experience? _currentExperience;

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _currentExperience = widget.experience;
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (_isFavorite) {
      _heartAnimationController.forward();
    } else {
      _heartAnimationController.reverse();
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      final userRepository =
          Provider.of<UserRepository>(context, listen: false);
      final currentUser = await userRepository.getCurrentUser();
      setState(() {
        _currentUserId = currentUser?.id;
      });
      _checkRegistrationStatus();
    } catch (e) {
      // Handle error silently for now
    }
  }

  void _checkRegistrationStatus() {
    if (_currentUserId != null && _currentExperience?.attendees != null) {
      final isAlreadyRegistered = _currentExperience!.attendees!
          .any((attendee) => attendee.id.toString() == _currentUserId);
      setState(() {
        _isRegistered = isAlreadyRegistered;
      });
    }
  }

  Future<void> _toggleRegistration() async {
    if (_currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to register for experiences'),
        ),
      );
      return;
    }

    if (_currentExperience?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid experience data'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final experienceRepository =
          Provider.of<ExperienceRepository>(context, listen: false);
      final experienceId = _currentExperience!.id.toString();

      bool success;
      if (_isRegistered) {
        success = await experienceRepository.unregisterAttendance(experienceId);
      } else {
        success = await experienceRepository.registerAttendance(experienceId);
      }

      if (success) {
        // Refresh the experience data to get updated attendees list
        final updatedExperience =
            await experienceRepository.getById(int.parse(experienceId));
        setState(() {
          _currentExperience = updatedExperience ?? _currentExperience;
          _isRegistered = !_isRegistered;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isRegistered
                ? 'Successfully registered for this experience!'
                : 'Successfully unregistered from this experience!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isRegistered
                ? 'Failed to register for this experience'
                : 'Failed to unregister from this experience'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _reportExperience() async {
    if (_currentExperience?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid experience data'),
        ),
      );
      return;
    }

    final reportRepository = context.read<MockReportRepository?>();
    if (reportRepository == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Report feature not available'),
        ),
      );
      return;
    }

    if (reportRepository.isReported(_currentExperience!.id!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This experience has already been reported'),
        ),
      );
      return;
    }

    setState(() {
      _isReporting = true;
    });

    try {
      final success =
          await reportRepository.reportExperience(_currentExperience!.id!);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Experience reported successfully'),
            backgroundColor: Colors.orange,
          ),
        );
        // Navigate back to the list which will be refreshed automatically
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to report experience'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
        ),
      );
    } finally {
      setState(() {
        _isReporting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final appBarHeight = (height * 0.45).clamp(260, 420);
    final number =
        (_currentExperience?.attendees ?? widget.experience.attendees)
                ?.length ??
            0;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: appBarHeight.toDouble(),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider.builder(
                    // itemCount: widget.experience.images.length,
                    itemCount: 1,
                    options: CarouselOptions(
                      height: appBarHeight.toDouble(),
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {});
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return CachedNetworkImage(
                        imageUrl: widget.experience.photoUrl ??
                            'https://storage.googleapis.com/cms-storage-bucket/stable-and-reliable.3461c6a5b33c339001c5.jpg',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: AnimatedBuilder(
                    animation: _heartAnimationController,
                    builder: (context, child) {
                      return Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.black,
                      );
                    },
                  ),
                  onPressed: _toggleFavorite,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              Consumer<MockReportRepository?>(
                builder: (context, reportRepository, child) {
                  if (reportRepository == null) {
                    return const SizedBox.shrink();
                  }

                  final isReported = reportRepository.isReported(
                      _currentExperience?.id ?? widget.experience.id ?? 0);

                  return Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: _isReporting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.orange,
                              ),
                            )
                          : Icon(
                              Icons.flag,
                              color: isReported ? Colors.red : Colors.orange,
                            ),
                      onPressed:
                          _isReporting || isReported ? null : _reportExperience,
                      tooltip: isReported
                          ? 'Already reported'
                          : 'Report this experience',
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentExperience?.name ?? widget.experience.name,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn().slideY(begin: 0.2),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          _currentExperience?.location ??
                              widget.experience.location,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.experience.averageRating > 0
                                  ? widget.experience.averageRating.toString()
                                  : 'New',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${_currentExperience?.reviewCount ?? widget.experience.reviewCount})',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: AppColors.secondary),
                            const SizedBox(width: 4),
                            Text(
                              widget.experience.formattedDuration,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.people,
                                size: 16, color: AppColors.primary),
                            const SizedBox(width: 4),
                            if (number > 0)
                              Text(
                                '$number attending',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                  const SizedBox(height: 24),
                  Text(
                    'About this experience',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 12),
                  Text(
                    _currentExperience?.name ?? widget.experience.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _toggleRegistration,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: _isRegistered ? Colors.red : null,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _isRegistered ? 'Unregister' : 'Register',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),
    );
  }
}
