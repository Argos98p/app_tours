import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FancyFab({required this.onPressed, required this.tooltip, required this.icon});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>

    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  var _currIndex=0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 5.0,
            0.0,
          ),
          child: link(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: hotspot(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: inicio(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: video(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value ,
            0.0,
          ),
          child: sonido(),
        ),
        toggle(),
      ],
    );
  }


  Widget link() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey[300],
        onPressed: null,
        tooltip: 'Link',
        child: Icon(Icons.insert_link),
      ),
    );
  }

  Widget hotspot() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey[300],
        onPressed: null,
        tooltip: 'Hotspot',
        child: Icon(FontAwesome5.tag),
      ),
    );
  }
  Widget inicio() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn4",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey[300],
        onPressed: null,
        tooltip: 'Inicio',
        child: Icon(FontAwesome.flag),
      ),
    );
  }

  Widget video() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn5",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey[300],
        onPressed: null,
        tooltip: 'Video',
        child: Icon(FontAwesome5.film),
      ),
    );
  }

  Widget sonido() {
    return Container(
      child: FloatingActionButton(
        heroTag: "btn6",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.grey[300],
        onPressed: null,
        tooltip: 'Sonido',
        child: Icon(Icons.volume_up),
      ),
    );
  }


  Widget toggle() {

    return Container(
      child: FloatingActionButton(
          heroTag: "btn1",
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child:   IconButton(
          icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == ValueKey('icon1')
                    ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                    : Tween<double>(begin: 0.75, end: 1).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: _currIndex == 0
                  ? Icon(Icons.add, key: const ValueKey('icon1'),color: Colors.grey[300],)
                  : Icon(
                Icons.keyboard_arrow_down_outlined, color: Colors.grey[300],
                key: const ValueKey('icon2'),
              )),
          onPressed: () {
            setState(() {
              animate();
              _currIndex = _currIndex == 0 ? 1 : 0;
            });
          },
        )    ),
    );
  }

}