import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/loading.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/pages/profile/profile.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget{
  const ProfilePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final userApp = Provider.of<AppUser?>(context);
    if(userApp==null){
      return const Loading();
    }else{
    return StreamProvider<AppUserData?>.value(
      value: DatabaseService(userApp.uid, '').user,
      child: const Scaffold(
          body: ProfileWidget()
      ),
      initialData: null,
    );
  }
  }
}
