import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cartões",
      home: CarteiraDigital(),
    );
  }
}

class CarteiraDigital extends StatelessWidget {
  const CarteiraDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carteira Digital"), centerTitle: true),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CartaoBanco(
            corCartao: const Color.fromARGB(255, 89, 84, 98),
            banco: "Banco Bradesco",
            numero: "1234 5678 9012 3456",
            nome: "Leonardo Casellato",
            validade: "12/30",
            bandeira: "assets/images/elo.png",
            logo: "assets/images/bradesco.png",
          ),
          SizedBox(height: 20),
          CartaoBanco(
            corCartao: const Color.fromARGB(255, 110, 39, 165),
            banco: "Banco Nubank",
            numero: "5678 9045 6789 4567",  
            nome: "Samuel Angelo",
            validade: "12/32",
            bandeira: "assets/images/pngwing.com.png",
            logo: "assets/images/images.png",
          ),
          SizedBox(height: 20),
          CartaoBanco(
            corCartao: const Color.fromARGB(255, 244, 221, 19),
            banco: "Banco Do Brasil",
            numero: "0000 1111 2222 3333",
            nome: "Jair Bolsonaro",
            validade: "22/22",
            bandeira: "assets/images/image.png",
            logo: "assets/images/bncdbr.png",

          )
        ],
      ),
    );
  }
}

class CartaoBanco extends StatelessWidget {
  final Color corCartao;
  final String banco;
  final String numero;
  final String nome;
  final String validade;
  final String bandeira;
  final String logo;


  const CartaoBanco({
    super.key,
    required this.corCartao,
    required this.banco,
    required this.numero,
    required this.nome,
    required this.validade,
    required this.bandeira,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: corCartao,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(logo, height: 45, width: 45),
              SizedBox(width: 1),
              Text(
                banco,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 30),
              Image.asset(bandeira, height: 50, width: 50),

              Icon(Icons.contactless, color: Colors.white),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.sim_card, color: Colors.amber, size: 37),
              SizedBox(width: 10),
            ],

          ),
          
          Text(
            numero,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Titular",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),

                  Text(
                    nome,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Validade",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),

                  Text(
                    validade,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
