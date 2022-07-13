import 'package:flutter/material.dart';

import '../welcome/welcome_screen.dart';
import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AssetImage? assetImage;
  startTime() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          NavigatorFadeTransition(
            child: const WelcomeScreen(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    assetImage = const AssetImage('assets/images/logo.png');
    startTime();
  }

  @override
  void didChangeDependencies() {
    precacheImage(assetImage!, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientVertical),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              defaultPadding,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: assetImage!,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
