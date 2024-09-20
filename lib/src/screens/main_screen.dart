import 'package:app_movil_coffe/src/models/usuario_model.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final Usuario usuario;

  MainScreen({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Bienvenido, ${usuario.tipoUsuario}'),
      ),
    );
  }
}