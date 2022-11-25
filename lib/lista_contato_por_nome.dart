import 'package:apicontatosfront/api_service.dart';
import 'package:apicontatosfront/contato.dart';
import 'package:apicontatosfront/tela_inicial.dart';
import 'package:flutter/material.dart';

class ListaContatoPorNome extends StatelessWidget {
  const ListaContatoPorNome({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contato por nome"),
      ),
      body: Column(
        children: [
          //FutureBuilder indica que acontecerá algo no Futuro, ou seja, é uma tarefa assíncrona
          FutureBuilder<List<Contato>>(
            //Futuro esperado é: chamar método GetPorNome passando como parâmetro o texto do Controller da tela inicial
            future: apiService.getPorNome(pesquisaContatoTelaInicial.text),
            //Snapshot builder conterá as informações vindas do getPorNome, executando o snapshot.data terá acesso a lista de dados do contato
            builder: (context, snapshot) {
              //Criada uma variável dadosDoContatoCadastrado que receberá as informações de data contidas no snapshot
              final dadosDoContatoCadastrado = snapshot.data;
              //Tempo de resposta da API para a requisição, enquanto há a espera para resposta retornará um CircularProgressIndicator
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //Após o envio da resposta da API, retorna uma Column com o ListViewBuilder
              return Column(
                children: [
                  //Cria um Array linear rolável
                  ListView.builder(
                    //Quantidade de itens que retornará na Lista, caso altere para 3, por exemplo, serão listados somente três contatos
                    itemCount: dadosDoContatoCadastrado?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //Criação de variável que receberá os dadosDoContato já cadastrado
                      final listaDeDadosDoContato =
                          dadosDoContatoCadastrado?[index];
                      //Retorna uma Column no qual exibirá os dados tratados do contato
                      return Column(
                        children: [
                          ListTile(
                            title: Text(listaDeDadosDoContato!.nomeDoContato
                                .toString()),
                            subtitle: Text(
                                "O telefone do contato é: ${listaDeDadosDoContato.telefoneDoContato}"),
                            trailing: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 3,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
