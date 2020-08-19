import 'package:flutter/material.dart';

import 'package:peliculas_repaso/src/routes/routes.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'PeliculasR',

      initialRoute: '/',

      routes: getRoutes()

    );

  }
}