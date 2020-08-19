import 'package:flutter/material.dart';

import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';

import 'package:peliculas_repaso/src/providers/provedor_peliculas.dart';
import 'package:peliculas_repaso/src/search/search_delegate.dart';

import 'package:peliculas_repaso/src/widgets/horizontal_scroll.dart';
import 'package:peliculas_repaso/src/widgets/swiper.dart';



class HomePage extends StatelessWidget {

  final provedor =  new ProvedorDePeliculas();

  var esTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  var ssize;

  @override
  Widget build(BuildContext context) {


  provedor.getTrending();


   ssize =  MediaQuery.of(context).size;


    return Container(
      child: Scaffold(

        appBar: AppBar(
          centerTitle: false,
          title: Text('Peliculas Populares'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){

               showSearch(context: context, delegate: DataSearch(), );

              }
            )
          ],
          
        ),

        body: Container(
          child: Column(
            children: <Widget>[
              swiperTarjetas(),
              footer(),
            ]
          )

        )

      ),
    );
  }

  swiperTarjetas() {

    return FutureBuilder(
      future: provedor.getCartelera(),
      builder: (BuildContext context , AsyncSnapshot snapshot){

        if(snapshot.hasData){

        return SwiperWidget(peliculas: snapshot.data);

        }else{
          
          return 
            Container(
              height: MediaQuery.of(context).size.height*0.50,
              child: Center(child: CircularProgressIndicator())
            );

        }


      }

    );

  }

  footer() {

    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,

      child: Column(
        children: <Widget>[
          Container(
            width: ssize.width*0.70,
            child: Divider(height: 50, color: Colors.black87,)
          ),
          Text('Trending Movies', style: esTitle),
          SizedBox(height: 20),
          
          StreamBuilder(
            stream: provedor.stream,
            builder: (context, AsyncSnapshot<List<Pelicula>> snapshot){

              if(snapshot.hasData){

                return HorizontalScroll(
                  peliculas: snapshot.data,
                  metodo: provedor.getTrending
                );

              }else{

                return Center(child: CircularProgressIndicator());

              }

            }

          ),
        ],
      ),
    );
  }


}