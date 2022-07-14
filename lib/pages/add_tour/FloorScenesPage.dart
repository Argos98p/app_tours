import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
import 'package:app_tours/models/Floor.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/widgets/itemCardScene.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FloorScenesPage extends StatefulWidget {
  Floor floor;
  List<ScenesInTourModel> scenes;
  FloorScenesPage({Key? key, required this.floor, required this.scenes})
      : super(key: key);

  @override
  State<FloorScenesPage> createState() => _FloorScenesPageState();
}

class _FloorScenesPageState extends State<FloorScenesPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: const EdgeInsets.all(10),
        children: List.generate(widget.scenes.length, (index) {
          /*Scene newScene = Scene(
              imageList: [],
              name: widget.scenes[index].title,
              slug: widget.scenes[index].slug);*/
          //newTour.floors![widget.index].scenes!.add(newScene);
          return Center(
              child: DragTarget(
            onWillAccept: (data) {
              return true;
            },
            onAccept: (String data) {
              print('adfadsf');
              print(widget.scenes[index].slug);
              print(widget.floor.slug);
              context.read<TourProvider>().newTour.floors![widget.floor.slug]!.scenes![widget.scenes[index].slug]!.imageList.add(XFile(data));
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return ItemCardScene(
                  sceneInTour: widget.scenes[index], floor: widget.floor);
            },
          ));
        }));
  }
}
