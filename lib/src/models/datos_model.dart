import 'package:app_movil_coffe/src/models/seguimiento_model.dart';

class Datos {
  final String id;
  final Seguimiento seguimiento;
  final String temperaturaAmbiente;
  final String temperaturaSensor;
  final String maquina;
  final bool rotor;
  final bool motor;
  final DateTime fecha;

  Datos({
    required this.id,
    required this.seguimiento,
    required this.temperaturaAmbiente,
    required this.temperaturaSensor,
    required this.maquina,
    required this.rotor,
    required this.motor,
    required this.fecha,
  });

  // Método para crear una instancia de Dato a partir de un JSON
  factory Datos.fromJson(Map<String, dynamic> json) {
    return Datos(
      id: json['_id'],
      seguimiento: json['seguimiento'], // Si el ID está incluido en el JSON
      temperaturaAmbiente: json['temperaturaAmbiente'],
      temperaturaSensor: json['temperaturaSensor'],
      maquina: json['maquina'],
      rotor: json['rotor'],
      motor: json['motor'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  // Método para convertir una instancia de Dato a JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'temperaturaAmbiente': temperaturaAmbiente,
      'temperaturaSensor': temperaturaSensor,
      'maquina': maquina,
      'rotor': rotor,
      'motor': motor,
      'fecha': fecha.toIso8601String(),
    };
  }
}
