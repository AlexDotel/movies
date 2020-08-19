import 'package:flutter/material.dart';
import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';
import 'package:peliculas_repaso/src/providers/provedor_peliculas.dart';


class DataSearch extends SearchDelegate{

  final provedor = ProvedorDePeliculas();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro appbar
    return [

      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){

          query = '';

        }
      )

    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Builder de los resultados que mostraremos
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Builder de sugerencias que apareceran al escribir 
    if(query.isEmpty){

      return Container();

    }else{

      return FutureBuilder(
        future: provedor.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          
          if(snapshot.hasData){

            final peliculas = snapshot.data;

            return ListView(

              children: peliculas.map((pelicula){
                
                pelicula.uniqueId = '$pelicula.id'+'-busqueda';

                return ListTile(
                  onTap: (){

                    close(context, null);
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);

                  },
                  leading: Hero(
                    tag: pelicula.uniqueId,
                    child: FadeInImage(
                      width: 50,
                      fit: BoxFit.contain,
                      placeholder: AssetImage('assets/img/holder_pop.png'),
                      image: NetworkImage(pelicula.getPoster())
                    ),
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                );

              }).toList()
            );

          }else{

            return Center(child: CircularProgressIndicator(),);

          }
        },
      );

    }

  }



}