import 'package:flutter/material.dart';

// FUNÇÃO PRINCIPAL
void main() {

  // INICIA O APLICATIVO
  runApp(const MeuApp());
}

// CLASSE PRINCIPAL
class MeuApp extends StatelessWidget {

  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {

    // MATERIALAPP DEFINE A BASE DO APP
    return MaterialApp(

      // REMOVE A FAIXA DEBUG
      debugShowCheckedModeBanner: false,

      // TELA INICIAL
      home: const TelaContatos(),
    );
  }
}

// STATEFULWIDGET
// USADO QUANDO A TELA PRECISA ATUALIZAR
class TelaContatos extends StatefulWidget {

  const TelaContatos({super.key});

  @override
  State<TelaContatos> createState() =>
      _TelaContatosState();
}

// ESTADO DA TELA
class _TelaContatosState
    extends State<TelaContatos> {

  // CONTROLLER DO CAMPO NOME
  final TextEditingController controllerNome =
      TextEditingController();

  // CONTROLLER DO CAMPO TELEFONE
  final TextEditingController controllerTelefone =
      TextEditingController();

  // LISTA DE CONTATOS
  List<Map<String, dynamic>> contatos = [

    {
      "nome": "João Silva",
      "telefone": "99999-9999",
    },

    {
      "nome": "Maria Oliveira",
      "telefone": "98888-8888",
    },
  ];

  // FUNÇÃO PARA ADICIONAR CONTATO
  void adicionarContato() {

    // VERIFICA SE OS CAMPOS ESTÃO VAZIOS
    if (controllerNome.text.isEmpty ||
        controllerTelefone.text.isEmpty) {

      return;
    }

    // ATUALIZA A TELA
    setState(() {

      // ADICIONA NOVO CONTATO
      contatos.add({

        "nome": controllerNome.text,

        "telefone":
            controllerTelefone.text,
      });
    });

    // LIMPA OS CAMPOS
    controllerNome.clear();
    controllerTelefone.clear();
  }

  // FUNÇÃO PARA REMOVER CONTATO
  void removerContato(int index) {

    // ATUALIZA A INTERFACE
    setState(() {

      // REMOVE PELO ÍNDICE
      contatos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    // SCAFFOLD É A ESTRUTURA DA TELA
    return Scaffold(

      // APPBAR SUPERIOR
      appBar: AppBar(

        // TÍTULO
        title: const Text(
          "Lista de Contatos",
        ),

        // CENTRALIZA O TÍTULO
        centerTitle: true,
      ),

      // CORPO DA TELA
      body: Padding(

        // ESPAÇAMENTO
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // CAMPO NOME
            TextField(

              // CONTROLLER
              controller: controllerNome,

              // DECORAÇÃO
              decoration: InputDecoration(

                // TEXTO
                labelText: "Nome",

                // ÍCONE
                prefixIcon:
                    const Icon(Icons.person),

                // BORDA
                border: OutlineInputBorder(

                  // BORDA ARREDONDADA
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
              ),
            ),

            // ESPAÇO
            const SizedBox(height: 10),

            // CAMPO TELEFONE
            TextField(

              // CONTROLLER
              controller:
                  controllerTelefone,

              decoration: InputDecoration(

                // TEXTO
                labelText: "Telefone",

                // ÍCONE
                prefixIcon:
                    const Icon(Icons.phone),

                // BORDA
                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
              ),
            ),

            // ESPAÇO
            const SizedBox(height: 15),

            // BOTÃO ADICIONAR
            SizedBox(

              // LARGURA TOTAL
              width: double.infinity,

              child: ElevatedButton.icon(

                // AÇÃO
                onPressed: adicionarContato,

                // ÍCONE
                icon: const Icon(Icons.add),

                // TEXTO
                label: const Text(
                  "Adicionar Contato",
                ),
              ),
            ),

            // ESPAÇO
            const SizedBox(height: 20),

            // TEXTO TOTAL DE CONTATOS
            Text(

              "Total de contatos: ${contatos.length}",

              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            // ESPAÇO
            const SizedBox(height: 10),

            // EXPANDED OCUPA O RESTANTE DA TELA
            Expanded(

              // LISTA DINÂMICA
              child: ListView.builder(

                // QUANTIDADE DE ITENS
                itemCount: contatos.length,

                // CRIA CADA ITEM
                itemBuilder:
                    (context, index) {

                  // CARD
                  return Card(

                    // SOMBRA
                    elevation: 3,

                    // ESPAÇO ENTRE ITENS
                    margin:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: ListTile(

                      // ÍCONE ESQUERDO
                      leading: const CircleAvatar(

                        child:
                            Icon(Icons.person),
                      ),

                      // NOME
                      title: Text(

                        contatos[index]["nome"],

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      // TELEFONE
                      subtitle: Text(
                        contatos[index]
                            ["telefone"],
                      ),

                      // BOTÃO EXCLUIR
                      trailing: IconButton(

                        // ÍCONE
                        icon: const Icon(
                          Icons.delete,

                          color: Colors.red,
                        ),

                        // AO CLICAR
                        onPressed: () {

                          // REMOVE CONTATO
                          removerContato(
                              index);
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

      // BOTÃO FLUTUANTE
      floatingActionButton:
          FloatingActionButton(

        // AÇÃO
        onPressed: adicionarContato,

        // ÍCONE
        child: const Icon(Icons.add),
      ),
    );
  }
}