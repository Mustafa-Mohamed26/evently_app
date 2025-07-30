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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for the text fields
  // These controllers will hold the input values for name, email, password, and re-password
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
  // Global key for the form state
  // This key is used to validate the form and access its state
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // State variables for password visibility
  // These variables control whether the password and re-password fields are visible or hidden
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Get the current app language from the provider
    // This is used to determine the initial state of the language switch
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    bool isEnglish = languageProvider.appLanguage == 'en';

    // Get the current app theme from the provider
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      // AppBar with transparent background
      // The icon theme color changes based on the app theme
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.light
              ? AppColors.blackColor
              : AppColors.primaryLight,
        ),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.register_Title,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.bold20Black
              : AppStyles.bold20primary,
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
                    // Custom text field for name input
                    // This field includes validation to ensure the name is not empty
                    CustomTextField(
                      controller: nameController,
                      colorBorderSide: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.greyColor
                          : AppColors.primaryLight,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? AppStyles.medium16Black
                          : AppStyles.medium16White,
                      hintStyle: themeProvider.appTheme == ThemeMode.light
                          ? AppStyles.medium16Gray
                          : AppStyles.medium16White,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 30,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                      ),
                      hintText: AppLocalizations.of(context)!.register_name,
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.register_empty_name;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    // Custom text field for email input
                    // This field includes validation to ensure the email is not empty and is in a valid format
                    CustomTextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      colorBorderSide: themeProvider.appTheme == ThemeMode.light
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
                    // Custom text field for password input
                    // This field includes validation to ensure the password is not empty and has at least 6 characters
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      colorBorderSide: themeProvider.appTheme == ThemeMode.light
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
                    // Custom text field for re-entering password
                    // This field includes validation to ensure the re-password matches the password and is not empty
                    CustomTextField(
                      controller: rePasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      colorBorderSide: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.greyColor
                          : AppColors.primaryLight,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? AppStyles.medium16Black
                          : AppStyles.medium16White,
                      hintStyle: themeProvider.appTheme == ThemeMode.light
                          ? AppStyles.medium16Gray
                          : AppStyles.medium16White,
                      obscureText: !isRePasswordVisible,
                      obscuringCharacter: "*",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.greyColor
                            : AppColors.whiteColor,
                      ),
                      hintText: AppLocalizations.of(
                        context,
                      )!.register_rePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isRePasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.greyColor
                              : AppColors.whiteColor,
                        ),
                        onPressed: () {
                          setState(() {
                            isRePasswordVisible = !isRePasswordVisible;
                          });
                        },
                      ),
                      validate: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.register_empty_repassword;
                        }
                        if (text.length < 6) {
                          return AppLocalizations.of(
                            context,
                          )!.login_6_characters;
                        }
                        if (passwordController.text != text) {
                          return AppLocalizations.of(
                            context,
                          )!.register_password_not_match;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.02),
                    // Custom elevated button for registration
                    // This button will trigger the registration process when pressed
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.register_button,
                      backgroundColor: AppColors.primaryLight,
                      borderColorSide: AppColors.primaryLight,
                      onPressed: () {
                        register();
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    // Row with text and button to navigate to login screen
                    // This row allows users to switch to the login screen if they already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.register_have,
                          style: themeProvider.appTheme == ThemeMode.light
                              ? AppStyles.medium16Gray
                              : AppStyles.medium16White,
                        ),
                        TextButton(
                          onPressed: () {
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
                    // Custom switch for language
                    // This switch allows users to change the app language between English and Arabic
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
            ],
          ),
        ),
      ),
    );
  }

  /// Function to handle user registration
  /// This function validates the form inputs and attempts to create a user with email and password
  void register() async {
    if (formKey.currentState!.validate()) {
      // Show loading dialog while registering
      // This dialog will be dismissed once the registration is complete
      DialogUtils.showLoading(
        context: context,
        loadingText: AppLocalizations.of(context)!.register_loading,
      );

      // Attempt to create a user with email and password
      // If successful, the user will be added to Firestore and the app will navigate to the home screen
      // If there is an error, an appropriate message will be shown to the user
      try {
        // Create user with email and password using FirebaseAuth
        // This will return a UserCredential object containing the user's information
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              // Firebase authentication method for email and password
              email: emailController.text,
              password: passwordController.text,
            );
        // Create a MyUser object with the user's information
        // This object will be used to store user data in Firestore
        MyUser myUser = MyUser(
          id: credential.user!.uid,
          name: nameController.text,
          email: emailController.text,
        );
        // Add the user to Firestore using FirebaseUtils
        await FirebaseUtils.addUserToFirestore(myUser);

        // Update the user provider with the new user
        // This will allow the app to access the current user's information throughout the app
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);

        // If the event list is empty, fetch all events from Firestore
        // This ensures that the app has the latest events available for the user
        var eventListProvider = Provider.of<EventListProvider>(
          context,
          listen: false,
        );

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
          message: AppLocalizations.of(context)!.register_success,
          title: AppLocalizations.of(context)!.register_success_title,
          posActionName: AppLocalizations.of(context)!.register_success_ok,
          posAction: () => Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homeRouteName,
            (_) => false,
          ),
        );

      // Catch any FirebaseAuthException errors that occur during registration
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context: context);

        // Show appropriate error messages based on the error code
        // These messages will inform the user about the specific issue that occurred
        if (e.code == 'weak-password') {
          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_weak_password,
            title: AppLocalizations.of(context)!.register_error_title,
            posActionName: AppLocalizations.of(context)!.register_success_ok,
            posAction: () => Navigator.pop(context),
          );

        // If the email is already in use, show a message to the user
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_email_exists,
            title: AppLocalizations.of(context)!.register_error_title,
            posActionName: AppLocalizations.of(context)!.register_success_ok,
            posAction: () => Navigator.pop(context),
          );

        // If there is a network request failure, show a message to the user
        } else if (e.code == 'network-request-failed') {
          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_no_internet,
            title: AppLocalizations.of(context)!.register_error_title,
            posActionName: AppLocalizations.of(context)!.register_success_ok,
            posAction: () => Navigator.pop(context),
          );
        }

      // Catch any other errors that occur during registration
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: AppLocalizations.of(context)!.register_error_title,
          posActionName: AppLocalizations.of(context)!.register_success_ok,
        );
      }
    }
  }
}
