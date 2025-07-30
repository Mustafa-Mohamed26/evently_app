import 'package:colorful_iconify_flutter/icons/circle_flags.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/my_user.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/widgets/custom_elevated_button.dart';
import 'package:evently_app/ui/widgets/custom_switch.dart';
import 'package:evently_app/ui/widgets/custom_text_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers
  // TextEditingController for email and password fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // GlobalKey for the form state
  // This key is used to validate the form inputs
  var formKey = GlobalKey<FormState>();

  // Variable to track if the password is visible
  // This is used to toggle the visibility of the password field
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(
      context,
    ).size.width; // Get the width of the screen
    var height = MediaQuery.of(
      context,
    ).size.height; // Get the height of the screen

    // Get the current app language from the provider
    // This is used to determine the initial state of the language switch
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    bool isEnglish = languageProvider.appLanguage == 'en';

    // Get the current app theme from the provider
    var themeProvider = Provider.of<AppThemeProvider>(context);

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

                // Form widget for email and password inputs
                // This form contains two text fields for email and password
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // CustomTextField for email input
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        colorBorderSide:
                            themeProvider.appTheme == ThemeMode.light
                            ? AppColors.greyColor
                            : AppColors.primaryLight,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                        hintStyle: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Gray
                            : AppStyles.medium16White,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          size: 30,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.whiteColor,
                        ),
                        hintText: AppLocalizations.of(context)!.login_email,

                        // Validate the email input
                        // Check if the email is empty or not valid
                        validate: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.login_empty_email;
                          }
                          final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(text);
                          if (!emailValid) {
                            return AppLocalizations.of(
                              context,
                            )!.login_valid_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      // CustomTextField for password input
                      CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        colorBorderSide:
                            themeProvider.appTheme == ThemeMode.light
                            ? AppColors.greyColor
                            : AppColors.primaryLight,
                        style: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Black
                            : AppStyles.medium16White,
                        hintStyle: themeProvider.appTheme == ThemeMode.light
                            ? AppStyles.medium16Gray
                            : AppStyles.medium16White,
                        obscureText: !isPasswordVisible,
                        obscuringCharacter: "*",
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 30,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.whiteColor,
                        ),
                        hintText: AppLocalizations.of(context)!.login_password,

                        // Suffix icon for toggling password visibility
                        // This icon will change based on the isPasswordVisible state
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.greyColor
                                : AppColors.whiteColor,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),

                        // Validate the password input
                        // Check if the password is empty or less than 6 characters
                        validate: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.login_empty_password;
                          }
                          if (text.length < 6) {
                            return AppLocalizations.of(
                              context,
                            )!.login_6_characters;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // TextButton for "Forget Password"
                          // This button is used to navigate to the forget password screen
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
                      // CustomElevatedButton for login action
                      // This button is used to trigger the login function
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login_button,
                        backgroundColor: AppColors.primaryLight,
                        borderColorSide: AppColors.primaryLight,
                        onPressed: () {
                          login();
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      // Row for account creation link
                      // This row contains a text and a button to navigate to the registration screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.login_account,
                            style: themeProvider.appTheme == ThemeMode.light
                                ? AppStyles.medium16Gray
                                : AppStyles.medium16White,
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
                      // Divider with "Or" text in the middle
                      // This divider separates the login form from the Google login button
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
                      // CustomElevatedButton for Google login
                      // This button is used to trigger the Google login function
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login_google,
                        backgroundColor: AppColors.transparentColor,
                        borderColorSide: AppColors.primaryLight,
                        mainAxisAlignment: MainAxisAlignment.center,
                        hasIcon: true,
                        iconWidget: Image.asset(AppAssets.google),
                        textStyle: AppStyles.medium20Primary,
                        onPressed: () {
                          loginWithGoogle();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomSwitch(
                  value: isEnglish,
                  onToggle: (val) {
                    if (val) {
                      languageProvider.changeLanguage('en');
                    } else {
                      languageProvider.changeLanguage('ar');
                    }
                  },
                  activeIcon: Iconify(CircleFlags.lr),
                  inactiveIcon: Iconify(CircleFlags.eg),
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
      // Show loading dialog while signing in
      // This dialog will be dismissed after the login process is complete
      DialogUtils.showLoading(
        context: context,
        loadingText: AppLocalizations.of(context)!.loading_login,
      );
      try {
        // Sign in with email and password
        // This uses FirebaseAuth to authenticate the user
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              // Firebase authentication method for email and password
              email: emailController.text,
              password: passwordController.text,
            );
        // Check if the credential or user is null
        // If the user is null, it means the login failed
        var user = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );
        if (user == null) {
          return;
        }
        // If the user exists, update the user provider with the user data
        // This will allow the app to access the user data throughout the app
        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        ); // provider only once
        userProvider.updateUser(user);

        // Get the event list provider to update the event list
        // This will fetch the user's favorite events from Firestore
        var eventListProvider = Provider.of<EventListProvider>(
          context,
          listen: false,
        ); // provider only once
        // Change the selected index to 0 (home tab) and fetch favorite events
        // This will update the UI to show the user's favorite events
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        // Fetch all favorite events from Firestore
        // This will populate the event list with the user's favorite events
        eventListProvider.getAllFavoriteEventFromFireStore(
          userProvider.currentUser!.id,
        );

        // Hide the loading dialog after successful login
        // Show a success message and navigate to the home screen
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.login_success,
          title: AppLocalizations.of(context)!.login_success_title,
          posActionName: AppLocalizations.of(context)!.login_success_action,
          posAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRouteName,
            (_) => false,
          ),
        );
        // If the login fails, hide the loading dialog and show an error message
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.error_invalid_credential,
            title: AppLocalizations.of(context)!.error_title,
            posActionName: AppLocalizations.of(context)!.login_success_action,
            posAction: () => Navigator.pop(context),
          );
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.error_no_internet,
            title: AppLocalizations.of(context)!.error_title,
            posActionName: AppLocalizations.of(context)!.login_success_action,
            posAction: () => Navigator.pop(context),
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: AppLocalizations.of(context)!.error_title,
          posActionName: AppLocalizations.of(context)!.login_success_action,
        );
      }
    }
  }

  void loginWithGoogle() async {
    // Show loading dialog
    DialogUtils.showLoading(
      context: context,
      loadingText: AppLocalizations.of(context)!.loading_google,
    );

    try {
      // Sign in with Google
      final credential = await FirebaseUtils.signInWithGoogle();

      // Check if credential or user is null (shouldn't happen with current FirebaseUtils)
      if (credential.user == null) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.google_login_cancelled,
          title: AppLocalizations.of(context)!.error_title,
          posActionName: AppLocalizations.of(context)!.login_success_action,
        );
        return;
      }

      // Read user from Firestore
      var user = await FirebaseUtils.readUserFromFireStore(
        credential.user!.uid,
      );

      // If user doesn't exist in Firestore, create it
      if (user == null) {
        final newUser = MyUser(
          id: credential.user!.uid,
          email: credential.user!.email ?? '',
          name: credential.user!.displayName ?? 'No Name',
        );
        await FirebaseUtils.addUserToFirestore(newUser);
        user = newUser;
      }

      // Save user to provider
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(user);

      var eventListProvider = Provider.of<EventListProvider>(
        context,
        listen: false,
      );
      eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
      eventListProvider.getAllFavoriteEventFromFireStore(
        userProvider.currentUser!.id,
      );

      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        context: context,
        barrierDismissible: false,
        message: AppLocalizations.of(context)!.google_login_success,
        title: AppLocalizations.of(context)!.login_success_title,
        posActionName: AppLocalizations.of(context)!.login_success_action,
        posAction: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeRouteName,
          (_) => false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        context: context,
        barrierDismissible: false,
        message: e.message ?? AppLocalizations.of(context)!.error_firebase,
        title: AppLocalizations.of(context)!.error_title,
        posActionName: AppLocalizations.of(context)!.login_success_action,
        posAction: () => Navigator.pop(context),
      );
    } catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
        context: context,
        barrierDismissible: false,
        message: e.toString(),
        title: AppLocalizations.of(context)!.error_title,
        posActionName: AppLocalizations.of(context)!.login_success_action,
        posAction: () => Navigator.pop(context),
      );
    }
  }
}
