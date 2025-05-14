import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFD5DAED),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo del aeropuerto
              Image.asset(
                'assets/AIQ_LOGO.png',
                width: 230,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 40),
              // Avión con fondo circular degradado
              SizedBox(
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Círculo degradado
                    Container(
                      width: 220,
                      height: 220,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color.fromARGB(255, 246, 246, 247),
                            Color(0xFFD5DAED),
                          ],
                          center: Alignment.center,
                          radius: 0.55,
                        ),
                      ),
                    ),
                    // Imagen del avión
                    Image.asset(
                      'assets/Avion-one.png',
                      fit: BoxFit.contain,
                      width: 450,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Botón "COMENZAR"
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bienvenido al Aeropuerto Intercontinental de Querétaro'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F3A5F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'COMENZAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1.5,
                    fontFamily: 'Avenir',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
