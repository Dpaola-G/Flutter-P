import 'package:app_movil_coffe/src/Widgets/card_build.dart';
import 'package:app_movil_coffe/src/Widgets/curva_appbar.dart';
import 'package:app_movil_coffe/src/controllers/maquinas_controller.dart';
import 'package:app_movil_coffe/src/models/maquina_model.dart';
import 'package:app_movil_coffe/src/provider/user_provider.dart';
import 'package:app_movil_coffe/src/screens/formulario_proceso_screen.dart';
import 'package:app_movil_coffe/src/screens/informe_maquina_screen.dart';
import 'package:app_movil_coffe/src/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Maquina> maquinas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _traerMaquinas();
  }

  void _traerMaquinas() async {
    try {
      List<Maquina> getAllMaquinas = await MaquinaService().getAllMaquinas();
      setState(() {
        maquinas = getAllMaquinas;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error al obtener las maquinas : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: ClipPath(
          clipper: CurveAppBar(),
          child: AppBar(
            toolbarHeight: 90,
            shadowColor: Colors.grey,
            scrolledUnderElevation: 20.0,
            backgroundColor: const Color.fromARGB(255, 41, 28, 171),
            title: Text(
              usuario!.nombreCompleto,
              style: const TextStyle(fontSize: 35, color: Colors.white),
            ),
            actions: [
              IconButton(
                padding: const EdgeInsets.all(8.0),
                iconSize: 25,
                alignment: Alignment.topCenter,
                onPressed: () {
                  // Crea una instancia de AuthService
                  // AuthService authService = AuthService();

                  // Llama al método logout y pasa el contexto actual
                  // await authService.logout(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) =>
                        false, // Esto eliminará todas las pantallas anteriores
                  );
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : maquinas.isEmpty
              ? const Center(child: Text('No se encontraron máquinas'))
              : Column(
                  children: [
                    // Center(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: CircleAvatar(
                    //       radius: 90,
                    //       backgroundColor: const Color.fromARGB(255, 41, 28, 171),
                    //       child: Image.asset(
                    //         'assets/logo.png',
                    //         height: 120,
                    //         width: 120,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 30),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.black,
                              ],
                              stops: [0.0, 0.1, 0.9, 1.0],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: maquinas.length,
                            itemBuilder: (context, index) {
                              final maquina = maquinas[index];
                              return GestureDetector(
                                onTap: (){
                                  if (maquina.estado=='Activo') {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InformeMaquinaScreen(maquina:maquina)));
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InformeScreen(maquina:maquina)));
                                  }
                                  
                                },
                                child: buildCard(
                                  
                                  maquina.nombre,
                                  maquina.estado == 'Activo',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
