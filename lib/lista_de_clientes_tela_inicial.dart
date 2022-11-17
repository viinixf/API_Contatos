import 'package:apicontatosfront/api_service.dart';
import 'package:apicontatosfront/contato.dart';
import 'package:flutter/material.dart';

class ListaDeClientesTelaInicial extends StatefulWidget {
  const ListaDeClientesTelaInicial({super.key});

  @override
  State<ListaDeClientesTelaInicial> createState() =>
      _ListaDeClientesTelaInicialState();
}

class _ListaDeClientesTelaInicialState
    extends State<ListaDeClientesTelaInicial> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: FutureBuilder<List<Contato>>(
        future: apiService.getContato(),
        builder: (context, snapshot) {
          final contatoCriado = Contato();
          if (contatoCriado.id == null) {
            return const Center(
              child: Text('Nenhum contato adicionado'),
            );
          }
          return ListTile(
            title: Text(contatoCriado.nomeDoContato!),
            subtitle: Text(contatoCriado.sexoDoContato!),
          );
        },
      ),
    );
  }
}
