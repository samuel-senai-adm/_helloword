import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carteira Digital"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CartaoWidget(
            cor: Colors.blue,
            banco: "Banco SENAI",
            numero: "1111 2222 3333 4444",
            titular: "Samuel Dias",
            validade: "10/30",
          ),
          SizedBox(height: 16),
          CartaoWidget(
            cor: Colors.brown,
            banco: "Banco SESI",
            numero: "5555 6666 7777 8888",
            titular: "Maria Silva",
            validade: "12/30",
          ),
          SizedBox(height: 16),
          CartaoWidget(
            cor: Colors.purple,
            banco: "Nubank",
            numero: "9999 0000 1111 2222",
            titular: "João Oliveira",
            validade: "08/30",
          ),
        ],
      ),
    );
  }
}

class CartaoWidget extends StatelessWidget {
  final Color cor;
  final String banco;
  final String numero;
  final String titular;
  final String validade;

  const CartaoWidget({
    super.key,
    required this.cor,
    required this.banco,
    required this.numero,
    required this.titular,
    required this.validade,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOPO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                banco,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.credit_card, color: Colors.white),
                  SizedBox(width: 8),
                  Icon(Icons.contactless, color: Colors.white),
                ],
              ),
            ],
          ),

          const Spacer(),

          // NÚMERO
          Text(
            numero,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 10),

          // TITULAR E VALIDADE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titular,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                validade,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}