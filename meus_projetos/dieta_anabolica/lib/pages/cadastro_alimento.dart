import 'dart:convert';
import 'dart:ffi';

import 'package:dieta_anabolica/components/alimento_api.dart';
import 'package:dieta_anabolica/models/alimento.dart';
import 'package:dieta_anabolica/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CadastroAlimentoPage extends StatefulWidget {
  const CadastroAlimentoPage({super.key});

  @override
  State<CadastroAlimentoPage> createState() => _CadastroAlimentoPageState();
}

class _CadastroAlimentoPageState extends State<CadastroAlimentoPage> with AlimentoApi {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  Alimento alimento = Alimento(nome: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Alimentos')),
      drawer: const Menu(),
      body:  Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // controller: _nomeController,
                decoration: const InputDecoration(hintText: 'Nome'),
                onSaved: (nome) => alimento.nome = nome!,
                validator: (nome) => validarCampoFormulario(nome, "Nome")
              ),
              TextFormField(
                // controller: _caloriasController,
                decoration: const InputDecoration(hintText: 'Calorias'),
                  onSaved: (caloria) => alimento.calorias = double.tryParse(caloria!),
                validator: (caloria) => validarCampoFormulario(caloria, "Caloria")
              ),
              ElevatedButton(onPressed: () {
                if (_formKey.currentState!.validate()) {

                  _formKey.currentState!.save();
                  // print("Nome: ${alimento.nome}");
                  // print("Caloria: ${alimento.caloria}");

                  save(alimento);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processando dados')),
                  );
                }
              }, child: const Text("Salvar"))
            ],
          )
      ),
    );
  }

  validarCampoFormulario(String? valor, String atributo) {
    return (valor?.isEmpty ?? true)
        ? "$atributo não pode ser nulo"
        : null;
  }
}
