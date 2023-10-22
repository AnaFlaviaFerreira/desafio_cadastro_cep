import 'package:desafio_cadastro_cep/model/viacep_back4app_model.dart';
import 'package:desafio_cadastro_cep/repostories/back4app/back4app_custon_dio.dart';

class ViaCepsBack4AppRepository {
  final _custonDio = Back4AppCustonDio();

  ViaCepsBack4AppRepository();

  Future<ViaCEPsBack4AppModel> obterCeps() async {
    var url = "/CEPs";
    var result = await _custonDio.dio.get(url);
    return ViaCEPsBack4AppModel.fromJson(result.data);
  }

  Future<String> criar(ViaCEPBack4AppModel viaCepBack4AppModel) async {
    try {
      var consulta = await _custonDio.dio.get(
          "/CEPs?where=%7B%22cep%22%3A%20%22${viaCepBack4AppModel.cep}%22%20%7D");
      var data = consulta.data as Map;
      var result = data['results'] as List;
      if (result.isNotEmpty) {
        return 'CEP já foi cadastrado.';
      }
      await _custonDio.dio
          .post("/CEPs", data: viaCepBack4AppModel.toJsonEndpoint());
      return 'CEP cadastrado com sucesso!';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(ViaCEPBack4AppModel viaCepBack4AppModel) async {
    try {
      await _custonDio.dio.put("/CEPs/${viaCepBack4AppModel.objectId}",
          data: viaCepBack4AppModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete(
        "/CEPs/$objectId",
      );
    } catch (e) {
      throw e;
    }
  }
}
