import 'package:app_tours/models/ScenesTourModel.dart';
import 'package:app_tours/providers/newTourProvider.dart';
import 'package:app_tours/utils/ColorsTheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemCardScene extends StatefulWidget {
  ScenesInTourModel scene;

  ItemCardScene({Key? key, required this.scene})
      : super(key: key);

  @override
  State<ItemCardScene> createState() => _ItemCardScenesState();
}

class _ItemCardScenesState extends State<ItemCardScene> {

  @override
  Widget build(BuildContext context){

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorsApp['primaryColor'],
        child: InkWell(
          onTap: () {

            _navigateAddImageAndReturn(context,widget.scene);

            //List<XFile>? imageFileList = await Navigator.pushNamed(context, '/toursDisponibles/agregarEscena',arguments:widget.scene) as List<XFile>;
            //print(imageFileList);
          },
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*Expanded(*/
                  Icon(widget.scene.icon, size: 38, color: colorsApp['iconColor']),
                  /*),*/
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:
                          Text(widget.scene.title, style: TextStyle(fontSize: 16))),
                ]),
          ),
        ));
  }

  Future _navigateAddImageAndReturn(BuildContext context, ScenesInTourModel scene) async {
    //TourProvider watch = context.watch<TourProvider>();

    var imageFileList = await Navigator.pushNamed(context, '/toursDisponibles/agregarEscena',arguments:widget.scene) ;

    if(imageFileList != null){
      imageFileList as List<XFile>;
    }
      //context.read<TourProvider>().setListScenes(slug_scene: scene.slug, images: imageFileList);


  }
}
