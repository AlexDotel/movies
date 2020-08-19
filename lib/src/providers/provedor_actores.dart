import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas_repaso/src/models/modelo_actor.dart';

class ProvedorActores{


  String _api = '9db10114bde6808d4aee6a84c54489ca';
  String _url = 'api.themoviedb.org';
  String _idi = 'es-ES';


  Future<List<Actor>> getActores( int movie_id) async {


  Uri url = Uri.https(_url, '3/movie/$movie_id/credits',{

    'api_key' : _api,
    'language': _idi,

  });

  final resp = await http.get(url);
  final decodedData = json.decode(resp.body);

  final actores = new Actores.fromJsonList(decodedData['cast']);

  return actores.actores;

  

}

}