import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _ContarCurtidas();
}

class _ContarCurtidas extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Aplicativo de Curtidas'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 80, color: Colors.red,),
              Text(
                "Curtidas: $contador",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              ElevatedButton(onPressed: () { setState(() { contador++;});
                },
                child: Text("Curtir👍")
              ),
              SizedBox(width: 20),
              ElevatedButton(onPressed: () { setState(() { if (contador > 0) {contador--;} });
                },
                child: Text("Descurtir👎")
                  ),
                ],
              )     
            ],
          ),
        ),
      ),
    );
  }
}

