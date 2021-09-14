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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends AuthState<SignUpPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;

  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();

    _authController.signUpPassword.value = "";

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
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackButton(),
                const SizedBox(height: 48),
                Text(
                  "Ready to join",
                  style: Get.textTheme.headline2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Glad to see you join our gang, please fill the required field below",
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
                  action: TextInputAction.next,
                  validators: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 8),
                  ]),
                  onChanged: (value) {
                    _authController.signUpPassword.value = value ?? "";
                  },
                ),
                const SizedBox(height: 24),
                Obx(
                  () => AppTextField(
                    controller: _repeatPasswordController,
                    obscureText: true,
                    prefixIcon: Icon(
                      Ionicons.key_sharp,
                      size: 20,
                      color: AppColor.white.withOpacity(0.3),
                    ),
                    name: "repeat-password",
                    hintText: "Repeat Password",
                    keyboardType: TextInputType.visiblePassword,
                    validators: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 8),
                      FormBuilderValidators.equal(
                        context,
                        _authController.signUpPassword.value,
                        errorText: "Repeat password must match the password",
                      ),
                    ]),
                    onChanged: null,
                  ),
                ),
                const SizedBox(height: 48),
                FilledButton(
                  text: "Sign Up",
                  textColor: AppColor.black,
                  backgroundColor: AppColor.white,
                  onPressed: () {
                    _formKey.currentState?.save();

                    if (_formKey.currentState!.validate()) {
                      //  call sign in method
                      final emailValue = _formKey.currentState?.value["email"];
                      final passwordValue =
                          _formKey.currentState?.value["password"];

                      _authController.signUpWithEmailAndPassword(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
