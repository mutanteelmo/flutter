import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_tile/datafile.dart';
import 'package:teste_tile/models/Boleto.dart';
import 'package:teste_tile/models/Mensalidade.dart';
import 'package:teste_tile/components/mensalidades_component.dart';

class mensalidadePage extends StatefulWidget {
  final Boleto boleto;

  const mensalidadePage({super.key, required this.boleto});

  @override
  State<mensalidadePage> createState() => _mensalidadePageState();
}

class _mensalidadePageState extends State<mensalidadePage> {
  late FutureBuilder<Mensalidade> futureMensalidade;

  // void initState() {
  //   super.initState();
  //   mensalidade = getDadosMensalidade();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mensalidade"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MensalidadeComponent(boleto: widget.boleto),
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Voltar"))
          ],
        ));
  }
}
