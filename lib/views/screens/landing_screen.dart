import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/controllers/scripture_controller.dart';
import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final PrayerController prayerController = Get.find<PrayerController>();
  final ScriptureController scriptureController = Get.find<ScriptureController>();
}

