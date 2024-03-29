import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gncms_clone/getX/controllers/login_controller.dart';
import 'package:gncms_clone/getX/controllers/main_controller.dart';
import '../../constants.dart';
import '../../custom_widgets/custom_radio_button.dart';
import '../route/app_routes.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/components/app_text_form_field.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../utils/resources/resources.dart';
import '../values/app_constants.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final MainController mainController = Get.find();
  late final LoginController loginController;
  @override
  void initState() {
    super.initState();
    loginController = mainController.loginController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientBackground(
            children: [
              Text(
                AppStrings.signInToYourNAccount,
                style: AppTheme.titleLarge,
              ),
              SizedBox(height: 6),
              Text(AppStrings.signInToYourAccount, style: AppTheme.bodySmall),
            ],
          ),
          Form(
            key: loginController.getFormKey(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRadioButton(
                            character: mainController.currentUser.value,
                            title: UserType.teacher.name,
                            value: UserType.teacher,
                            onChanged: (UserType? value) {
                              mainController.currentUser.value = value!;
                            },
                          ),
                          CustomRadioButton(
                            character: mainController.currentUser.value,
                            title: UserType.student.name,
                            value: UserType.student,
                            onChanged: (UserType? value) {
                              mainController.currentUser.value = value!;
                            },
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    controller: loginController.emailController,
                    labelText: AppStrings.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) =>
                        loginController.getFormKey().currentState?.validate(),
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
                      obscureText: loginController.passwordNotifier.value =
                          false,
                      controller: loginController.passwordController,
                      labelText: AppStrings.password,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (_) =>
                          loginController.getFormKey().currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterPassword
                            : AppConstants.passwordRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidPassword;
                      },
                      suffixIcon: IconButton(
                        onPressed: () => loginController.passwordNotifier
                            .value = !loginController.passwordNotifier.value,
                        style: IconButton.styleFrom(
                          minimumSize: const Size.square(48),
                        ),
                        icon: Icon(
                          loginController.passwordNotifier.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(AppStrings.forgotPassword),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => FilledButton(
                      onPressed: loginController.fieldValidNotifier.value
                          ? () async {
                              await loginController.signIn();
                            }
                          : null,
                      child: const Text(AppStrings.login),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade200)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppStrings.orLoginWith,
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade200)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            SnackBarHelper.showSnackBar(
                              message: "spandan how are you",
                            );
                            print("there is a snack bar");
                          },
                          icon: SvgPicture.asset(Vectors.google, width: 14),
                          label: const Text(
                            AppStrings.google,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(Vectors.facebook, width: 14),
                          label: const Text(
                            AppStrings.facebook,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doNotHaveAnAccount,
                style: AppTheme.bodySmall.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 4),
              TextButton(
                //onPressed: () => Get.toNamed(AppRoutes.getRegisterRoute()),
                onPressed: () => SnackBarHelper.showSnackBar(
                    title: "Sorry",
                    message: "Registration is done by administration",
                    contentType: ContentType.warning),
                child: const Text(AppStrings.register),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
