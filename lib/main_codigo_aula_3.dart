import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // REMOVE A FAIXA "DEBUG"
      debugShowCheckedModeBanner: false,
      title: 'Listas Dinâmicas',
      // TEMA DO APLICATIVO
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TelaListaDinamica(),
    );
  }
}

// STATEFULWIDGET
// USAMOS QUANDO A TELA PRECISA ATUALIZAR
class TelaListaDinamica extends StatefulWidget {
  const TelaListaDinamica({super.key});

  @override
  State<TelaListaDinamica> createState() =>
      _TelaListaDinamicaState();
}

// ESTADO DA TELA
class _TelaListaDinamicaState
    extends State<TelaListaDinamica> {
  // CONTROLA O CAMPO DE TEXTO
  // PERMITE PEGAR O QUE O USUÁRIO DIGITOU
  final TextEditingController controller =
      TextEditingController();
  // LISTA DE TAREFAS
  // CADA ITEM POSSUI:
  // titulo
  // concluida
  List<Map<String, dynamic>> tarefas = [

    {"titulo": "Estudar Flutter",
      "concluida": false,},

    {"titulo": "Fazer exercícios",
      "concluida": false,},

    {"titulo": "Criar projeto",
      "concluida": false,},
  ];

  // FUNÇÃO PARA ADICIONAR NOVA TAREFA
  void adicionarTarefa() {
    if (controller.text.trim().isEmpty) {
        return;
    }
    setState(() {
      tarefas.add({
        "titulo": controller.text,
        "concluida": false,
      });
    });

    controller.clear();
  }

  // FUNÇÃO PARA REMOVER TAREFA
  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  // ALTERA O STATUS DO CHECKBOX
  void alterarStatus(bool? valor, int index) {
    setState(() {
      tarefas[index]["concluida"] = valor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listas Dinâmicas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              // CONTROLLER LIGADO AO CAMPO
              controller: controller,
              decoration: InputDecoration(
                // TEXTO DE AJUDA
                labelText: "Digite uma tarefa",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                // ÍCONE DENTRO DO CAMPO
                suffixIcon: IconButton(
                  // ÍCONE "+"
                  icon: const Icon(Icons.add),
                  onPressed: adicionarTarefa,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TEXTO MOSTRANDO QUANTIDADE
            Text(
              // INTERPOLAÇÃO
              "Total de tarefas: ${tarefas.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // EXPANDED OCUPA O RESTANTE DA TELA
            Expanded(
              // CRIA LISTA DINÂMICA
              child: ListView.builder(
                // QUANTIDADE DE ITENS
                itemCount: tarefas.length,
                // CRIA CADA ITEM
                itemBuilder: (context, index) {
                  // CARD CRIA UM BLOCO VISUAL
                  return Card(
                    // SOMBRA
                    elevation: 3,
                    // ESPAÇO ENTRE OS CARDS
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: ListTile(
                      // LADO ESQUERDO
                      leading: Checkbox(
                        // VALOR DO CHECKBOX
                        value:
                            tarefas[index]["concluida"],

                        // AO ALTERAR
                        onChanged: (valor) {

                          // CHAMA FUNÇÃO
                          alterarStatus(
                              valor, index);
                        },
                      ),

                      // TEXTO PRINCIPAL
                      title: Text(

                        // MOSTRA O TÍTULO
                        tarefas[index]["titulo"],

                        style: TextStyle(

                          fontSize: 18,

                          // RISCA O TEXTO SE ESTIVER CONCLUÍDO
                          decoration:
                              tarefas[index]
                                      ["concluida"]
                                  ? TextDecoration
                                      .lineThrough
                                  : TextDecoration
                                      .none,
                        ),
                      ),

                      // BOTÃO DIREITO Deletar
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {

                          // REMOVE O ITEM
                          removerTarefa(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // BOTÃO FLUTUANTE +
      floatingActionButton:
          FloatingActionButton(
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}