import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/resource/color.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage>
    with TickerProviderStateMixin {
  //late AnimationController _dropController;
  late AnimationController _separateController;
  //late Animation<Offset> _dropAnimation;

  late AnimationController _dropController1;
  late AnimationController _dropController2;
  late AnimationController _dropController3;

  late Animation<Offset> _dropAnimation1;
  late Animation<Offset> _dropAnimation2;
  late Animation<Offset> _dropAnimation3;

  @override
  void initState() {
    super.initState();

    // _dropController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 2500),
    // );

    _dropController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    _dropController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    _dropController3 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    _separateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _dropAnimation1 = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
          CurvedAnimation(parent: _dropController1, curve: Curves.bounceOut),
        );

    _dropAnimation2 = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
          CurvedAnimation(parent: _dropController2, curve: Curves.bounceOut),
        );

    _dropAnimation3 = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
          CurvedAnimation(parent: _dropController3, curve: Curves.bounceOut),
        );

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    _dropController1.forward();
    await Future.delayed(Duration(milliseconds: 200));
    _dropController2.forward();
    await Future.delayed(Duration(milliseconds: 200));
    _dropController3.forward();
    await Future.delayed(Duration(milliseconds: 400));
    await _separateController.forward();
  }

  @override
  void dispose() {
    _dropController1.dispose();
    _dropController2.dispose();
    _dropController3.dispose();
    _separateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxWidth = kIsWeb ? (width * 0.9 > 600 ? 800.0 : width) : width;

    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            width: maxWidth,
            child: Stack(
              children: [
                SlideTransition(
                  position: _dropAnimation1,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _dropController1,
                      _separateController,
                    ]),
                    builder: (_, __) {
                      final dropProgress = _dropController1.value;
                      final separateProgress = _separateController.value;

                      final dropOffset = Offset(-65, -64);

                      final targetOffset = Offset(0, 0);
                      final animatedOffset = Offset.lerp(
                        dropOffset,
                        targetOffset,
                        separateProgress,
                      )!;

                      final rotation = (8 * pi / 180) * separateProgress;

                      return Align(
                        alignment: Alignment.centerRight,
                        child: Transform.translate(
                          offset: dropProgress < 1.0
                              ? dropOffset
                              : animatedOffset,
                          child: Transform.rotate(
                            angle: dropProgress < 1.0 ? 0 : rotation,
                            child: _card(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SlideTransition(
                  position: _dropAnimation2,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _dropController2,
                      _separateController,
                    ]),
                    builder: (_, __) {
                      final dropProgress = _dropController2.value;
                      final separateProgress = _separateController.value;

                      final dropOffset = Offset(-65, -32);

                      final targetOffset = Offset(-120, 0);
                      final animatedOffset = Offset.lerp(
                        dropOffset,
                        targetOffset,
                        separateProgress,
                      )!;

                      final rotation = -(8 * pi / 180) * separateProgress;

                      return Align(
                        alignment: Alignment.centerRight,
                        child: Transform.translate(
                          offset: dropProgress < 1.0
                              ? dropOffset
                              : animatedOffset,
                          child: Transform.rotate(
                            angle: dropProgress < 1.0 ? 0 : rotation,
                            child: _card(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SlideTransition(
                  position: _dropAnimation3,
                  child: Align(
                    alignment: Alignment.center,
                    child: _cardWithContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: 576,
      height: 416,
      decoration: BoxDecoration(
        color: ColorList.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: ColorList.cardBorderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(64, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _cardWithContent() {
    return Container(
      width: 576,
      height: 416,
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 64),
      decoration: BoxDecoration(
        color: ColorList.cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: ColorList.cardBorderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(64, 0, 0, 0),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ANDRI',
                  style: TextStyle(
                    fontFamily: 'PostNoBillsJaffnaSemiBold',
                    fontSize: 64,
                    letterSpacing: 10.24,
                    color: ColorList.whiteColor,
                  ),
                ),
                Text(
                  'FRITZENT.',
                  style: TextStyle(
                    fontFamily: 'PostNoBillsJaffnaSemiBold',
                    fontSize: 64,
                    letterSpacing: 10.24,
                    color: ColorList.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            'FLUTTER DEV_',
            style: TextStyle(
              fontFamily: 'PostNoBillsJaffnaExtraBold',
              fontSize: 36,
              letterSpacing: 5.12,
              fontWeight: FontWeight.bold,
              color: ColorList.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
