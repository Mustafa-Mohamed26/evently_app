import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'jdoe@ex.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  final TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void register() {
    if (formKey.currentState!.validate()) {
      //TODO: register logic
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeRouteName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBgColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.register_Title,
          style: AppStyles.bold16Black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.authLogo, height: height * 0.2),
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: nameController,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.greyColor,
                      ),
                      hintText: AppLocalizations.of(context)!.register_name,
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter your name'; //TODO: localization
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        size: 30,
                        color: AppColors.greyColor,
                      ),
                      hintText: AppLocalizations.of(context)!.login_email,
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter your email'; //TODO: localization
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", //TODO: localization
                        ).hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter a valid email'; //TODO: localization
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      obscuringCharacter: "*",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                        color: AppColors.greyColor,
                      ),
                      hintText: AppLocalizations.of(context)!.login_password,
                      suffixIcon: Image.asset(AppAssets.hideEyePassword),
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter your password'; //TODO: localization
                        }
                        if (text.length < 6) {
                          return 'Password must be at least 6 characters'; //TODO: localization
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextField(
                      controller: rePasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      obscuringCharacter: "*",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                        color: AppColors.greyColor,
                      ),
                      hintText: AppLocalizations.of(
                        context,
                      )!.register_rePassword,
                      suffixIcon: Image.asset(AppAssets.hideEyePassword),
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter your password again'; //TODO: localization
                        }
                        if (text.length < 6) {
                          return 'Password must be at least 6 characters'; // TODO: localization
                        }
                        if (passwordController.text != text) {
                          return 'Passwords do not match'; // TODO: localization
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            // TODO: forget password action
                          },
                          child: Text(
                            '${AppLocalizations.of(context)!.login_forget}?',
                            style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.register_button,
                      backgroundColor: AppColors.primaryLight,
                      borderColorSide: AppColors.primaryLight,
                      onPressed: () {
                        register();
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.register_have}?',
                          style: AppStyles.medium16Black,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: navigate to login
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.register_login,
                            style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
