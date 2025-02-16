import 'package:flutter/material.dart';
import 'package:teste_tile/datafile.dart';
import 'package:teste_tile/models/Boleto.dart';

class BoletoComponent extends StatefulWidget {
  final Boleto boleto;

  const BoletoComponent({required this.boleto, super.key});

  @override
  State<BoletoComponent> createState() => _BoletoComponentState();
}

class _BoletoComponentState extends State<BoletoComponent> {
  late Boleto boleto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boleto = widget.boleto;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("Boleto Outubro 2024"), //boleto.data?
      titleAlignment: ListTileTitleAlignment.center,
      subtitle: Container(
          child: Text(
            // ignore: prefer_interpolation_to_compose_strings
              "Boleto: ${boleto.numero} \n" +
                  "Vencimento: ${boleto.data} \n" + //mudar para boleto.dataVencimento
                  "Valor: R\$ ${boleto.valor.toStringAsFixed(1)}")),
      isThreeLine: false,
      // onTap: () {
      //   setState(() {
      //     _data.removeWhere((Item currentItem) => item == currentItem);
      //   });
      // },
    );
  }
}
