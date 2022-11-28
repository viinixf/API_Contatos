import 'package:apicontatosfront/api_service.dart';
import 'package:apicontatosfront/contato.dart';
import 'package:flutter/material.dart';

class ListaDeContatosTelaInicial extends StatefulWidget {
  const ListaDeContatosTelaInicial({super.key});

  @override
  State<ListaDeContatosTelaInicial> createState() =>
      _ListaDeContatosTelaInicialState();
}

class _ListaDeContatosTelaInicialState
    extends State<ListaDeContatosTelaInicial> {
  ApiService apiService = ApiService();

  List<Contato> listaContato = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contato>>(
      future: apiService.getContato(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        listaContato = snapshot.data!;
        if (listaContato.isEmpty) {
          return const Center(
            child: Text('Não há clientes cadastrados!'),
          );
        }
        return ListView.builder(
          itemCount: listaContato.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final dadosContatoCadastrado = listaContato[index];
            return ListTile(
              //Será listada na página inicial um Title com o NomeDoContado não podendo ser nulo
              title: Text(dadosContatoCadastrado.nomeDoContato!),
              subtitle: Text(
                  'O telefone do contato é: ${dadosContatoCadastrado.telefoneDoContato!}'),
              //Propriedade Trailing exibe um Widget após o título

              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  //Ao pressionar o IconButton será chamado o método DeletaContato e passado o ID que não poderá ser nulo
                  apiService.deletaContato(dadosContatoCadastrado.id!);
                  const snackBarDelete = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Contato removido!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBarDelete);
                  //Propriedade responsável por reconstruir a página
                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }
}
