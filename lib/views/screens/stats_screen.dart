import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({super.key});

  final PrayerController controller = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Obx(() {
          // Derived statistics — computed reactively from controller lists
          final int totalSubmitted = controller.unansweredPrayers.length +
              controller.answeredPrayers.length;
          final int totalAnswered = controller.answeredPrayers.length;
          final int totalUnanswered = controller.unansweredPrayers.length;
          final double progressValue = totalSubmitted == 0
              ? 0
              : totalAnswered / totalSubmitted;

          return SingleChildScrollView(
            padding: AppResponsive.screenPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section header
                _sectionHeader(context, 'OVERVIEW'),
                const SizedBox(height: 12),

                // Stat cards = responsive grid
                _statCardsGrid(
                  context,
                  totalSubmitted: totalSubmitted,
                  totalAnswered: totalAnswered,
                  totalUnanswered: totalUnanswered,
                ),

                const SizedBox(height: 24),

                // Section header
                _sectionHeader(context, AppStrings.statsProgressLabel),
                const SizedBox(height: 12),

                // Progress bar showing answered vs unanswered prayers
                _progressSection(
                  context,
                  progressValue: progressValue,
                  totalAnswered: totalAnswered,
                  totalUnanswered: totalUnanswered,
                  totalSubmitted: totalSubmitted,
                ),

                const SizedBox(height: 24),

                // Most recent answered prayer 
                if (controller.answeredPrayers.isNotEmpty) ...[
                  _sectionHeader(context, 'MOST RECENTLY ANSWERED'),
                  const SizedBox(height: 12),
                  _mostRecentAnswered(context),
                  const SizedBox(height: 24),
                ],

                // Empty state if no prayers have been added yet
                if (totalSubmitted == 0) ...[
                  _emptyState(context),
                  const SizedBox(height: 24),
                ],

                // Back to landing button
                _backToLandingButton(context),
                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      ),
    );
  }

  // App bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.beige),
      title: Text(
        AppStrings.appBarStats,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.beige,
            ),
      ),
    );
  }

  // Section header
  Widget _sectionHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.darkBrown,
                letterSpacing: 2.5,
              ),
        ),
        const SizedBox(height: 6),
        const Divider(),
      ],
    );
  }

  // Stat cards grid
  // Single column on mobile, two columns on tablet and desktop
  Widget _statCardsGrid(
    BuildContext context, {
    required int totalSubmitted,
    required int totalAnswered,
    required int totalUnanswered,
  }) {
    final List<Map<String, dynamic>> stats = [
      {
        'label': AppStrings.statsTotalSubmitted,
        'value': '$totalSubmitted',
        'icon':  Icons.format_list_bulleted,
      },
      {
        'label': AppStrings.statsAnswered,
        'value': '$totalAnswered',
        'icon':  Icons.check_circle_outline,
      },
      {
        'label': AppStrings.statsAwaiting,
        'value': '$totalUnanswered',
        'icon':  Icons.hourglass_empty_outlined,
      },
    ];

    final bool isWide = !AppResponsive.isMobile(context);

    // On tablet and/or desktop show all 3 cards in a row
    // On mobile stack them in a single column
    return isWide
        ? Row(
            children: stats
                .map(
                  (s) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: stats.indexOf(s) < stats.length - 1 ? 12 : 0,
                      ),
                      child: _statCard(
                        context,
                        label: s['label'] as String,
                        value: s['value'] as String,
                        icon: s['icon'] as IconData,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Column(
            children: stats
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _statCard(
                      context,
                      label: s['label'] as String,
                      value: s['value'] as String,
                      icon: s['icon'] as IconData,
                    ),
                  ),
                )
                .toList(),
          );
  }

  // Individual stat card
  Widget _statCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and value row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.darkBrown,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.gold, width: 1),
                ),
                child: Icon(icon, color: AppColors.gold, size: 20),
              ),
              // Large gold value
              Text(
                value,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                      fontSize: AppResponsive.responsiveValue<double>( 
                        context,
                        mobile: 28,
                        tablet: 32,
                        desktop: 36,
                      ),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),

          // Label underneath
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.darkBrown,
                  letterSpacing: 1.2,
                ),
          ),
        ],
      ),
    );
  }

  // Progress bar section with answered vs unanswered ratio
  Widget _progressSection(
    BuildContext context, {
    required double progressValue,
    required int totalAnswered,
    required int totalUnanswered,
    required int totalSubmitted,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Legend row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Answered legend
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Answered',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.darkBrown,
                        ),
                  ),
                ],
              ),

              // Unanswered legend
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.darkBrown.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Awaiting',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.darkBrown,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 20,
              backgroundColor: AppColors.darkBrown.withOpacity(0.15),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.gold),
            ),
          ),
          const SizedBox(height: 12),

          // Counts below bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$totalAnswered answered',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.darkBrown,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '$totalUnanswered awaiting',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.darkBrown,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),

          // Total summary
          if (totalSubmitted > 0) ...[
            const SizedBox(height: 10),
            Center(
              child: Text(
                '$totalAnswered of $totalSubmitted prayers answered',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Most recently answered prayer tile
  Widget _mostRecentAnswered(BuildContext context) {
    final recentAnswered = controller.answeredPrayers.first;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkBrown,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.gold, width: 1),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Prayer title
                Text(
                  recentAnswered.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Answered timestamp
                Text(
                  recentAnswered.answeredAt != null
                      ? DateFormatter.formatAnsweredAt(
                          recentAnswered.answeredAt!)
                      : DateFormatter.formatCreatedAt(
                          recentAnswered.createdAt),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.darkBrown,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Empty state when no prayers have been entered yet
  Widget _emptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        children: [
          const Icon(
            Icons.bar_chart_outlined,
            color: AppColors.gold,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'No statistics yet.',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first prayer request to start tracking your journey.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkBrown,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.prayerForm),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 28,
              ),
              decoration: AppTheme.primaryButtonDecoration,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, color: AppColors.darkBrown, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.buttonAdd,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.darkBrown,
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

  // Back to landing button
  Widget _backToLandingButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.offAllNamed(AppRoutes.landing),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: AppTheme.buttonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, color: AppColors.gold, size: 18),
            const SizedBox(width: 8),
            Text(
              AppStrings.buttonBack,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.beige,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}