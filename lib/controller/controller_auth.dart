import 'package:chat_test/model/repositories/repository_auth.dart';
import 'package:chat_test/utility/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerAuth extends ChangeNotifier {
  // SCREEN TYPE
  TypeAuthScreen screenType = TypeAuthScreen.signIn;

  // SCREEN TEXTs
  String screenTitle = "Sign In";
  String toggleButtonTitle = "Create Account";

  // EMAIL & PASSWORD CONTROLLER
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // LOADER
  bool isLoading = false;

  /// ~~~~~~~~~~~~ AUTHENTICATION ~~~~~~~~~~~~ ///
  onAuthButtonPressed(context) {
    // TOGGLE LOADER
    isLoading = true;
    notifyListeners();
    // AUTHENTICATE
    try {
      if (screenType == TypeAuthScreen.signIn) {
        // SIGN IN
        _signIn(context);
      } else {
        // SIGN UP
        _signUp(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// ~~~~~~~~~~~~ TOGGLE AUTHENTICATION FLOW ~~~~~~~~~~~~ ///
  onToggleAuthPressed() {
    if (screenType == TypeAuthScreen.signIn) {
      screenType = TypeAuthScreen.signUp;
      screenTitle = "Sign Up";
      toggleButtonTitle = "Already have an account? Sign In";
    } else {
      screenType = TypeAuthScreen.signIn;
      screenTitle = "Sign In";
      toggleButtonTitle = "Create account";
    }
    notifyListeners();
  }


  /// ~~~~~~~~~~~~ SIGN UP ~~~~~~~~~~~~ ///
  _signUp(context) async {
    var response = await RepositoryAuth().signUp(
        email: emailController.text.toString(),
        password: passwordController.text.toString());
    if (response == 200) {
      // SUCCESS, Navigate to ScreenChatRoom
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.routeScreenChatRoom, (route) => false);
    }else{
      showMessage(context: context, message: response, seconds: 3);
    }
    // TOGGLE LOADER
    isLoading = false;
    notifyListeners();
  }

  /// ~~~~~~~~~~~~ SIGN UP ~~~~~~~~~~~~ ///
  _signIn(context) async {
    var response = await RepositoryAuth().signUp(
        email: emailController.text.toString(),
        password: passwordController.text.toString());
    if (response == 200) {
      // SUCCESS, Navigate to ScreenChatRoom
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.routeScreenChatRoom, (route) => false);
    }else{
      showMessage(context: context, message: response, seconds: 3);
    }
    // TOGGLE LOADER
    isLoading = false;
    notifyListeners();
  }
}

///~~~~~~~~~~~~ SNACK BAR ~~~~~~~~~~~~///
showMessage(
    {required BuildContext context,
      required String message,
      required int seconds}) {
  double width = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.deepPurple.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: seconds),
      // margin: const EdgeInsets.all(16.0),
      width: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12.0),
      )));
}

enum TypeAuthScreen { signIn, signUp }
