import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String respostaFinal = '';
  final dio = Dio();
  Map<String, dynamic>? endereco;

  Future<Map<String, dynamic>> getHttp() async {
    final response = await dio.get('https://viacep.com.br/ws/76871360/json/');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Consumo de api usando dio'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Aqui vai aparecer o cep'),
              SizedBox(height: 25),
              ElevatedButton(onPressed: () async {
                Map<String, dynamic> enderecoAuxiliar = await getHttp();
                setState(() {
                  endereco = enderecoAuxiliar;
                });
              }, child: Text('Consultar')),
              SizedBox(height: 25),
              Text('${endereco?['logradouro'] ?? ''}'),
              Text('${endereco?['bairro'] ?? ''}'),
              Text('${endereco?['estado'] ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
