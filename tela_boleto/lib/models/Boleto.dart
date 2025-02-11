import 'package:teste_tile/models/Mensalidade.dart';

class Boleto {
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
    this.mensalidades
  });

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
