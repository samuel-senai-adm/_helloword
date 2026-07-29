import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(home: TelaPrincipal()));

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String textoNaTela = "Memória Vazia";

  // 1. FUNÇÃO PARA SALVAR (Igualzinho ao seu slide)
  void salvar() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('cidade', 'São Paulo');
  }

  // 2. FUNÇÃO PARA LER (Igualzinho ao seu slide)
  void ler() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      textoNaTela = prefs.getString('cidade') ?? "Não encontrado";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textoNaTela, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: salvar, child: const Text("1. Salvar 'Leonardo'")),
            ElevatedButton(onPressed: ler, child: const Text("2. Ler da Memória")),
          ],
        ),
      ),
    );
  }
}
