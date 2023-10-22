import 'package:desafio_cadastro_cep/model/viacep_back4app_model.dart';
import 'package:desafio_cadastro_cep/model/viacep_model.dart';
import 'package:desafio_cadastro_cep/repostories/back4app/viaceps_back4app_repository.dart';
import 'package:desafio_cadastro_cep/repostories/via_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListagemPage extends StatefulWidget {
  const ListagemPage({super.key});

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  bool loading = true;
  ViaCepsBack4AppRepository cepRepository = ViaCepsBack4AppRepository();
  var _cepsBack4App = ViaCEPsBack4AppModel([]);
  var cepController = TextEditingController(text: "");
  var viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();

  @override
  void initState() {
    super.initState();
    obterCeps();
  }

  obterCeps() async {
    setState(() {
      loading = true;
    });
    _cepsBack4App = await cepRepository.obterCeps();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Listagem",
            style: GoogleFonts.nosifer(),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: loading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LinearProgressIndicator(),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: _cepsBack4App.ceps.length,
                      itemBuilder: (context, index) {
                        var cep = _cepsBack4App.ceps[index];

                        return InkWell(
                          onTap: () {
                            cepController.text = "";
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: Text(
                                        "Altere o cep:",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: TextField(
                                        controller: cepController,
                                        keyboardType: TextInputType.number,
                                        //maxLength: 8,
                                        onChanged: (String value) async {
                                          var cep = value.replaceAll(
                                              RegExp(r'[^0-9]'), '');
                                          if (cep.length == 8) {
                                            setState(() {
                                              loading = true;
                                            });
                                            viacepModel = await viaCEPRepository
                                                .consultarCEP(cep);
                                          }
                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: TextButton(
                                            onPressed: () async {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();

                                              if (cepController.text.length ==
                                                  8) {
                                                cep.cep = viacepModel.cep!
                                                    .replaceAll(
                                                        RegExp(r'[^0-9]'), '');

                                                cep.logradouro =
                                                    viacepModel.logradouro!;
                                                cep.complemento =
                                                    viacepModel.complemento!;
                                                cep.bairro =
                                                    viacepModel.bairro!;
                                                cep.localidade =
                                                    viacepModel.localidade!;
                                                cep.uf = viacepModel.uf!;
                                                await cepRepository
                                                    .atualizar(cep);

                                                obterCeps();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              "Salvar",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: Key(cep.objectId),
                            onDismissed: (direction) async {
                              await cepRepository.remover(cep.objectId);
                              obterCeps();
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.red,
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text("Cep",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    subtitle: Text(cep.cep),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text("Cidade",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    subtitle: Text(cep.localidade),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text("Estado",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    subtitle: Text(cep.uf),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}
