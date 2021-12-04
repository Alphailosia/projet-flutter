import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/models/basket_product.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';

class BasketProductList extends StatefulWidget {
  final String uid;

  const BasketProductList({Key? key, required this.uid}) : super(key: key);
  @override
  _BasketProductListState createState() => _BasketProductListState(uid);
}

class _BasketProductListState extends State<BasketProductList> {
  final String uid;

  _BasketProductListState(this.uid);
  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<Iterable<BasketProduct>>(context);
    if (basket.isEmpty) {
      return const Center(
        child: Text('Aucun porduit dans le panier'),
      );
    } else {
      return ListView(
        children: <Widget>[
          ListView.builder(
            itemCount: basket.length,
            itemBuilder: (context, index) {
              return BasketProductTile(
                  product: basket.elementAt(index), uid: uid);
            },
            shrinkWrap: true,
            physics: const ScrollPhysics(),
          ),
          Text('Prix : ' + _calculPrix(basket) + '€')
        ],
      );
    }
  }

  String _calculPrix(Iterable<BasketProduct> basket) {
    double prix = 0.0;
    for (var element in basket) {
      prix += element.prix * element.quantite;
    }
    return double.parse(prix.toStringAsFixed(2)).toString();
  }
}

class BasketProductTile extends StatelessWidget {
  final BasketProduct product;
  final String uid;

  const BasketProductTile({Key? key, required this.product, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          title: Text(product.clothe),
          leading: Image(
            image: NetworkImage(product.image),
          ),
          subtitle: Row(
            children: [
              Column(
                children: [
                  Text('Taille : ${product.taille}'),
                  Text('Prix : ${product.prix}'),
                  Text('Quantité : ${product.quantite}'),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              (product.quantite == 1) ? TextButton.icon(
                onPressed: () async {
                  product.quantite--;
                    await DatabaseService(uid, product.uid).removeFromBasket();
                },
                icon: const Icon(Icons.delete),
                label: const Text(''),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                          color: Colors.amber
                      )
                  )
                ),
              ): TextButton.icon(
                onPressed: () async {
                  product.quantite--;
                  await DatabaseService(uid, product.uid).updateProduct(product);
                },
                icon: const Icon(Icons.exposure_minus_1),
                label: const Text(''),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                            color: Colors.amber
                        )
                    )
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}
