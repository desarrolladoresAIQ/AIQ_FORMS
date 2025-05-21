import 'package:flutter/material.dart';
import 'forms_select.dart'; // Ya sin espacio

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Avion-bg3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Fuerza altura de pantalla
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/AIQ_LOGO.png',
                    width: 440,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 450),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text(
      'Bienvenido al Aeropuerto Intercontinental de Querétaro',
      style: TextStyle(
        color: Color.fromARGB(255, 35, 50, 88),
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontFamily: 'Avenir',
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 226, 235, 247), // Fondo azul oscuro
    elevation: 2,
    behavior: SnackBarBehavior.floating, // Se despega de la parte inferior
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    duration: const Duration(seconds: 3),
  ),
);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 31, 56, 88),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'COMENZAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.5,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
