import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/models/basket_product.dart';
import 'package:projet_flutter_desire_stephane/models/clothe.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';

class ClotheDetailPage extends StatelessWidget {
  const ClotheDetailPage({Key? key, required this.clothe, required this.uid}) : super(key: key);

  final String uid;
  final Clothe clothe;

  @override
  Widget build(BuildContext context) {
    final DatabaseService _database = DatabaseService(uid,clothe.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: const Text('Détail du produit'),
        actions: <Widget>[
          StreamBuilder<BasketProduct>(
            stream: _database.basketProduct,
            builder: (context, snapshot){
              if(snapshot.hasData){
                BasketProduct? basketProduct = snapshot.data;
                return TextButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('+panier'),
                  onPressed: () async{
                    basketProduct!.quantite++;
                    await _database.updateProduct(basketProduct);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                );
              } else{
                return TextButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('+panier'),
                  onPressed: () async{
                    await _database.updateProduct(BasketProduct(clothe.uid,clothe.titre,clothe.taille,clothe.image,clothe.prix,1));
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Text(
               clothe.titre,
               style: const TextStyle(
                fontWeight: FontWeight.bold,
                 fontSize: 30.0
               ),
            ),
            Center(
                child: Image(
                  image: NetworkImage(clothe.image),

                )
            ),
            Row(
              children: [
                const Text('Taille :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    clothe.taille
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                const Text('Marque :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    clothe.marque
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                const Text('Catégorie :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    clothe.categorie
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                const Text('Prix :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    clothe.prix.toString()+' €'
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      )
    );
  }
}
