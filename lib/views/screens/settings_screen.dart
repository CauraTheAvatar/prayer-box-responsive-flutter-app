import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';

import 'package:prayer_box_flutter/controllers/settings_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView( 
          padding: AppResponsive.screenPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Preferences section
              _sectionHeader(context, 'PREFERENCES'),
              const SizedBox(height: 12),
              _notificationsToggle(context),

              const SizedBox(height: 24),

              // Account section
              _sectionHeader(context, 'ACCOUNT'),
              const SizedBox(height: 12),
              _logoutTile(context),

              const SizedBox(height: 24),

              // App info section
              _sectionHeader(context, 'ABOUT'),
              const SizedBox(height: 12),
              _appInfoTile(context),

              const SizedBox(height: 32),

              // Back to landing button
              _backToLandingButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
        AppStrings.appBarSettings,
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

  // Notifications toggle persisted via SettingsController and LocalStorageService
  Widget _notificationsToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.widgetDecoration,
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkBrown,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.gold, width: 1),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),

          // Label and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.settingsNotifications,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.settingsNotificationsSubtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.darkBrown,
                      ),
                ),
              ],
            ),
          ),

          // Reactive toggle switch
          Obx(() => Switch(
                value: controller.notificationsEnabled.value,
                onChanged: (_) => controller.toggleNotifications(),
                activeColor: AppColors.gold,
                activeTrackColor: AppColors.darkBrown,
                inactiveThumbColor: AppColors.beige,
                inactiveTrackColor: AppColors.darkBrown.withOpacity(0.4),
              )),
        ],
      ),
    );
  }

  // Logout tile (unresponsive)
  Widget _logoutTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.widgetDecoration,
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkBrown,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.gold, width: 1),
            ),
            child: const Icon(
              Icons.logout,
              color: AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),

          // Label and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.settingsLogout,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Coming soon',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.darkBrown,
                      ),
                ),
              ],
            ),
          ),

          // Disabled arrow indicator
          Icon(
            Icons.chevron_right,
            color: AppColors.darkBrown.withOpacity(0.3),
            size: 20,
          ),
        ],
      ),
    );
  }

  // App info tile
  Widget _appInfoTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.darkBrown,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.gold, width: 1),
                ),
                child: const Icon(
                  Icons.volunteer_activism_outlined,
                  color: AppColors.gold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.appTagline,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.darkBrown,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2026 Prayer Box. All rights reserved.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.darkBrown,
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