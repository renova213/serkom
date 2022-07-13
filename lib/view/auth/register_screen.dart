import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pembayaran_listrik/view/auth/login_screen.dart';
import 'package:pembayaran_listrik/view/home/home_screen.dart';

import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  String? nik;
  String? password;
  var obscureText = true;
  bool isLoading = false;
  final _passwordEditingController = TextEditingController();
  final _nikEditingController = TextEditingController();

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _nikEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/icons/arrow_back.svg',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFieldName("Username"),
                      const SizedBox(height: 4),
                      fieldUsername(),
                      const SizedBox(height: 8),
                      textFieldName("Password"),
                      const SizedBox(height: 4),
                      fieldPassowrd()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                registerButton(),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun?",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          NavigatorFadeTransition(
                            child: const LoginScreen(),
                          ),
                        );
                      },
                      child: Text("Login",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return Center(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child:
            nik == null || password == null || nik!.isEmpty || password!.isEmpty
                ? ElevatedButton(
                    onPressed: null,
                    child: Text("Register",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white)),
                  )
                : ElevatedButton(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Register",
                          ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (isLoading) return;

                        try {
                          await Future.delayed(
                            const Duration(seconds: 2),
                          )
                              .then(
                                (_) => setState(() => isLoading = true),
                              )
                              .then(
                                (_) => Navigator.of(context).pushAndRemoveUntil(
                                  NavigatorFadeTransition(
                                    child: const HomeScreen(),
                                  ),
                                  ModalRoute.withName('/home'),
                                ),
                              );
                        } catch (_) {}
                      }
                    },
                  ),
      ),
    );
  }

  Widget fieldPassowrd() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          password = value;
        },
      ),
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: obscureText,
      cursorColor: Colors.white,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(
              () {
                obscureText = !obscureText;
              },
            );
          },
          child: obscureText
              ? const Icon(
                  Icons.visibility_off_rounded,
                  color: Colors.grey,
                )
              : const Icon(Icons.visibility_rounded, color: Colors.grey),
        ),
        hintText: 'input',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColorSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: pressedColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
        FilteringTextInputFormatter.allow(
          RegExp("[a-zA-Z0-9 ]"),
        ),
      ],
      controller: _passwordEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        } else if (value.length < 8) {
          return "Minimum password 8 character";
        }
        return null;
      },
    );
  }

  Widget fieldUsername() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          nik = value;
        },
      ),
      style: Theme.of(context).textTheme.bodyText1,
      cursorColor: Colors.white,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp("[a-zA-Z0-9 ]"),
        ),
        LengthLimitingTextInputFormatter(50),
      ],
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
        hintText: 'input',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: pressedColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColorSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      controller: _nikEditingController,
      validator: (value) {
        if (value!.length < 8) {
          return "username minimal 8 character";
        }
        return null;
      },
    );
  }

  Widget textFieldName(label) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: defaultPadding / 3,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.grey.shade700),
      ),
    );
  }
}
