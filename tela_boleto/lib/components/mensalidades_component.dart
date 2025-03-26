import 'package:flutter/material.dart';
import 'package:teste_tile/models/Boleto.dart';
import 'dart:convert';

import '../models/Mensalidade.dart';
import 'package:http/http.dart' as http;

class MensalidadeComponent extends StatefulWidget {
  final Boleto boleto;

  const MensalidadeComponent({super.key,  required this.boleto});

  @override
  State<MensalidadeComponent> createState() => _MensalidadeComponentState();
}

class _MensalidadeComponentState extends State<MensalidadeComponent> {
  @override
  Widget build(BuildContext context) {
    return getMensalidade(widget.boleto);
  }

    FutureBuilder<List<Mensalidade>> getMensalidade(Boleto boleto) {
      return FutureBuilder<List<Mensalidade>>(
          future: fetchMensalidades(boleto),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (!snapshot.hasData) { // or hasError
              return Text("Sem itens de mensalidade");
            } else if (snapshot.hasData) {
              List<Mensalidade> mensalidades = snapshot.data!;
              return Table(
                border: TableBorder(
                    bottom: BorderSide(
                        color: Colors.grey.shade200,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        width: 1
                    )
                ),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1)
                },
                children: carregarLinhasTabela(mensalidades),
              );
            } else { throw Exception("Nenhum dado disponível");}
          });
    }

    Future<List<Mensalidade>> fetchMensalidades(Boleto boleto) async {
      final response = await http.get(
          Uri.parse("https://testes-elmo-default-rtdb.firebaseio.com/mensalidades/${boleto.numero}.json")
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMapMensalidades = jsonDecode(response.body);
        List<Mensalidade> mensalidades = jsonMapMensalidades.values
            .map((itemMensalidade) => Mensalidade.fromJson(itemMensalidade as Map<String, dynamic>))
            .toList();

        // debug
        for (var mensalidade in mensalidades) {
          print('${mensalidade.descricao}: R\$ ${mensalidade.valor}');
        }

        return mensalidades;
      } else {
        throw Exception("Falha ao carregar mensalidade");
      }
    }

  List<TableRow> carregarLinhasTabela(mensalidades) {
    return mensalidades.map<TableRow>((mensalidade) {
      return TableRow(children: <TableCell>[
        TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text("- 11/01/2025 ${mensalidade.descricao}"),
            )),
        TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text("R\$${mensalidade.valor}"),
            )),
      ]);
    }).toList();
  }
}
