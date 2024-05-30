import 'package:chat_test/controller/controller_auth.dart';
import 'package:chat_test/view/common_widgets/widget_button.dart';
import 'package:chat_test/view/common_widgets/widget_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAuth extends StatelessWidget {
  ScreenAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
        leading: Container(),
      ),
      body: _body(context),
    );
  }

  /// ~~~~~~~~~~~~ BODY ~~~~~~~~~~~~ ///
  _body(BuildContext context) {
    return Consumer<ControllerAuth>(
      builder: ((context, providerValues, child) => Container(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  providerValues.screenTitle,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),

                /// EMAIL TEXT FIELD
                WidgetTextField(
                  controller: providerValues.emailController,
                  marginVertical: 8.0,
                  hint: "Email",
                ),

                /// PASSWORD TEXT FIELD
                WidgetTextField(
                  controller: providerValues.passwordController,
                  marginVertical: 8.0,
                  isObscure: true,
                  hint: "Password",
                ),

                /// BUTTON AUTHENTICATION
                Center(
                  child: WidgetButton(
                    onPressed: () {
                      providerValues.onAuthButtonPressed(context);
                    },
                    text: providerValues.screenTitle,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    isLoading: providerValues.isLoading,
                  ),
                ),

                const Spacer(),

                /// BUTTON TOGGLE AUTH METHOD
                WidgetButton(
                  onPressed: providerValues.onToggleAuthPressed,
                  text: providerValues.toggleButtonTitle,
                  color: Colors.transparent,
                  width: double.infinity,
                )
              ],
            ),
          )),
    );
  }
}
