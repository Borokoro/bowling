
import 'package:flutter/material.dart';

class Bowling extends StatefulWidget {
  const Bowling({Key? key}) : super(key: key);

  @override
  State<Bowling> createState() => _BowlingState();
}

class _BowlingState extends State<Bowling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
      ),
    );
  }
}
