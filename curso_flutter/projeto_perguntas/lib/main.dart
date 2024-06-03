import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resultado.dart';
import './questao.dart';
import './resposta.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  // Exemplo de função de retorno. Consigo chamar como 'funcao()', ao invez de passar como parametro
  // Null Function() funcaoDeRetorno() {
  //   return () {
  //     print('Usando funcao de retorno');
  //   };
  // }

  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Verde', 'pontuacao': 3},
        {'texto': 'Branco', 'pontuacao': 1}
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 10},
        {'texto': 'Cobra', 'pontuacao': 5},
        {'texto': 'Elefante', 'pontuacao': 3},
        {'texto': 'Leão', 'pontuacao': 1},
      ]
    },
    {
      'texto': 'Qual é o seu instrutor favorito?',
      'respostas': [
        {'texto': 'Leo', 'pontuacao': 10},
        {'texto': 'Maria', 'pontuacao': 5},
        {'texto': 'João', 'pontuacao': 3},
        {'texto': 'Pedro', 'pontuacao': 1},
      ]
    }
  ];

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
    print(_pontuacaoTotal);
  }

  void _reiniciarQuestionario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> respostas = [];
    // for (var textoResposta
    //     in perguntas[_perguntaSelecionada].cast()['respostas']) {
    //   respostas.add(Resposta(textoResposta, _responder));
    // }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Perguntas')),
          body: temPerguntaSelecionada
              ? Questionario(
                  perguntas: _perguntas,
                  perguntaSelecionada: _perguntaSelecionada,
                  responder: _responder)
              : Resultado(_pontuacaoTotal, _reiniciarQuestionario)

          // Exemplo de tipos de chamadas de função (arrow, função como parametro inteira)
          /*
          body: Column(
            children: [
              Text(perguntas[perguntaSelecionada]),
              ElevatedButton(onPressed: _responder, child: Text('Resposta 1')),
              ElevatedButton(
                  onPressed: () => print('Resposta com funcao arrow'),
                  child: Text('Resposta 2')),
              ElevatedButton(
                  onPressed: () {
                    print('Resposta com funcao nao nomeada');
                  },
                  child: Text('Resposta 3')),
              ElevatedButton(
                  onPressed: funcaoDeRetorno(), child: Text('Resposta 4')),
            ],
          ),
          */

          // Exemplo de vários elementos children
          // body: Column(
          //   children: [Text('Linha 1'), Text('Linha 2')],
          // ),
          ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  @override
  State<PerguntaApp> createState() {
    return _PerguntaAppState();
  }
}
