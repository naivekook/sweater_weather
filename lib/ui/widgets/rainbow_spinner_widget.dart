import 'dart:math';

import 'package:flutter/widgets.dart';

class RainbowSpinnerWidget extends StatefulWidget {
  @override
  _RainbowSpinnerWidgetState createState() => _RainbowSpinnerWidgetState();
}

class _RainbowSpinnerWidgetState extends State<RainbowSpinnerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: Image.asset('assets/images/rainbow.png', width: 50, height: 50),
    );
  }
}
