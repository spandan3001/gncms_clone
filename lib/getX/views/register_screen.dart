import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';

import '../controllers/register_controller.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/components/app_text_form_field.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_constants.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final MainController mainController = Get.find();
  late final RegisterController registerController;

  @override
  void initState() {
    super.initState();
    registerController = mainController.registerController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const GradientBackground(
            children: [
              Text(AppStrings.register, style: AppTheme.titleLarge),
              SizedBox(height: 6),
              Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: registerController.getFormKey(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    autofocus: true,
                    labelText: AppStrings.name,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => registerController
                        .getFormKey()
                        .currentState
                        ?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterName
                          : value.length < 4
                              ? AppStrings.invalidName
                              : null;
                    },
                    controller: registerController.nameController,
                  ),
                  AppTextFormField(
                    labelText: AppStrings.email,
                    controller: registerController.emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => registerController
                        .getFormKey()
                        .currentState
                        ?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? AppStrings.pleaseEnterEmailAddress
                          : AppConstants.emailRegex.hasMatch(value)
                              ? null
                              : AppStrings.invalidEmailAddress;
                    },
                  ),
                  Obx(
                    () => AppTextFormField(
                      obscureText: registerController.passwordNotifier.value,
                      controller: registerController.passwordController,
                      labelText: AppStrings.password,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (_) => registerController
                          .getFormKey()
                          .currentState
                          ?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterPassword
                            : AppConstants.passwordRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidPassword;
                      },
                      suffixIcon: Focus(
                        /// If false,
                        ///
                        /// disable focus for all of this node's descendants
                        descendantsAreFocusable: false,

                        /// If false,
                        ///
                        /// make this widget's descendants un-traversable.
                        // descendantsAreTraversable: false,
                        child: IconButton(
                          onPressed: () =>
                              registerController.passwordNotifier.value =
                                  !registerController.passwordNotifier.value,
                          style: IconButton.styleFrom(
                            minimumSize: const Size.square(48),
                          ),
                          icon: Icon(
                            registerController.passwordNotifier.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() => AppTextFormField(
                        labelText: AppStrings.confirmPassword,
                        controller:
                            registerController.confirmPasswordController,
                        obscureText: registerController.passwordNotifier.value,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => registerController
                            .getFormKey()
                            .currentState
                            ?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseReEnterPassword
                              : AppConstants.passwordRegex.hasMatch(value)
                                  ? registerController
                                              .passwordController.text ==
                                          registerController
                                              .confirmPasswordController.text
                                      ? null
                                      : AppStrings.passwordNotMatched
                                  : AppStrings.invalidPassword;
                        },
                        suffixIcon: Focus(
                          /// If false,
                          ///
                          /// disable focus for all of this node's descendants.
                          descendantsAreFocusable: false,

                          /// If false,
                          ///
                          /// make this widget's descendants un-traversable.
                          // descendantsAreTraversable: false,
                          child: IconButton(
                            onPressed: () => registerController
                                    .confirmPasswordNotifier.value =
                                !registerController
                                    .confirmPasswordNotifier.value,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              registerController.confirmPasswordNotifier.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )),
                  Obx(() => FilledButton(
                        onPressed: registerController.fieldValidNotifier.value
                            ? () {
                                SnackbarHelper.showSnackBar(
                                  AppStrings.registrationComplete,
                                );
                                registerController.nameController.clear();
                                registerController.emailController.clear();
                                registerController.passwordController.clear();
                                registerController.confirmPasswordController
                                    .clear();
                              }
                            : null,
                        child: const Text(AppStrings.register),
                      ))
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.iHaveAnAccount,
                style: AppTheme.bodySmall.copyWith(color: Colors.black),
              ),
              TextButton(
                onPressed: () => NavigationHelper.pushReplacementNamed(
                  AppRoutes.login,
                ),
                child: const Text(AppStrings.login),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
