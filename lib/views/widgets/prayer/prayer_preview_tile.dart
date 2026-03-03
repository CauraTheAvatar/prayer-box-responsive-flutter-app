import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/views/widgets/prayer/recent_prayer_checklist.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';

class PrayerPreviewTile extends StatelessWidget {
  const PrayerPreviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Access PrayerController via Get.find()
    final PrayerController controller = Get.find<PrayerController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Widget title — caps, white text on dark brown as per requirements
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.darkBrown,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gold, width: 1),
            ),
            child: Text(
              AppStrings.prayerRequests,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                    letterSpacing: 2.5,
                  ),
            ),
          ),

          const SizedBox(height: 14),

          // RecentPrayerChecklist handles Obx, empty state,
          // responsive layout, checkbox, and timestamp internally
          const RecentPrayerChecklist(),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          // View and Add buttons at bottom
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  context: context,
                  label: AppStrings.buttonView,
                  icon: Icons.remove_red_eye_outlined,
                  onTap: () => Get.toNamed(AppRoutes.prayerList),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  context: context,
                  label: AppStrings.buttonAdd,
                  icon: Icons.add,
                  onTap: () => Get.toNamed(AppRoutes.prayerForm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: AppTheme.buttonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.gold, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
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