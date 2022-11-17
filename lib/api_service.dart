import 'dart:convert';
import 'package:apicontatosfront/contato.dart';
import 'package:apicontatosfront/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var urlRequest = Uri.parse('$apiUrl/contato');

  //Método responsável por inserir contatos (MÉTODO POST)
  Future<Contato> postContato(Contato contato) async {
    http.Response response;
    try {
      response = await http.post(
        urlRequest,
        headers: {"Content-type": "application/json"},
        body: contato.toJson(),
      );
      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao cadastrar!');
      }
      return Contato.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  //Método responsável por listar os contatos (MÉTODO GET)
  Future<List<Contato>> getContato() async {
    http.Response response = await http.get(urlRequest);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Contato> contato =
          body.map((dynamic item) => Contato.fromJson(item)).toList();
      return contato;
    } else {
      throw "Falha ao listar";
    }
  }
}