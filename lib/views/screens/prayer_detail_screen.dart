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

class PrayerDetailScreen extends StatelessWidget {
  PrayerDetailScreen({super.key});

  final PrayerController controller = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    // Path variable — satisfies project requirement for path variables
    final String id = Get.parameters['id'] ?? '';

    // Full prayer object passed via arguments
    final PrayerRequest prayer = Get.arguments as PrayerRequest;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView( // Removed ResponsiveContainer
          padding: AppResponsive.screenPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Prayer title and timestamp card
              _titleCard(context, prayer),
              const SizedBox(height: 16),

              // Prayer content card
              _contentCard(context, prayer),
              const SizedBox(height: 16),

              // Meditation scripture card
              if (prayer.meditationScripture.isNotEmpty)
                _scriptureCard(context, prayer),
              if (prayer.meditationScripture.isNotEmpty)
                const SizedBox(height: 16),

              // Edit and Back buttons
              Row(
                children: [
                  Expanded(
                    child: _editButton(context, prayer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _backButton(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
        AppStrings.appBarPrayerDetail,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.beige,
            ),
      ),
    );
  }

  // Title and timestamp card
  Widget _titleCard(BuildContext context, PrayerRequest prayer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prayer title
          Text(
            prayer.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 6),

          // Created timestamp in tiny font underneath title
          Text(
            DateFormatter.formatCreatedAt(prayer.createdAt),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
        ],
      ),
    );
  }

  // Prayer content card
  Widget _contentCard(BuildContext context, PrayerRequest prayer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.formContentLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.darkBrown,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 10),

          // Main body content as added by the user
          Text(
            prayer.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.7,
                ),
          ),
        ],
      ),
    );
  }

  // Meditation scripture card
  Widget _scriptureCard(BuildContext context, PrayerRequest prayer) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.formScriptureLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.darkBrown,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 6),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            prayer.meditationScripture,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.darkBrown,
                  height: 1.7,
                ),
          ),
        ],
      ),
    );
  }

  // Edit button 
  Widget _editButton(BuildContext context, PrayerRequest prayer) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.prayerForm,
        arguments: prayer,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: AppTheme.primaryButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.edit_outlined,
              color: AppColors.darkBrown,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.buttonEdit,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.darkBrown,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Back button
  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.prayerList),
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
}