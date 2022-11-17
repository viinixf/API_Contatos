class Contato {
  int? id;
  String? nomeDoContato;
  String? telefoneDoContato;
  int? idadeDoContato;
  String? sexoDoContato;
  Contato({
    this.id,
    this.nomeDoContato,
    this.telefoneDoContato,
    this.idadeDoContato,
    this.sexoDoContato,
  });

  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json['id'] != null ? json['id'] as int : null,
      nomeDoContato: json['nomeDoContato'] != null
          ? json['nomeDoContato'] as String
          : null,
      telefoneDoContato: json['telefoneDoContato'] != null
          ? json['telefoneDoContato'] as String
          : null,
      idadeDoContato:
          json['idadeDoContato'] != null ? json['idadeDoContato'] as int : null,
      sexoDoContato: json['sexoDoContato'] != null
          ? json['sexoDoContato'] as String
          : null,
    );
  }

  @override
  String toString() {
    return 'Contato(id: $id, nomeDoContato: $nomeDoContato, telefoneDoContato: $telefoneDoContato, idadeDoContato: $idadeDoContato, sexoDoContato: $sexoDoContato)';
  }
}
