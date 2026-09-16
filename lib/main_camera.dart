import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Produto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProdutoPage(),
    );
  }
}

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({super.key});

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final TextEditingController nomeController = TextEditingController();

  File? foto;

  // Função para abrir a câmera e tirar a foto
  Future<void> tirarFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? imagem = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (imagem != null) {
      setState(() {
        foto = File(imagem.path);
      });
    }
  }

  // Função para cadastrar o produto
  void cadastrarProduto() {
    if (nomeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite o nome do produto.'),
        ),
      );
      return;
    }

    if (foto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tire uma foto do produto.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto cadastrado com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Produto'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text(
              'Cadastrar Produto',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Campo para o nome do produto
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do produto',
                hintText: 'Digite o nome do produto',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Foto do produto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Área onde a foto será exibida
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),

              child: foto == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Nenhuma foto tirada',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        foto!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // Botão para abrir a câmera
            ElevatedButton.icon(
              onPressed: tirarFoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('TIRAR FOTO'),
            ),

            const SizedBox(height: 15),

            // Botão para cadastrar
            ElevatedButton.icon(
              onPressed: cadastrarProduto,
              icon: const Icon(Icons.check),
              label: const Text('CADASTRAR PRODUTO'),
            ),
          ],
        ),
      ),
    );
  }
}