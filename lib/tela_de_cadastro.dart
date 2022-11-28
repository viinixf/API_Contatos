import 'package:apicontatosfront/api_service.dart';
import 'package:apicontatosfront/contato.dart';
import 'package:apicontatosfront/tela_inicial.dart';
import 'package:flutter/material.dart';

class TelaDeCadastro extends StatelessWidget {
  // A GlobalKey serve para identificar de forma exclusiva o formulário e permite validar as informações
  final _formKey = GlobalKey<FormState>();

  final apiService = ApiService();

  TelaDeCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    // Criação das variáveis de Controller que irão receber o conteúdo digitado no TextFormField
    var nomeController = TextEditingController(text: '');
    var telefoneController = TextEditingController(text: '');
    var idadeController = TextEditingController(text: '');
    var sexoController = TextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cadastrar contato"),
        actions: [
          ///////////////////////////////////////////////////////////////////
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              //Ao pressionar o IconButton Done, validará se a chave FormKey é valida e salvará
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                //Sendo válida as informações, é chamado o método Post da ApiService e guardando as informações do Controller nos atributos da classe entidade
                await apiService.postContato(Contato(
                    nomeDoContato: nomeController.text,
                    telefoneDoContato: telefoneController.text,
                    idadeDoContato: int.parse(idadeController.text),
                    sexoDoContato: sexoController.text));
                //Após guardar as informações, retorna para a TelaInicial
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const TelaInicial()),
                    (route) => false);
                //exibição do SnackBar correspondente com o que é executado no app
                const snackBarCadastrado = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      'Contato salvo com sucesso!',
                      style: TextStyle(fontSize: 16),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBarCadastrado);
              } else {
                const snackBarErroNoCadastro = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text(
                      'Preencha os campos corretamente!',
                      style: TextStyle(fontSize: 16),
                    ));
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarErroNoCadastro);
              }
            },
          ),
          ////////////////////////////////////////////////////////////////
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //Criada a Form pois é necessária para validar os campos (classe de formulário)
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                //Validações utilizando o TextFormField
                TextFormField(
                  controller: nomeController,
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Preencha o nome do contato';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome do contato: ',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  controller: telefoneController,
                  validator: (telefone) {
                    if (telefone == null || telefone.isEmpty) {
                      return 'Preencha o telefone do contato';
                    }
                    return null;
                  },
                  maxLength: 15,
                  decoration:
                      const InputDecoration(labelText: 'Telefone do contato:'),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  controller: idadeController,
                  keyboardType: TextInputType.number,
                  validator: (idade) {
                    if (idade == null || idade.isEmpty) {
                      return 'Preencha a idade do contato';
                    }
                    return null;
                  },
                  maxLength: 3,
                  decoration:
                      const InputDecoration(labelText: 'Idade do contato:'),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  controller: sexoController,
                  validator: (sexo) {
                    if (sexo == null ||
                        sexo.isEmpty ||
                        sexo != 'M' && sexo != 'F') {
                      return 'Preencha o sexo do contato corretamente: "M" ou "F"';
                    }
                    return null;
                  },
                  maxLength: 1,
                  decoration: const InputDecoration(
                    labelText: 'Sexo do contato',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
