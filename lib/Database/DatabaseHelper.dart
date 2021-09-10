import 'dart:async';
import 'dart:io';
import 'package:safe_language/Models/Codigo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  //database instance
  //info database

  final String listaTable = 'codigo_user';
  final String codigo = 'codigo';




  static DatabaseHelper _instance= DatabaseHelper._internal();
  DatabaseHelper._internal();

  static late Database _database;

  factory DatabaseHelper(){
    return _instance;
  }


  Future<Database> get database async{
    _database =await initializeDatabase();

    return  _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path  = directory.path + 'safeLanguage.db';

    var SLDatabase = await openDatabase(
        path,
        version: 1,
        onCreate: _createDb

    );
    return SLDatabase;
  }
  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $listaTable($codigo TEXT)');
  }

  //incluir
  Future<int> insertCodigo(Codigo codigo) async{
    Database db = await this.database;
    List<Map> listaDb= await db.query(this.listaTable);

    var resultado;

    if(listaDb.isEmpty){
      resultado = await db.insert(listaTable, codigo.toMap());
    }else{
      resultado = await updateCodigo(codigo);
    }
    return resultado;
  }


  Future<String> getCodigos() async{
    Database db = await this.database;
    List<Map> listaDb= await db.query(this.listaTable);
    List<Codigo> resultado =[];

    if(!listaDb.isEmpty){
      for(Map map in listaDb){
        resultado.add(Codigo.fromMap(map));
      }
    }else{
      resultado.add(new Codigo("empty"));
    }
    return resultado[0].codigo;
  }

  Future<int> updateCodigo(Codigo cod) async{
    Database db = await this.database; // método get

    var resultado = await db.rawUpdate('''
    UPDATE $listaTable
    SET $codigo = ?
    ''',[cod.codigo]);

    return resultado;
  }

  Future<int> deleteUser() async{
    Database db = await this.database; //método get

    var resultado =
    await db.delete(this.listaTable);
    return resultado;
  }

  Future close() async{
    Database db = await this.database; //método get
    db.close();
  }

}