import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/my_user.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void register() async {
    if (formKey.currentState!.validate()) {
      DialogUtils.showLoading(context: context, loadingText: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        MyUser myUser = MyUser(
          id: credential.user!.uid,
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFirestore(myUser);
        //TODO: save user in provder
        
        var userProvider = Provider.of<UserProvider>(context, listen: false); // provider only once
        userProvider.updateUser(myUser);

        var eventListProvider = Provider.of<EventListProvider>(context, listen: false); // provider only once
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getAllFavoriteEventFromFireStore(userProvider.currentUser!.id);

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: 'Registration success',
          title: 'Success',
          posActionName: 'OK',
          posAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRouteName,
            (_) => false,
          ),
        );
        print('register success');
        print('id: ${credential.user!.uid}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email. Please login',
            title: 'Error',
            posActionName: 'OK',
            posAction: () => Navigator.pop(context),
          );
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: 'No internet connection',
            title: 'Error',
            posActionName: 'OK',
            posAction: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'OK',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteBgColor,
        iconTheme: IconThemeData(color: AppColors.blackColor),
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
