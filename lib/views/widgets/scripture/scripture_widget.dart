import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/scripture_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';

class ScriptureWidget extends StatelessWidget {
  const ScriptureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ScriptureController controller = Get.find<ScriptureController>();

    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: AppTheme.widgetDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget title row with refresh button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.verseOfTheDay,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.darkBrown,
                        letterSpacing: 2.5,
                      ),
                ),
                // Refresh button
                GestureDetector(
                  onTap: () => controller.loadDailyScripture(),
                  child: const Icon(
                    Icons.refresh,
                    color: AppColors.gold,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            const SizedBox(height: 12),

            // Show loading spinner if isLoading
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.gold,
                  strokeWidth: 2,
                ),
              )
            // Show scripture text
            else if (controller.dailyScripture.value == null)
              Text(
                AppStrings.noScripture,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            else ...[
              Text(
                '"${controller.dailyScripture.value!.verseText}"',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontSize: AppResponsive.responsiveValue<double>(
                        context,
                        mobile: 15,
                        tablet: 17,
                        desktop: 18,
                      ),
                      height: 1.7,
                    ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '— ${controller.dailyScripture.value!.reference}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.gold,
                      ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}