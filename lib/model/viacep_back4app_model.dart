class ViaCEPsBack4AppModel {
  List<ViaCEPBack4AppModel> ceps = [];

  ViaCEPsBack4AppModel(this.ceps);

  ViaCEPsBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <ViaCEPBack4AppModel>[];
      json['results'].forEach((v) {
        ceps.add(ViaCEPBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ceps != null) {
      data['results'] = ceps.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViaCEPBack4AppModel {
  String objectId = "";
  String cep = "";
  String logradouro = "";
  String complemento = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  String createdAt = "";
  String updatedAt = "";

  ViaCEPBack4AppModel(
      this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.createdAt,
      this.updatedAt);

  ViaCEPBack4AppModel.criar(this.cep, this.logradouro, this.complemento,
      this.bairro, this.localidade, this.uf);

  ViaCEPBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}
