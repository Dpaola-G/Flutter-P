import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Importa tus modelos y pantallas aquí
import 'package:app_movil_coffe/src/models/usuario_model.dart';
import 'package:app_movil_coffe/src/provider/user_provider.dart';
import 'package:app_movil_coffe/src/screens/home_screen.dart';
import 'package:app_movil_coffe/src/controllers/maquinas_controller.dart';
import 'package:app_movil_coffe/src/models/maquina_model.dart';

// Mocks
class MockMaquinaService extends Mock implements MaquinaService {}
class MockUserProvider extends Mock implements UserProvider {}

void main() {
  late MockMaquinaService mockMaquinaService;
  late MockUserProvider mockUserProvider;

  setUp(() {
    mockMaquinaService = MockMaquinaService();
    mockUserProvider = MockUserProvider();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: mockUserProvider),
        Provider<MaquinaService>.value(value: mockMaquinaService),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  testWidgets('Debe mostrar CircularProgressIndicator mientras carga las máquinas', (WidgetTester tester) async {
    // Simular el retorno de una lista vacía de máquinas
    when(mockMaquinaService.getAllMaquinas()).thenAnswer((_) async => []);
    when(mockUserProvider.user).thenReturn(Usuario(
      id: '123',
      username: 'testuser',
      cedula: '1234567890',
      nombreCompleto: 'Test User',
      telefono: '123456789',
      direccion: 'Test Address',
      email: 'test@example.com',
      estado: true,
      tipoUsuario: 'admin',
    ));

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Debe mostrar mensaje cuando no se encuentran máquinas', (WidgetTester tester) async {
    // Simular el retorno de una lista vacía de máquinas
    when(mockMaquinaService.getAllMaquinas()).thenAnswer((_) async => []);
    when(mockUserProvider.user).thenReturn(Usuario(
      id: '123',
      username: 'testuser',
      cedula: '1234567890',
      nombreCompleto: 'Test User',
      telefono: '123456789',
      direccion: 'Test Address',
      email: 'test@example.com',
      estado: true,
      tipoUsuario: 'admin',
    ));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('No se encontraron máquinas'), findsOneWidget);
  });
}
