import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants_util.dart';
import '../../../widgets/labeled_text_form_field.dart';

class LoginView extends StatefulWidget {
  final String? tag;
  const LoginView({super.key, this.tag});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _hasInternet = false;
  bool showProgress = false;
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final RoundedLoadingButtonController _emailButtonController =
      RoundedLoadingButtonController();

  bool signInStart = false;
  bool signInComplete = false;

  String? email;
  String? pass;

  void handleSignInWithEmailPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).requestFocus(FocusNode());

      // Simuler une connexion avec des données statiques
      setState(() {
        signInStart = true;
        showProgress = true;
      });

      await Future.delayed(
          Duration(seconds: 2)); // Simuler un délai pour la connexion

      // Vérification fictive des identifiants
      if (email == "test@example.com" && pass == "password") {
        // Connexion réussie
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connexion réussie !').tr(),
        ));
        // Vous pouvez naviguer vers une autre page ici
        afterSignIn();
      } else {
        // Échec de la connexion
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Identifiants invalides').tr(),
        ));
      }

      setState(() {
        signInStart = false;
        showProgress = false;
      });
    } else {
      _emailButtonController.reset();
      if (kDebugMode) {
        print('Erreur dans le formulaire');
      }
    }
  }

  afterSignIn() {
    if (widget.tag == null) {
      Navigator.of(context).popAndPushNamed(Routes.home);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                      child: Column(children: <Widget>[
                    // Votre en-tête ici (par exemple, WaveHeader)
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 38),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    child: SizedBox(
                                      height: 10,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'sign_in'.tr(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Form(
                                      key: formKey,
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                LabeledTextFormField(
                                                  title: 'email'.tr(),
                                                  controller: _emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  hintText: 'votre.email'.tr(),
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? "error.email.required"
                                                          .tr()
                                                      : null,
                                                  onChanged: (value) =>
                                                      email = value!.trim(),
                                                ),
                                                LabeledTextFormField(
                                                  title: 'password'.tr(),
                                                  controller:
                                                      _passwordController,
                                                  obscureText: true,
                                                  validator: (value) => value!
                                                          .isEmpty
                                                      ? 'error.password.required'
                                                          .tr()
                                                      : null,
                                                  onChanged: (value) =>
                                                      pass = value!,
                                                  hintText: '* * * * * *',
                                                  padding: 0,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(Routes
                                                                .forgotPassword);
                                                      },
                                                      child: Text(
                                                        'forgot_your_password'
                                                            .tr(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge!
                                                            .copyWith(
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]))),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: kColorPrimary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      height: 45,
                                      child: showProgress == true
                                          ? const Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: kColorLight,
                                                  )),
                                            )
                                          : EmailLogin(
                                              controller:
                                                  _emailButtonController,
                                              onTap:
                                                  handleSignInWithEmailPassword,
                                            )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      height: 20,
                                    ),
                                  ),
                                ]))),
                  ]))));
        }));
  }
}

class EmailLogin extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final void Function() onTap;

  const EmailLogin({super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller,
      onPressed: () => onTap(),
      width: MediaQuery.of(context).size.width * 0.80,
      color: kColorPrimary,
      elevation: 0,
      borderRadius: 3,
      child: Wrap(
        children: [
          const Text(
            'login',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ).tr()
        ],
      ),
    );
  }
}
