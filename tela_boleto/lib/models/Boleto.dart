import 'package:flutter/cupertino.dart';
import 'package:teste_tile/models/Mensalidade.dart';
import 'package:teste_tile/models/Expansivel.dart';

class Boleto with Expansivel {
  int numero;
  String linhaDigitavel;
  DateTime? data;
  int valor;
  List<Mensalidade>? mensalidades;

  Boleto({
    required this.numero,
    required this.linhaDigitavel,
    this.data,
    required this.valor,
    this.mensalidades,
    isExpanded
  });

  // Método copyWith para criar uma nova cópia com valores modificados
  Boleto copyWith({int? numero, String? linhaDigitavel, DateTime? data, int? valor, bool? isExpanded}) {
    return Boleto(
      numero: numero ?? this.numero,
      linhaDigitavel: linhaDigitavel ?? this.linhaDigitavel,
      data: data ?? this.data,
      valor: valor ?? this.valor,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  factory Boleto.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'numero': int numero,
        'linhaDigitavel': String linhaDigitavel,
        'valor': int valor,
      } =>
        Boleto(numero: numero, linhaDigitavel: linhaDigitavel, valor: valor),
      _ => throw const FormatException("Erro ao carregar Json")
    };
  }
}
