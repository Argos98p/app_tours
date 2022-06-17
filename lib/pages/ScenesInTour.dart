import 'package:app_tours/models/scenesTourModel.dart';
import 'package:app_tours/widgets/itemCard.dart';
import 'package:app_tours/widgets/itemCardScene.dart';
import 'package:flutter/material.dart';

class ScenesInTour extends StatefulWidget {
  String typeTour;

  ScenesInTour({Key? key, required this.typeTour}) : super(key: key);

  @override
  State<ScenesInTour> createState() => _ScenesInTourState();
}

class _ScenesInTourState extends State<ScenesInTour> {
  List<ScenesInTourModel> scenes = [];

  @override
  Widget build(BuildContext context) {
    switch (widget.typeTour) {
      case 'casa':
        scenes = houseScenes;
        break;
      case 'restaurante':
        scenes = restaurantScenes;
        break;
      case 'comercial':
        scenes = commercerScenes;
        break;

      case 'otro':
        scenes = otherScenes;
        break;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Text(
                'Tours Virtuales',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Expanded(child: gridScenes(scenes))
          ],
        ),
      ),
    );
  }

  Widget gridScenes(List<ScenesInTourModel> scenesTour) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(10),
        children: List.generate(scenesTour.length, (index) {
          return Center(
              child: ItemCardScene(
                  icono: scenesTour[index].icon,
                  titulo: scenesTour[index].title));
        }));
  }
}
