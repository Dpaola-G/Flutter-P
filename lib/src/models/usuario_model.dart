

class Usuario {
  final String id; 
  final String username;
  final String cedula;
  final String nombreCompleto;
  final String telefono;
  final String direccion;
  final String email;
  final bool estado;
  final String? foto; // Puede ser nulo si no se proporciona
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.username,
    required this.cedula,
    required this.nombreCompleto,
    required this.telefono,
    required this.direccion,
    required this.email,
    required this.estado,
    this.foto,
    required this.tipoUsuario,
  });

  // Método para crear un objeto Usuario a partir de un JSON
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      username: json['username'],
      cedula: json['cedula'],
      nombreCompleto: json['nombreCompleto'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      email: json['email'],
      estado: json['estado'],
      foto: json['foto'],
      tipoUsuario: json['tipoUsuario'],
    );
  }
}