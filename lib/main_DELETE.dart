import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TelaExcluir(),
    );
  }
}

class TelaExcluir extends StatefulWidget {
  const TelaExcluir({super.key});

  @override
  State<TelaExcluir> createState() => _TelaExcluirState();
}

class _TelaExcluirState extends State<TelaExcluir> {
  final TextEditingController idController = TextEditingController();

  String mensagem = '';

  Future<void> excluirSensor() async {
    final id = int.tryParse(idController.text);

    if (id == null) {
      setState(() {
        mensagem = 'Digite um ID válido.';
      });
      return;
    }

    try {
      final resposta = await http.delete(
        Uri.parse('http://10.140.169.22/iot/sensores.php'),

        headers: {
          'Content-Type': 'application/json',
        }, 

        body: jsonEncode({
          'id': id,
        }),
      );

      final dados = jsonDecode(resposta.body);

      if (resposta.statusCode == 200) {
        setState(() {
          mensagem = dados['mensagem'] ?? dados['erro'];
        });
      } else {
        setState(() {
          mensagem = 'Erro: ${resposta.statusCode}';
        });
      }
    } catch (erro) {
      setState(() {
        mensagem = 'Erro na requisição: $erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excluir Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ID do sensor',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: excluirSensor,
              child: const Text('Excluir Sensor'),
            ),

            const SizedBox(height: 20),

            Text(mensagem),
          ],
        ),
      ),
    );
  }
}