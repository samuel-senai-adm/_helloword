import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const DistanciaApp());
}

class DistanciaApp extends StatelessWidget {
  const DistanciaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Distância',
      home: TelaDistancia(),
    );
  }
}

class TelaDistancia extends StatefulWidget {
  const TelaDistancia({super.key});

  @override
  State<TelaDistancia> createState() => _TelaDistanciaState();
}

class _TelaDistanciaState extends State<TelaDistancia> {
  // Coordenadas da minha casa
  // Rua Pedro Picoli, nº 289
  // Jardim Chico Piscina - Mococa/SP
  final double latitudeCasa = -21.48014;
  final double longitudeCasa = -47.00545;

  String resultado = 'Clique no botão para calcular a distância.';
  bool carregando = false;

  Future<void> calcularDistancia() async {
    setState(() {
      carregando = true;
      resultado = 'Calculando...';
    });

    try {
      // Verifica se o GPS está ligado
      bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

      if (!servicoAtivo) {
        await Geolocator.openLocationSettings();

        setState(() {
          resultado = 'Ative a localização do celular e tente novamente.';
          carregando = false;
        });

        return;
      }

      // Verifica permissão
      LocationPermission permissao = await Geolocator.checkPermission();

      if (permissao == LocationPermission.denied) {
        permissao = await Geolocator.requestPermission();
      }

      if (permissao == LocationPermission.denied ||
          permissao == LocationPermission.deniedForever) {
        setState(() {
          resultado = 'Permissão de localização negada.';
          carregando = false;
        });

        return;
      }

      // Pega a localização atual do celular
      Position localAtual = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Calcula a distância em linha reta
      double distanciaMetros = Geolocator.distanceBetween(
        localAtual.latitude,
        localAtual.longitude,
        latitudeCasa,
        longitudeCasa,
      );

      double distanciaKm = distanciaMetros / 1000;

      setState(() {
        resultado =
            'Distância em linha reta:\n'
            '${distanciaKm.toStringAsFixed(2)} km\n\n'
            'Localização atual:\n'
            '${localAtual.latitude.toStringAsFixed(5)}, '
            '${localAtual.longitude.toStringAsFixed(5)}';

        carregando = false;
      });
    } catch (e) {
      setState(() {
        resultado = 'Erro ao calcular a distância.';
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Distância'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 90, color: Colors.red),

              const SizedBox(height: 20),

              const Text(
                'SESI 357 até minha casa',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Rua Pedro Picoli, nº 289\n'
                'Jardim Chico Piscina - Mococa/SP',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 35),

              Text(
                resultado,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: carregando ? null : calcularDistancia,

                  icon: carregando
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.calculate),

                  label: Text(
                    carregando ? 'Calculando...' : 'Calcular Distância',

                    style: const TextStyle(fontSize: 16),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
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
