import 'package:flutter/material.dart';

void main() {
  runApp(const AppNavegacao());
}

class AppNavegacao extends StatelessWidget {
  const AppNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPrincipal(),
    );
  }
}

// Tela Principal (Stateful para poder atualizar a tela quando a outra retornar um dado)
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  String retorno = "Nenhum dado retornado ainda.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(retorno, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaSecundaria(
                      mensagem: 'Dado enviado da Tela Principal',
                    ),
                  ),
                );

                if (resultado != null) {
                  setState(() {
                    retorno = resultado;
                  });
                }
              },
              child: const Text('Ir para a próxima tela'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela Secundária
class TelaSecundaria extends StatelessWidget {
  final String mensagem;

  // Construtor exigindo que a tela anterior passe a "mensagem"
  const TelaSecundaria({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Secundária'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Recebido: $mensagem', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Tudo certo por aqui!');
              },
              child: const Text('Voltar com resposta'),
            ),
          ],
        ),
      ),
    );
  }
}   