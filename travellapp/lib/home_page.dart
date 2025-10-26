import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Robotic Login',
      theme: ThemeData.dark(),
      home: const RoboticLoginPage(),
    );
  }
}

class RoboticLoginPage extends StatefulWidget {
  const RoboticLoginPage({super.key});

  @override
  State<RoboticLoginPage> createState() => _RoboticLoginPageState();
}

class _RoboticLoginPageState extends State<RoboticLoginPage>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  late AnimationController _glowController;
  late AnimationController _scanController;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _scanController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          CustomPaint(size: MediaQuery.of(context).size, painter: GridPainter()),

          AnimatedBuilder(
            animation: _scanController,
            builder: (context, _) {
              final posY = MediaQuery.of(context).size.height * _scanController.value;
              return Positioned(
                top: posY,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.cyanAccent.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.cyanAccent.withOpacity(0.4),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _rotateController,
                        builder: (context, _) {
                          return Transform.rotate(
                            angle: _rotateController.value * 2 * pi,
                            child: const Icon(
                              Icons.android_outlined,
                              color: Colors.cyanAccent,
                              size: 90,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "ROBO LOGIN",
                        style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 26,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      const SizedBox(height: 30),

                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outline, color: Colors.cyanAccent),
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.cyanAccent),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyanAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        controller: _passwordController,
                        obscureText: _obscure,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.cyanAccent),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.cyanAccent,
                            ),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.cyanAccent),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.cyanAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: 30),

                      AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, _) {
                          double glowValue =
                              0.4 + (_glowController.value * 0.6);
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Colors.cyanAccent, Colors.lightBlueAccent],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(glowValue),
                                  blurRadius: 25,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "No account?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withOpacity(0.15)
      ..strokeWidth = 0.5;

    const gridSize = 40.0;
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}