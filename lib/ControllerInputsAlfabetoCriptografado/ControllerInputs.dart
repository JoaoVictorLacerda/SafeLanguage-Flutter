import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_language/Controller/Controller.dart';
import 'package:safe_language/Popup/ShowAlert.dart';

class ControllerInputs{


  List<String> _alfabetoUser = [
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","","",
    "","","","","","","",""
  ];

  ControllerInputs._internal(){}

  static final ControllerInputs _singleton = ControllerInputs._internal();

  factory ControllerInputs() {
    return _singleton;
  }




  int verificaSeHaCodigosRepetidos(BuildContext context, int numberController) {


    int numI = numberController-4;
    int parada = numberController;
    for(int i = numI; i<parada;i++){
      if(_alfabetoUser[i].length <= 5){
        return 2;
      }
    }
    for (int i = numI; i < parada; i++) {
      if (_alfabetoUser[i] == "" || _alfabetoUser[i] == " " ||
          _alfabetoUser[i] == null) {
        return 0;
      }
    }

    for(int i = 0; i< parada;i++){
      for(int j =i+1;j<parada;j++){
        if(_alfabetoUser[i] == _alfabetoUser[j]){
          return 1;
        }
      }
    }
    if(numberController < 112){
      return 200;
    }else{
      try{
        Controller.colocarNoBanco(_alfabetoUser);
        ShowAlert.popup(context, "Salvo com sucesso");
      }catch(error){
        ShowAlert.popup(context, "Houve um erro ao salvar");

      }

      this.limparAlfabeto();
      return 100;
    }

  }

  void limparAlfabeto(){
    for(int i =0; i<_alfabetoUser.length;i++){
      _alfabetoUser[i]="";
    }
  }

  List<String> getAlfabetouser(){
    return this._alfabetoUser;
  }
}