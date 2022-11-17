import 'package:apicontatosfront/lista_de_contatos.dart';
import 'package:apicontatosfront/tela_de_cadastro.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gerenciador de contatos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => TelaDeCadastro())));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pesquisar contato: ',
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: TextButton(
                    child: const Text('Pesquisar'),
                    onPressed: () {},
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contatos',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 3,
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ListaDeContatosTelaInicial())));
                      },
                      child: const Text('Lista de contatos'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
