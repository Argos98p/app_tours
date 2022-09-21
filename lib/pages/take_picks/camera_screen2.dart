import 'package:app_tours/models/Scene.dart';
import 'package:archive/archive_io.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:math';
import 'package:flutter_sensors/flutter_sensors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class CameraScreen2 extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String iduser;
  final String idtour;
  final String scene;
  final String img;
  //final String qrdata;

  const CameraScreen2({
    Key? key,
    required this.cameras,
    required this.iduser,
    required this.idtour,
    required this.scene,
    required this.img,
    //required this.qrdata,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen2> {
  late CameraController controller;
  late var deviceRatio = 0.0;
  bool showFocusCircle = false;
  var encoder = ZipFileEncoder();
  var encoder2 = ZipFileEncoder();
  var encoder3 = ZipFileEncoder();
  var encoder4 = ZipFileEncoder();
  var encoder5 = ZipFileEncoder();
  var encoder6 = ZipFileEncoder();
  var encoder7 = ZipFileEncoder();
  var encoder8 = ZipFileEncoder();
  var paquetes;
  var enviandofotos = false;
  double x = 0;
  double y = 0;
  int fotos = 0;
  double top = 0;
  double left = 0.0;
  double width = 0;
  double height = 0;
  var escenainicial = 0;
  bool primeravezx = false;
  bool primeravezy = false;
  var now;
  var day = "";
  var month = "";
  var year = "";
  var hour = "";
  var minute = "";
  var dir = "";
  var _accelSubscription;
  // var escena = 0;
  bool str = false;
  bool addescenanuevotour = false;
  Directory? appDocumentsDirectory;
  String? appDocumentsPath;
  String vendor_email = 'penafieldavid471@gmail.com';
  @override
  void initState() {
    print("giroscope");
    giroscope();
    print("inicio");
    inicio();

    print("init state");
    super.initState();
    print("ccamera controler");
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    print("initialize controller");
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    // controller.setFocusMode(FocusMode.auto).then((_) {});
    print("state init");
  }

  Future<void> inicio() async {
    now = DateTime.now();

    day = now.day.toString();
    month = now.month.toString();
    year = now.year.toString();
    hour = now.hour.toString();
    minute = now.minute.toString();
    //dir="$year-$month-$day-$hour:$minute";
    //var info=json.decode(widget.qrdata);
    //info=info["3DSPACE"];
    //dir=info["product_id"];
    //vendor_email=info["vendor_email"];
    // escena = escena + 1;
    enviandofotos = false;
    appDocumentsDirectory = await getExternalStorageDirectory();
    appDocumentsPath = appDocumentsDirectory?.path;
    encoder.create("$appDocumentsPath/test/$dir/fotos1.zip");
    encoder2.create("$appDocumentsPath/test/$dir/fotos2.zip");
    encoder3.create("$appDocumentsPath/test/$dir/fotos3.zip");
    encoder4.create("$appDocumentsPath/test/$dir/fotos4.zip");
    encoder5.create("$appDocumentsPath/test/$dir/fotos5.zip");
    encoder6.create("$appDocumentsPath/test/$dir/fotos6.zip");
    encoder7.create("$appDocumentsPath/test/$dir/fotos7.zip");
    encoder8.create("$appDocumentsPath/test/$dir/fotos8.zip");
    //await controller.setFocusMode(FocusMode.locked);
    paquetes = 1;
    fotos = 0;
    str = false;
    // escena = await getEscena();
    // print("//////////////////////////////////////////////////////");
    // print(escena);
  }

  Future<int> getEscena() async {
    var response = await http
        .get(Uri.parse('http://redpanda.sytes.net:8081/tours/numescenas/$dir'));
    var es = -1;
    if (response.statusCode == 200) {
      print(
          "*********************************************************************");
      print(response.body);
      es = int.parse(response.body);
      print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      print(es);
    }
    if (es == 0) {
      es = 1;
    }
    return es;
  }

  @override
  void dispose() {
    controller.dispose();
    //stream.cancel();
    _accelSubscription.cancel();
    super.dispose();
  }

  Future<String> saveFile2(File file) async {
    //final now = DateTime.now();
    /*var day=now.day.toString();
    var month=now.month.toString();
    var year=now.year.toString();
    var hour=now.hour.toString();
    var minute=now.minute.toString();
    var dir="$year-$month-$day-$hour:$minute";
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    String? appDocumentsPath = appDocumentsDirectory?.path;*/
    /*dev.log('********************: $appDocumentsPath');
    final directory = Directory("$appDocumentsPath/test/$dir");
    if(!(await directory.exists())){
        directory.create(recursive: true);
    }
    Uint8List bytes= await file.readAsBytes();
    dev.log("***************** im$fotos.jpg");
    File file2=File("$appDocumentsPath/test/$dir/im$fotos.jpg");

    file2.writeAsBytes(bytes);*/
    if (fotos <= 10) {
      encoder.addFile(file);
      return "im$fotos" + "1.jpg";
    }
    if (fotos <= 20) {
      encoder2.addFile(file);
      return "im$fotos" + "2.jpg";
    }
    if (fotos <= 30) {
      encoder3.addFile(file);
      return "im$fotos" + "3.jpg";
    }
    if (fotos <= 40) {
      encoder4.addFile(file);
      return "im$fotos" + "4.jpg";
    }
    if (fotos <= 50) {
      encoder5.addFile(file);
      return "im$fotos" + "5.jpg";
    }
    if (fotos <= 60) {
      encoder6.addFile(file);
      return "im$fotos" + "6.jpg";
    }
    if (fotos <= 70) {
      encoder7.addFile(file);
      return "im$fotos" + "7.jpg";
    }
    if (fotos <= 83) {
      encoder8.addFile(file);
      return "im$fotos" + "8.jpg";
    }
    return "error";
  }

  void compress() {}
  Future<bool> enviar2(int i) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://redpanda.sytes.net:5000/api/save?idusuario=${widget.iduser}&idtour=${widget.idtour}&escena=${widget.scene}&imagen=${widget.img}&nombre=fotos$i.zip'));
    request.headers.addAll({'Content-Type': 'image/jpeg'});
    //var nombre='im$fotos.jpg';
    //var path='/storage/emulated/0/Android/data/com.example.test3camara/files/test/2022-3-16-11:58/im1.jpg';
    request.fields.addAll({'carpeta': dir, 'nombre': 'fotos$i.zip'});
    //MultipartFile multipartFile=
    request.files.add(await http.MultipartFile.fromPath(
        'file', '$appDocumentsPath/test/$dir/fotos$i.zip'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      return true;
    }
    return false;
  }

  /*Future<void> enviar(String nombre) async {
    var day=now.day.toString();
    var month=now.month.toString();
    var year=now.year.toString();
    var hour=now.hour.toString();
    var minute=now.minute.toString();
    var dir="$year-$month-$day-$hour:$minute";
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    String? appDocumentsPath = appDocumentsDirectory?.path;
    dev.log('********************: $appDocumentsPath');
    var request = http.MultipartRequest('POST', Uri.parse('http://redpanda.sytes.net:8081/save'));
    request.headers.addAll({'Content-Type':'image/jpeg'});
    //var nombre='im$fotos.jpg';
    //var path='/storage/emulated/0/Android/data/com.example.test3camara/files/test/2022-3-16-11:58/im1.jpg';
    request.fields.addAll({
      'carpeta': dir,
      'nombre': nombre
    });
    //MultipartFile multipartFile=
    request.files.add(await http.MultipartFile.fromPath('file', '$appDocumentsPath/test/$dir/$nombre'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }
  }*/
  void saveFile(String xFile) async {
    var r = await ImageGallerySaver.saveFile(xFile);
    var r2 = r['filePath'].toString();
    //var path = await FlutterAbsolutePath.getAbsolutePath(r2);
    dev.log('********************: $xFile');
    dev.log('********************: $r2');
  }

  Future<void> giroscope() async {
    var stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.GYROSCOPE, interval: Sensors.SENSOR_DELAY_GAME);
    var _accelData1;
    _accelSubscription = stream.listen((event) {
      setState(() {
        _accelData1 = event.data;
        var rad = _accelData1[1];
        var rady = _accelData1[0];
        var traslacion = sin(rad);
        var traslaciony = sin(rady);
        if (!enviandofotos) {
          if (!primeravezx && width != 0) {
            left = width - 100; //-100
            primeravezx = true;
          }
          if (!primeravezy && height != 0) {
            top = (height - 100) / 2;
            primeravezy = true;
          }
          if (traslaciony > 0) {
            top = (top + traslaciony * 12);
          } else {
            top = (top - (traslaciony * -1) * 12);
          }
          if (traslacion > 0) {
            //dev.log("se mueve: $traslacion");
            left = (left + traslacion * 12);
          } else {
            //dev.log("se mueve: $traslacion");
            left = (left - (traslacion * -1) * 12);
          }
          //left=((traslacion *60) + ((width - 100) / 2));
          if (left > (width - 100)) {
            //width-100
            left = width - 100;
          }
          if (top < 20) {
            top = 25;
          }
          //verificar ubicacion pa tomar la foto
          double diffy = 0;
          double diffx = 0;
          if (top > ((height - 100) / 2)) {
            //si esta mas abajo de la cosa roja
            diffy = (top - ((height - 100) / 2));
          } else {
            diffy = (((height - 100) / 2) - top);
          }
          if (left > ((width - 125) / 2)) {
            // si esta mas a la derecha
            diffx = left - ((width - 125) / 2);
          } else {
            diffx = ((width - 125) / 2) - left;
          }
          //Fluttertoast fluttertoast = new Fluttertoast();
          if (diffx < 20 && diffx != 0 && diffy < 20 && diffy != 0) {
            print("hola");

            takephoto();
            var fotos2 = fotos + 1;
            Fluttertoast.showToast(
                msg: "Foto tomada $fotos2 de 63",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER);
            //sleep(Duration(seconds:1));
            fotos = fotos + 1;
            mover(fotos);
            //Fluttertoast.cancel();

          }
        }

        //dev.log("total. $_accelData1");
      });
    });
  }

  void mover(int i) {
    if (i != 0) {
      if (i % 3 == 0 && i != 0) {
        // regresar a horizontal y arriba
        top = ((height - 100) / 2) - 150; // debe ser el mismo valor que arriba
        left = width - 130; //-175 mucho overlap -100 nada de overlap
      }
      if ((i + 2) % 3 == 0) {
        //arriba
        top = ((height - 100) / 2) - 150; //125
      }
      if ((i + 1) % 3 == 0) {
        //abajo
        top = ((height - 100) / 2) + 300; //debe ser el doble se arriba
      }
    }
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  void takephoto() async {
    //probar con future<void>
    //controller.setFocusMode(FocusMode.locked);
    var xFile = await controller.takePicture();
    //var path=xFile.path;
    //var day=now.day.toString();
    //var month=now.month.toString();
    //var year=now.year.toString();
    //var hour=now.hour.toString();
    //var minute=now.minute.toString();
    //var dir="$year-$month-$day-$hour:$minute";
    var file = new File(xFile.path);
    var file2 = await changeFileNameOnly(file, "foto_$fotos" + ".jpg");
    String nombre = await saveFile2(file2);
    //await enviar(nombre);
    /*Fluttertoast.showToast(
        msg: "Foto enviada",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER

    );*/
    switch (fotos) {
      case 10:
        encoder.close();
        break;
      case 20:
        encoder2.close();
        break;
      case 30:
        encoder3.close();
        break;
      case 40:
        encoder4.close();
        break;
      case 50:
        encoder5.close();
        break;
      case 63:
        encoder6.close();
        encoder7.close();
        encoder8.close();
        break;
      case 70:
        encoder7.close();
        break;
      case 83:
        encoder8.close();
        break;
    }
    if (fotos == 12) {
      str = true;
      // encoder.close();
      encoder2.close();
      encoder3.close();
      encoder4.close();
      encoder5.close();
      encoder6.close();
      encoder7.close();
      encoder8.close();
      Fluttertoast.showToast(
          msg: "Presiona enviar",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }

  Future<XFile> recibir(String dir) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://redpanda.sytes.net:5000/api/stitch?idusuario=${widget.iduser}&idtour=${widget.idtour}&escena=${widget.scene}&imagen=${widget.img}'));
    request.fields.addAll({
      // 'carpeta': dir, //product id
      // 'escena': "$escena",
      'correo': vendor_email, // vendor_email
    });

    http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    var bytes = await response.stream.toBytes();

    final dir = await getTemporaryDirectory();
    File file = File('${dir.path}/tempImg.jpg');
    await file.writeAsBytes(bytes);
    print('downloaded file path = ${file.path}');

    return XFile(file.path);
    // } else {
    //   print(response.reasonPhrase);
    //   return null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    deviceRatio = (size.width / size.height);
    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        GestureDetector(
            onTapUp: (details) {
              _onTap(details);
            },
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: CameraPreview(controller)),
                if (showFocusCircle)
                  Positioned(
                      top: y - 20,
                      left: x - 20,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.black, width: 1.5)),
                      )),
              ],
            )),
        /*Align(
          alignment: Alignment.bottomCenter,
          child: Material(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: IconButton(
                  icon: Icon(Icons.add_a_photo,color:Colors.black),
                  onPressed:() async{
                    var xFile = await controller.takePicture();
                    var path=xFile.path;
                    var file=new File(xFile.path);
                   saveFile2(file);
                    setState(()  {
                      //capturedImages.add(File(xFile.path));
                      //var r=GallerySaver.saveImage(xFile.path);
                      saveFile(xFile.path);


                    });
                  } ,
                ),

              )
          )
        ),*/
        Positioned(
          // positioned 50 from the top of the stack
          // and centered horizontally, left = (ScreenWidth - Container width) / 2
          top: (height - 100) / 2,
          left: (width - 125) / 2,
          child: Visibility(
              visible: !str,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(125),
                ),
              )),
        ),
        Positioned(
            left: left,
            top: top,
            child: Visibility(
                visible: !str,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                ))),
        Center(
            child: Visibility(
                visible: str,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.blue,
                ))),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(100, 40), //////// HERE
                ),
                child: const Text('Cancelar', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
              Visibility(
                  visible: str,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: const Text('Enviar', style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      str = true;
                      enviandofotos = true;
                      for (int i = paquetes; i < 9; i++) {
                        str = true;
                        str = await enviar2(i);
                        if (str) {
                          Fluttertoast.showToast(
                              msg:
                                  "Error al enviar, reintenta cuando tengas buena conexión",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER);
                          break;
                        } else {
                          Fluttertoast.showToast(
                              msg: "fotos enviadas parte $i",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER);
                          paquetes++;
                        }
                      }
                      //str=await enviar2();
                      var img = await recibir(dir);
                      addescenanuevotour = true;

                      // await inicio();
                    },
                  )),
              Visibility(
                visible: addescenanuevotour,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child:
                      const Text('Add Escena', style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    addescenanuevotour = false;
                    print('quitaste esto babas');
                    // escena = escena + 1;
                    // var response = await http.post(Uri.parse(
                    // 'http://redpanda.sytes.net:8081/tours/nuevaescena/$dir/$escena'));

                    // if (response.statusCode == 200) {
                    //   print(response.body);
                    // } else {
                    //   print(response.reasonPhrase);
                    // }
                  },
                ),
              ),
              Visibility(
                visible: addescenanuevotour,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                    shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(100, 40), //////// HERE
                  ),
                  child: const Text('End Tour', style: TextStyle(fontSize: 20)),
                  onPressed: () async {
                    addescenanuevotour = false;
                    print('end tour');
                    // var response = await http.post(Uri.parse(
                    //     'http://redpanda.sytes.net:8081/tours/finalizar/$dir'));
                    // escena = escena + 1;
                    // if (response.statusCode == 200) {
                    //   print(response.body);
                    // } else {
                    //   print(response.reasonPhrase);
                    // }

                    // var response2 = await http.post(Uri.parse(
                    //     'http://redpanda.sytes.net:8081/tours/nuevaescena/$dir/$escena'));

                    // if (response2.statusCode == 200) {
                    //   print(response2.body);
                    // } else {
                    //   print(response2.reasonPhrase);
                    // }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onTap(TapUpDetails details) async {
    if (controller.value.isInitialized) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * controller.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp, yp);
      dev.log("point : $point");

      // Manually focus

      controller.setFocusMode(FocusMode.locked);
      controller.setFocusPoint(point);
      //controller.setExposureMode(ExposureMode.locked);
      // Manually set light exposure
      //controller.setExposurePoint(point);

      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }
}
