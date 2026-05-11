import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prayer_box_flutter/controllers/auth_controller.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/routes/app_routes.dart';
import 'package:prayer_box_flutter/core/utils/validators.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveContainer(
          child: SingleChildScrollView(
            padding: AppResponsive.screenPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: AppResponsive.value<double>(
                    context,
                    mobile: 32,
                    tablet: 48,
                    desktop: 64,
                  ),
                ),

                _header(context),
                const SizedBox(height: 32),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _usernameField(context),
                      const SizedBox(height: 16),

                      _emailField(context),
                      const SizedBox(height: 16),

                      _passwordField(context),
                      const SizedBox(height: 16),

                      _confirmPasswordField(context),
                      const SizedBox(height: 16),

                      Obx(() {
                        if (_authController.errorMessage.value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            _authController.errorMessage.value,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.red.shade700),
                          ),
                        );
                      }),

                      const SizedBox(height: 24),

                      _signUpButton(context),
                      const SizedBox(height: 16),

                      _loginLink(context),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.appName.toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.espresso,
                letterSpacing: 3,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.appTagline,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.clay,
              ),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 12),
        Text(
          AppStrings.signUpTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.espresso,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.signUpSubtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.clay,
              ),
        ),
      ],
    );
  }

  // // FORM
  // Widget _formField({
  //   required BuildContext context,
  //   required String label,
  //   requried TextEditingController controller,
  //   required String hintText,
  //   required String? Function(String?) validator,
  //   TextInputAction textInputAction = TextInputAction.next,
  //   TextInputType keyboardType = TextInputType.text,
  //   bool obscure = false,
  //   VoidCallback? onToggleObscure,
  //   bool isObscured = false,
  // }) {
  //   return Container(
  //     decoration: AppTheme.widgetDecoration,
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           label,
  //           style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //                 color: AppColors.espresso,
  //                 letterSpacing: 2,
  //               ),
  //         ),
  //         const SizedBox(height: 10),
  //         TextFormField(
  //           controller: controller,
  //           obscureText: obscure,
  //           keyboardType: keyboardType,
  //           textInputAction: textInputAction,
  //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                 color: AppColors.espresso,
  //               ),
  //           decoration: InputDecoration(
  //             hintText: hint,
  //             suffixIcon: onToggleObscure != null
  //                 ? GestureDetector(
  //                     onTap: onToggleObscure,
  //                     child: Icon(
  //                       isObscured
  //                           ? Icons.visibility_outlined
  //                           : Icons.visibility_off_rounded,
  //                       color: AppColors.clay,
  //                       size: 20,
  //                     ),
  //                   )
  //                 : null,
  //           ),
  //           validator: validator,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // USERNAME FIELD
  Widget _usernameField(BuildContext context) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Username',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.espresso,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'Enter a username...',
            ),
            validator: (value) => Validators.validateRequired(
              value,
              fieldName: 'Username',
            ),
          ),
        ],
      ),
    );
  }

  // EMAIL FIELD
  Widget _emailField(BuildContext context) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.espresso,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: 'Enter your email address...',
            ),
            validator: (value) => Validators.validateRequired(
              value,
              fieldName: 'Email',
            ),
          ),
        ],
      ),
    );
  }

  // PASSWORD FIELD
  Widget _passwordField(BuildContext context) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.espresso,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 10),
          Obx(() => TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword.value,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Enter a password...',
                  suffixIcon: GestureDetector(
                    onTap: () => _obscurePassword.value = !_obscurePassword.value,
                    child: Icon(
                      _obscurePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.espresso,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required!';
                  }
                  if (value.trim().length < 6) {
                    return 'Password must be at least 6 characters.';
                  }
                  return null;
                },
              )),
        ],
      ),
    );
  }

  // CONFIRM PASSWORD FIELD
  Widget _confirmPasswordField(BuildContext context) {
    return Container(
      decoration: AppTheme.widgetDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Password',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.espresso,
                  letterSpacing: 2,
                ),
          ),
          const SizedBox(height: 10),
          Obx(() => TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword.value,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Confirm your password...',
                  suffixIcon: GestureDetector(
                    onTap: () => _obscureConfirmPassword.value = !_obscureConfirmPassword.value,
                    child: Icon(
                      _obscureConfirmPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.espresso,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please confirm your password.';
                  } 
                  if (value.trim() != _passwordController.text.trim()) {
                    return 'Passwords do not match.';
                  }
                  return null;
                }
              )),
        ],
      ),
    );
  }

  // SIGN UP BUTTON
  Widget _signUpButton(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: _authController.isLoading.value
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    await _authController.signUp(
                      username: _usernameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                }
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: _authController.isLoading.value
                ? AppTheme.buttonDecoration
                : AppTheme.primaryButtonDecoration,
            child: Center(
              child: _authController.isLoading.value
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.espresso,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    AppStrings.signUpButton,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.espresso,
                        ),
                ),
            ),
          ),
    ));
  }

  // LOGIN LINK
  Widget _loginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.signUpHaveAccount,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.clay,
              ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            AppStrings.signUpLoginLink,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.chambray,
                ),
          ),
        ),
      ],
    );
  }
}