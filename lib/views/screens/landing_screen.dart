import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';

import 'package:prayer_box_flutter/core/theme/app_colors.dart'; 
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';

import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';
import 'package:prayer_box_flutter/views/widgets/common/footer_widget.dart';
import 'package:prayer_box_flutter/views/widgets/prayer/prayer_preview_tile.dart';
import 'package:prayer_box_flutter/views/widgets/scripture/scripture_widget.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final PrayerController prayerController = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppResponsive.screenPadding(context),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScriptureWidget(),
              SizedBox(height: 16),
              PrayerPreviewTile(),
              SizedBox(height: 16),
              FooterWidget(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.beige),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.appBarWelcome,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.goldLight,
                  letterSpacing: 1.5,
                ),
          ),
          Text(
            'Prayer Box',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.beige,
                ),
          ),
        ],
      ),
    );
  }
}