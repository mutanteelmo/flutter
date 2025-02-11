import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_tile/components/lista_boletos_component.dart';
import 'package:teste_tile/datafile.dart';
import 'package:teste_tile/models/Boleto.dart';

class listaBoletosPage extends StatefulWidget {
  // final Boleto boleto;
  // const listaBoletosPage({super.key, required this.boleto});

  const listaBoletosPage({super.key});

  @override
  State<listaBoletosPage> createState() => _listaBoletosPageState();
}

class _listaBoletosPageState extends State<listaBoletosPage> {
  // void initState() {
  //   super.initState();
  //   mensalidade = getDadosMensalidade();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista de boletos"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // MensalidadeComponent(boleto: widget.boleto),
            ListaBoletosComponent(),
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Voltar"))
          ],
        ));
  }
}
