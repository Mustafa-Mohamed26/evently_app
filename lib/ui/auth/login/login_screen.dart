import 'package:evently_app/l10n/app_localizations.dart';
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

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
    text: 'jdoe@ex.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
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
                        keyboardType: TextInputType.phone,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              //TODO: forget password
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
                        text: AppLocalizations.of(context)!.login_button,
                        backgroundColor: AppColors.primaryLight,
                        borderColorSide: AppColors.primaryLight,
                        onPressed: () {
                          //TODO: login
                          login();
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.login_account,
                            style: AppStyles.medium16Black,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.registerRouteName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login_create,
                              style: AppStyles.bold16Primary.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.primaryLight,
                              indent: width * 0.05,
                              endIndent: width * 0.05,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.login_or,
                            style: AppStyles.bold16Primary,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: AppColors.primaryLight,
                              indent: width * 0.05,
                              endIndent: width * 0.05,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login_google,
                        backgroundColor: AppColors.transparentColor,
                        borderColorSide: AppColors.primaryLight,
                        mainAxisAlignment: MainAxisAlignment.center,
                        hasIcon: true,
                        iconWidget: Image.asset(AppAssets.google),
                        textStyle: AppStyles.medium20Primary,
                        onPressed: () {
                          //TODO: login with google
                        },
                      ),
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

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //TODO: login
      //TODO: show loading
      DialogUtils.showLoading(context: context, loadingText: 'Loading...');
      try {
        //TODO: sign in firebase auth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //TODO: read user from fireStore
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return;
        }
        //TODO: save user in provder
        
        var userProvider = Provider.of<UserProvider>(context, listen: false); // provider only once
        userProvider.updateUser(user);

        var eventListProvider = Provider.of<EventListProvider>(context, listen: false); // provider only once
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getAllFavoriteEventFromFireStore(userProvider.currentUser!.id);

        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: 'Login success',
          title: 'Success',
          posActionName: 'OK',
          posAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRouteName,
            (_) => false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
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
}
