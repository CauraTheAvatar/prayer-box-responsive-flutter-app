import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/validators.dart';

abstract class PrayerFormFields {
  PrayerFormFields._(); // prevent instantiation

  // Title field with max 100 characters
  static Widget titleField({
    required BuildContext context,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.formTitleLabel.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.darkBrown,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: AppStrings.formTitleHint,
            ),
            validator: Validators.validateTitle,
          ),
        ],
      ),
    );
  }

  // Content field with 15000 character limit
  static Widget contentField({
    required BuildContext context,
    required TextEditingController controller,
    required RxInt charCount,
  }) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            maxLines: AppResponsive.responsiveValue<int>( 
              context,
              mobile: 8,
              tablet: 10,
              desktop: 12,
            ),
            textInputAction: TextInputAction.newline,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: AppStrings.formContentHint,
            ),
            onChanged: (value) => charCount.value = value.length,
            validator: Validators.validateContent,
          ),
        ],
      ),
    );
  }

  // Scripture field
  static Widget scriptureField({
    required BuildContext context,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 4),
          Text(
            'Optional — no character limit',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.darkBrown,
                ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            maxLines: AppResponsive.responsiveValue<int>( 
              context,
              mobile: 3,
              tablet: 4,
              desktop: 5,
            ),
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: AppStrings.formScriptureHint,
            ),
            // No character limit
            validator: Validators.validateScripture,
          ),
        ],
      ),
    );
  }
}