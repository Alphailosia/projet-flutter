import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/pages/addclothe/add_clothe_page.dart';
import 'package:projet_flutter_desire_stephane/pages/basket/basket_product_list_page.dart';
import 'package:projet_flutter_desire_stephane/pages/clothesList/clothes_list_page.dart';
import 'package:projet_flutter_desire_stephane/pages/profile/profile_page.dart';
import 'package:projet_flutter_desire_stephane/services/authentication.dart';
import 'package:provider/provider.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);


  @override
  _AccueilPageState createState(){
    return _AccueilPageState();
  }

}

class _AccueilPageState extends State{

  final AuthenticationService _auth = AuthenticationService();
 
  Widget page = StreamProvider<AppUser?>.value(
    value:AuthenticationService().user,
    child: const Scaffold(
        body: ClothesListPage()
    ),
    initialData: null,
  );
  int _selectedIndex = 0;
  Text titre = const Text('Liste des vêtements');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: titre,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text('Déconnexion'),
            icon: const Icon(Icons.logout),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          ),
        ],
      ),
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Achats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
      switch(index){
        case 1:{
          titre = const Text('Panier');
          page = StreamProvider<AppUser?>.value(
            value:AuthenticationService().user,
            child: const Scaffold(
                body: BasketProductListPage()
            ),
            initialData: null,
          );
          break;
        }
        case 2:{
          titre = const Text('Profile');
          page = StreamProvider<AppUser?>.value(
            value:AuthenticationService().user,
            child: const Scaffold(
                body: ProfilePage()
            ),
            initialData: null,
          );
          break;
        }
        case 3:{
          titre = const Text('Ajout d\'un vêtement');
          page = AddClothePage();
          break;
        }
        default:{
          titre = const Text('Liste des vêtements');
          page = StreamProvider<AppUser?>.value(
            value:AuthenticationService().user,
            child: const Scaffold(
                body: ClothesListPage()
            ),
            initialData: null,
          );
        }
      }
    });
  }

}
