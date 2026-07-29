import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Configuração das Rotas
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/produto/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetalhesProdutoScreen(id: id);
      },
    ),
  ],
);
// O código acima define as rotas usando o GoRouter, incluindo uma rota dinâmica para detalhes do produto.

// 2. Inicialização no MaterialApp
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router, // Conecta o GoRouter aqui
      debugShowCheckedModeBanner: false,
    );
  }
}

// O MaterialApp.router é usado para integrar o GoRouter, permitindo a navegação declarativa e fácil entre as telas.
// 3. Telas Simplificadas
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              context.push('/produto/42'), // Vai para a tela de detalhes
          child: const Text('Ver Todos os produtos'),
        ),
      ),
    );
  }
}
// A HomeScreen tem um botão que, quando pressionado, navega para a tela de detalhes do produto com um ID específico (neste caso, 42).

class DetalhesProdutoScreen extends StatelessWidget {
  final String id;
  const DetalhesProdutoScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Center(
        child: Text('ID do Produto: $id', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
// A DetalhesProdutoScreen exibe o ID do produto passado pela URL, demonstrando como capturar e usar parâmetros dinâmicos com o GoRouter.
