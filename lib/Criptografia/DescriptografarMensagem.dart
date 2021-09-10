import 'Alfabeto.dart';

class DescriptografarMensagem{


  static String descriptografar(String codigo) {
    String resultado="";

    List<String> quebraMsg = codigo.split(",");

    try{
      for(int i=0;i<quebraMsg.length;i++){
        for(int j =0; j < Alfabeto.codigosDescriptografia.length;j++){
          if(quebraMsg[i]==Alfabeto.codigosDescriptografia[j]){
            resultado += Alfabeto.alfabeto[j];
          }
        }
      }
    }catch(error){

    }

    return resultado;

  }


}