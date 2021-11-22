import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:irllink/routes/app_pages.dart';
import 'package:irllink/src/presentation/views/login_view.dart';

void main() async {
  await GetStorage.init();
  //todo : faire la vérif d'utilisateur déjà existant ici plutôt que dans loginviewcontroller
  //comme ça on a pas besoin de charger login view controller pour rien ?
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginView(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
