import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/pages/authenticate/authenticate_page.dart';
import 'package:provider/provider.dart';

import 'accueil/accueil_page.dart';

class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if(user==null){
      return const AuthenticationPage();
    }
    else{
      return const AccueilPage();
    }
  }
}
