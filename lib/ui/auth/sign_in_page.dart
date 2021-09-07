import 'package:chirp/controller/auth/auth_controller.dart';
import 'package:chirp/controller/auth/auth_states.dart';
import 'package:chirp/ui/core/widgets/buttons.dart';
import 'package:chirp/ui/core/widgets/snackbars.dart';
import 'package:chirp/ui/core/widgets/textfields.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends AuthState<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                const SizedBox(height: 48),
                Text(
                  "Let\'s jump in",
                  style: Get.textTheme.headline2,
                ),
                const SizedBox(height: 8),
                Text(
                  "People need to know you first before start a conversation",
                  style: Get.textTheme.bodyText2,
                ),
                const SizedBox(height: 48),
                AppTextField(
                  controller: _emailController,
                  prefixIcon: Icon(
                    Ionicons.mail_outline,
                    size: 20,
                    color: AppColor.white.withOpacity(0.3),
                  ),
                  name: "email",
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  action: TextInputAction.next,
                  validators: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                  onChanged: null,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _passwordController,
                  obscureText: true,
                  prefixIcon: Icon(
                    Ionicons.key_outline,
                    size: 20,
                    color: AppColor.white.withOpacity(0.3),
                  ),
                  name: "password",
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  validators: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 8),
                  ]),
                  onChanged: null,
                ),
                const SizedBox(height: 48),
                FilledButton(
                  text: "Sign In",
                  textColor: AppColor.black,
                  backgroundColor: AppColor.white,
                  onPressed: () {
                    _formKey.currentState?.save();

                    if (_formKey.currentState!.validate()) {
                      //  call sign in method
                      final emailValue = _formKey.currentState?.value["email"];
                      final passwordValue =
                          _formKey.currentState?.value["password"];

                      _authController.signInWithEmailAndPassword(
                        email: emailValue,
                        password: passwordValue,
                      );
                    } else {
                      //  show invalid snackbar
                      Get.showSnackbar(
                        Snackbars.appSnackbar(
                          title: "Invalid field values",
                          message: "Please input valid value in the fields",
                          type: SnackbarType.ERROR,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                BorderedButton(
                  text: "Google",
                  color: AppColor.white,
                  onPressed: () {
                    //  Logging in with google
                    _authController.signInWithGoogle();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
