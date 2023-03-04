import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usuario.dart';
import '../screens/home_screen.dart';
// :::::::::: Obtener Datos Especificos de la Base de Datos :::::::::: //
// En Proceso...

class GetUserController extends GetxController {

  
  String id = '';
  String nombre = '';
  String apellidos = '';
  String fechaDeNacimiento = '';
  String genero = '';
  String telefono = '';
  String email = '';
  String password = '';
  
  handleId(String newId) {
    id = newId;
    update();
  }

  handleName(String newName) {
    nombre = newName;
    update();
  }

  handleApellidos(String newApellidos) {
    apellidos = newApellidos;
    update();
  }

  handleFechaDeNacimiento(String handleFechaDeNacimiento) {
    fechaDeNacimiento = handleFechaDeNacimiento;
    update();
  }

  handleGenero(String newGenero) {
    genero = newGenero;
    update();
  }

  handleTelefono(String newTelefono) {
    telefono = newTelefono;
    update();
  }

  handleEmail(String handleEmail) {
    email = handleEmail;
    update();
  }

  handlePassword(String newPassword) {
    password = newPassword;
    update();
  }

  handleUser() async {
    try {
        await saveUserInDB(id);

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
    } catch (e) {
      print(e);
    }
  }

  saveUserInDB(String id) {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("Usuarios").doc(id);
    docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
      print("PALABRAS " + data.toString());
    return data;

    // ...
  },
  onError: (e) => print("Error getting document: $e"),
);
    
  }

  handleUserName() async{
    nombre = await getUserNameInDB(id);
    return nombre; 

  }

  getUserNameInDB(String id) async {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("Usuarios").doc(id);
    await docRef.get().then((DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    print("PALABRAS " + data["nombre"].toString());
    final nombre = data["nombre"].toString();
    return nombre;

    // ...
  },
    onError: (e) => print("Error getting document: $e"),
  );
    
  }

  handleUserData() {
    return getUserInDB(id);
  }

  getUserInDB(String id) {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("Usuarios").doc(id);
     docRef.get().then((DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    print("PALABRAS " + data["nombre"].toString());
    //final nombre = data["nombre"].toString();
    return data;

    // ...
    },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
