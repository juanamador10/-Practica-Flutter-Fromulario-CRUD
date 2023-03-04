import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_flutter_formulario_amador/controllers/get_user_controller.dart';
import 'package:curso_flutter_formulario_amador/screens/update_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final controllerGetUser = Get.put(GetUserController());
class HomeScreen extends StatefulWidget {
  //final String nombre;
  final id;
  
  const HomeScreen({super.key,  required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  
  // :::: FutureBuilder Usado Para Tratar de Usar Datos Especificos de la Base de Datos :::: //
  // :::: En Proceso de Implementacion... :::://
  @override
  Widget build(BuildContext context) {
    controllerGetUser.handleId(widget.id);
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: (Text("Home")),
            centerTitle: true,
            leading: IconButton(onPressed: () {
              Navigator.of(context).pop();
            },
              icon: const Icon(Icons.logout_rounded),
            ),
            actions: [
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserScreen(documentId: widget.id)));
              }, icon: const Icon(Icons.person_rounded)),
            ]) ,
          body: Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                // En Proceso... Text(nombreUsuario().toString()),
                Text('Bienvenido', style: TextStyle(fontSize: 20,), textAlign: TextAlign.end,),
                //Text(nombre, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),      

              ],
            ),
          ),
        );
      }
    );

    
  }

  
//Funcion a Mejorar Para Mandar a Llamar el Nombre del Usuario - En Proceso...
  Future<String> nombreUsuario() async {
    final nombre = controllerGetUser.getUserNameInDB(widget.id).then((value){
      final nombre = value;
      print("Nombre " + nombre.toString());
     return nombre;
    });
    return "null";
  }

}