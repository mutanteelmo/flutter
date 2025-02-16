import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:teste_tile/models/Boleto.dart';
import 'package:teste_tile/pages/lista_boletos_page.dart';
import 'package:teste_tile/pages/mensalidade_page.dart';
import 'components/boletos_component.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:teste_tile/components/mensalidades_component.dart';
import 'package:teste_tile/datafile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Testes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Boleto boleto = boletos[0];
  // late Future<Boleto> boleto = fetchBoleto(12345678);
  Boleto? boleto;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchBoleto(12345678).then((futureBoleto) {
      setState(() {
        boleto = futureBoleto;
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        errorMessage = "Erro ao carregar boleto: $onError";
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: ListaBoletos()
      body: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : (errorMessage != null
          ? Text(errorMessage!)
          : Column(
            children: [
              Container(
                color: Colors.grey.shade200,
                child: Column(
                    children: [
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.qr_code),
                            ),
                            Expanded(
                              child: Center(
                                child: AutoSizeText(
                                  boleto!.linhaDigitavel,
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  minFontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const IconButton(onPressed: null, icon: Icon(Icons.open_in_browser)),
                          const IconButton(onPressed: null, icon: Icon(Icons.download)),
                          ElevatedButton.icon(
                            onPressed: null, // copiar código do boleto
                            icon: const Icon(Icons.copy),
                            label: const Text("Copiar código do boleto"),
                          )
                        ],
                      )
                    ]),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        "Mensalidade",
                        style: TextStyle(
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    MensalidadeComponent(boleto: boleto!),
                  ],
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mensalidadePage(boleto: boleto!))
                  ),
                  child: const Text("Teste Mensalidade")
              ),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => listaBoletosPage())),
                  child: const Text("Teste List Tile"))
            ],
          )
        )

      ),
    );
  }

  Future<Boleto> fetchBoleto(int numeroBoleto) {
    return http
        .get(Uri.parse("https://testes-elmo-default-rtdb.firebaseio.com/boletos/${numeroBoleto}.json"))
        .then((response) {
      if (response.statusCode == 200) {
        return Boleto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception("Falha ao carregar boleto");
      }
    }).catchError((erro) {
      throw Exception("Erro: $erro");
    });
  }

  // Boleto getBoleto({Future<Boleto>? futureBoleto}) {
  //   FutureBuilder<Boleto>(
  //     future: boleto,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text("Erro: ${snapshot.error}"));
  //       } else if (snapshot.hasData) {
  //         return Text("Boleto: ${snapshot.data!.codigo}");
  //       } else {
  //         return const Center(child: Text("Nenhum boleto encontrado."));
  //       }
  //     },
  //   );
  // }

}


