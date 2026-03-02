import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.darkBrown,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer header
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 28,
              ),
              decoration: const BoxDecoration(
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

            const SizedBox(height: 8),

            // Main nav items
            _drawerItem(
              context: context,
              icon: Icons.home_outlined,
              label: AppStrings.navPrayerRequests,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.prayerList);
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.add_circle_outline,
              label: AppStrings.navAddNewPrayer,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.prayerForm);
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.check_circle_outline,
              label: AppStrings.navAnsweredPrayers,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.answeredPrayers);
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.menu_book_outlined,
              label: AppStrings.navDailyScripture,
              onTap: () => Get.back(),
            ),
            _drawerItem(
              context: context,
              icon: Icons.bar_chart_outlined,
              label: AppStrings.navStatistics,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.stats);
              },
            ),

            const Spacer(),

            const Divider(
              color: AppColors.gold,
              thickness: 0.5,
              indent: 20,
              endIndent: 20,
            ),

            _drawerItem(
              context: context,
              icon: Icons.settings_outlined,
              label: AppStrings.navSettings,
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.settings);
              },
            ),
            _drawerItem(
              context: context,
              icon: Icons.logout,
              label: AppStrings.navLogout,
              onTap: () {
                Get.back();
                // Simple print statement - no actual logout logic
                print('Logout tapped - demo only');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.gold.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 22),
            const SizedBox(width: 14),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.beige,
                    fontSize: 15,
                    letterSpacing: 0.8,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}