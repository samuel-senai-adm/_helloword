import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const AppConsultas());
}

class AppConsultas extends StatelessWidget {
  const AppConsultas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agendamento de Consultas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaPrincipal(),
    );
  }
}

class Consulta {
  String paciente;
  String medico;
  String especialidade;
  String data;
  String horario;

  Consulta({
    required this.paciente,
    required this.medico,
    required this.especialidade,
    required this.data,
    required this.horario,
  });
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<Consulta> consultas = [];

  final AudioPlayer player = AudioPlayer();

  void adicionarConsulta() {
    TextEditingController paciente = TextEditingController();
    TextEditingController medico = TextEditingController();
    TextEditingController especialidade = TextEditingController();
    TextEditingController data = TextEditingController();
    TextEditingController horario = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Nova Consulta",
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: paciente,
                  decoration: const InputDecoration(
                    labelText: "Nome do paciente",
                  ),
                ),
                TextField(
                  controller: medico,
                  decoration: const InputDecoration(
                    labelText: "Nome do médico",
                  ),
                ),
                TextField(
                  controller: especialidade,
                  decoration: const InputDecoration(
                    labelText: "Especialidade",
                  ),
                ),
                TextField(
                  controller: data,
                  decoration: const InputDecoration(
                    labelText: "Data da consulta",
                  ),
                ),
                TextField(
                  controller: horario,
                  decoration: const InputDecoration(
                    labelText: "Horário",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Salvar"),
              onPressed: () async {

                await player.play(
                  AssetSource('audio/som.mp3'),
                );

                setState(() {
                  consultas.add(
                    Consulta(
                      paciente: paciente.text,
                      medico: medico.text,
                      especialidade: especialidade.text,
                      data: data.text,
                      horario: horario.text,
                    ),
                  );
                });

                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void removerConsulta(int index) {
    setState(() {
      consultas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agendamento de Consultas",
        ),
        centerTitle: true,
      ),
      body: consultas.isEmpty
          ? const Center(
              child: Text(
                "Nenhuma consulta agendada",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              itemCount: consultas.length,
              itemBuilder: (context, index) {
                final consulta = consultas[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.medical_services,
                      color: Colors.blue,
                    ),
                    title: Text(
                      consulta.paciente,
                    ),
                    subtitle: Text(
                      "Médico: ${consulta.medico}\n"
                      "Especialidade: ${consulta.especialidade}\n"
                      "Data: ${consulta.data}\n"
                      "Horário: ${consulta.horario}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        removerConsulta(index);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarConsulta,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
