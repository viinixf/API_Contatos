import 'dart:convert';

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

  Contato copyWith({
    int? id,
    String? nomeDoContato,
    String? telefoneDoContato,
    int? idadeDoContato,
    String? sexoDoContato,
  }) {
    return Contato(
      id: id ?? this.id,
      nomeDoContato: nomeDoContato ?? this.nomeDoContato,
      telefoneDoContato: telefoneDoContato ?? this.telefoneDoContato,
      idadeDoContato: idadeDoContato ?? this.idadeDoContato,
      sexoDoContato: sexoDoContato ?? this.sexoDoContato,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nomeDoContato': nomeDoContato,
      'telefoneDoContato': telefoneDoContato,
      'idadeDoContato': idadeDoContato,
      'sexoDoContato': sexoDoContato,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      id: map['id'] != null ? map['id'] as int : null,
      nomeDoContato:
          map['nomeDoContato'] != null ? map['nomeDoContato'] as String : null,
      telefoneDoContato: map['telefoneDoContato'] != null
          ? map['telefoneDoContato'] as String
          : null,
      idadeDoContato:
          map['idadeDoContato'] != null ? map['idadeDoContato'] as int : null,
      sexoDoContato:
          map['sexoDoContato'] != null ? map['sexoDoContato'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) =>
      Contato.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contato(id: $id, nomeDoContato: $nomeDoContato, telefoneDoContato: $telefoneDoContato, idadeDoContato: $idadeDoContato, sexoDoContato: $sexoDoContato)';
  }

  @override
  bool operator ==(covariant Contato other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nomeDoContato == nomeDoContato &&
        other.telefoneDoContato == telefoneDoContato &&
        other.idadeDoContato == idadeDoContato &&
        other.sexoDoContato == sexoDoContato;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nomeDoContato.hashCode ^
        telefoneDoContato.hashCode ^
        idadeDoContato.hashCode ^
        sexoDoContato.hashCode;
  }
}
