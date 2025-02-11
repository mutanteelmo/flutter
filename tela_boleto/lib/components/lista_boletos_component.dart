import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste_tile/datafile.dart' as datafile;
import 'package:teste_tile/models/Boleto.dart';

class Item {
  Item(
      {required this.valorExpandido,
      required this.valorHeader,
      this.isExpanded = false});

  String valorExpandido;
  String valorHeader;
  bool isExpanded;
}

List<Item> gerarItens(int numeroDeItens) {
  return List<Item>.generate(numeroDeItens, (int index) {
    return Item(
      valorExpandido: 'Painel $index',
      valorHeader: 'Este é o item $index',
    );
  });
}

class ListaBoletosComponent extends StatefulWidget {
  const ListaBoletosComponent({super.key});

  @override
  State<ListaBoletosComponent> createState() => _ListaBoletosComponentState();
}

class _ListaBoletosComponentState extends State<ListaBoletosComponent> {
  final List<Item> _data = gerarItens(3);
  final List<Boleto> boletos = datafile.boletos;

  int _counter = 0;
  String _boleto = "85696585";
  String _vencimento = "21/10/2024";
  double _valor = 980.01;

  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: Icon(Icons.person),
                title: Text("Boleto Outubro 2024"),
                titleAlignment: ListTileTitleAlignment.center,
                subtitle: Container(
                  child: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "Boleto: " +
                          _boleto +
                          " \n"
                              "Vencimento: " +
                          _vencimento +
                          " \n"
                              "Valor: R\$ " +
                          _valor.toStringAsFixed(1)),
                ),
                isThreeLine: false,
                onTap: () {
                  // setState(() {
                  //   _data.removeWhere((Item currentItem) => item == currentItem);
                  // });
                },
              );
            },
            body: ListView(
                shrinkWrap: true,
                children: [
              Row(
                children: [
                  Container(
                    child: Text("Boletão"),
                    height: 50,
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.open_in_browser)),
                  IconButton(onPressed: null, icon: Icon(Icons.download)),
                  ElevatedButton.icon(
                    onPressed: null, // copiar código do boleto
                    icon: Icon(Icons.copy),
                    label: Text("Copiar código do boleto"),
                  )
                ],
              )
            ]),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}
