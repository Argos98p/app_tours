import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';

class ItemCardScene extends StatefulWidget {
  IconData icono;
  String titulo;
  ItemCardScene({Key? key, required this.icono, required this.titulo})
      : super(key: key);

  @override
  State<ItemCardScene> createState() => _ItemCardScenesState();
}

class _ItemCardScenesState extends State<ItemCardScene> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorsApp['primaryColor'],
        child: InkWell(
          onTap: () {
            //print('tap');
            //Navigator.of(context).pushNamed(route);
          },
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*Expanded(*/
                  Icon(widget.icono, size: 38, color: colorsApp['iconColor']),
                  /*),*/
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:
                          Text(widget.titulo, style: TextStyle(fontSize: 16))),
                ]),
          ),
        ));
  }
}
