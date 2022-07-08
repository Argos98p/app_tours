import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class OnWork extends StatefulWidget {
  const OnWork({Key? key}) : super(key: key);

  @override
  State<OnWork> createState() => _OnWorkState();
}

class _OnWorkState extends State<OnWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text('We work on this ', style: TextStyle(
          fontSize: 30
        ),),
            Container(
              width: 300,
                child: Lottie.asset('assets/lottie/working.json'))

          ],
        )

      ),
    );
  }
}
