import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_employee/data/local/db/app_db.dart';
import 'package:smart_employee/route/route_genarate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
      Provider(
        create: (context) => AppDb(),
        dispose: (context, AppDb db) => db.close(),
        child: const MyApp(),
      ),



  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

