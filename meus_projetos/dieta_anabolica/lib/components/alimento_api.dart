import 'dart:convert';
import 'dart:ffi';

import 'package:dieta_anabolica/models/alimento.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

mixin AlimentoApi {

  // // TODO "Implementar"
  // Future<void> get(Alimento alimento) async {
  //
  // }

  // // TODO "Implementar"
  // Future<void> getAll(Alimento alimento) async {
  //
  // }

  Future<void> save(Alimento alimento) async {
    final url = Uri.parse("http://192.168.1.131:8082/alimentos");

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

  Future<List<Alimento>> getAll() async {
    final response = await http.get(
        // Uri.parse("http://10.0.2.2:8082/alimentos")
        Uri.parse("http://192.168.1.131:8082/alimentos")
    );

    if (response.statusCode == 200) {
      try {
        print("Response Body: ${response.body}");

        List<dynamic> jsonMapAlimentos = jsonDecode(response.body);
        List<Alimento> alimentos = jsonMapAlimentos
            .map((alimento) => Alimento.fromJson(alimento as Map<String, dynamic>))
            .toList();

        // debug
        alimentos.map((alimento) => print("Alimento: ${alimento.nome}"));

        return alimentos;
      } catch (e, stackTrace) {
        print("Erro ao processar JSON: $e");
        print(stackTrace);
        return[];
      }

    } else {
      throw Exception("Falha ao carregar alimentos");
    }
  }

}
