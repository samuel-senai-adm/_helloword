import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "MediaQuery", home: const HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: largura * 0.8,
              child: Column(
                children: [
                  SizedBox(height: altura * 0.1),
                  Icon(Icons.lock, size: 100, color: Colors.blue),
                  SizedBox(height: altura * 0.05),
                  Text("Login", style: TextStyle(fontSize: 28)),
                  SizedBox(height: altura * 0.05),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: altura * 0.02),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: altura * 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(largura * 0.5, 40),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text("Entrar"),
                  ),
                  SizedBox(height: altura * 0.8),
                  TextButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      minimumSize: Size(largura * 0.5, 50),
                      elevation: 0,
                    ),
                    child: Text("Criar Conta"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
