import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/sign_in_provider.dart';
import '../../routes/routes.dart';
import '../../utils/constants_util.dart';
import '../../widgets/labeled_text_form_field.dart';
import '../../widgets/wave_header.dart';
import '../login/widgets/social_login_widget.dart';
import 'widgets/footer_signup.dart';

class SignupView extends StatefulWidget {
  final String? tag;
  const SignupView({super.key, this.tag});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool showProgress = false;
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? name;
  String? phone;
  String? password;

  void handleSignUp() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      // Simulate saving user data
      String staticEmail = "${phone!.trim().split(" ").join("")}@example.com";

      // Store user data statically (you can modify this to save to a local database or similar)
      print(
          "Name: $name, Phone: $phone, Email: $staticEmail, Password: $password");

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User signed up with email: $staticEmail'),
      ));

      // Navigate to home
      Navigator.of(context).popAndPushNamed(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    WaveHeader(
                      title: 'sign_up'.tr(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Expanded(child: SizedBox(height: 10)),
                            Center(
                              child: Text(
                                'create_an_account_to_get_started'.tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    LabeledTextFormField(
                                      title: 'last_name'.tr(),
                                      controller: _nameController,
                                      hintText: '',
                                      validator: (value) => value!.isEmpty
                                          ? 'error.name'.tr()
                                          : null,
                                      onChanged: (value) => name = value,
                                    ),
                                    LabeledTextFormField(
                                      title: 'numero_telephone'.tr(),
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      hintText: '',
                                      validator: (value) => value!.isEmpty
                                          ? "error.phone.required".tr()
                                          : null,
                                      onChanged: (value) => phone = value,
                                    ),
                                    LabeledTextFormField(
                                      title: 'password'.tr(),
                                      controller: _passwordController,
                                      obscureText: true,
                                      validator: (value) => value!.isEmpty
                                          ? 'error.password.required'.tr()
                                          : null,
                                      onChanged: (value) => password = value,
                                      hintText: '* * * * * *',
                                      padding: 20,
                                    ),
                                    LabeledTextFormField(
                                      title: 'confirm_password'.tr(),
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      validator: (value) => value != password
                                          ? 'error.password.match'.tr()
                                          : null,
                                      hintText: '* * * * * *',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: kColorPrimary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              height: 45,
                              child: showProgress
                                  ? const Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                            color: kColorLight),
                                      ),
                                    )
                                  : TextButton(
                                      child: Text(
                                        'sign_up'.tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        handleSignUp();
                                      },
                                    ),
                            ),
                            const SignupFooter(),
                            const SizedBox(height: 5),
                            if (Platform.isAndroid)
                              SocialLoginWidget(
                                onTap: () {
                                  // Handle Google sign-in
                                },
                              ),
                            const Expanded(child: SizedBox(height: 20)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
