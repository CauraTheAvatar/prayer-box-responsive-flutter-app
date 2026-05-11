import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';

class RecentPrayerChecklist extends StatelessWidget {
  const RecentPrayerChecklist({super.key});

  @override
  Widget build(BuildContext context) {
    final PrayerController prayerController = Get.find<PrayerController>();

    return Obx(() {
      // Display first 3 unanswerd prayers 
      final List<PrayerRequest> recent = prayerController.recentUnansweredPrayers;

      // Empty state
      if (recent.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.inbox_outlined,
                  color: AppColors.gold,
                  size: 36,
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.noPrayersYet,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.tapAddToStart,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.darkBrown,
                      ),
                ),
              ],
            ),
          ),
        );
      }

      // Two-column grid on tablet/desktop, single column on mobile
      final bool isWide = !AppResponsive.isMobile(context);

      return isWide
          ? GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 4,
              children: recent
                  .map((p) => _checkItem(context, p, prayerController))
                  .toList(),
            )
          : Column(
              children: recent
                  .map((p) => _checkItem(context, p, prayerController))
                  .toList(),
            );
    });
  }

  Widget _checkItem(
    BuildContext context,
    PrayerRequest prayer,
    PrayerController prayerController,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox tap to mark as answered
          GestureDetector(
            onTap: () => prayerController.markAsAnswered(prayer.id),
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gold, width: 1.5),
                borderRadius: BorderRadius.circular(4),
                color: AppColors.white,
              ),
              child: prayer.isAnswered
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.gold,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 10),

          // Prayer title and timestamp subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Prayer title
                Text(
                  prayer.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),

                // Timestamp subtitle via DateFormatter utility
                Text(
                  DateFormatter.formatShortDateTime(prayer.createdAt),
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
}