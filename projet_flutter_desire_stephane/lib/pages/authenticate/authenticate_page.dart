import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/constants.dart';
import 'package:projet_flutter_desire_stephane/common/loading.dart';
import 'package:projet_flutter_desire_stephane/services/authentication.dart';

class AuthenticationPage extends StatefulWidget{
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AthenticationPageState createState() => _AthenticationPageState();

}

class _AthenticationPageState extends State<AuthenticationPage>{
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
  String error = '';
  bool loading = false;
  bool inscription = false;

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return loading ? const Loading() :
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: inscription ? const Text('Inscription') : const Text('Connexion'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: (){
              setState(() {
                inscription ? inscription=false : inscription=true;
              });
            },
            icon: inscription ? const Icon(Icons.login) : const Icon(Icons.account_circle),
            label: inscription ? const Text('Connection') : const Text('Inscription'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
          )
        ]
        //_widgetList(),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: textInputDecoration.copyWith(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? "Entrer un nom" : null,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value!.length < 6 ? "Entrer un mot de passe de plus de 6 caractères" : null,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                  child: inscription ? const Text('S\'inscrire') : const Text('Se connecter'),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      var password = passwordController.value.text;
                      var name = nameController.value.text;
                      dynamic result;

                      if(!inscription) {
                        result = await _auth.signInWithNameAndPswd( name, password);
                      } else {
                        result = await _auth.registerWithNameAndPswd(name, password);
                      }

                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'mauvais identifiant';
                          print(error);
                        });
                      }
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}