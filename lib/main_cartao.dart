import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Imagem SENAI"), centerTitle: true),

        body: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(21),
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 11, 226),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Banco SESI / SENAI",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 70),
                    Icon(Icons.contactless, size: 30, color: Colors.white),
                  ],
                ),
                SizedBox(height: 11),
                Row(
                  children: [
                    SizedBox(width: 0),
                    Icon(Icons.sim_card, size: 40, color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "1234 5678 9012 3456",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Titular",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(width: 196),
                    Text(
                      "Validade:",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "João da Silva",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    SizedBox(width: 140),
                    Text(
                      "12/30",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            // child: Row(),
          ),
        ),
      ),
    );
  }
}
