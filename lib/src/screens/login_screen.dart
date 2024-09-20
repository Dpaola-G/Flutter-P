import 'package:app_movil_coffe/Animations/FadeAnimation.dart';
import 'package:app_movil_coffe/src/controllers/login_controller.dart';
import 'package:app_movil_coffe/src/models/usuario_model.dart';
import 'package:app_movil_coffe/src/provider/user_provider.dart';
import 'package:app_movil_coffe/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _obscureText = true;

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    AuthService authService = AuthService();
    final response = await authService.login(email, password);

    if (response['success']) {
      // Si el login es exitoso, navega a la nueva pantalla con animación
      final user = response['user'];
      final usuario = Usuario.fromJson(user);

      // Guarda el usuario en UserProvider
      Provider.of<UserProvider>(context, listen: false).setUser(usuario);

      // Navegar a la siguiente pantalla con la animación Slide
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Comienza desde la derecha
            const end = Offset.zero; // Termina en la posición actual
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else {
      // Mostrar un mensaje de error si la autenticación falla
      final message = response['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeAnimation(
            1.5,
            Container(
              height: 500,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 41, 28, 171),
                    Color.fromARGB(255, 0, 0, 116)
                  ]),
                  // color: const Color.fromARGB(255, 41, 28, 171),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
            ),
          ),
          Positioned.fill(
            top: 110,
            child: Align(
              alignment: Alignment.topCenter,
              child: FadeAnimation(
                  1.5,
                  Image.asset(
                    'assets/logo.png',
                    scale: 0.9,
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 350, left: 40, right: 40, bottom: 40),
              child: SafeArea(
                child: FadeAnimation(
                  1.8,
                  SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 10,
                            blurStyle: BlurStyle.normal,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 50),
                        child: Center(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Text(
                                    'Bienvenido',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 41, 28, 171),
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 239, 238, 238),
                                        labelText: "Email",
                                        labelStyle: const TextStyle(
                                          // backgroundColor: Colors.white,
                                          fontSize: 15,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        hintStyle:
                                            const TextStyle(fontSize: 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 41, 28, 171),
                                              width:
                                                  2.0), // Color del borde cuando está en foco
                                        ),
                                        errorStyle: const TextStyle(
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14.0)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "email requerido";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 239, 238, 238),
                                        labelText: "Contraseña",
                                        labelStyle: const TextStyle(
                                          // backgroundColor: Colors.white,
                                          fontSize: 15,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        hintStyle:
                                            const TextStyle(fontSize: 15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 41, 28, 171),
                                              width:
                                                  2.0), // Color del borde cuando está en foco
                                        ),
                                        errorStyle: const TextStyle(
                                            color: Colors.red,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14.0),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          child: Icon(_obscureText
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined),
                                        )),
                                    obscureText: _obscureText,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Contraseña requerida";
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: const Text(
                                        "Restablecer Contraseña",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 41, 28, 171),
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color.fromARGB(
                                                255, 41, 28, 171)),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 20),
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color.fromARGB(
                                          255, 41, 28, 171),
                                      padding: const EdgeInsets.all(8),
                                      minimumSize: const Size(350, 53),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _login();

                                        // User userData = User(name:_name, password: _password);

                                        // // Navegación con transición Slide desde la derecha
                                        // Navigator.of(context).pushReplacement(
                                        //   PageRouteBuilder(
                                        //     pageBuilder: (context, animation, secondaryAnimation) => MainScreen(userData: userData),
                                        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        //       const begin = Offset(1.0, 0.0);
                                        //       const end = Offset.zero;
                                        //       const curve = Curves.ease;
                                        //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        //       var offsetAnimation = animation.drive(tween);

                                        //       return SlideTransition(
                                        //         position: offsetAnimation,
                                        //         child: child,
                                        //       );
                                        //     },
                                        //   ),
                                        // );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Credenciales incorrectas')),
                                        );
                                      }
                                    },
                                    child: const Text('Ingresar'),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              // child: Image.asset('assets/logo.png')),

              )
        ],
      ),
    );
  }
}
