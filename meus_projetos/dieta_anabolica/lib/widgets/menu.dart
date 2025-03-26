import 'package:dieta_anabolica/main.dart';
import 'package:dieta_anabolica/pages/cadastro_alimento.dart';
import 'package:dieta_anabolica/pages/lista_alimentos.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu"),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DietaAnabolica()));
              // Navigator.pop(context);
            },
          ),
          // ListTile(
          //   title: Text("Alimentos"),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroAlimentoPage(),));
          //     // Navigator.pop(context);
          //   },
          // ),
          ExpansionTile(
            leading: const Icon(Icons.food_bank),
            title: const Text("Alimentos"),
            children: [
              ListTile(
                title: const Text("Cadastro de alimentos"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroAlimentoPage()));
                },
              ),
              ListTile(
                title: const Text("Lista de alimentos"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ListaDeAlimentosPage()));
                },
              )
            ],
          ),
          ListTile(
            title: const Text("Dieta"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
