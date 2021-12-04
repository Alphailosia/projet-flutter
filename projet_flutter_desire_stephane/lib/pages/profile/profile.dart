import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_flutter_desire_stephane/common/constants.dart';
import 'package:projet_flutter_desire_stephane/common/loading.dart';
import 'package:projet_flutter_desire_stephane/models/user.dart';
import 'package:projet_flutter_desire_stephane/services/authentication.dart';
import 'package:projet_flutter_desire_stephane/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileStateWidget createState() => _ProfileStateWidget();
}

class _ProfileStateWidget extends State {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUserData?>(context);
    if(user==null){
      return const Loading();
    }else {
      initializeDateFormatting();
      final DatabaseService _database = DatabaseService(user.uid, '');


      final passwordController = TextEditingController(text: user.password);
      final codePostalController = TextEditingController(text: user.codePostal);
      final addressController = TextEditingController(text: user.address);
      final cityController = TextEditingController(text: user.city);

      return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(labelText: 'Login'),
                initialValue: user.login,
                readOnly: true,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime(2021, 12, 12),
                    onChanged: (date) {
                    },
                    onConfirm: (date) {
                      setState(() {
                        user.birthday = date;
                      });
                    },
                    currentTime: user.birthday,
                    locale: LocaleType.fr
                  );
                },
                child: Text(
                  "Birthday : " + DateFormat.yMd('fr').format(user.birthday),
                  style: const TextStyle(color: Colors.amber),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: addressController,
                decoration: textInputDecoration.copyWith(labelText: 'Address'),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: codePostalController,
                decoration: textInputDecoration.copyWith(
                    labelText: 'codePostal'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: cityController,
                decoration: textInputDecoration.copyWith(labelText: 'city'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                child: const Text('Valider'),
                onPressed: () async {
                  var password = passwordController.value.text;
                  var address = addressController.value.text;
                  var code = codePostalController.value.text;
                  var city = cityController.value.text;

                  await AuthenticationService().updatePassword(
                      user.password, password);
                  await _database.saveUser(
                      user.login, password, user.birthday, address, code, city);
                },
              ),
            ],
          )
      );
    }
    }
}
