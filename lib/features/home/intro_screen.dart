import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:splitizer/shared/app_scaffold.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

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
          context.go('/bill');
        },
        onSkip: () {
          context.go('/bill');
        }, // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: Text(
          'Empezar',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        next: const Icon(Icons.arrow_forward),
        done: Text(
          'Listo',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: DotsDecorator(
          size: Size(10.0, 10.0),
          color:
              Theme.of(context).appBarTheme.foregroundColor?.withOpacity(0.8) ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black54),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: ShapeDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
