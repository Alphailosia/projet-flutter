class AppUser {

  final String uid;

  AppUser(this.uid);
  
  String getUid(){
    return uid;
  }

}

class AppUserData{

  final String uid;
  final String login;
  final String password;
  DateTime birthday;
  final String address;
  final String codePostal;
  final String city;

  AppUserData(this.uid, this.login, this.password, this.birthday, this.address, this.codePostal, this.city);

}