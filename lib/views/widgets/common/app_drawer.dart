import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // White background as per requirements
      backgroundColor: AppColors.white,
      width: AppResponsive.responsiveValue<double>( 
        context,
        mobile: 280,
        tablet: 320,
        desktop: 360,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: AppResponsive.responsiveValue<double>( 
                  context,
                  mobile: 24,
                  tablet: 28,
                  desktop: 32,
                ),
              ),
              decoration: const BoxDecoration(
                color: AppColors.darkBrown,
                border: Border(
                  bottom: BorderSide(color: AppColors.gold, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.appName.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.gold,
                          letterSpacing: 3,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.appTagline,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.goldLight,
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Main nav items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _navButton(
                    context: context,
                    icon: Icons.home_outlined,
                    label: AppStrings.navPrayerRequests,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.prayerList);
                    },
                  ),
                  const SizedBox(height: 10),
                  _navButton(
                    context: context,
                    icon: Icons.add_circle_outline,
                    label: AppStrings.navAddNewPrayer,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.prayerForm);
                    },
                  ),
                  const SizedBox(height: 10),
                  _navButton(
                    context: context,
                    icon: Icons.check_circle_outline,
                    label: AppStrings.navAnsweredPrayers,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.answeredPrayers);
                    },
                  ),
                  const SizedBox(height: 10),
                  _navButton(
                    context: context,
                    icon: Icons.menu_book_outlined,
                    label: AppStrings.navDailyScripture,
                    onTap: () {
                      Get.back();
                      Get.offAllNamed(AppRoutes.landing);
                    },
                  ),
                  const SizedBox(height: 10),
                  _navButton(
                    context: context,
                    icon: Icons.bar_chart_outlined,
                    label: AppStrings.navStatistics,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.stats);
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Footer divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: AppColors.gold, thickness: 0.8),
            ),

            // Footer row with logout (unresponsive) on left and settings icon on right
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: AppResponsive.responsiveValue<double>( 
                  context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logout (unresponsive)
                  _footerItem(
                    context: context,
                    icon: Icons.logout,
                    label: AppStrings.navLogout,
                    onTap: null,
                  ),

                  // Settings icon
                  _footerIconOnly(
                    context: context,
                    icon: Icons.settings_outlined,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.settings);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Nav button 
  Widget _navButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: AppTheme.buttonDecoration,
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.beige,
                      letterSpacing: 0.8,
                    ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.gold,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Footer item with icon and label
  // onTap is nullable
  Widget _footerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    final bool isActive = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive
                ? AppColors.darkBrown
                : AppColors.darkBrown.withOpacity(0.4),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isActive
                      ? AppColors.darkBrown
                      : AppColors.darkBrown.withOpacity(0.4),
                  letterSpacing: 0.5,
                ),
          ),
        ],
      ),
    );
  }

  // Footer icon only 
  Widget _footerIconOnly({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.darkBrown,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.gold, width: 1),
        ),
        child: Icon(
          icon,
          color: AppColors.gold,
          size: 20,
        ),
      ),
    );
  }
}