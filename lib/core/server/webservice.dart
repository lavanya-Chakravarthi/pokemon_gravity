import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'webconstant.dart';

class Webservice{
  getApicall(String action) async{
    final url = WebConstant.serviceUrl + action;
    // print(url);
    try{
      var response = await http.get(Uri.parse(url));
      
      return response;
    }catch(e){
      throw HttpException(e.toString());
    }
  }
}