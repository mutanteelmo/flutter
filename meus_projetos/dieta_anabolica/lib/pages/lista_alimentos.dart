import 'package:dieta_anabolica/models/alimento.dart';
import 'package:dieta_anabolica/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'package:dieta_anabolica/components/alimento_api.dart';

class ListaDeAlimentosPage extends StatefulWidget {
  const ListaDeAlimentosPage({super.key});

  @override
  State<ListaDeAlimentosPage> createState() => _ListaDeAlimentosPageState();
}

class _ListaDeAlimentosPageState extends State<ListaDeAlimentosPage> with AlimentoApi{

  late Future<List<Alimento>> alimentos = getAll();

  @override
  void initState() {
    super.initState();
    alimentos = getAll();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
            title: const Text("Lista de alimentos"),
            leading: const BackButton(),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Alimento>>(
            future: alimentos.timeout(
              const Duration(seconds: 3),
              onTimeout: () => [],
            ),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) return const LinearProgressIndicator();
              else if (!snapshot.hasData) return const Text("Nenhum alimento cadastrado");
              else if (snapshot.hasData) {
                List<Alimento> alimentos = snapshot.data!;
                return ListView(
                    children: alimentos.map<ListTile>((alimento) {
                      return ListTile(
                        title: Text(alimento.nome ?? "Sem nome"),
                        subtitle: Text(
                            "${alimento.calorias} kcal "
                            "\n"
                              "Carbs: ${alimento.carboidrato}"
                            "| Protein: ${alimento.proteina} "
                            "| Fat: ${alimento.gordura}"
                            "\n"
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton(
                            itemBuilder: (BuildContext) => <PopupMenuEntry>[
                              const PopupMenuItem(
                                child: Text("Detalhes"),
                                onTap: null, // Abrir detalhes do produto
                              )
                            ]
                        ),
                      );
                    }).toList()
                );
              } else return const Text("Nenhum alimento carregado");
            }
        ),
      );
    }
}
