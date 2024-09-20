import 'package:app_movil_coffe/src/models/tipo_proceso_model.dart';
import 'package:app_movil_coffe/src/models/usuario_model.dart';
import 'package:app_movil_coffe/src/models/variedad.model.dart';

class LoteCafe {
  final String id;
  final double peso;
  final Usuario proveedor;
  final TipoProceso tipoProceso;
  final Variedad variedad;

  LoteCafe({
    required this.id,
    required this.peso,
    required this.proveedor,
    required this.tipoProceso,
    required this.variedad,
  });

  // Método para crear una instancia de LoteCafe a partir de un JSON
  factory LoteCafe.fromJson(Map<String, dynamic> json) {
    return LoteCafe(
      id: json['_id'], 
      peso: json['peso'].toDouble(),
      proveedor: Usuario.fromJson(json['proveedor']),
      tipoProceso: TipoProceso.fromJson(json['tipoProceso']),
      variedad: Variedad.fromJson(json['variedad']),
    );
  }
}
