import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_language/Controller/Controller.dart';
import 'package:safe_language/Criptografia/Alfabeto.dart';
import 'package:safe_language/Popup/ShowAlert.dart';

import 'package:safe_language/Views/PrepararMensagemView.dart';


class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = new TextEditingController();

  Widget criaMultiline(){

    return new TextField(
      maxLines: 8,
      minLines: 8,

      decoration: new InputDecoration(
          labelText: "Digite aqui",
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      controller: _controller,

    );
  }

  @override
  void initState(){
    super.initState();
    Controller.recuperar().then((codigo) => {
      setState((){
        this.prepararAmbienteCripto(codigo);
        this.prepararAmbienteDescripto(codigo);
      })

    });
  }

  void prepararAmbienteCripto(String codigo){
    if(codigo!= "empty"){
      List<String> resultado = codigo.split(",");

      List<String> resultadoCriptografia = [];

      for(int i=0; i < resultado.length;i++){

        resultadoCriptografia.add(resultado[i]+",");
      }

      Alfabeto.codigosCriptografia = resultadoCriptografia;
    }else{
      Alfabeto.codigosCriptografia = [
        "cxr89,","fhH52,","3fgg7,","0829g,","5jfb2,","gca7d,","z1zca,","12cc9,",
        "aa5bc,","0820t,","1137g,","5jf4c,","3fg21,","z1zbz,","08291,","2448g,",
        "12ct1,","61bgg,","g5582,","12ca9,","61bt4,","8tz0g,","244cd,","5jfa0,",
        "gcaa3,","6zc2f,","aa5d4,","12cd6,","3fg56,","om3l4,","z2pla,","cac31,",
        "bi4c0,","hig98,","77tyx,","fuh76,","0pp61,","iuio9,","it552,","tig2a,",
        "01009,","j0a32,","m009g,","nha55,","iHbH7,","gg3rs,","b2b34,","9jgyt,",
        "op5H8,","x1c47,","189hi,","omlH7,","ad087,","ll282,","00llH,","c475a,",
        "k2bbc,","a35e9,","a3528,","04f74,","04gff,","0094g,","00920,","ef7d9,",
        "ef7e0,","gc8b0,","c2c51,","c2c47,","c2c91,","0c368,","6g7gg,","m4175,",
        "cop32,","32pco,","H40i9,","ccl22,","om675,","tjk82,","ph908,","eli56,",
        "29183,","292d0,","53gd1,","53gcg,","95767,","958c2,","958g3,","e47bf,",
        "c14e3,","c1421,","c15ed,","c15g8,","g6e4b,","g7wyx,","g6e4f,","g6e90,",
        "a784c,","bag58,","ba1ba,","2f149,","64b01,","64cg0,","64dfa,",
        "887bc,","abtur,","ciub4,","enop9,","i7858,","cac67,","ff650,","556tr,","xr5bc,"
      ];
    }
  }
  void prepararAmbienteDescripto(String codigo){
    if(codigo!= "empty") {
      Alfabeto.codigosDescriptografia = codigo.split(",");
    }else{
      Alfabeto.codigosDescriptografia=[
        "cxr89","fhH52","3fgg7","0829g","5jfb2","gca7d","z1zca","12cc9",
        "aa5bc","0820t","1137g","5jf4c","3fg21","z1zbz","08291","2448g",
        "12ct1","61bgg","g5582","12ca9","61bt4","8tz0g","244cd","5jfa0",
        "gcaa3","6zc2f","aa5d4","12cd6","3fg56","om3l4","z2pla","cac31",
        "bi4c0","hig98","77tyx","fuh76","0pp61","iuio9","it552","tig2a",
        "01009","j0a32","m009g","nha55","iHbH7","gg3rs","b2b34","9jgyt",
        "op5H8","x1c47","189hi","omlH7","ad087","ll282","00llH","c475a",
        "k2bbc","a35e9","a3528","04f74","04gff","0094g","00920","ef7d9",
        "ef7e0","gc8b0","c2c51","c2c47","c2c91","0c368","6g7gg","m4175",
        "cop32","32pco","H40i9","ccl22","om675","tjk82","ph908","eli56",
        "29183","292d0","53gd1","53gcg","95767","958c2","958g3","e47bf",
        "c14e3","c1421","c15ed","c15g8","g6e4b","g7wyx","g6e4f","g6e90",
        "a784c","bag58","ba1ba","2f149","64b01","64cg0","64dfa",
        "887bc","abtur","ciub4","enop9","i7858","cac67","ff650","556tr","xr5bc"
      ];
    }
  }


  Widget criarBotaoLimpar(String nome, BuildContext context){

    return new Container(
      height: 40,
      child: new RaisedButton(
          child: new Center(
            child: new Text(nome),
          ),
          onPressed: () async {
            try{
              _FachadaHomePage fachada = new _FachadaHomePage(_controller);
              switch(nome){
                case "Limpar":
                  fachada.limpar();
                  break;

                case "Colar":
                  fachada.colar();
                  break;

                case "Criptografar":
                  fachada.criptografar(context);
                  break;

                case "Descriptografar":
                  fachada.descriptografar(context);
                  break;


              }
            }catch(error){
              ShowAlert.popup(context,"Houve algo errado");
            }


          },
          color: new Color(0xFF4da6ff)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: new ListView(
            padding: EdgeInsets.all(10),
            children: [
              new Container(height: 35,),
              criaMultiline(),
              new Container(height: 20,),
              criarBotaoLimpar("Criptografar", context),
              new Container(height: 20,),
              criarBotaoLimpar("Descriptografar", context),
              new Container(height: 20,),
              criarBotaoLimpar("Limpar", context),
              new Container(height: 20,),
              criarBotaoLimpar("Colar", context),
            ],
          ),
        ),
      ),
    );
  }
}

class _FachadaHomePage{

  final TextEditingController _controller;
  const _FachadaHomePage(this._controller);

  void limpar(){
    _controller.clear();
  }

  void colar() async{
    var result = await Clipboard.getData(Clipboard.kTextPlain);
    _controller.text = result!.text!;
  }

  void criptografar(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => new PrepararMensagemView(_controller.text, true))
    );
  }
  void descriptografar(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => new PrepararMensagemView(_controller.text, false))
    );
  }



}
