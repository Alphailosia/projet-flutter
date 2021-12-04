import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_flutter_desire_stephane/models/basket_product.dart';
import 'package:projet_flutter_desire_stephane/models/clothe.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';

class DatabaseService {
  final String uid;
  final String uidProduct;

  DatabaseService(this.uid, this.uidProduct);

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference clothesCollection = FirebaseFirestore.instance.collection('clothes');
  final CollectionReference basketCollection = FirebaseFirestore.instance.collection('basket');

  Future<void>  saveUser(String name, String mdp, DateTime anniversaire, String adresse, String codePostal, String ville) async {
    Timestamp anniv =  Timestamp.fromDate(anniversaire);
    return await usersCollection.doc(uid).set({
      'login':name,
      'password':mdp,
      'birthday':anniv,
      'address':adresse,
      'codePostal':codePostal,
      'city':ville
    });
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot){
    DateTime birthday = snapshot.data()['birthday'].toDate();
    return AppUserData(uid,
        snapshot.data()['login'],
        snapshot.data()['password'],
        birthday,
        snapshot.data()['address'],
        snapshot.data()['codePostal'],
        snapshot.data()['city']
    );
  }
  
  Stream<AppUserData> get user {
    return usersCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  Clothe _clotheFromSnapshot(DocumentSnapshot snapshot){
    return Clothe(snapshot.id,
        snapshot.data()['categorie'],
        snapshot.data()['taille'],
        snapshot.data()['titre'],
        snapshot.data()['image'],
        snapshot.data()['marque'],
        snapshot.data()['prix']
    );
  }

  Future<void>  createItem(String cat, String img, String marque, String prix, String taille, String titre) async{
    await clothesCollection.add({
      'categorie':cat,
      'image':img,
      'marque':marque,
      'prix':double.parse(prix),
      'taille':taille,
      'titre':titre,
    });
  }

  Iterable<Clothe> _clotheListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map( (doc){
        return _clotheFromSnapshot(doc);
      }
    );
  }

  Stream<Iterable<Clothe>> get clothes {
    return clothesCollection.snapshots().map(_clotheListFromSnapshot);
  }

  Future<void> updateProduct(BasketProduct basketProduct) async{
    return await basketCollection.doc(uid).collection(uid+':basket').doc(uidProduct).set({
      'produit':basketProduct.clothe,
      'image':basketProduct.image,
      'taille':basketProduct.taille,
      'prix':basketProduct.prix,
      'quantite':basketProduct.quantite
    });
  }

  Future<void> removeFromBasket() async{
    basketCollection.doc(uid).collection(uid+':basket').doc(uidProduct).delete();
  }

  BasketProduct _basketProductFromSnapshot(DocumentSnapshot snapshot){
    return BasketProduct(snapshot.id,
        snapshot.data()['produit'],
        snapshot.data()['taille'],
        snapshot.data()['image'],
        snapshot.data()['prix'],
        snapshot.data()['quantite']
    );
  }

  Stream<BasketProduct> get basketProduct{
    return basketCollection.doc(uid).collection(uid+':basket').doc(uidProduct).snapshots().map(_basketProductFromSnapshot);
  }



  Iterable<BasketProduct> _basketProductListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map( (doc){
      return _basketProductFromSnapshot(doc);
    });
  }

  Stream<Iterable<BasketProduct>> get basket{
    return basketCollection.doc(uid).collection(uid+':basket').snapshots().map(_basketProductListFromSnapshot);
  }
}