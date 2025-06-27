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
  late AnimationController _dropController;
  late AnimationController _separateController;
  late Animation<Offset> _dropAnimation;

  @override
  void initState() {
    super.initState();

    _dropController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _separateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _dropAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _dropController, curve: Curves.bounceOut));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await _dropController.forward();
    await _separateController.forward();
  }

  @override
  void dispose() {
    _dropController.dispose();
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
            child: SlideTransition(
              position: _dropAnimation,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _dropController,
                      _separateController,
                    ]),
                    builder: (_, __) {
                      final dropProgress = _dropController.value;
                      final separateProgress = _separateController.value;

                      final dropOffset = Offset(-65, -64);

                      final targetOffset = Offset(
                        0,
                        0,
                      );
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
                            angle: rotation,
                            child: _card(),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _dropController,
                      _separateController,
                    ]),
                    builder: (_, __) {
                      final dropProgress = _dropController.value;
                      final separateProgress = _separateController.value;

                      final dropOffset = Offset(-65, -32);

                      final targetOffset = Offset(
                        -120,
                        0,
                      );
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
                            angle: rotation,
                            child: _card(),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(alignment: Alignment.center, child: _cardWithContent()),
                ],
              ),
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
