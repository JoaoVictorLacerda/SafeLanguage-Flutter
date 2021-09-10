import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_language/Criptografia/CriptografarMensagem.dart';
import 'package:safe_language/Criptografia/DescriptografarMensagem.dart';

import 'package:safe_language/Popup/ShowAlert.dart';








class PrepararMensagemView extends StatelessWidget {


  final String _mensagem;
  final bool _cripOrDesc;


  PrepararMensagemView(this._mensagem, this._cripOrDesc);

  final TextEditingController _controller = new TextEditingController();


  String criptografiaOuDescriptografia(){
    if(_cripOrDesc){
      return CriptografarMensagem.criptografia(_mensagem);
    }

    return DescriptografarMensagem.descriptografar(_mensagem);
  }

  Widget criarBotaoLimpar(BuildContext context){

    return new Container(
      height: 60,
      child: new RaisedButton(
          child: new Text("Copiar"),

          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: _controller.text));
            ShowAlert.popup(context,"Texto Copiado com sucesso");
          },
          color: new Color(0xFF4da6ff)
      ),
    );
  }
  Widget criaMultiline(){
    _controller.text = this.criptografiaOuDescriptografia();
    return new TextField(
      maxLines: 14,
      minLines: 14,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          hintText: "Seu texto aparecerá aqui"
      ),
      controller: _controller,

    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Retornar")
      ),
      body:new SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: new ListView(
            padding: EdgeInsets.all(10),
            children: [
              new Container(height: 15,),
              criaMultiline(),
              new Container(height: 30,),
              criarBotaoLimpar(context)
            ],
          ),
        ),
      ),
    );
  }
}



