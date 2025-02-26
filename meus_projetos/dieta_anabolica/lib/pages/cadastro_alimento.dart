import 'dart:convert';
import 'dart:ffi';

import 'package:dieta_anabolica/models/alimento.dart';
import 'package:dieta_anabolica/widgets/menu.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CadastroAlimentoPage extends StatefulWidget {
  const CadastroAlimentoPage({super.key});

  @override
  State<CadastroAlimentoPage> createState() => _CadastroAlimentoPageState();
}

class _CadastroAlimentoPageState extends State<CadastroAlimentoPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  Alimento alimento = Alimento();

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
                onSaved: (nome) => alimento.nome = nome,
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

  // TODO "Implementar"
  Future<void> get(Alimento alimento) async {

  }

  // TODO "Implementar"
  Future<void> getAll(Alimento alimento) async {

  }

  Future<void> save(Alimento alimento) async {
    final url = Uri.parse("http://10.203.2.221:8081/alimentos");

    // Debug
    print("Nome: ${alimento.nome}");
    print("Calorias: ${alimento.calorias}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer TOKEN_AQUI',
      },
      body: jsonEncode({
        'nome': alimento.nome,
        'calorias': alimento.calorias
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Sucesso: ${response.body}');
    } else {
      print('Erro: ${response.statusCode} - ${response.body}');
    }
  }

  // TODO "Implementar"
  Future<void> delete(Alimento alimento) async {
    
  }
  
  validarCampoFormulario(String? valor, String atributo) {
    return (valor?.isEmpty ?? true)
        ? "$atributo não pode ser nulo"
        : null;
  }
}
