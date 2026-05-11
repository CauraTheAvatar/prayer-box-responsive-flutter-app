import 'package:flutter/material.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';        
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';          
import 'package:prayer_box_flutter/core/constants/app_strings.dart';    
import 'package:prayer_box_flutter/core/theme/app_theme.dart';          
import 'package:prayer_box_flutter/core/utils/date_formatter.dart';         

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: AppTheme.widgetDecoration,
      child: Column(
        children: [
          Icon(
            Icons.volunteer_activism_outlined,
            color: AppColors.gold,
            size: AppResponsive.responsiveValue<double>(  
              context,
              mobile: 28,
              tablet: 32,
              desktop: 36,
            ),
          ),
          const SizedBox(height: 10),

          // Hardcoded motivation text via AppStrings
          Text(
            '"${AppStrings.footerMotivation}"',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: AppResponsive.responsiveValue<double>(  
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 17,
                  ),
                  height: 1.7,
                ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),

          // Current date via DateFormatter utility
          Text(
            DateFormatter.formatFullDate(DateTime.now()),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
          ),
        ],
      ),
    );
  }
}