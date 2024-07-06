import 'dart:convert';

class Car {
  int id;
  int timestampCadastro;
  int modeloId;
  int ano;
  String combustivel;
  int numPortas;
  String cor;
  String nomeModelo;
  int valor;
  Car({
    required this.id,
    required this.timestampCadastro,
    required this.modeloId,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.nomeModelo,
    required this.valor,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id']?.toInt() ?? 0,
      timestampCadastro: map['timestamp_cadastro']?.toInt() ?? 0,
      modeloId: map['modelo_id']?.toInt() ?? 0,
      ano: map['ano']?.toInt() ?? 0,
      combustivel: map['combustivel'] ?? '',
      numPortas: map['num_portas']?.toInt() ?? 0,
      cor: map['cor'] ?? '',
      nomeModelo: map['nome_modelo'] ?? '',
      valor: map['valor']?.toInt() ?? 0,
    );
  }

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Car(id: $id, timestampCadastro: $timestampCadastro, modeloId: $modeloId, ano: $ano, combustivel: $combustivel, numPortas: $numPortas, cor: $cor, nomeModelo: $nomeModelo, valor: $valor)';
  }
}
