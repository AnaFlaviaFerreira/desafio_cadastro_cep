import 'package:desafio_cadastro_cep/model/viacep_back4app_model.dart';
import 'package:desafio_cadastro_cep/model/viacep_model.dart';
import 'package:desafio_cadastro_cep/repostories/back4app/viaceps_back4app_repository.dart';
import 'package:desafio_cadastro_cep/repostories/via_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViaCepPage extends StatefulWidget {
  const ViaCepPage({super.key});

  @override
  State<ViaCepPage> createState() => _ViaCepPageState();
}

class _ViaCepPageState extends State<ViaCepPage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();
  ViaCepsBack4AppRepository cepRepository = ViaCepsBack4AppRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Adição de CEP",
          style: GoogleFonts.nosifer(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        "CEP:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: cepController,
                      keyboardType: TextInputType.number,
                      //maxLength: 8,
                      onChanged: (String value) async {
                        var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                        if (cep.length == 8) {
                          setState(() {
                            loading = true;
                          });
                          viacepModel =
                              await viaCEPRepository.consultarCEP(cep);
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Cidade: ${viacepModel.localidade ?? ''}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Estado: ${viacepModel.uf ?? ''}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 16),
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple)),
                      onPressed: () async {
                        setState(() {
                          loading = false;
                        });
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (cepController.text.length == 8) {
                          setState(() {
                            loading = true;
                          });

                          var cep = viacepModel.cep!
                              .replaceAll(RegExp(r'[^0-9]'), '');

                          var result = await cepRepository
                              .criar(ViaCEPBack4AppModel.criar(
                            cep,
                            viacepModel.logradouro!,
                            viacepModel.complemento!,
                            viacepModel.bairro!,
                            viacepModel.localidade!,
                            viacepModel.uf!,
                          ));
                          cepController.text = "";
                          viacepModel = ViaCEPModel();
                          setState(() {
                            loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.toString())));
                        }
                      },
                      child: const Text("Adicionar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
      ),
    ));
  }
}
