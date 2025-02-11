import 'package:teste_tile/models/Boleto.dart';
import 'package:teste_tile/models/Mensalidade.dart';

List<Boleto> boletos = [
  Boleto(
      numero: 12345678,
      linhaDigitavel: "00190500954014481606906809350314337370000000100",
      data: DateTime(DateTime.january, 7, 2025),
      valor: 850,
      mensalidades: <Mensalidade>[
        Mensalidade(
          descricao: "Valor da mensalidade",
          data: DateTime(DateTime.january, 7, 2025),
          valor: 800,
          idBoleto: 12345678
        ),
        Mensalidade(
            descricao: "Teatro",
            data: DateTime(DateTime.january, 3, 2025),
            valor: 50,
            idBoleto: 12345678
        )
      ]
  )
];
