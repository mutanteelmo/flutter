import 'package:dieta_anabolica/models/alimento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:intl/intl.dart';

main() => runApp(DietaAnabolicaApp());

class DietaAnabolicaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DietaAnabolica());
  }
}

class DietaAnabolica extends StatelessWidget {
  final _alimentos = [
    Alimento(
      id: 1,
      name: 'Maçã',
      caloria: 52,
      carboidrato: 14,
      proteina: 0.3,
      gordura: 0.2,
      microNutrientes: ['Vitamina C', 'Potássio'],
    ),
    Alimento(
      id: 2,
      name: 'Ovo',
      caloria: 155,
      carboidrato: 1.1,
      proteina: 13,
      gordura: 11,
      microNutrientes: ['Vitamina B12', 'Vitamina D', 'Selênio'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Dieta Anabolica')),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: _alimentos
                  .map((alimento) => Card(
                          child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Card(
                              elevation: 5,
                              color: Colors.grey,
                              child: Text(alimento.name),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  child: Text('Carbs: ${alimento.carboidrato}'),
                                ),
                                Container(
                                  child: Text('Prot: ${alimento.proteina}'),
                                ),
                                Container(
                                  child: Text('Fat: ${alimento.gordura}'),
                                ),
                              ],
                            ),
                          ),
                          Row(children: [
                            Text('Calorias: ${alimento.caloria}'),
                          ]),
                        ],
                      )))
                  .toList(),
            ),
          ],
        ));
  }
}
