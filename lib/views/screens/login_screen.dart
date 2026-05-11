import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prayer_box_flutter/routes/app_pages.dart';
import 'package:prayer_box_flutter/core/theme/app_theme.dart';
import 'package:prayer_box_flutter/core/utils/validators.dart';
import 'package:prayer_box_flutter/core/theme/app_colors.dart';
import 'package:prayer_box_flutter/core/responsive/app_responsive.dart';
import 'package:prayer_box_flutter/core/constants/app_strings.dart';
import 'package:prayer_box_flutter/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;

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
                    mobile: 48,
                    tablet: 64,
                    desktop: 80,
                  )
                ),

                // Header
                _header(context),
                const SizedBox(height: 40),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      _emailField(context),
                      const SizedBox(height: 16),

                      // Password
                      _passwordField(context),
                      const SizedBox(height: 8),

                      // Reactive error message
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

                      // login button
                      _loginButton(context),
                      const SizedBox(height: 16),

                      // nav to sign up
                      _signUpLink(context),
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
        Divider(color: AppColors.chambray.withOpacity(0.4)),
        const SizedBox(height: 12),
        Text(
          AppStrings.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.espresso,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.loginSubtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.clay,
              ),
        ),
      ],
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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.espresso,
                ),
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
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.espresso,
                    ),
                decoration: InputDecoration(
                  hintText: 'Enter your password...',
                  suffixIcon: GestureDetector(
                    onTap: () => _obscurePassword.value = !_obscurePassword.value,
                    child: Icon(
                      _obscurePassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.clay,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) => Validators.validateRequired(
                  value,
                  fieldName: 'Password',
                ),
              )),
        ],
      ),
    );
  }

  // LOGIN BUTTON
  Widget _loginButton(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: _authController.isLoading.value
              ? null
              : () async {
                if (_formKey.currentState!.validate()) {
                  await _authController.login(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
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
                      AppStrings.loginButton,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.espresso,
                          ),
                  ),
            ),
          ),
        ));
  }

  // SIGN UP LINK
  Widget _signUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.loginNoAccount,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.clay,
              ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.signUp),
          child: Text(
            AppStrings.loginSignUpLink,
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
