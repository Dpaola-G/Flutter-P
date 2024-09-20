// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:app_movil_coffe/src/Widgets/curva_appbar.dart';
// import 'package:app_movil_coffe/src/models/maquina_model.dart';
// import 'package:app_movil_coffe/src/screens/formulario_proceso_screen.dart';

// void main() {
//   testWidgets('Verificar que el formulario se renderiza correctamente', (WidgetTester tester) async {
//     // Crear un widget para pruebas
//     await tester.pumpWidget(
//       MaterialApp(
//         home: InformeScreen(
//           maquina: Maquina(id: '1', idInterno: '001', nombre: 'M1', estado: 'activa'),
//         ),
//       ),
//     );

//     expect(find.text('CREACION DEL PROCESO'), findsOneWidget);
//     expect(find.text('Origen del café'), findsOneWidget);
//     expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(3));
//     expect(find.text('Descripción'), findsOneWidget); 
//     expect(find.text('Peso del café (Kg)'), findsOneWidget);
//     expect(find.byIcon(Icons.power_settings_new_rounded), findsOneWidget);
//   });
// }
