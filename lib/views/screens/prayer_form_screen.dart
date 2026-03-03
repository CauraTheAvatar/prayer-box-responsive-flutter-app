import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prayer_box_flutter/controllers/prayer_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/validators.dart';

import 'package:prayer_box_flutter/data/models/prayer_models.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/views/widgets/common/app_drawer.dart';
import 'package:prayer_box_flutter/views/widgets/prayer/prayer_form_fields.dart';

class PrayerFormScreen extends StatelessWidget {
  PrayerFormScreen({super.key});

  final PrayerController controller = Get.find<PrayerController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Reactive text controllers so that character counter rebuilds with Obx
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _scriptureController = TextEditingController();

  // Reactive character count for content field
  final RxInt _contentCharCount = 0.obs;

  // Holds the prayer being edited with null when in add mode
  final Rx<PrayerRequest?> _editingPrayer = Rx<PrayerRequest?>(null);

  // Edit mode initialiser
  void _initEditMode() {
    if (Get.arguments != null && Get.arguments is PrayerRequest) {
      final PrayerRequest existing = Get.arguments as PrayerRequest;

      // Only pre-fill if not already initialised for this prayer
      if (_editingPrayer.value?.id != existing.id) {
        _editingPrayer.value = existing;
        _titleController.text = existing.title;
        _contentController.text = existing.content;
        _scriptureController.text = existing.meditationScripture;
        _contentCharCount.value = existing.content.length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialise edit mode before building the widget tree
    _initEditMode();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppResponsive.screenPadding(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title field
                PrayerFormFields.titleField(
                  context: context,
                  controller: _titleController,
                ),
                const SizedBox(height: 16),

                // Content field with character counter
                PrayerFormFields.contentField(
                  context: context,
                  controller: _contentController,
                  charCount: _contentCharCount,
                ),
                const SizedBox(height: 6),

                // Reactive character counter display
                Obx(() => Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        Validators.characterCount(
                          _contentController.text,
                        ),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: _contentCharCount.value >
                                      Validators.contentCharacterLimit
                                  ? Colors.red
                                  : AppColors.darkBrown,
                            ),
                      ),
                    )),

                const SizedBox(height: 16),

                // Scripture field
                PrayerFormFields.scriptureField(
                  context: context,
                  controller: _scriptureController,
                ),

                const SizedBox(height: 32),

                // Save and Clear buttons
                Row(
                  children: [
                    Expanded(
                      child: _saveButton(context),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _clearButton(context),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar
  // Title updates depending on whether in add or edit mode
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.beige),
      title: Obx(() => Text(
            _editingPrayer.value != null
                ? AppStrings.appBarPrayerFormEdit
                : AppStrings.appBarPrayerForm,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.beige,
                ),
          )),
    );
  }

  // Save button
  Widget _saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          if (_editingPrayer.value != null) {
            // Edit mode
            await controller.editPrayerRequest(
              id: _editingPrayer.value!.id,
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
              meditationScripture: _scriptureController.text.trim(),
            );
          } else {
            // Add mode
            await controller.addPrayerRequest(
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
              meditationScripture: _scriptureController.text.trim(),
            );
          }
          // Navigate back to landing with the most recent prayer at the top
          Get.offAllNamed(AppRoutes.landing);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: AppTheme.primaryButtonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.save_outlined,
              color: AppColors.darkBrown,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.buttonSave,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.darkBrown,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // Clear button that resets all fields and character counter
  // Edit button clears back to empty, not back to original values
  Widget _clearButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleController.clear();
        _contentController.clear();
        _scriptureController.clear();
        _contentCharCount.value = 0;
        _formKey.currentState!.reset();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: AppTheme.buttonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.clear, color: AppColors.gold, size: 18),
            const SizedBox(width: 8),
            Text(
              AppStrings.buttonClear,
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