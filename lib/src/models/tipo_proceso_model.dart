class TipoProceso{
  final String id;
  final String nombre;
  final String descripcion;

  TipoProceso({required this.id, required this.nombre, required this.descripcion});

  factory TipoProceso.fromJson(Map<String,dynamic>json){
    return TipoProceso(
      id: json['_id'], 
      nombre: json['nombre'], 
      descripcion: json['descripcion']);
  }

}