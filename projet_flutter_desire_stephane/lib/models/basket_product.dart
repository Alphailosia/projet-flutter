import 'clothe.dart';

class BasketProduct{

  String uid;
  final String clothe;
  final String taille;
  final String image;
  num prix;
  num quantite;

  BasketProduct(this.uid,this.clothe, this.taille,  this.image, this.prix,this.quantite);
}