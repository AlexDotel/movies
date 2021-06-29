import 'package:flutter/material.dart';
import 'package:peliculas_repaso/src/models/modelo_actor.dart';

import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';
import 'package:peliculas_repaso/src/providers/provedor_actores.dart';

class Detalle extends StatelessWidget {

  var esTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color:  Colors.black87);


  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments; 

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar( pelicula ),
            _sliver( pelicula ),
          ]
        )
    );  }

  
  Widget _crearAppBar(Pelicula pelicula){

      return SliverAppBar(
        elevation: 2,
        backgroundColor: Colors.redAccent,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          // centerTitle: true,
          background: FadeInImage(
            placeholder: AssetImage('assets/img/holder_mov.png'),
            image: NetworkImage(pelicula.getPortada()),
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 500),
            ),
          title: Text(pelicula.title),
        ),
      );

    }

  Widget _sliver(Pelicula pelicula) {

    return SliverList(
      delegate: SliverChildListDelegate([
        SizedBox(height: 10,),
        mini(pelicula),
        descripcion( pelicula ),
        descripcion( pelicula ),
        descripcion( pelicula ),
        descripcion( pelicula ),
        descripcion( pelicula ),
        descripcion( pelicula ),
        descripcion( pelicula ),
        crearCasting( pelicula ),

        
      ]),
    );

  }

  Widget mini(Pelicula pelicula){

    return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Hero(
                tag: pelicula.uniqueId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    height: 150,
                    placeholder: AssetImage('assets/img/holder_pop.png'),
                    image: NetworkImage(pelicula.getPoster())
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        pelicula.title,
                        style: esTitle,
                        overflow: TextOverflow.visible,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star_border, size: 20),
                          SizedBox(width: 5,),
                          Text(pelicula.voteAverage.toString(), style: esTitle)
                        ]
                      ),
                      SizedBox(height: 5 ),
                      Text(
                        'Original Title: '+ pelicula.originalTitle,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Release: '+pelicula.releaseDate,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Adult: '+pelicula.adult.toString().toUpperCase(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ]
                  ),
                )
              )
            ],
          ),
        );

  }

  Widget descripcion(Pelicula pelicula) {

    if(pelicula.overview == ''){

      return Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Text(
          'Upsss... No tenemos esta sinopsis',
          textAlign: TextAlign.justify,
        ),
      );

    }else{

      return Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,
        ),
      );

    }
    

  }

  crearCasting(Pelicula pelicula) {

    final provedorCasting = ProvedorActores();

    return FutureBuilder(
      future: provedorCasting.getActores(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){

          return crearActoresPageView(snapshot.data);

        }else{

          return Center(child: CircularProgressIndicator());

        }
      },
    );

  }

  crearActoresPageView( List<Actor> actores) {

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        pageSnapping: false,
        itemCount: actores.length,
        itemBuilder: (context, i) => actorTarjeta(actores[i]),
      )  
    );

  }

  Widget actorTarjeta(Actor actor){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 150,
              width: 120,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/img/holder_mov.png'), 
              image: NetworkImage(actor.getProfile())
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ]
      )
    );

  }


}

