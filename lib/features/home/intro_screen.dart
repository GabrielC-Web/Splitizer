import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitizer/shared/app_scaffold.dart';

const String _kHasSeenIntroKey = 'hasSeenIntro';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  late Future<bool> _hasSeenIntroFuture;

  // Asynchronously checks SharedPreferences
  Future<bool> _checkIntroStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // If _kHasSeenIntroKey exists and is true, then intro has been seen.
    // Otherwise, (if null or false), it hasn't been seen.
    return prefs.getBool(_kHasSeenIntroKey) ?? false;
  }

  Future _makeIntroSeen() async {
    final prefs = await SharedPreferences.getInstance();
    // Set the flag to true so intro doesn't show again
    await prefs.setBool(_kHasSeenIntroKey, true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hasSeenIntroFuture = _checkIntroStatus();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return AppScaffold(
      title: 'Splitizer',
      showBack: false,
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        infiniteAutoScroll: false,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(padding: const EdgeInsets.only(top: 16, right: 16)),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Divide las cuentas de manera justa y precisa",
            body:
                "¿La factura se pasó de lo que esperaban? No hay problema, esta app se encargará de calcular cuánto debe pagar cada participante de una cuenta compartida que... se fue un poco de las manos :)",
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "¿Listo para empezar?",
            body: "Evitate complicaciones y empieza a dividir esas cuentas!",
            decoration: pageDecoration,
          ),
        ],
        onDone: () {
          _makeIntroSeen;
          context.go('/bill');
        },
        onSkip: () {
          _makeIntroSeen;
          context.go('/bill');
        }, // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text(
          'Empezar',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Listo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
