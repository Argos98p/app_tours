/*import 'package:flutter/material.dart';

class TourInformationPage extends StatefulWidget {
  const TourInformationPage({Key? key}) : super(key: key);

  @override
  State<TourInformationPage> createState() => _TourInformationPageState();
}

class _TourInformationPageState extends State<TourInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: EdgeInsets.all(20),
        child: Expanded(child: _FormTourInfo(sizeSpace: 20.0)),
      )
      ,
    );
  }
}

class _FormTourInfo extends StatefulWidget {

  double sizeSpace;

  _FormTourInfo({Key? key, required this.sizeSpace})
      : super(key: key);

  @override
  State<_FormTourInfo> createState() => _FormTourInfoState();
}

class _FormTourInfoState extends State<_FormTourInfo> {
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: SingleChildScrollView(
          child: Column(
      children: [
          SizedBox(height:widget.sizeSpace ),
          Text('Editar Informacion del Tour', style: TextStyle(fontSize: 20),),
          SizedBox(height:widget.sizeSpace ),
          makeInput(
            label: "Titulo del tour",
            icon_text: Icons.threesixty_outlined,
          ),
          SizedBox(height:widget.sizeSpace ),
          makeInput(
            label: "Direccion",
            obsureText: false,
            icon_text: Icons.location_on_outlined,
          ),
          SizedBox(height:widget.sizeSpace ),
          makeInput(
            label: "Ciudad",
            obsureText: true,
            icon_text: Icons.my_location_rounded ,
          ),
          SizedBox(height:widget.sizeSpace ),
          makeInput(
            label: "Referencia externa",
            obsureText: true,
            icon_text: Icons.nat_sharp ,
          ),
          SizedBox(height:widget.sizeSpace ),
          ElevatedButton(onPressed: (){
            if(_formKey.currentState!.validate()){
              print('Guardar');
            }
          }, child: Text("Guardar"))
      ],
    ),
        ));
  }

  Widget makeInput({label, obsureText = false, fieldController, icon_text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFormField(
          validator: (value){
            if(value!.isEmpty){
              return "Llene la informacion";
            }
            return null;
          },
          controller: fieldController,
          obscureText: obsureText,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon_text),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(),
          ),
        ),

      ],
    );
  }
}
*/