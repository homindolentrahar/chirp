import 'package:chirp/routes/bindings.dart';
import 'package:chirp/routes/routes.dart';
import 'package:chirp/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  //  Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['API_URL'],
    anonKey: dotenv.env['ANON_KEY'],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chirp',
      themeMode: ThemeMode.dark,
      darkTheme: AppThemes.darkTheme,
      initialRoute: "/",
      initialBinding: InitialBinding(),
      getPages: appRoutes,
    );
  }
}
