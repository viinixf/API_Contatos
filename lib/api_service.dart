import 'dart:convert';
import 'package:apicontatosfront/contato.dart';
import 'package:apicontatosfront/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var urlRequest = Uri.parse('$apiUrl/contato');

  ///Método responsável por inserir contatos (MÉTODO POST)
  Future<Contato> postContato(Contato contato) async {
    //Criando um objeto do tipo Map no qual recebe os dados do contato
    Map dadosDoContado = {
      // Passando os dados digitados no cadastrado para um Map dadosDoContado
      'nomeDoContato': contato.nomeDoContato,
      'telefoneDoContato': contato.telefoneDoContato,
      'idadeDoContato': contato.idadeDoContato,
      'sexoDoContato': contato.sexoDoContato
    };
    http.Response response;

    try {
      //será atribuido ao "response" o que está na URL request, ou seja, response irá esperar até receber o que há na URLRequest passada
      response = await http.post(
        urlRequest,
        //define o tipo de mídia
        headers: {"Content-type": "application/json"},
        //Body receberá o dadosDoContato convertido to JSON
        body: jsonEncode(dadosDoContado),
      );
      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao cadastrar!');
      }
      return Contato.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Método responsável por listar os contatos (MÉTODO GET)
  /// Criando uma lista do tipo contato (dizendo ao Flutter que o método retornará uma lista no futuro)
  Future<List<Contato>> getContato() async {
    //response aguarda um retorno da URLRequest e ficará aguardando até que seja enviado algo do localhost:8080/contato
    http.Response response = await http.get(urlRequest);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Contato> contatos =
          body.map((contato) => Contato.fromJson(contato)).toList();
      return contatos;
    } else {
      throw 'Falha na listagem';
    }
  }

  ///Método responsável por deletar contato (MÉTODO DELETE)
  Future<http.Response> deletaContato(int id) async {
    http.Response response = await http.delete(
      Uri.parse('$urlRequest/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  ///Método responsável por listar contato por nome (GET por NOME)
  Future<List<Contato>> getPorNome(String nomeDoContato) async {
    var urlGetPorNome = Uri.parse('$urlRequest/buscarPorNome/$nomeDoContato');
    //Indo na API e solicitando a lista de contatos com o nome passado
    //Dizendo para API: pega o que estiver dentro desta URL e espera até obter uma resposta, após isso guarde em response
    http.Response response = await http.get(urlGetPorNome);
    //Após obter resposta da API
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Contato> contatos =
          body.map((contato) => Contato.fromJson(contato)).toList();
      return contatos;
    } else {
      throw response;
    }
  }
}
