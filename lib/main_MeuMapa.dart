import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatelessWidget {
  const MapaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Mapa')),

      body: FlutterMap(
        //componente responsavel pelo mapa
        options: const MapOptions(
          //definições iniciais do mapa
          initialCenter: LatLng(-21.470000, -47.030000),
          initialZoom: 13,
        ),

        children: [
          TileLayer(
            //carrega as imagens que forma o mapa
            urlTemplate: 'https://tile.openstreemap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),
        ],
      ),
    );
  }
}
