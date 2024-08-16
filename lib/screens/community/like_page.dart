import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      upperBound: 1,
      duration: const Duration(
        milliseconds: 400,
      ),
      vsync: this,
      value: 0,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        alignment: Alignment.center,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:
          // BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //     child:
          Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                color: Colors.transparent,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 150,
                ),
                // ),
              )),
        ));
  }
}
