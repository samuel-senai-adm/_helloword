import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp inicia o aplicativo
    return MaterialApp(home: TelaFormulario());
  }
}

class TelaFormulario extends StatefulWidget {
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  // Controla o TextField do nome
  final nomeController = TextEditingController();

  // Controla o TextField da idade
  final idadeController = TextEditingController();

  // Variável do DropdownButton
  String sexo = 'Masculino';

  // Variável do Switch
  bool notificacoes = false;

  // Variável do Checkbox
  bool temHabilitacao = false;

  // Variável da saída
  String resultado = "";

  // Variável da idade
  int idade = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(title: Text("Formulário Simples")),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            // Campo de texto do nome
            TextField(
              controller: nomeController,

              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            // Campo de texto da idade
            TextField(
              controller: idadeController,

              decoration: InputDecoration(
                labelText: "Idade",
                border: OutlineInputBorder(),
              ),

              keyboardType: TextInputType.number,

              // Atualiza a idade automaticamente
              onChanged: (valor) {
                setState(() {
                  idade = int.tryParse(valor) ?? 0;
                });
              },
            ),

            SizedBox(height: 10),

            // Menu de seleção
            DropdownButton<String>(
              value: sexo,

              items: [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),

                DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),

                DropdownMenuItem(value: 'Outro', child: Text('Outro')),
              ],

              onChanged: (valor) {
                setState(() {
                  sexo = valor!;
                });
              },
            ),

            SizedBox(height: 10),

            Row(
              children: [
                // Caixa de seleção
                Checkbox(
                  value: temHabilitacao,

                  // Só permite clicar se idade >= 18
                  onChanged: idade >= 18
                      ? (valor) {
                          setState(() {
                            temHabilitacao = valor!;
                          });
                        }
                      : null,
                ),

                Text("Possui habilitação"),
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // PROCESSAMENTO
                if (idade >= 18 && temHabilitacao) {
                  resultado = "Pode dirigir";
                } else {
                  resultado = "Não pode dirigir";
                }

                // Atualiza a tela
                setState(() {});

                // Saída no console
                print("Nome: ${nomeController.text}");
                print("Idade: $idade");
                print("Sexo: $sexo");
                print("Notificações: $notificacoes");
                print("Habilitação: $temHabilitacao");
              },

              child: Text("Mostrar Dados"),
            ),

            SizedBox(height: 20),


            // SAÍDA
            Text(resultado, style: TextStyle(fontSize: 20)),

            SizedBox(height: 20),

            Row(
              children: [
                // Botão liga/desliga
                Switch(
                  value: notificacoes,

                  onChanged: (valor) {
                    setState(() {
                      notificacoes = valor;
                    });
                  },
                ),

                Text("Exemplo Switch"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
