import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';

final TextStyle textStyle = TextStyle();

Widget itemCard(BuildContext context, IconData icono, String titulo,
    double iconSize, String route) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: colorsApp['primaryColor'],
      child: InkWell(
        onTap: () {
          //print('tap');
          Navigator.of(context).pushNamed(route);
        },
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*Expanded(*/
                Icon(icono, size: iconSize, color: colorsApp['iconColor']),
                /*),*/
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(titulo, style: TextStyle(fontSize: 16))),
              ]),
        ),
      ));
}
