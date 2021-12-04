import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/constants.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';

class AddClothePage extends StatelessWidget {
  const AddClothePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    final DatabaseService _database = DatabaseService(user!.uid, '');


    final categoryController = TextEditingController();
    final imageController = TextEditingController();
    final brandController = TextEditingController();
    final prixController = TextEditingController();
    final tailleController = TextEditingController();
    final titreController = TextEditingController();

    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            TextFormField(
              controller: categoryController,
              decoration: textInputDecoration.copyWith(labelText: 'Catégorie'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: imageController,
              decoration: textInputDecoration.copyWith(labelText: 'Url de l\'image'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: brandController,
              decoration: textInputDecoration.copyWith(labelText: 'Marque'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: prixController,
              decoration: textInputDecoration.copyWith(labelText: 'Prix'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: tailleController,
              decoration: textInputDecoration.copyWith(labelText: 'Taille'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: titreController,
              decoration: textInputDecoration.copyWith(labelText: 'Titre'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              child: const Text('Valider'),
              onPressed: () async {
                var cat = categoryController.value.text;
                var img = imageController.value.text;
                var marque = brandController.value.text;
                var prix = prixController.value.text;
                var taille = tailleController.value.text;
                var titre = titreController.value.text;

                await _database.createItem(cat,img,marque,prix,taille,titre);
              },
            ),
          ],
        )
    );
  }
}
