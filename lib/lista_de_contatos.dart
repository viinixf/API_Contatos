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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final contatosListados = snapshot.data;
            if (contatosListados!.isEmpty) {
              return const Center(
                child: Text('Não há clientes cadastrados!'),
              );
            }

            return ListView.builder(
              itemCount: contatosListados.length,
              itemBuilder: (context, index) {
                final dadosContatoCadastrados = contatosListados[index];

                return ListTile(
                  title: Text(dadosContatoCadastrados.nomeDoContato!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      apiService.deletaContato(dadosContatoCadastrados.id!);
                      const snackBarDelete = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Contato removido!'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarDelete);
                      setState(() {});
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
