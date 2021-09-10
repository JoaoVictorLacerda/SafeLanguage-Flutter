import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_language/Controller/Controller.dart';
import 'package:safe_language/Popup/ShowAlert.dart';

class ShareCode extends StatefulWidget {


  @override
  _ShareCodeState createState() => _ShareCodeState();
}

class _ShareCodeState extends State<ShareCode> {

  final TextEditingController _controller = new TextEditingController();


  Widget criaMultiline(){

    return new TextField(
      maxLines: 8,
      minLines: 8,
      enabled: true,
      decoration: new InputDecoration(
          labelText: "Seu codigo:",
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      controller: _controller,
    );
  }

  Widget criarBotoes(String nome, BuildContext context, bool isButtonApagar){

     return new Container(
       height: 40,
       child: new RaisedButton(
           child: new Center(
             child: new Text(nome),
           ),
           onPressed: () async {
             _FachadaShareCode fachada = new _FachadaShareCode(_controller,context);
             switch(nome){
               case "Copiar meu codigo":
                 fachada.copiarMeuCodigo();
                 break;

               case "Colar codigo compartilhado":
                 fachada.colarCodigoCompartilhado();
                 break;

               case "Salvar Código":
                 fachada.salvarCodigo();
                 break;
                 
               case "Limpar":
                 _controller.text="";
                 break;
               case"Apagar alfabeto personalizado":
                 fachada.apagarAlfabetoPersonalizado();
                 break;
             }

           },
           color: isButtonApagar? Colors.red : Color(0xFF4da6ff)
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:new SizedBox(
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
                this.criarBotoes("Copiar meu codigo",context, false),
                new Container(height: 20,),
                this.criarBotoes("Colar codigo compartilhado",context, false),
                new Container(height: 20,),
                this.criarBotoes("Salvar Código",context, false),
                new Container(height: 20,),
                this.criarBotoes("Limpar",context, false),
                new Container(height: 20,),
                this.criarBotoes("Apagar alfabeto personalizado",context, true),
              ],
            ),
          ),
        ),
    );
  }


}


class _FachadaShareCode{

  String _codigos="";
  final TextEditingController _controller;
  final BuildContext _context;

  _FachadaShareCode(this._controller, this._context);

  void copiarMeuCodigo() async{
    String codigo = await Controller.recuperar();
    _controller.text = codigo;
    this._codigos=codigo;
    await Clipboard.setData(ClipboardData(text: codigo));
    ShowAlert.popup(_context,"Copiado");
  }


  void colarCodigoCompartilhado() async{
    final result =await Clipboard.getData(Clipboard.kTextPlain);
    _controller.text = result!.text!;
  }


  void salvarCodigo(){
    if(this._controller.text.length > 672){
      if(this._codigos != _controller.text){
        Controller.colocarNoBancoString(_controller.text);
        ShowAlert.popup(_context,"Codigo atualizado");
      }else{
        ShowAlert.popup(_context,"Codigos iguais");
      }
    }else{
      ShowAlert.popup(_context, "O código não está apto");
    }
  }


  void apagarAlfabetoPersonalizado(){
      Controller.apagar();
      ShowAlert.popup(_context, "Alfabeto deletado");
  }

}
