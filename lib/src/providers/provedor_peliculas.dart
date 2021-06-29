import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';


class ProvedorDePeliculas{


  String _api = '9db10114bde6808d4aee6a84c54489ca';
  String _url = 'api.themoviedb.org';
  String _idi = 'es-ES';

  //Creacion del Stream ↓↓↓

  int _page = 0;

  List<Pelicula> trendingList = new List();
  bool cargando = false;


  final _controller = StreamController<List<Pelicula>>.broadcast();
  
  Function(List<Pelicula>) get sink => _controller.sink.add;

  Stream<List<Pelicula>> get stream => _controller.stream;


  void disposeStream(){

    _controller?.close();

  }






  //Cartelera

  Future<List<Pelicula>> getCartelera() async {


    Uri url = Uri.https(_url, '3/movie/now_playing',{

      'api_key' : _api,
      'language': _idi,

    });
    
    return resolverUrl(url);

  }





  //Populares

  Future<List<Pelicula>> getTrending() async {

    if(cargando) return [];
 
    cargando = true;

    _page++;

    print('Cargando siguientes');


    Uri url = Uri.https(_url, '3/movie/popular',{

      'api_key' : _api,
      'language': _idi,
      'page'    : _page.toString()

    });

    final resp = await resolverUrl(url);

    trendingList.addAll(resp);
    sink(trendingList);

    cargando = false;


    return resp;

  }



  //Cartelera

  Future<List<Pelicula>> buscarPelicula(String query) async {


    Uri url = Uri.https(_url, '3/search/movie',{

      'api_key' : _api,
      'language': _idi,
      'query'   : query

    });
    
    return resolverUrl(url);

  }




  //Resolver Uri

  Future<List<Pelicula>> resolverUrl(Uri url) async {
    
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body); ///Transformamos de String llano a Mapa

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;

  }


}