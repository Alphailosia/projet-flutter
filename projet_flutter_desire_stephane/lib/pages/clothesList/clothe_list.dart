import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/models/clothe.dart';
import 'package:projet_flutter_desire_stephane/pages/clothesList/clothe_detail_page.dart';
import 'package:provider/provider.dart';

class ClotheList extends StatefulWidget {
  final String uid;

  const ClotheList({Key? key,required this.uid}) : super(key: key);

  @override
  _ClotheListState createState() => _ClotheListState(uid);
}

class _ClotheListState extends State<ClotheList> {
  final String uid;

  _ClotheListState(this.uid);

  String _filtreCat = 'Tous';
  String _filtreTaille = 'Tous';
  Iterable<Clothe> clothesFiltre = [];

  @override
  Widget build(BuildContext context) {
    final clothes = Provider.of<Iterable<Clothe>>(context);
    filtreList(clothes);
    if(clothesFiltre.isEmpty){
      return Column(
          children:[
            Row(
              children: [
                const Text('Filtre '),
                PopupMenuButton(
                    onSelected: (value){
                      setState(() {
                        _filtreCat = value.toString();
                        filtreList(clothes);
                      });
                    },
                    itemBuilder:(context) => [
                      const PopupMenuItem(
                        child: Text("Tous"),
                        value: "Tous",
                      ),
                      const PopupMenuItem(
                        child: Text("Short"),
                        value: "Short",
                      ),
                      const PopupMenuItem(
                        child: Text("Pantalon"),
                        value: "Pantalon",
                      ),
                      const PopupMenuItem(
                        child: Text("Chemise"),
                        value: "Chemise",
                      ),
                      const PopupMenuItem(
                        child: Text("T-shirt"),
                        value: "T-shirt",
                      )
                    ]
                ),
                Text(_filtreCat),
                PopupMenuButton(
                    onSelected: (value){
                      setState(() {
                        _filtreTaille = value.toString();
                        filtreList(clothes);
                      });
                    },
                    itemBuilder:(context) => [
                      const PopupMenuItem(
                        child: Text("Tous"),
                        value: "Tous",
                      ),
                      const PopupMenuItem(
                        child: Text("M"),
                        value: "M",
                      ),
                      const PopupMenuItem(
                        child: Text("L"),
                        value: "L",
                      ),
                      const PopupMenuItem(
                        child: Text("XL"),
                        value: "XL",
                      ),
                      const PopupMenuItem(
                        child: Text("XXL"),
                        value: "XXL",
                      )
                    ]
                ),
                Text(_filtreTaille),
              ],
            ),
            const Center(child:Text('Aucun article correspond à votre sélection')),
          ]
        );
    }
    else{
      return ListView(
        children: [
          Row(
            children: [
              const Text('Filtre '),
              PopupMenuButton(
                  onSelected: (value){
                    setState(() {
                      _filtreCat = value.toString();
                      filtreList(clothes);
                    });
                  },
                  itemBuilder:(context) => [
                    const PopupMenuItem(
                      child: Text("Tous"),
                      value: "Tous",
                    ),
                    const PopupMenuItem(
                      child: Text("Short"),
                      value: "Short",
                    ),
                    const PopupMenuItem(
                      child: Text("Pantalon"),
                      value: "Pantalon",
                    ),
                    const PopupMenuItem(
                      child: Text("Chemise"),
                      value: "Chemise",
                    ),
                    const PopupMenuItem(
                      child: Text("T-shirt"),
                      value: "T-shirt",
                    )
                  ]
              ),
              Text(_filtreCat),
              PopupMenuButton(
                  onSelected: (value){
                    setState(() {
                      _filtreTaille = value.toString();
                      filtreList(clothes);
                    });
                  },
                  itemBuilder:(context) => [
                    const PopupMenuItem(
                      child: Text("Tous"),
                      value: "Tous",
                    ),
                    const PopupMenuItem(
                      child: Text("M"),
                      value: "M",
                    ),
                    const PopupMenuItem(
                      child: Text("L"),
                      value: "L",
                    ),
                    const PopupMenuItem(
                      child: Text("XL"),
                      value: "XL",
                    ),
                    const PopupMenuItem(
                      child: Text("XXL"),
                      value: "XXL",
                    )
                  ]
              ),
              Text(_filtreTaille),
            ],
          ),
          ListView.builder(
            itemCount:clothesFiltre.length,
            itemBuilder:(context, index){
              return ClotheTile(clothe: clothesFiltre.elementAt(index),uid: uid);
            },
            shrinkWrap: true,
            physics: const ScrollPhysics(),
          )
        ],
      );
    }
  }

  void filtreList(Iterable<Clothe> clothes){
    List<Clothe> result = [];
      if(_filtreCat=='Tous' && _filtreTaille=='Tous'){
        setState(() {
          clothesFiltre = clothes;
        });
      }
      else{
        for(var elem in clothes){
          if(_filtreCat==elem.categorie && _filtreTaille==elem.taille){
            result.add(elem);
          }
          else if(_filtreCat=='Tous' && _filtreTaille==elem.taille){
            result.add(elem);
          }
          else if(_filtreTaille=='Tous' && _filtreCat==elem.categorie){
            result.add(elem);
          }
        }
        setState(() {
          clothesFiltre = result;
        });
      }
  }
}

class ClotheTile extends StatelessWidget{
  final Clothe clothe;
  final String uid;

  const ClotheTile({Key? key, required this.clothe, required this.uid}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Card(
        margin: const EdgeInsets.only(top: 12.0,bottom: 6.0,left: 20.0,right: 20.0),
        child: ListTile(
          title: Text('Prix : ${clothe.prix}€ \nTaille : ${clothe.taille}'),
          subtitle: Text(clothe.titre),
          leading: Image(
            image: NetworkImage(clothe.image),
          ),
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ClotheDetailPage(clothe: clothe,uid: uid))
            );
          },
        ),
      ),
    );
  }
}
