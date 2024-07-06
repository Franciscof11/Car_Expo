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

  Car copyWith({
    int? id,
    int? timestampCadastro,
    int? modeloId,
    int? ano,
    String? combustivel,
    int? numPortas,
    String? cor,
    String? nomeModelo,
    int? valor,
  }) {
    return Car(
      id: id ?? this.id,
      timestampCadastro: timestampCadastro ?? this.timestampCadastro,
      modeloId: modeloId ?? this.modeloId,
      ano: ano ?? this.ano,
      combustivel: combustivel ?? this.combustivel,
      numPortas: numPortas ?? this.numPortas,
      cor: cor ?? this.cor,
      nomeModelo: nomeModelo ?? this.nomeModelo,
      valor: valor ?? this.valor,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'timestampCadastro': timestampCadastro});
    result.addAll({'modeloId': modeloId});
    result.addAll({'ano': ano});
    result.addAll({'combustivel': combustivel});
    result.addAll({'numPortas': numPortas});
    result.addAll({'cor': cor});
    result.addAll({'nomeModelo': nomeModelo});
    result.addAll({'valor': valor});

    return result;
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id']?.toInt() ?? 0,
      timestampCadastro: map['timestampCadastro']?.toInt() ?? 0,
      modeloId: map['modeloId']?.toInt() ?? 0,
      ano: map['ano']?.toInt() ?? 0,
      combustivel: map['combustivel'] ?? '',
      numPortas: map['numPortas']?.toInt() ?? 0,
      cor: map['cor'] ?? '',
      nomeModelo: map['nomeModelo'] ?? '',
      valor: map['valor']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Car(id: $id, timestampCadastro: $timestampCadastro, modeloId: $modeloId, ano: $ano, combustivel: $combustivel, numPortas: $numPortas, cor: $cor, nomeModelo: $nomeModelo, valor: $valor)';
  }
}
