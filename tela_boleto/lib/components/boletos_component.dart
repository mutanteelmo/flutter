import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste_tile/components/boleto_component.dart';
import 'package:teste_tile/components/mensalidades_component.dart';
import 'package:teste_tile/datafile.dart' as datafile;
import 'package:teste_tile/models/Boleto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ListaBoletosComponent extends StatefulWidget {
  const ListaBoletosComponent({super.key});

  @override
  State<ListaBoletosComponent> createState() => _ListaBoletosComponentState();
}

class _ListaBoletosComponentState extends State<ListaBoletosComponent> {
  late Future<List<Boleto>>? futureBoletos;
  List<Boleto> boletos = [];

  @override
  void initState() {
    super.initState();
    futureBoletos = fetchBoletos();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return getBoletos();
  }

  // Future<Boleto> fetchBoletos() {
  //   return http
  //       .get(Uri.parse("https://testes-elmo-default-rtdb.firebaseio.com/boletos.json"))
  //       .then((response) {
  //     if (response.statusCode == 200) {
  //       return Boleto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //     } else {
  //       throw Exception("Falha ao carregar boleto");
  //     }
  //   }).catchError((erro) {
  //     throw Exception("Erro: $erro");
  //   });
  // }

  Future<List<Boleto>> fetchBoletos() async {
    final response = await http.get(Uri.parse(
        "https://testes-elmo-default-rtdb.firebaseio.com/boletos.json"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMapBoletos = jsonDecode(response.body);
      List<Boleto> boletos = jsonMapBoletos.values
          .map((itemBoleto) =>
              Boleto.fromJson(itemBoleto as Map<String, dynamic>))
          .toList();

      // debug
      print("Lista de boletos: ");
      for (var boleto in boletos) {
        print('Boleto: ${boleto.numero} - ${boleto.valor}');
      }

      return boletos;
    } else {
      throw Exception("Falha ao carregar lista de boletos");
    }
  }

  FutureBuilder<List<Boleto>> getBoletos() {
    return FutureBuilder<List<Boleto>>(
        future: futureBoletos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            throw Exception(
                "Erro ao carregar dados dos boletos da api: \n ${snapshot.error}");
          } else if (snapshot.hasData) {


            if (boletos.isEmpty) {
              // boletos = snapshot.data!.map((boleto) => boleto.copyWith()).toList();
              boletos = snapshot.data!.map((boleto) => boleto).toList();
            }

            return SingleChildScrollView(
                child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        // isExpanded = !isExpanded;
                        // boletos[index] = boletos[index].copyWith(isExpanded: !isExpanded);
                        boletos[index].isExpanded = isExpanded;
                      });
                    },
                    children: boletos.map<ExpansionPanel>((Boleto boleto) {
                      return ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return BoletoComponent(boleto: boleto);
                        },
                        body: ListView(shrinkWrap: true, children: [
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
                                MensalidadeComponent(boleto: boleto),
                              ],
                            ),
                          ),
                        ]),
                        isExpanded: boleto.isExpanded,
                      );
                    }).toList()
                )
            );
          } else {
            throw Exception("Nenhuma lista de boleto disponível");
          }
        });
  }
}
