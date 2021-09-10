
import 'Alfabeto.dart';

class CriptografarMensagem{





  static String criptografia(String msg) {
    String resultado="";
    List<String> quebraMsg = msg.split("");
    try{
      for(int i=0;i<quebraMsg.length;i++){
        for(int j =0;j<Alfabeto.alfabeto.length;j++){
          if(quebraMsg[i]==Alfabeto.alfabeto[j]){
            resultado += Alfabeto.codigosCriptografia[j];
          }
        }
      }
    }catch(error){

    }
    return resultado;

  }


}