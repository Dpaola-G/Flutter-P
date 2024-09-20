class Maquina{
  final String id;
  final String idInterno;
  final String nombre;
  final String estado;

  Maquina({required this.id, required this.idInterno, required this.nombre, required this.estado});

  //Metodo para crear un objeto Maquina a partir de un JSON
  factory Maquina.fromJson (Map<String,dynamic> json){
    return Maquina(
      id: json['_id'], 
      idInterno: json['id'], 
      nombre: json['nombre'], 
      estado: json['estado']);
  }
}