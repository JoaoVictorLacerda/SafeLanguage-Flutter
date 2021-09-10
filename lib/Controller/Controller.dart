import 'package:flutter/cupertino.dart';
import 'package:safe_language/Database/DatabaseHelper.dart';
import 'package:safe_language/Models/Codigo.dart';

class Controller{

  static final ChangeNotifier _cn =  new ChangeNotifier();



  static void colocarNoBanco(List<String> codigo) async{
    DatabaseHelper db = DatabaseHelper();
    String result ="";
    for(String cod in codigo ){
      result += cod;
    }

    Codigo cod = new Codigo(result);
    await db.insertCodigo(cod);

    new ChangeNotifier().notifyListeners();
  }
  static void colocarNoBancoString(String codigo) async{
    DatabaseHelper db = DatabaseHelper();
    print(codigo.length);
    Codigo cod = new Codigo(codigo);
    await db.insertCodigo(cod);
    _cn.notifyListeners();
  }

  static Future<String> recuperar()async{
    DatabaseHelper db = DatabaseHelper();

    return await db.getCodigos();
  }

  static void apagar()async{
    DatabaseHelper db = DatabaseHelper();

    print(await db.deleteUser());
    _cn.notifyListeners();
  }
}