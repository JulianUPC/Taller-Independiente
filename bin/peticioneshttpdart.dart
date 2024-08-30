import 'dart:convert'; // Para convertir la respuesta a JSON
import 'package:http/http.dart' as http;
import 'Usuario.dart'; // Importa la clase Usuario

Future<void> fetchUsers() async {
  final url = 'https://jsonplaceholder.typicode.com/users';

  try {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      final List<Usuario> usuarios = jsonResponse.map((json) => Usuario.fromJson(json)).toList();

      // Imprimir todos los datos de los usuarios de la API
      /*for (var usuario in usuarios) {
        print('ID: ${usuario.id}');
        print('Nombre: ${usuario.name}');
        print('Username: ${usuario.username}');  
        print('Correo: ${usuario.email}');
        print('----------------------');
      }*/

      filtrar_usuario(usuarios);
      usuariosconbiz(usuarios);
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Funcion para filtrar y mostrar usuarios con username de mas de 6 caracteres
void filtrar_usuario(List<Usuario> usuarios) {
  final contadorusuario = usuarios.where((usuario) => usuario.username.length > 6).toList();
  print('Usuarios de la API con username de mas de 6 caracteres:\n');
  for (var usuario in contadorusuario) {
    print('ID: ${usuario.id}');
    print('Nombre: ${usuario.name}');
    print('Username: ${usuario.username}');
    print('Correo: ${usuario.email}');
    print('----------------------');
  }
}

// Funcion para contar e imprimir usuarios con correo electronico que termina en 'biz'
void usuariosconbiz(List<Usuario> usuario) {
  final contador = usuario.where((Usuario) => Usuario.email.endsWith('biz')).length;
  print('Cantidad de usuarios en la API con correo electrónico que termina en "biz": ${contador + 1}');
}

void main() {
  fetchUsers();
}