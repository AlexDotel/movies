import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:peliculas_repaso/src/models/modelo_pelicula.dart';



class SwiperWidget extends StatelessWidget {


  final List<Pelicula> peliculas;


  SwiperWidget({@required this.peliculas});
  

  @override
  Widget build(BuildContext context) {
  
  final ssize = MediaQuery.of(context).size;

    return Container(
      // margin: EdgeInsets.only(top: 10),
      
      child: Swiper(
        itemWidth:  ssize.width*0.70,
        itemHeight: ssize.height*0.50,
        itemBuilder: (BuildContext context,int i){

          peliculas[i].uniqueId = '${peliculas[i].id}-tarjeta';

          return Hero(
            tag: peliculas[i].uniqueId,
            child: GestureDetector(
              onTap: (){
                
                Navigator.pushNamed(context, 'detalle', arguments: peliculas[i]);

              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: FadeInImage(
                  image: NetworkImage(peliculas[i].getPoster()),
                  placeholder: AssetImage('assets/img/holder_pop.png'),
                  fit: BoxFit.cover,)
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        layout: SwiperLayout.TINDER,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl()
      ),
    );

  }
}