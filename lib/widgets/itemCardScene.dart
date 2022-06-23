import 'package:app_tours/initalConfigurations/ScenesTourModel.dart';
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
  int numScenes=0;

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
          child: Stack(
            children:[
              Positioned(
                right: 0,
                top: 0,
                child:numScenesButton(numScenes),

              ),
              Center(
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
            ),]
          ),
        ));
  }

  Widget numScenesButton(int n){
    if(n>0){
      return  Container(
          width: 20,
          height: 20,
          decoration: new BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(numScenes.toString())));
    }else{
      return Container(
          width: 20,
          height: 20,
          decoration: new BoxDecoration(
            color: colorsApp['secondaryColor'],
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(numScenes.toString())));
    }
  }
  Future _navigateAddImageAndReturn(BuildContext context, ScenesInTourModel scene) async {
    //TourProvider watch = context.watch<TourProvider>();

    var imageFileList = await Navigator.pushNamed(context, '/toursDisponibles/agregarEscena',arguments:widget.scene) ;

    if(imageFileList != null){
      imageFileList as List<XFile>;
      numScenes=imageFileList.length;
      setState(() {

      });
      //print(numScenes);
    }
      //context.read<TourProvider>().setListScenes(slug_scene: scene.slug, images: imageFileList);


  }
}
