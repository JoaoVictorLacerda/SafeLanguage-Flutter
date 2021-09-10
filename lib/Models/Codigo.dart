class Codigo{

  late String codigo;

  Codigo(String codigo){
    this.codigo=codigo;
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'codigo':  codigo,
    };
    return map;
  }

  Codigo.fromMap(Map map){
    codigo = map['codigo'];
  }



}