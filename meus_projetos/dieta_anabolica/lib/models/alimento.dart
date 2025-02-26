class Alimento {
  int? id;
  String? nome;
  double? calorias;
  double? carboidrato;
  double? proteina;
  double? gordura;
  List<String>? microNutrientes;

  Alimento({
    this.id,
    this.nome,
    this.calorias,
    this.carboidrato,
    this.proteina,
    this.gordura,
    this.microNutrientes = const [],
  });

  // Método para exibir as informações do alimento
  @override
  String toString() {
    return 'Alimento{id: $id, name: $nome, caloria: $calorias, carboidrato: $carboidrato, proteina: $proteina, gordura: $gordura, microNutrientes: $microNutrientes}';
  }
}

void main() {
  // Exemplo de instância da classe Alimento
  Alimento maca = Alimento(
    id: 1,
    nome: 'Maçã',
    calorias: 52,
    carboidrato: 14,
    proteina: 0.3,
    gordura: 0.2,
    microNutrientes: ['Vitamina C', 'Potássio'],
  );

  print(maca);

  // Nova instância para o alimento Ovo
  Alimento ovo = Alimento(
    id: 2,
    nome: 'Ovo',
    calorias: 155,
    carboidrato: 1.1,
    proteina: 13,
    gordura: 11,
    microNutrientes: ['Vitamina B12', 'Vitamina D', 'Selênio'],
  );

  print(ovo);
}
