
class Actores{

  List<Actor> actores = new List();

  Actores.fromJsonList(List<dynamic> jsonList ){

    if(jsonList == null) return;

    jsonList.forEach((item){

      final actor = new Actor.fromJsonMap(item);
      actores.add(actor);

    });

  }

}


class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map <String, dynamic> json ){
    
    castId        = json['cast_id'];
    character     = json['character'];
    creditId      = json['credit_id'];
    gender        = json['gender'];
    id            = json['id'];
    name          = json['name'];
    order         = json['order'];
    profilePath   = json['profile_path'];

  }

  getProfile(){

    if(profilePath != null ){

      return 'https://image.tmdb.org/t/p/w500/$profilePath';

    }else{

      if(gender == 1){
        //Female
      return 'https://images.assetsdelivery.com/compings_v2/apoev/apoev1804/apoev180400022.jpg';

      } else{
        //Male
      return 'https://images.assetsdelivery.com/compings_v2/apoev/apoev1804/apoev180400195.jpg';        

      }

    }

  }

}


