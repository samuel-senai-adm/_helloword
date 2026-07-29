import 'package:flutter/material.dart';

void main() {
  runApp(ExpandedExample());
}

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exemplo de Expanded",
      home: Scaffold(
        appBar: AppBar(title: const Text("Extended")),
        body: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: const Center(child: Text("Header")),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Ocupa todo espaço restante",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
