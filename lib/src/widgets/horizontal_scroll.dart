import 'package:flutter/material.dart';
import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';

class HorizontalScroll extends StatelessWidget {
    
    final List<Pelicula> peliculas;
    final Function metodo;

    HorizontalScroll({
      @required this.peliculas,
      @required this.metodo
    });

    var ssize;
    final controlador = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    

  @override
  Widget build(BuildContext context) {

    ssize = MediaQuery.of(context).size;

    controlador.addListener((){

      if(controlador.position.pixels >= controlador.position.maxScrollExtent){

        metodo();

      }

    });



    return Container(
      height: ssize.height*0.20,
      child: PageView.builder(
        pageSnapping: false,
        scrollDirection: Axis.horizontal,
        controller: controlador,
        itemCount: peliculas.length,
        itemBuilder: (context, i){

          return _tarjeta(context, peliculas[i]); 

        },
      ),
    );

    }


    Widget _tarjeta (BuildContext context, Pelicula pelicula){

      pelicula.uniqueId = '${pelicula.id}-footer';

      final tarjeta =  Container(
          // margin: EdgeInsets.only(right: 15),
          child: Column(

            children: <Widget>[
              Hero(
                tag: pelicula.uniqueId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPoster()),
                    placeholder: AssetImage('assets/img/holder_pop.png'),
                    fit: BoxFit.cover,
                    height: ssize.height*0.15,
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                child: Text(
                  pelicula.title, 
                  overflow: TextOverflow.ellipsis, 
                  style: TextStyle(fontWeight: FontWeight.bold))
              )
            ],
          ),
        );

        return GestureDetector(
          child: tarjeta,
          onTap: (){

            Navigator.pushNamed(context, 'detalle',arguments: pelicula);

          },
        );

    }





  

//↓↓↓↓ Esta lista de abajo no se esta utilizando porque en vez de mandar el page View que carga TODAS LAS TARJETAS
//se esta utilizando el Page View Builder que se encarga de ir cargando como el Recycler view segun sea
//necesario. Para eso creamos una sola tarjeta y le pasamos el context y la pelicula que va a renderizarse
//individualmente, tambien el itemCount que es el largo de la lista de peliculas.

List<Widget> tarjetas(){

      return peliculas.map((pelicula){

        return Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(

            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPoster()),
                  placeholder: AssetImage('assets/img/holder_pop.png'),
                  fit: BoxFit.cover,
                  height: 160,
                ),
              ),

              SizedBox(height: 10),
              Container(
                child: Text(
                  pelicula.title, 
                  overflow: TextOverflow.ellipsis, 
                  style: TextStyle(fontWeight: FontWeight.bold))
              )

            ],

          ),



        );


      }).toList();

    }


}