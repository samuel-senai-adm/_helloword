import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SensorPage(),
    );
  }
}

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  double x = 0;
  double y = 0;
  double z = 0;

  // Valores anteriores do acelerômetro
  double ultimoX = 0;
  double ultimoY = 0;
  double ultimoZ = 0;

  // Indica se o celular está sendo movimentado
  bool movimentando = false;

  // Guarda a conexão com o sensor
  StreamSubscription? acelerometro;

  @override
  void initState() {
    super.initState();

    // Recebe os valores do acelerômetro
    acelerometro = accelerometerEventStream().listen((event) {
      // Calcula quanto os valores mudaram
      double diferencaX = (event.x - ultimoX).abs();
      double diferencaY = (event.y - ultimoY).abs();
      double diferencaZ = (event.z - ultimoZ).abs();

      // Define o limite para considerar que houve movimento
      bool houveMovimento =
          diferencaX > 1.5 ||
          diferencaY > 1.5 ||
          diferencaZ > 1.5;

      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        movimentando = houveMovimento;

        // Guarda os valores atuais para comparar na próxima leitura
        ultimoX = event.x;
        ultimoY = event.y;
        ultimoZ = event.z;
      });
    });
  }

  @override
  void dispose() {
    acelerometro?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor do celular'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Acelerômetro',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              'X: ${x.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),

            Text(
              'Y: ${y.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),

            Text(
              'Z: ${z.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 40),

            // Indica se o celular está parado ou em movimento
            Text(
              movimentando ? 'CELULAR EM MOVIMENTO' : 'CELULAR PARADO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: movimentando ? Colors.red : Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // Altera a informação na tela quando há movimento
            Icon(
              movimentando ? Icons.vibration : Icons.phone_android,
              size: 50,
              color: movimentando ? Colors.red : Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}