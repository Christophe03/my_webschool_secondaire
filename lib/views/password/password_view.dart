// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_webschool_secondaire/utils/snacbar.dart';

import '../../providers/sign_in_provider.dart';
import '../../routes/routes.dart';
import '../../utils/constants_util.dart';
import '../../utils/dialog.dart';
import '../../widgets/text_form_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PasswordView extends StatefulWidget {
  final String? tag;
  const PasswordView({super.key, this.tag});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailCtrl = TextEditingController();
  String? _email;

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  afterSignIn() {
    if (widget.tag == null) {
      Navigator.of(context).popAndPushNamed(Routes.login);
    } else {
      Navigator.pop(context);
    }
  }

  void handleSubmit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      resetPassword(_email ?? '');
    } else {
      _btnController1.reset();
    }
  }

  Future<void> resetPassword(String email) async {
    // Simulate a delay to represent sending a reset email
    await Future.delayed(Duration(seconds: 2));

    // Here you can check if the email is static or from your own user list
    if (email == 'test@example.com') {
      _btnController1.success();
      openDialogWithDoubleClose(context, 'reset password'.tr(),
          'message sent to email'.tr(namedArgs: {'email': email}));
    } else {
      _btnController1.reset();
      openSnacbar(
          context, 'l.adresse.email.n.est.pas.associer.a.un.compte'.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10),
                child: RichText(
                    text: TextSpan(
                  text: "mot de passe oublie".tr(),
                  style: const TextStyle(
                    color: kColorDark,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                )),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "entrer l'email associe a votre compte".tr(),
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'email'.tr(), labelText: 'votre.email'.tr()),
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.length == 0) return "Email can't be empty".tr();
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RoundedLoadingButton(
                successIcon: Icons.done,
                failedIcon: Icons.error,
                height: 45,
                width: MediaQuery.of(context).size.width,
                elevation: 0,
                borderRadius: 0,
                color: kColorPrimary,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'envoyer'.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500))),
                controller: _btnController1,
                onPressed: () {
                  handleSubmit();
                },
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
