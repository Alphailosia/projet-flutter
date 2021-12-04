import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/pages/splashpage_wrapper.dart';
import 'package:projet_flutter_desire_stephane/services/authentication.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
          home: const SplashPageWrapper(),
          theme: ThemeData(primarySwatch: Colors.amber)),
      initialData: null,
    );
  }
}
