import 'dart:convert';
import 'package:app_movil_coffe/src/models/maquina_model.dart';
import 'package:http/http.dart' as http;


class MaquinaService {
  final String baseUrl = "https://proyecto-sena-backend-s666.onrender.com/api"; // Reemplaza <TU_IP> con la dirección IP de tu servidor

  Future<List<Maquina>> getAllMaquinas() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/maquinas'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Maquina> maquinas = (data['maquinas'] as List)
            .map((maquinaJson) => Maquina.fromJson(maquinaJson))
            .toList();
        return maquinas;
      } else {
        throw Exception('Error al obtener las máquinas');
      }
      
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
