import 'package:flutter/material.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';

class AnsweredPrayerTile extends StatelessWidget {
  const AnsweredPrayerTile({
    super.key,
    required this.prayer,
    required this.onView,
    required this.onDelete,
  });

  final PrayerRequest prayer;
  final VoidCallback onView;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.widgetDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Answered check indicator
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.gold, width: 1.5),
            ),
            child: const Icon(
              Icons.check,
              size: 14,
              color: AppColors.gold,
            ),
          ),

          // Prayer title and answered timestamp
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
                const SizedBox(height: 4),

                // Answered timestamp for when it was ticked off
                Text(
                  prayer.answeredAt != null
                      ? DateFormatter.formatAnsweredAt(prayer.answeredAt!)
                      : DateFormatter.formatCreatedAt(prayer.createdAt),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.darkBrown,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Eye icon 
          GestureDetector(
            onTap: onView,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.darkBrown,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.gold, width: 1),
              ),
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: AppColors.gold,
                size: 18,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Delete icon 
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.red.shade900, width: 1),
              ),
              child: const Icon(
                Icons.delete_outline,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}