import 'dart:convert';
import 'package:app_movil_coffe/src/models/seguimiento_model.dart';
import 'package:http/http.dart' as http;


class SeguimientoController {
  Future<Seguimiento> getSeguimientoByMaquinaId(String idMaquina) async {

    final String baseUrl = "https://proyecto-sena-backend-s666.onrender.com/api"; 

    try {
      
      final response = await http.get(Uri.parse('$baseUrl/seguimiento/maquina/$idMaquina'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final seguimientoData = jsonData['data']; // Acceder a la clave "data"
        return Seguimiento.fromJson(seguimientoData);
      } else {
        throw Exception('Error al obtener seguimiento por maquina: ${response.statusCode}');
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception('Error de conexión: ${e.message}');
      } else {
        throw Exception('Error desconocido: $e');
      }
    }
  }
}
