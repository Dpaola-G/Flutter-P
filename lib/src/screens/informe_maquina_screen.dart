import 'package:app_movil_coffe/src/Widgets/curva_appbar.dart';
import 'package:app_movil_coffe/src/Widgets/grafica_widget.dart';
import 'package:app_movil_coffe/src/controllers/seguimiento_controller.dart';
import 'package:app_movil_coffe/src/models/maquina_model.dart';
import 'package:app_movil_coffe/src/models/seguimiento_model.dart';
import 'package:app_movil_coffe/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Pantalla principal que muestra el informe de la máquina.
class InformeMaquinaScreen extends StatefulWidget {
  final Maquina maquina;
  const InformeMaquinaScreen({super.key, required this.maquina});

  @override
  State<InformeMaquinaScreen> createState() => _InformeMaquinaScreenState();
}

class _InformeMaquinaScreenState extends State<InformeMaquinaScreen> {
  bool temporizador = false;
  bool inicio = false;

  late Maquina maquina;
  Seguimiento? seguimiento;

  @override
  void initState() {
    super.initState();
    maquina = widget.maquina;
    _fetchSeguimiento();
  }

  Future<void> _fetchSeguimiento() async {
    try {
      final seguimientoData =
          await SeguimientoController().getSeguimientoByMaquinaId(maquina.id);
      setState(() {
        seguimiento = seguimientoData;
      });
    } catch (e) {
      print('Error al obtener seguimiento: $e');
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
            foregroundColor: Colors.white,
            toolbarHeight: 90,
            shadowColor: Colors.grey,
            scrolledUnderElevation: 20.0,
            backgroundColor: const Color.fromARGB(255, 41, 28, 171),
            title: Text(
              usuario!.nombreCompleto,
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 1, right: 20),
                child: Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      maquina.idInterno,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 41, 28, 171),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información sobre el propietario del café.
              Row(
                children: [
                  const Text(
                    'Propietario:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    seguimiento?.loteCafe.proveedor.nombreCompleto ??
                        'Cargando...',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 25),

              // Información sobre el tipo de café.
              Row(
                children: [
                  const Text(
                    "Tipo café:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    seguimiento?.loteCafe.variedad.nombre ?? 'Cargando...',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 25),

              // Información sobre el tipo de proceso.
              Row(
                children: [
                  const Text(
                    "Tipo Proceso:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    seguimiento?.loteCafe.tipoProceso.nombre ?? 'Cargando...',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 25),

              // Información sobre la fecha y hora de inicio del proceso.
              Row(
                children: [
                  const Text(
                    "Fecha y hora de inicio de proceso:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    seguimiento != null
                        ? '${seguimiento!.fecha.day}/${seguimiento!.fecha.month}/${seguimiento!.fecha.year} ${seguimiento!.fecha.hour}:${seguimiento!.fecha.minute}'
                        : 'Cargando...',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
              const SizedBox(height: 35),

              // Dos columnas que muestran la temperatura relativa y la temperatura interna.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Columna para la temperatura relativa.
                  Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: const Icon(
                          Icons.air,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Temperatura relativa",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 18, 182, 23),
                        ),
                        child: Center(
                          child: Text(
                            '00',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Columna para la temperatura interna.
                  Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: const Icon(
                          Icons.settings,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Temperatura interna",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(197, 26, 101, 231),
                        ),
                        child: Center(
                          child: Text(
                            // seguimiento?.datos?.last.temperaturaSensor.toString() ??
                            '00',
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //Grafica Lineal
              if (seguimiento != null)
                LinealCharts(),

                // Información sobre la humedad final del café.
                const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Humedad final del café",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("00,00"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Texto que indica finalizar el proceso.
              const Center(
                child: Text(
                  'Finalizar proceso',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 25),

              // Switch para activar/desactivar el temporizador.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Temporizador',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 10),
                  Switch(
                    inactiveThumbColor: Colors.grey,
                    activeTrackColor: const Color.fromARGB(255, 229, 227, 248),
                    activeColor: const Color.fromARGB(255, 41, 28, 171),
                    value: temporizador,
                    onChanged: (value) {
                      setState(() {
                        temporizador = value;
                      });
                    },
                  ),
                ],
              ),
              // Si el temporizador está activado, muestra el campo de texto.
              if (temporizador)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ingrese el tiempo',
                    ),
                  ),
                ),
              const SizedBox(height: 25),

              // Botón para iniciar el proceso.
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: inicio
                        ? Colors.grey
                        : const Color.fromARGB(255, 41, 28, 171),
                  ),
                  onPressed: () {
                    setState(() {
                      inicio = !inicio;
                    });
                  },
                  child: const Text("Iniciar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
