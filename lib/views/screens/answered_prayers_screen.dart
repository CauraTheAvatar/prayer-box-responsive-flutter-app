import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';

import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';
import 'package:prayer_box_flutter/views/widgets/prayer/answered_prayer_tile.dart';

class AnsweredPrayersScreen extends StatelessWidget {
  AnsweredPrayersScreen({super.key});

  final PrayerController controller = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Obx(() {
          final List<PrayerRequest> answered =
              controller.answeredPrayers;

          if (answered.isEmpty) {
            return _emptyState(context);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Answered prayers list
              Expanded(
                child: ListView.separated(
                  padding: AppResponsive.screenPadding(context),
                  itemCount: answered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final PrayerRequest prayer = answered[index];
                    return AnsweredPrayerTile(
                      prayer: prayer,
                      onView: () => Get.toNamed(
                        '/prayer-detail/${prayer.id}',
                        arguments: prayer,
                      ),
                      onDelete: () =>
                          _showDeleteDialog(context, prayer),
                    );
                  },
                ),
              ),

              // Back to landing button
              Padding(
                padding: AppResponsive.screenPadding(context).copyWith(
                  top: 0,
                ),
                child: _backToLandingButton(context),
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.beige),
      title: Text(
        AppStrings.appBarAnswered,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.beige,
            ),
      ),
    );
  }

  // Empty state
  Widget _emptyState(BuildContext context) {
    return Padding(
      padding: AppResponsive.screenPadding(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.gold,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noAnsweredPrayers,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prayers you mark as answered will appear here.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkBrown,
                  height: 1.6,
                ),
          ),
          const Spacer(),

          // Back to landing button shown even in an empty state
          _backToLandingButton(context),
          const SizedBox(height: 8),
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
            const Icon(
              Icons.arrow_back,
              color: AppColors.gold,
              size: 18,
            ),
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

  // Delete confirmation dialog 
  void _showDeleteDialog(BuildContext context, PrayerRequest prayer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.beige,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.gold, width: 1.5),
        ),
        title: Text(
          AppStrings.deleteDialogTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.darkBrown,
              ),
        ),
        content: Text(
          AppStrings.deleteDialogMessage,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.darkBrown,
              ),
        ),
        actions: [
          // Cancel button that dismisses dialog and returns to list
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: AppTheme.buttonDecoration,
              child: Text(
                AppStrings.deleteDialogCancel,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.beige,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Continue to permanently delete answered prayer
          GestureDetector(
            onTap: () async {
              await controller.deletePrayerRequest(prayer.id);
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade900, width: 1),
              ),
              child: Text(
                AppStrings.deleteDialogContinue,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}