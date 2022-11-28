import 'package:apicontatosfront/lista_contato_por_nome.dart';
import 'package:apicontatosfront/lista_de_contatos.dart';
import 'package:apicontatosfront/tela_de_cadastro.dart';
import 'package:flutter/material.dart';

///Tela inicial do App
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

// Variável que recebe o conteúdo digite no TextFormField de pesquisa contato
var pesquisaContatoTelaInicial = TextEditingController(text: '');

class _TelaInicialState extends State<TelaInicial> {
  @override
  ///////////////////////////////////////////////////////////////////////////////////////
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gerenciador de contatos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            // Ao pressionar o IconButton "add", será redirecionado para a TelaDeCadastro
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => TelaDeCadastro())));
            },
          ),
        ],
      ),

      // Criação do Body Column no qual distribui os Widgets verticalmente
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              //Texto digitado no TextFormField será guardado no buscaContatoController que será utilizado para validar se o contato está inserido
              TextFormField(
                controller: pesquisaContatoTelaInicial,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar contato: ',
                ),
              ),
              SizedBox(
                height: 60,
                child: TextButton(
                  child: const Text('Pesquisar'),

                  ///////////////////////////////////////////////////////////////////////////////////////

                  //Se o buscaContatoController.text = vazio, retornará o SnackBar com duração de 4s informando que não há nada digitado
                  onPressed: () {
                    if (pesquisaContatoTelaInicial.text.isEmpty) {
                      const snackBarPreenchaOsCampos = SnackBar(
                        duration: Duration(seconds: 4),
                        content: Text('Preencha o campo de pesquisar contato!'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBarPreenchaOsCampos);
                      //Se não, é direcionado a página de ListarContatoPorNome
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListaContatoPorNome()));
                    }
                  },
                  ///////////////////////////////////////////////////////////////////////////////////////
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
                //Lista de contatos já cadastrados
              ),
              const SingleChildScrollView(
                child: Card(child: ListaDeContatosTelaInicial()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
