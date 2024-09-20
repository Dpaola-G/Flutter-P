import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://proyecto-sena-backend-s666.onrender.com/api"; // Cambia esto por la URL de tu backend

  // Método para iniciar sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    
    // Cuerpo de la solicitud
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      // Realiza la solicitud POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Verifica el estado de la respuesta
      if (response.statusCode == 200) {
        // Decodifica el JSON de la respuesta
        final data = jsonDecode(response.body);

        // Extrae el token y el usuario del cuerpo de la respuesta
        final token = data['token'];
        final user = data['user'];

        // Guarda el token usando shared_preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        return {
          'success': true,
          'user': user,
          'token': token,
        };
      } else {
        // Maneja errores específicos
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'],
        };
      }
    } catch (e) {
      // Manejo de errores de red o inesperados
      return {
        'success': false,
        'message': 'Error al conectar con el servidor.',
      };
    }
  }

  // Método para obtener el token almacenado
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Método para eliminar el token 
  Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');

  // Navegar a la pantalla de login y eliminar todas las pantallas anteriores
  
}
}
