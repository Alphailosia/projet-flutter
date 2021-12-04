import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/loading.dart';
import 'package:projet_flutter_desire_stephane/models/clothe.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';

import 'clothe_list.dart';

class ClothesListPage extends StatelessWidget {
  const ClothesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userApp = Provider.of<AppUser?>(context);
    if(userApp==null){
      return const Loading();
    }
    else{
      return StreamProvider<Iterable<Clothe>>.value(
        value: DatabaseService(userApp.uid,'').clothes,
        initialData: const [],
        child: Scaffold(
            body: ClotheList(uid :userApp.uid)
        ),
      );
    }
  }
}
