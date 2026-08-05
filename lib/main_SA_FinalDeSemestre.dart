import 'package:flutter/material.dart';

void main() {
  runApp(const SupermercadoApp());
}

const Color kGreen = Color(0xFF2E7D32);

class SupermercadoApp extends StatelessWidget {
  const SupermercadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lista de Supermercado",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen, primary: kGreen),
      ),
      home: const MainPage(),
    );
  }
}

class Produto {
  String nome;
  int quantidade;
  double preco;
  bool comprado;

  Produto({
    required this.nome,
    required this.quantidade,
    required this.preco,
    this.comprado = false,
  });

  double get total => quantidade * preco;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _paginaAtual = 0;

  final List<Produto> produtos = [
    Produto(nome: 'Arroz 5kg', quantidade: 1, preco: 24.90),
    Produto(nome: 'Feijão 1kg', quantidade: 2, preco: 8.49),
    Produto(nome: 'Leite 1L', quantidade: 3, preco: 4.89),
    Produto(nome: 'Óleo de Soja 900ml', quantidade: 1, preco: 7.99),
    Produto(nome: 'Papel Higiênico 12un', quantidade: 1, preco: 18.90),
    Produto(nome: 'Açúcar 1kg', quantidade: 1, preco: 5.29),
    Produto(nome: 'Macarrão 500g', quantidade: 2, preco: 4.50),
    Produto(nome: 'Café 500g', quantidade: 1, preco: 16.90),
    Produto(nome: 'Sabonete 90g', quantidade: 3, preco: 2.99),
    Produto(nome: 'Detergente 500ml', quantidade: 2, preco: 2.79),
  ];

  double get totalCompra {
    double total = 0;
    for (final item in produtos) {
      if (!item.comprado) total += item.total;
    }
    return total;
  }

  int get qtdNaoComprados {
    return produtos.where((p) => !p.comprado).length;
  }

  Future<void> abrirFormulario({Produto? produto, int? index}) async {
    final resultado = await showDialog<Produto>(
      context: context,
      builder: (_) => FormularioProduto(produto: produto),
    );
    if (resultado == null) return;
    setState(() {
      if (index == null) {
        produtos.add(resultado);
      } else {
        produtos[index] = resultado;
      }
    });
  }

  void excluirProduto(int index) {
    setState(() => produtos.removeAt(index));
  }

  void alterarStatus(int index) {
    setState(() => produtos[index].comprado = !produtos[index].comprado);
  }

  // ==================== TELAS ====================

  Widget _telaInicio() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Supermercado"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirFormulario(),
        icon: const Icon(Icons.add),
        label: const Text("Adicionar"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: kGreen,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Text(
                  "Valor Total",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  "R\$ ${totalCompra.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: produtos.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum produto cadastrado",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, index) =>
                        cardProduto(produtos[index], index),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _telaCategorias() {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorias"), centerTitle: true),
      body: const Center(
        child: Text(
          "Em breve: filtros por categoria",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _telaCarrinho() {
    final itens = produtos.where((p) => !p.comprado).toList();
    return Scaffold(
      appBar: AppBar(title: const Text("Carrinho"), centerTitle: true),
      body: itens.isEmpty
          ? const Center(
              child: Text("Carrinho vazio", style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final p = itens[index];
                return ListTile(
                  title: Text(p.nome),
                  subtitle: Text(
                    "${p.quantidade} x R\$ ${p.preco.toStringAsFixed(2)}",
                  ),
                  trailing: Text(
                    "R\$ ${p.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kGreen,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _telaPerfil() {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil"), centerTitle: true),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: kGreen,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Meu Perfil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardProduto(Produto produto, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: produto.comprado,
          activeColor: kGreen,
          onChanged: (_) => alterarStatus(index),
        ),
        title: Text(
          produto.nome,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: produto.comprado ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          "${produto.quantidade} x R\$ ${produto.preco.toStringAsFixed(2)}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "R\$ ${produto.total.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => abrirFormulario(produto: produto, index: index),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => excluirProduto(index),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final telas = [
      _telaInicio(),
      _telaCategorias(),
      _telaCarrinho(),
      _telaPerfil(),
    ];

    return Scaffold(
      body: telas[_paginaAtual],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaAtual,
        onDestinationSelected: (i) => setState(() => _paginaAtual = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          const NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Categorias',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: qtdNaoComprados > 0,
              label: Text('$qtdNaoComprados'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: qtdNaoComprados > 0,
              label: Text('$qtdNaoComprados'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Carrinho',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class FormularioProduto extends StatefulWidget {
  final Produto? produto;
  const FormularioProduto({super.key, this.produto});

  @override
  State<FormularioProduto> createState() => _FormularioProdutoState();
}

class _FormularioProdutoState extends State<FormularioProduto> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _quantidadeController;
  late final TextEditingController _precoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.produto?.nome ?? '');
    _quantidadeController = TextEditingController(
      text: widget.produto?.quantidade.toString() ?? '1',
    );
    _precoController = TextEditingController(
      text: widget.produto?.preco.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _quantidadeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    final produto = Produto(
      nome: _nomeController.text.trim(),
      quantidade: int.parse(_quantidadeController.text.trim()),
      preco: double.parse(_precoController.text.trim().replaceAll(',', '.')),
      comprado: widget.produto?.comprado ?? false,
    );
    Navigator.of(context).pop(produto);
  }

  @override
  Widget build(BuildContext context) {
    final isEditando = widget.produto != null;
    return AlertDialog(
      title: Text(isEditando ? 'Editar Produto' : 'Novo Produto'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_basket),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantidadeController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.format_list_numbered),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final q = int.tryParse(v?.trim() ?? '');
                  if (q == null || q <= 0) return 'Quantidade inválida';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(
                  labelText: 'Preço unitário (R\$)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  final p = double.tryParse((v ?? '').replaceAll(',', '.'));
                  if (p == null || p < 0) return 'Preço inválido';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _salvar,
          child: Text(isEditando ? 'Salvar' : 'Adicionar'),
        ),
      ],
    );
  }
}
