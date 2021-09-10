import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_language/ControllerInputsAlfabetoCriptografado/ControllerInputs.dart';
import 'package:safe_language/Criptografia/Alfabeto.dart';
import 'package:safe_language/Popup/ShowAlert.dart';




class ListViewPage extends StatefulWidget {

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  static int lenAlfabeto = Alfabeto.alfabeto.length;
  static String _textoBTN="Proximo $_numberController de $lenAlfabeto";
  static int _numberController = 4;

  final ControllerInputs _controllerInputs  = ControllerInputs();

  void controlaListaDeInputs(){

    setState(() {

      _numberController += 4;
      if(_numberController > 112){
        _numberController = 4;
      }
      if(_numberController == 112){
        _textoBTN = "Salvar códigos";
      }else{
        _textoBTN ="Proximo  $_numberController de $lenAlfabeto";
      }

    });

  }


  Widget addButttonOnScreen(BuildContext context, String _textoBTN){

    return new Container(
        height: 40,
        child: new RaisedButton(
          onPressed: () async {
            int resultado = _controllerInputs.verificaSeHaCodigosRepetidos(context, _numberController);
            if( resultado == 200 || resultado == 100){
              this.controlaListaDeInputs();

            }else{
              ShowAlert.popup(context,"Campos em branco, repetidos ou com menos de 5 caracteres");
            }

          },
          child: new Center(
            child: new Text(_textoBTN),
          ),
        )
    );
  }



  List<Widget> addInputsOnScreen(BuildContext context, int qtdItens){

    List<Widget> inputs = [];
    inputs.add(new Container(height: 40,));
    for(int i =qtdItens-4; i< qtdItens;i++){
      TextEditingController controllerTexto = new TextEditingController();
      inputs.add(criaInput(Alfabeto.alfabeto[i], i, controllerTexto));

      inputs.add(new Container(height: 15,));
    }
    inputs.add(addButttonOnScreen(context,_textoBTN));
    return inputs;
  }
  Widget criaInput(String caracter, int indice,TextEditingController controllerTexto ){
    return new TextField(
      maxLength: 6,

      decoration: new InputDecoration(
        labelText: caracter,
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),

        ),

      ),
      controller: controllerTexto,
      onChanged: (text) =>{
        _controllerInputs.getAlfabetouser()[indice] = text+","
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Builder(
            builder: (BuildContext context) {
              return  new Padding(
                padding: const EdgeInsets.all(9.0),
                child: new ListView(
                    padding: EdgeInsets.all(10),
                    children: this.addInputsOnScreen(context,_numberController)
                ),
              );
            },)
      ),
    );
  }

}