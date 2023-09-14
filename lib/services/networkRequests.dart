import 'dart:convert';

import 'package:ollypix/models/searchModel.dart';
import 'package:http/http.dart' as http;
class ApiService{
   Future<List<Object>?> getFetchedImages() async{

    var client = http.Client();
    var url = Uri.parse('https://pixabay.com/api/?key=24492969-ba7c05868d9509686fb182a52&q=cake&image_type=photo&pretty=true&per_page=100');
    var response =  await client.get(url);
    if(response.statusCode == 200){
      var list = [response.body, response.statusCode];
        var data = response.body;
        print(data);
        return  list;
       
    

    }
    return null;

   }
  
}