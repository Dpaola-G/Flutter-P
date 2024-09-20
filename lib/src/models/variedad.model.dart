class Variedad{
  final String id;
  final String nombre;

  Variedad({required this.id, required this.nombre});

  //Mertodo para crear un objeto Variedad a partit de un JSON
  factory Variedad.fromJson(Map<String,dynamic>json){
    return Variedad(
      id: json['_id'], 
      nombre: json['nombre']);
  }
}