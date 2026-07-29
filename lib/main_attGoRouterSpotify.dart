import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// =================================================================
// 1. MODELOS DE DADOS
// =================================================================
class Playlist {
  final String id;
  final String nome;
  final String subtitulo;
  final String emoji;
  final Color cor;
  final List<Musica> musicas;

  const Playlist({
    required this.id,
    required this.nome,
    required this.subtitulo,
    required this.emoji,
    required this.cor,
    required this.musicas,
  });
}

class Musica {
  final String titulo;
  final String artista;
  final String duracao;

  const Musica({
    required this.titulo,
    required this.artista,
    required this.duracao,
  });
}

// =================================================================
// 2. DADOS DE EXEMPLO (Sertanejo)
// =================================================================
const _playlists = [
  Playlist(
    id: 'sertanejo-hits',
    nome: 'Sertanejo Hits 2024',
    subtitulo: 'Os maiores sucessos do momento',
    emoji: '🤠',
    cor: Color(0xFFE8651A),
    musicas: [
      Musica(titulo: 'Diferença Particular', artista: 'Gusttavo Lima', duracao: '3:52'),
      Musica(titulo: 'Apelido Carinhoso', artista: 'Zé Neto & Cristiano', duracao: '3:14'),
      Musica(titulo: 'Conselho', artista: 'Henrique & Juliano', duracao: '4:01'),
      Musica(titulo: 'Tô Bem', artista: 'Jorge & Mateus', duracao: '3:38'),
      Musica(titulo: 'Flor e o Beija-Flor', artista: 'Marcos & Belutti', duracao: '3:22'),
      Musica(titulo: 'Camarote', artista: 'Vitor e Luan', duracao: '2:58'),
      Musica(titulo: 'Seu Polícia', artista: 'Bruno & Marrone', duracao: '3:45'),
    ],
  ),
  Playlist(
    id: 'raiz',
    nome: 'Sertanejo Raiz',
    subtitulo: 'A essência do campo',
    emoji: '🌾',
    cor: Color(0xFF2D8A4E),
    musicas: [
      Musica(titulo: 'Saudade do Nordeste', artista: 'Renato Teixeira', duracao: '4:10'),
      Musica(titulo: 'Luar do Sertão', artista: 'Catulo da Paixão Cearense', duracao: '3:55'),
      Musica(titulo: 'Romaria', artista: 'Renato Teixeira', duracao: '4:30'),
      Musica(titulo: 'Triste Recaída', artista: 'Tonico & Tinoco', duracao: '3:20'),
      Musica(titulo: 'Mágoa de Boiadeiro', artista: 'Palmeira & Biá', duracao: '3:48'),
    ],
  ),
  Playlist(
    id: 'forro',
    nome: 'Forró do Nordeste',
    subtitulo: 'Pé de serra e baião',
    emoji: '🪗',
    cor: Color(0xFFB8860B),
    musicas: [
      Musica(titulo: 'Asa Branca', artista: 'Luiz Gonzaga', duracao: '2:47'),
      Musica(titulo: 'Baião', artista: 'Luiz Gonzaga', duracao: '3:05'),
      Musica(titulo: 'Xote das Meninas', artista: 'Luiz Gonzaga', duracao: '2:33'),
      Musica(titulo: 'Véio São Pedro', artista: 'Luiz Gonzaga', duracao: '3:12'),
      Musica(titulo: 'Paraíba', artista: 'Luiz Gonzaga', duracao: '2:58'),
      Musica(titulo: 'Lula', artista: 'Luiz Gonzaga', duracao: '3:20'),
    ],
  ),
  Playlist(
    id: 'romanteco',
    nome: 'Romântico Demais',
    subtitulo: 'Para chorar e se apaixonar',
    emoji: '💔',
    cor: Color(0xFFC0394B),
    musicas: [
      Musica(titulo: 'Inevitável', artista: 'Luan Santana', duracao: '3:55'),
      Musica(titulo: 'Juntos e Shallow Now', artista: 'Marília Mendonça', duracao: '3:40'),
      Musica(titulo: 'Infiel', artista: 'Marília Mendonça', duracao: '3:28'),
      Musica(titulo: 'Esqueça Me', artista: 'Matheus & Kauan', duracao: '3:15'),
      Musica(titulo: 'A Culpa é Sua', artista: 'Zezé di Camargo', duracao: '4:02'),
    ],
  ),
];

// =================================================================
// 3. SERVIÇO DE AUTENTICAÇÃO
// =================================================================
class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _loggedUserName;

  bool get isAuthenticated => _isAuthenticated;
  String? get loggedUserName => _loggedUserName;

  static const _fakeUsers = {
    'admin@app.com': 'senha123',
    'user@app.com': '123456',
  };

  Future<String?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (!_fakeUsers.containsKey(email)) return 'E-mail não encontrado.';
    if (_fakeUsers[email] != password) return 'Senha incorreta.';
    _isAuthenticated = true;
    _loggedUserName = email.split('@').first;
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _loggedUserName = null;
    notifyListeners();
  }
}

final authService = AuthService();

// =================================================================
// 4. ROTAS
// =================================================================
class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String playlist = '/playlist/:id';

  static const String loginName = 'login';
  static const String homeName = 'home';
  static const String playlistName = 'playlist';
}

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
  refreshListenable: authService,
  errorBuilder: (context, state) => const ErrorScreen(),

  // ✅ GUARD — redireciona para login se não autenticado
  redirect: (context, state) {
    final isLoggedIn = authService.isAuthenticated;
    final isOnLogin = state.matchedLocation == AppRoutes.login;

    if (!isLoggedIn && !isOnLogin) return AppRoutes.login;
    if (isLoggedIn && isOnLogin) return AppRoutes.home;
    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.loginName,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (_, __) => const HomeScreen(),

      routes: [
        GoRoute(
          path: 'playlist/:id',
          name: AppRoutes.playlistName,
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            final playlist = _playlists.firstWhere(
              (p) => p.id == id, 
              orElse: () => _playlists.first,
            );
            return PlaylistScreen(playlist: playlist);
          },
        ),
      ],
    ),
  ],
);

// =================================================================
// 5. TEMA SPOTIFY-LIKE
// =================================================================
final _theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1DB954),
    surface: Color(0xFF121212),
    surfaceContainerHighest: Color(0xFF282828),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: -1),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(color: Color(0xFFB3B3B3)),
    bodySmall: TextStyle(color: Color(0xFF6A6A6A)),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF1DB954),
      foregroundColor: Colors.black,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    ),
    labelStyle: const TextStyle(color: Color(0xFF6A6A6A)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
  ),
);

// =================================================================
// 6. INICIALIZAÇÃO
// =================================================================
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Sertanejo FM',
      debugShowCheckedModeBanner: false,
      theme: _theme,
    );
  }
}

// =================================================================
// 7. TELAS
// =================================================================

// ------------------------------------------------------------------
// LOGIN
// ------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    final err = await authService.login(_emailCtrl.text.trim(), _passCtrl.text);
    if (!mounted) return;
    setState(() { _loading = false; _error = err; });
    // Se sucesso → GoRouter redireciona via refreshListenable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Logo
                  const _SpotifyLogo(),
                  const SizedBox(height: 40),

                  Text(
                    'Entrar no\nSertanejo FM',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 40),

                  // Hint
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1DB954).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF1DB954).withOpacity(0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline, color: Color(0xFF1DB954), size: 15),
                            SizedBox(width: 6),
                            Text('Credenciais demo', style: TextStyle(color: Color(0xFF1DB954), fontSize: 12, fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _hint('admin@app.com', 'senha123'),
                        _hint('user@app.com', '123456'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _emailCtrl,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Informe o e-mail.';
                      if (!v.contains('@')) return 'E-mail inválido.';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _passCtrl,
                    obscureText: _obscure,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: const Color(0xFF6A6A6A), size: 20),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Informe a senha.';
                      if (v.length < 6) return 'Mínimo 6 caracteres.';
                      return null;
                    },
                  ),

                  if (_error != null) ...[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.redAccent, size: 18),
                          const SizedBox(width: 8),
                          Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: _loading ? null : _login,
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5))
                          : const Text('Entrar', style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _hint(String email, String pass) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text('$email / $pass', style: const TextStyle(color: Color(0xFF6A6A6A), fontSize: 11, fontFamily: 'monospace')),
    );
  }
}

class _SpotifyLogo extends StatelessWidget {
  const _SpotifyLogo();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF1DB954),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.music_note_rounded, color: Colors.black, size: 40),
    );
  }
}

// ------------------------------------------------------------------
// HOME — Tela Principal (estilo Spotify)
// ------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hora = DateTime.now().hour;
    final saudacao = hora < 12 ? 'Bom dia' : hora < 18 ? 'Boa tarde' : 'Boa noite';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          // AppBar customizada sem seta de voltar (é a tela raiz)
          SliverAppBar(
            expandedHeight: 0,
            floating: true,
            backgroundColor: const Color(0xFF121212),
            automaticallyImplyLeading: false, // ← sem botão de voltar na Home
            title: ListenableBuilder(
              listenable: authService,
              builder: (_, __) => Text('$saudacao, ${authService.loggedUserName ?? 'você'} 👋'),
            ),
            actions: [
              IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Color(0xFF282828),
                  radius: 16,
                  child: Icon(Icons.person, size: 18, color: Colors.white),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.logout, size: 20),
                tooltip: 'Sair',
                onPressed: () => authService.logout(),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Playlists recentes em grade 2x2
                  _SectionTitle('Ouvidos recentemente'),
                  const SizedBox(height: 12),
                  _RecentGrid(playlists: _playlists.take(4).toList()),
                  const SizedBox(height: 32),

                  // Todas as playlists em lista
                  _SectionTitle('Suas playlists'),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Lista de playlists
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _PlaylistListTile(playlist: _playlists[i]),
              childCount: _playlists.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      // Mini player fixo no rodapé
      bottomNavigationBar: const _MiniPlayer(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
    );
  }
}

// Grade 2x2 de playlists recentes
class _RecentGrid extends StatelessWidget {
  final List<Playlist> playlists;
  const _RecentGrid({required this.playlists});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3.2,
      ),
      itemCount: playlists.length,
      itemBuilder: (context, i) {
        final p = playlists[i];
        return Material(
          color: const Color(0xFF282828),
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () {
              // ✅ DESAFIO 1: pushNamed empilha /home/playlist/:id sobre /home
              context.pushNamed(
                AppRoutes.playlistName,
                pathParameters: {'id': p.id},
              );
            },
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: p.cor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                  child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 22))),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    p.nome,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Linha de playlist na lista inferior
class _PlaylistListTile extends StatelessWidget {
  final Playlist playlist;
  const _PlaylistListTile({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: playlist.cor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Text(playlist.emoji, style: const TextStyle(fontSize: 26))),
      ),
      title: Text(playlist.nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text('${playlist.musicas.length} músicas • ${playlist.subtitulo}',
          style: const TextStyle(color: Color(0xFF6A6A6A), fontSize: 12)),
      trailing: const Icon(Icons.more_vert, color: Color(0xFF6A6A6A)),
      onTap: () {
        // ✅ Também navega via pushNamed — pilha: /home → /home/playlist/:id
        context.pushNamed(
          AppRoutes.playlistName,
          pathParameters: {'id': playlist.id},
        );
      },
    );
  }
}

// Mini player no rodapé
class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1DB954),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.music_note_rounded, color: Colors.black, size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Diferença Particular', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)),
                Text('Gusttavo Lima', style: TextStyle(color: Color(0xFF1A6133), fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.play_circle_fill, color: Colors.black, size: 32),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------
// PLAYLIST — Tela de músicas (empilhada sobre Home)
// ------------------------------------------------------------------
class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;
  const PlaylistScreen({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          // ✅ AppBar com botão de VOLTAR (seta para esquerda)
          // context.pop() desempilha /home/playlist/:id e retorna exatamente para /home
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            stretch: true,
            backgroundColor: playlist.cor.withOpacity(0.95),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white), // ← A SETA
              tooltip: 'Voltar',
              onPressed: () => context.pop(), // ✅ pop() = volta para /home
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _PlaylistHeader(playlist: playlist),
              stretchModes: const [StretchMode.zoomBackground],
            ),
          ),

          // Botões de ação
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF121212),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.download_outlined, color: Color(0xFF6A6A6A)),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Color(0xFF6A6A6A)),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  // Botão play verde
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1DB954),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(14),
                      elevation: 4,
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 28),
                  ),
                ],
              ),
            ),
          ),

          // Lista de músicas
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _MusicaTile(
                numero: i + 1,
                musica: playlist.musicas[i],
                accentColor: playlist.cor,
              ),
              childCount: playlist.musicas.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: const _MiniPlayer(),
    );
  }
}

class _PlaylistHeader extends StatelessWidget {
  final Playlist playlist;
  const _PlaylistHeader({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [playlist.cor, playlist.cor.withOpacity(0.6), const Color(0xFF121212)],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Capa da playlist
            Container(
              width: 160,
              height: 160,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(playlist.emoji, style: const TextStyle(fontSize: 80)),
              ),
            ),
            Text(
              playlist.nome,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5),
            ),
            const SizedBox(height: 4),
            Text(
              playlist.subtitulo,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              '${playlist.musicas.length} músicas',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _MusicaTile extends StatelessWidget {
  final int numero;
  final Musica musica;
  final Color accentColor;

  const _MusicaTile({required this.numero, required this.musica, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: SizedBox(
        width: 24,
        child: Text(
          '$numero',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF6A6A6A), fontSize: 14),
        ),
      ),
      title: Text(
        musica.titulo,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        musica.artista,
        style: const TextStyle(color: Color(0xFF6A6A6A), fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(musica.duracao, style: const TextStyle(color: Color(0xFF6A6A6A), fontSize: 12)),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: Color(0xFF6A6A6A), size: 18),
        ],
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('▶  ${musica.titulo} — ${musica.artista}'),
            backgroundColor: const Color(0xFF282828),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}

// ------------------------------------------------------------------
// ERRO 404
// ------------------------------------------------------------------
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image_outlined, size: 64, color: Color(0xFF6A6A6A)),
            const SizedBox(height: 16),
            const Text('Página não encontrada', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('A rota que você acessou não existe.', style: TextStyle(color: Color(0xFF6A6A6A))),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
    );
  }
}
