import 'package:flutter/material.dart';

import 'package:peliculas_repaso/src/pages/HomePage.dart';
import 'package:peliculas_repaso/src/pages/detalle.dart';

getRoutes(){

  return <String, WidgetBuilder>{

  
    '/'         : (BuildContext context) => HomePage(),
    'detalle'   : (BuildContext context) => Detalle(),
    
    
    };

}