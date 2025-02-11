class Mensalidade {
  String descricao;
  DateTime? data;
  int valor;
  int idBoleto;

  Mensalidade({
    required this.descricao,
    this.data,
    required this.valor,
    required this.idBoleto
  });

  factory Mensalidade.fromJson(Map<String, dynamic> json) {
    return
      switch (json) {
      {
        'descricao': String descricao,
        'idBoleto': int idBoleto,
        'valor': int valor,
      } =>
        Mensalidade(
          descricao: descricao,
          idBoleto: idBoleto,
          valor: valor,
        ),
      _ => throw const FormatException("Falha ao carregar Json")
      };
  }
}