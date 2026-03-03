import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';

import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';
import 'package:prayer_box_flutter/views/widgets/prayer/prayer_list_tile.dart';

class PrayerListScreen extends StatelessWidget {
  PrayerListScreen({super.key});

  final PrayerController controller = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Obx(() {
          final List<PrayerRequest> prayers =
              controller.unansweredPrayers;

          if (prayers.isEmpty) {
            return _emptyState(context);
          }

          return ListView.separated(
            padding: AppResponsive.screenPadding(context),
            itemCount: prayers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final PrayerRequest prayer = prayers[index];
              return PrayerListTile(
                prayer: prayer,
                onView: () => Get.toNamed(
                  '/prayer-detail/${prayer.id}',
                  arguments: prayer,
                ),
                onDelete: () => _showDeleteDialog(context, prayer),
              );
            },
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
        AppStrings.appBarPrayerList,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.beige,
            ),
      ),
    );
  }

  // Empty state
  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppResponsive.screenPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inbox_outlined,
              color: AppColors.gold,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noPrayersYet, 
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.darkBrown,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.tapAddToStart,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkBrown,
                  ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.prayerForm),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 32,
                ),
                decoration: AppTheme.primaryButtonDecoration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppColors.darkBrown,
                      size: 18,
                    ),
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
          // Cancel button navigates back to list
          TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
            ),
            child: Text(
              AppStrings.deleteDialogCancel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.darkBrown,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          // Continue button permanently deletes prayer
          TextButton(
            onPressed: () async {
              await controller.deletePrayerRequest(prayer.id);
              Get.back();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: AppColors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.red.shade900, width: 1),
              ),
            ),
            child: Text(
              AppStrings.deleteDialogContinue,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}