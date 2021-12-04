import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/loading.dart';
import 'package:projet_flutter_desire_stephane/models/basket_product.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';

import 'basket_product_list.dart';

class BasketProductListPage extends StatelessWidget {
  const BasketProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userApp = Provider.of<AppUser?>(context);
    if(userApp==null){
      return const Loading();
    } else {
     return StreamProvider<Iterable<BasketProduct>>.value(
       value: DatabaseService(userApp.uid,'').basket,
       initialData: const [],
       child: Scaffold(
           body: BasketProductList(uid:userApp.uid)
       ),
     );
    }
  }
}