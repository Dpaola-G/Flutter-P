import 'package:app_movil_coffe/src/models/usuario_model.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  void setUser(Usuario user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}