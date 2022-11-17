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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de contatos"),
      ),
      body: FutureBuilder<List<Contato>>(
          future: apiService.getContato(),
          builder: (context, snapshot) {
            final dadosContato = snapshot.data;
            if (dadosContato == null) {
              return const Center(
                child: Text('Não há clientes cadastrados!'),
              );
            }

            return ListView.builder(
              itemCount: dadosContato.length,
              itemBuilder: (context, index) {
                final dadosContatoCadastrados = dadosContato[index];

                return ListTile(
                  title: Text(dadosContatoCadastrados.nomeDoContato!),
                );
              },
            );
          }),
    );
  }
}
